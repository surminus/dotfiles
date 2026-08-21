---
name: eli5
description: >
  Explain changes as if Laura is five years old. Invoke to get a plain,
  jargon-free explanation of a diff, a branch, a file, or a change you have
  just made. Use when asked to "explain like I'm five", "eli5", or for a
  simple explanation of what some code does or what changed.
user-invocable: true
---

# ELI5

Explain the change as if you were explaining it to a five year old. That means
no jargon, no acronyms, and no assumed knowledge. If a technical word is
unavoidable, explain it with something a child would recognise first, then use
the word once.

## What to explain

Work out what "the change" means from context, in this order:

1. If Laura names a target (a file, a branch, a PR, a commit, "that thing you
   just did"), explain that.
2. If there are uncommitted changes, explain those. Use `git status` and
   `git diff` (plus `git diff --staged`) to see them.
3. If the working tree is clean, explain the commits on the current branch
   against its base: `git log --oneline main..HEAD` then `git show` on each.
4. If none of that applies, explain the last piece of work from this session.

Read the actual diff before explaining. Do not guess from filenames.

## How to explain it

- Short sentences. One idea per sentence.
- Use everyday comparisons: toys, snacks, LEGO, drawers, a post box, a queue at
  the shop, a light switch. Pick a comparison that actually matches how the
  thing works, not one that just sounds fun.
- Say what was happening before, what happens now, and why the new way is
  better. That order.
- Keep it to a handful of sentences per change. If there are several changes,
  give each one its own short paragraph or bullet, with the file it lives in.
- No code blocks unless a single line genuinely helps. If you include one,
  explain it in words straight after.
- Still British English, still no em dashes.

## What not to do

- Do not water down the facts. Simple wording, accurate content. If a change
  breaks something or has a risk, say so in simple words.
- Do not be patronising or do a performance of talking to a child. No "wow!",
  no baby talk, no excessive exclamation marks. Plain and friendly.
- Do not pad it out. Simple does not mean long.
- Do not skip a change because it is hard to explain. That is the one Laura
  most wants explained.

## Example

Bad:

```
This refactor extracts the token refresh logic into a dedicated middleware,
decoupling it from the request handler and allowing the expiry check to be
unit tested in isolation.
```

Good:

```
Before, the bit of code that checks your ticket is still valid was mixed in
with the bit that answers the door. That made it hard to test the ticket check
on its own.

Now the ticket check lives in its own little room. The door code just asks that
room "is this ticket alright?" and gets an answer back. Same behaviour, but we
can now poke at the ticket check by itself to make sure it works.
```
