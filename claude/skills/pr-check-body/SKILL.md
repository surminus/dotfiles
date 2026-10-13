---
name: pr-check-body
description: >
  Check that the PR description Laura has written is accurate against the
  branch: every claim matches the diff, commits and anything else it refers
  to. Read-only, reports findings and never edits the body. Use when Laura
  says "/pr-check-body" or asks whether her PR body is accurate.
user-invocable: true
---

# PR check body

Laura writes her own PR descriptions. This checks what she wrote is true. It
is not a style review and not a rewrite: only flag something that is wrong,
misleading, or no longer matches the branch.

## 1. Find the PR

Use the PR Laura names, otherwise the one for the current piece of work in this
session, otherwise `gh pr view` from the current branch. Note `<owner/repo>`,
`<n>`, the base and head branches, and find the head branch's worktree with
`git -C <repo> worktree list` if there is one.

## 2. Read the current state

Always read fresh, never from memory of earlier in the session. Laura may have
edited the body or pushed since.

```
gh pr view <n> -R <owner/repo> --json title,body,baseRefName,headRefName,headRefOid,commits,files
gh pr diff <n> -R <owner/repo>
```

Read each commit message in full (`git -C <wt> log --format='%H%n%B' origin/<base>..origin/<head>`
after a fetch, or the `commits` field), since the reasoning often lives there.

## 3. Check every claim

Break the body into its individual claims and check each against the evidence:

- **What changed**: anything the body says was added, removed, renamed or
  moved must appear in the diff. Check names, paths, flags, versions and
  numbers exactly.
- **Scope**: if the body says "only", "just", "all", "every" or "no", check the
  diff bears that out. Flag a change the body implies is not there, or one big
  enough that the body's summary misleads without it. Do not flag every small
  thing the body leaves out.
- **Why and impact**: claims about current behaviour, what breaks, what a
  setting does, or what happens on deploy. Read the surrounding code, not just
  the diff, to confirm them.
- **References**: ticket IDs, other PRs, linked docs, dashboards. Check they
  exist and say what the body says they do. Check the title's ticket is the
  right one for the work.
- **Title**: matches what the PR does.
- **Staleness**: claims that were true of an earlier version of the branch but
  not of the current head, for example something since dropped or renamed in a
  fixup.

Do not flag:

- Tone, wording, length or structure, unless the wording makes a claim false
- A missing Claude Code tagline. Bodies Laura writes do not need one
- Things the body reasonably leaves to the diff or commits

If a claim cannot be checked from what is reachable (for example, it depends on
production state you cannot read), say so rather than guessing.

## 4. Report

Read-only throughout. Do not edit the PR, post comments or change the branch.

Report in chat:

- One line per problem: quote the claim, say what is actually true with
  evidence (`file:line`, commit, or link), and suggest corrected wording where
  it helps
- Claims you could not verify, with why
- If everything checks out, say so in one line

Name tickets and PRs with their titles, never as bare IDs.
