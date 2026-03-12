---
name: git
description: Use when making git commits, reviewing history, or working with version control. Covers commit philosophy, message style, and history hygiene.
user-invocable: false
---

# Git

Commit history is the most important artefact in a codebase. We use it to reason about why changes were made and by who. Treat it with the same care you would treat production code.

## Before making changes

Before touching code, understand its context. Use `git log` and `git blame` to read the history of the files you're about to change. This tells you why the code looks the way it does, who last worked on it, and whether there's an ongoing effort you might be stepping on.

Don't skip this. If you're modifying something and you don't know why it was written that way, you're guessing.

## Staging and committing

Before committing anything, check which branch you're on. Never commit directly to `main`. If you're on `main`, create a branch first and switch to it before going any further.

Use `git add -p` to stage changes interactively. This forces you to review every hunk before it goes into a commit, and makes it easy to split unrelated changes across separate commits. Don't just `git add .` or `git add -A` unless you're certain everything in the working tree belongs together.

A commit should contain one logical change. If you're renaming a function and fixing a bug, those are two commits. If you're adding a feature that touches three files, that's one commit.

Commit as you go. Don't accumulate a pile of unrelated changes and try to sort them out later. Small, frequent commits make the history easier to read and easier to revert if something goes wrong. Each commit should tell a self-contained story.

## Commit messages explain *why*, not *what*

The diff already shows what changed. The commit message needs to explain why you made the change. What was the motivation? What problem does it solve? What was wrong before?

If you're not sure why a change is being made, ask the user. Don't write a vague message, get the real reason and capture it.

Even a tiny one-line change can warrant a longer explanation. The size of the diff has no bearing on the importance of the context. A one-character fix that prevents a production outage deserves a message that explains exactly what was going wrong and why.

Commit messages should never be just bullet points of files changed. That's useless. Anyone can run `git diff` to see which files were touched.

## Branches

Name branches as `name/area/description`, for example `laura/tool/feature` or `laura/bugfix/null-pointer-in-auth`. The name prefix makes it easy to see who's working on what, the area gives quick context, and the description says what the branch is for.

Branch from an up-to-date base. Before starting work, make sure you're branching from the latest main (or whatever the target branch is), not from something stale.

Rebase regularly. Always use rebase (not merge) to integrate upstream changes. Rebasing keeps history linear and readable. Do it often rather than leaving it until the end, where you'll have a painful conflict resolution session instead of a series of small, manageable ones.

One branch per logical piece of work. Like commits, branches should be cohesive. If you're doing two unrelated things, use two branches.

## Fixing up previous commits

When you realise a previous commit needs a small adjustment (a typo, a missing import, a minor correction), use `git commit --fixup <sha>` to mark the fix as belonging to that earlier commit. This keeps the intent clear: the fixup is not a new logical change, it's a correction to an existing one.

When appropriate, suggest running `git rebase --autosquash -i` to fold fixups into their parent commits before pushing or opening a PR.

## Rebasing and conflicts

Always rebase, never merge. When integrating upstream changes or rewriting history, use `git rebase`.

Resolve conflicts commit-by-commit as the rebase replays them. Don't `--skip` commits. Each conflict is a chance to make sure the replayed commit still makes sense on top of the new base. Resolve them manually in the editor.

If `git rerere` is enabled, git will remember how you resolved a conflict and automatically apply the same resolution if it sees the same conflict again. This is particularly useful when re-rebasing after a failed attempt.

Sometimes a commit is no longer necessary (the upstream changes made it redundant, or the approach changed). In that case, use interactive rebase and delete the entire line for that commit. If removing the commit causes conflicts in later commits, resolve them as normal during the rebase.

If a rebase produces an overwhelming number of conflicts on almost every commit and it's clear the branch has diverged too far, the last resort is to abort the rebase, reset all the commits, and create fresh ones on top of the current base. This throws away the original commit history on the branch, so always confirm with the user before doing this. It's a nuclear option, not a convenience.

## Before pushing for review

Before pushing a branch for review, walk through the full commit log in order. Check that each commit is atomic, the messages explain intent, and the sequence tells a coherent story. Look for commits that should be squashed, reordered, or reworded. This is the last chance to clean up before someone else reads the history.

Use `git log --oneline` for a quick overview, then `git log -p` or `git show` on individual commits if anything looks off.

## Recovery and history rewriting

`git reflog` is your safety net. If something goes wrong with a rebase or a reset, you can almost always get back to where you were. Know it's there, use it when you need it.

If history needs rewriting (reordering commits, rewording messages, squashing), do it before the work is shared. Once commits are pushed and others might be building on them, rewriting history gets dangerous.

If you do need to force push, always use `git push --force-with-lease`. Never use `--force`. `--force-with-lease` will refuse to overwrite the remote if someone else has pushed since you last fetched, which prevents you from silently destroying their work.

## Summary

1. Read the history before changing code (`git log`, `git blame`)
2. Use `git add -p` to stage intentionally
3. Make atomic commits, commit as you go
4. Write messages that explain why, not what
5. Ask the user if the reason for a change isn't clear
6. Branch from an up-to-date base, one branch per piece of work
7. Use `--fixup` for corrections to earlier commits
8. Use `git reflog` when things go sideways
