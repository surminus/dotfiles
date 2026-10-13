---
name: copilot
description: >
  Get a GitHub Copilot review on a PR and deal with it: request the review if
  it has not been requested, wait for it, fix or answer every Copilot thread,
  reply in each thread and resolve it, then hide Copilot's overview comment as
  resolved. Use when Laura says "/copilot" or that she has asked Copilot to
  review a PR.
user-invocable: true
---

# Copilot

Copilot's GraphQL login is `copilot-pull-request-reviewer` (a `Bot`). The REST
API calls it `copilot-pull-request-reviewer[bot]`.

## 1. Find the PR

Use the PR Laura names, otherwise the one for the current piece of work in this
session, otherwise `gh pr view` from the current branch. Note `<owner/repo>`,
`<n>` and the head branch, and find the branch's worktree with
`git -C <repo> worktree list`. All edits and git commands happen in that
worktree by absolute path.

## 2. Make sure a review is coming

Read the current state:

```
gh api graphql -F owner=<owner> -F name=<name> -F pr=<n> -f query='
query($owner: String!, $name: String!, $pr: Int!) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $pr) {
      reviewRequests(first: 50) { nodes { requestedReviewer { ... on Bot { login } } } }
      reviews(first: 100) { nodes { id author { login } isMinimized submittedAt } }
    }
  }
}'
```

Count the Copilot reviews already there: that number is the baseline.

- Copilot is in `reviewRequests`: a review is in progress. Wait for it.
- Copilot is not requested and has no reviews: request one with
  `gh pr edit <n> -R <owner/repo> --add-reviewer @copilot`, then wait.
- Copilot is not requested but has already reviewed: the review has landed.
  Skip the wait and go to step 4. Only re-request if Laura asks for a fresh
  review.

## 3. Wait

Run the watcher in the background so you are woken when it finishes:

```
~/.claude/skills/copilot/wait-for-review.sh <owner/repo> <n> <baseline>
```

with `run_in_background: true`. It polls every 30 seconds and gives up after 30
minutes (`INTERVAL` and `TIMEOUT` override these). Tell Laura you are waiting,
then stop until it reports. If it times out, say so and stop.

## 4. Work through the threads

List the unresolved threads:

```
gh api graphql -F owner=<owner> -F name=<name> -F pr=<n> -f query='
query($owner: String!, $name: String!, $pr: Int!) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $pr) {
      reviewThreads(first: 100) {
        nodes {
          id isResolved isOutdated path line
          comments(first: 20) { nodes { databaseId author { login } body } }
        }
      }
    }
  }
}'
```

Take only unresolved threads whose first comment is from Copilot. For each one:

1. Read the code it points at, in the worktree, and decide whether Copilot is
   right. Copilot is often wrong or lacks context. Do not apply a suggestion
   just because it was made.
2. If it is right, make the fix following the repo's own conventions, in the
   commit on the branch that introduced the code (`git log -L` or
   `git blame` to find it): commit it with `git commit --fixup <sha>`. Several
   threads can share a fixup when they amend the same commit.
3. If it is wrong, or outdated because the code has already changed, no code
   change. Note why.

Run the relevant tests and linters for what you touched. Then fold the fixups
into their commits, keeping the branch's base, and check the content is what
it was before the squash:

```
GIT_SEQUENCE_EDITOR=true git -C <wt> rebase -i --autosquash --keep-base origin/<base>
git -C <wt> diff ORIG_HEAD HEAD
```

The diff must be empty. If the rebase conflicts, `git rebase --abort` and ask
rather than pushing. Fetch the branch first, and if `origin/<branch>` has
commits you have not seen, stop and ask before rewriting it. Then push with
`git -C <wt> push --force-with-lease origin <branch>`, never `--force`.

Push a `fixup!` commit unsquashed only when a reviewer needs to see that exact
change on its own, and link it in the reply.

## 5. Reply and resolve

For every Copilot thread you handled, reply in the thread (never as a comment
on the PR's main conversation):

```
gh api repos/<owner>/<repo>/pulls/<n>/comments/<first comment databaseId>/replies \
  -f body='<reply>'
```

The reply is short and plain. For a fix, say how the behaviour has changed;
there is no need to link a commit, unless you pushed a `fixup!` for the
reviewer to see on its own. For no change, give the reason in a sentence or
two. Sign every reply off on its own line with `~ 𝒞𝓁𝒶𝓊𝒹𝑒`.

Then resolve the thread:

```
gh api graphql -f query='mutation($id: ID!) { resolveReviewThread(input: {threadId: $id}) { thread { isResolved } } }' -F id=<thread id>
```

## 6. Hide the overview

Re-run the thread query. Once every Copilot thread is resolved, minimise each
Copilot review that is not already minimised, using the review's `PRR_` node
id from step 2:

```
gh api graphql -f query='mutation($id: ID!) { minimizeComment(input: {subjectId: $id, classifier: RESOLVED}) { minimizedComment { isMinimized minimizedReason } } }' -F id=<review id>
```

If any Copilot thread is still open (for example one you need Laura's view on),
leave the overview visible.

## 7. Report

Short summary for Laura: one line per thread with fixed or not-changed and why,
which commits the fixes went into and the branch's new head, and whether the
overview was hidden. Call out anything you left open for her to decide.
