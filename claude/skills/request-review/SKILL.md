---
name: request-review
description: >
  Mark Laura's draft PR as ready for review and request a review from the
  repo's reviewers, once her own review is done. The follow-on to /draft-pr.
  Use when Laura says "/request-review" or asks to mark a PR ready and request
  a review.
user-invocable: true
---

# Request review

`/draft-pr` opens a draft for Laura to review herself. Invoking this is her
saying that review is done: mark the PR ready and request a review.

## 1. Find the PR

Use the PR Laura names, otherwise the one for the current piece of work in this
session, otherwise `gh pr view` from the current branch's worktree. Note
`<owner/repo>`, `<n>` and the head branch.

## 2. Check it is ready

Read fresh state, never from memory of earlier in the session:

```
gh pr view <n> -R <owner/repo> --json title,body,isDraft,headRefName,commits,reviewRequests
gh pr checks <n> -R <owner/repo>
```

Stop and tell Laura, without marking it ready, if any of these hold:

- **Body is still the placeholder.** It is only the commit-subject bullets and
  the tagline, or it is empty. Laura writes the description; do not write it.
- **Fixup commits.** Any commit subject starts with `fixup!`, `squash!` or
  `amend!`. Offer `/repush`.
- **Unresolved review threads.** Fetch them with the GraphQL API
  (`reviewThreads` with `isResolved`) and list any still open, with links.
- **CI failing.** Name the failing checks and quote the shortest line that
  says why.

If checks are still running, wait for them in the background
(`gh pr checks <n> -R <owner/repo> --watch --fail-fast`) and carry on once they
finish green.

If the PR is already not a draft, skip to requesting the review.

## 3. Mark ready and request

```
gh pr ready <n> -R <owner/repo>
gh pr edit <n> -R <owner/repo> --add-reviewer <reviewers>
```

Take the reviewers from the repo's rules (in `ably/infrastructure` that is
`ably/team-infrastructure`). If the repo does not say, ask Laura who to
request rather than guessing. Skip anyone already requested.

## 4. Ticket

Transition the PR's ticket to match a PR in review (normally "In Review") if
it is not already there, and mention it in one line.

## Report

One or two lines: the PR link with its title, that it is ready, who was
requested, and the ticket's new status. Name tickets and PRs with their
titles, never as bare IDs.
