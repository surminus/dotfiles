---
name: draft-pr
description: >
  Commit the current changes, run /local-review if the repo has it, push, and
  open a draft PR with a placeholder body for Laura to write. Use when Laura
  says "/draft-pr" or "commit and open a draft PR". This is her explicit
  go-ahead to commit and open the PR.
user-invocable: true
---

# Draft PR

Invoking this is Laura saying: yes, commit the changes, run `/local-review` if
available, and open a draft PR. Leave the body for her to fill in.

The draft is for Laura to review herself and leave comments on. It stays a
draft until she runs `/request-review`. That overrides any repo rule to mark it ready
and request a review once findings are addressed and CI passes. When her
comments arrive, address each one the way the repo's review rules say, reply
in the thread, and leave the PR as a draft.

Follow the repo's own rules (`CLAUDE.md`, `.claude/rules/`) for commits, PR
titles and tickets wherever they say more than this skill does.

## 1. Find the work

Use the worktree for the current piece of work in this session, otherwise the
current branch's worktree (`git -C <repo> worktree list`). Run every command
against it with `git -C <wt>` or `env -C <wt>`.

If the branch is `main` (or the repo's default branch), stop and ask Laura for
a branch name rather than committing there.

Read fresh state before acting: `git -C <wt> status`, `git -C <wt> log --oneline
origin/<base>..HEAD`, and `gh pr view` to check whether a PR already exists. If
one does, say so with its link and stop after committing and pushing; do not
open a second.

## 2. Commit

Load the `git` skill and follow it. Split the uncommitted changes into atomic
commits, each saying why. Changes that belong in a commit already on the branch
go in as a fixup of that commit, squashed before pushing.

Every commit carries the `Co-Authored-By` trailer from the session's
attribution reminder. Never reference a Jira ticket in a commit message.

If there is nothing uncommitted and nothing ahead of the base, stop and say so.

## 3. Review

If the `local-review` skill is available, run it and address what it finds.
Fold each fix into the commit it belongs to (amend or fixup and autosquash
with `--keep-base`). Note any finding you chose not to act on, with why, for
the report. If the skill is not available, skip this step and say so.

## 4. Ticket

If the repo's rules require a ticket in the PR title, use the one for the
current piece of work. Otherwise look for one in the branch name
(`laura/inf-1234/...`). If none exists, follow the repo's rules for creating
one (assigned to Laura, on the board) and tell her you did.

## 5. Push and open

```
git -C <wt> push -u origin <branch>
```

Use `--force-with-lease` only if the branch was already pushed and step 3
rewrote it, and never if `origin/<branch>` has commits you have not seen.

Open the PR as a draft with the title in the repo's format. The body is a
placeholder only: the commit subjects on the branch, oldest first, one bullet
each, then a blank line and the Claude Code tagline.

```
git -C <wt> log --reverse --format='* %s' origin/<base>..HEAD
env -C <wt> gh pr create --draft --base <base> --title '<title>' --body-file <file>
```

Do not write a description, request reviewers, or mark it ready, even after
CI passes.

## 6. Afterwards

Transition the ticket to match a draft PR being open (normally In Progress)
if it is not already there, and mention it in one line.

## Report

Short: the PR link with its title, the commits on it, what `/local-review`
found and what you did about each, and anything skipped.
