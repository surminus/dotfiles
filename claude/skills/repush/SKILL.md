---
name: repush
description: >
  Squash the fixup commits on the current branch into the commits they amend,
  then force push the branch. Use when Laura says "/repush", "repush", or
  "squash fixup commits and repush".
user-invocable: true
---

# Repush

Fold every `fixup!`, `squash!` and `amend!` commit on the branch into its
target, keeping the same base, then push with `--force-with-lease`.

## Find the branch

Work on the branch Laura means: the one named in her message, otherwise the one
from the current piece of work in this session, otherwise the current branch.
If that branch is `main`, stop and say so.

Find its worktree with `git -C <repo> worktree list` and run every git command
against it with `git -C <worktree path>`.

## Check before rewriting

1. `git -C <wt> status --porcelain`. If anything is uncommitted, stop and ask
   Laura what to do with it. Do not stash or commit it yourself.
2. Work out the base branch: `gh pr view --json baseRefName --jq .baseRefName`
   from the worktree (`env -C <wt> gh ...`), falling back to `main` when there
   is no PR.
3. `git -C <wt> fetch origin <base> <branch>`.
4. If `origin/<branch>` has commits that are not in the local branch
   (`git -C <wt> log --oneline HEAD..origin/<branch>`), stop and show them.
   Someone else pushed, and a force push would throw their work away.
5. `git -C <wt> log --oneline origin/<base>..HEAD` and check there is at least
   one fixup commit. If there are none, say so and push only if the local branch
   is ahead of `origin/<branch>`.

## Squash

Keep the existing base so the squash does not also pull in a rebase onto newer
`main`:

```
git -C <wt> -c sequence.editor=: rebase -i --autosquash --keep-base origin/<base>
```

If the rebase stops on a conflict, resolve it in the commit being replayed,
continue, and tell Laura which commit conflicted and how you resolved it. If it
cannot be resolved sensibly, `git rebase --abort` and report.

Afterwards confirm nothing is left over:

```
git -C <wt> log --format=%s origin/<base>..HEAD
```

No subject may start with `fixup!`, `squash!` or `amend!`. Also compare the tree
with what was there before: `git -C <wt> diff ORIG_HEAD HEAD` must be empty,
since squashing changes history, not content.

## Push

```
git -C <wt> push --force-with-lease origin <branch>
```

Never use `--force`.

## Report

One or two lines: how many fixups were squashed, the resulting commit list
(`git log --oneline origin/<base>..HEAD`), and that the push succeeded. Quote
the error if it did not.
