---
name: explain
description: >
  Explain changes to a competent developer who is new to this codebase, like
  explaining to a junior engineer. Assumes general programming knowledge but no
  knowledge of this project, its history, or its conventions. Invoke to
  understand what a diff, branch, file, or change actually does and why. Use
  when asked to "explain this", "walk me through this", or "explain it like I'm
  a junior". For a simpler, no-jargon version, use the eli5 skill instead.
user-invocable: true
---

# Explain

Explain the change to a capable developer who has never seen this codebase.

Assume they know: programming, control flow, data structures, functions,
classes, testing, git, HTTP, databases, the command line, and the general shape
of the language in front of them.

Do not assume they know: this project, why it is built this way, what any
project-specific name means, which library is doing what, what the team's
conventions are, or what the surrounding code was doing before.

This skill is the middle ground between [eli5](../eli5/SKILL.md) (no assumed
knowledge at all) and a normal technical answer (assumes full context). If the
explanation reads like release notes for someone who already knows the system,
it has gone too far.

## What to explain

Work out what "the change" means from context, in this order:

1. If Laura names a target (a file, a branch, a PR, a commit, "that thing you
   just did"), explain that.
2. If there are uncommitted changes, explain those. Use `git status` and
   `git diff` (plus `git diff --staged`) to see them.
3. If the working tree is clean, explain the commits on the current branch
   against its base: `git log --oneline main..HEAD` then `git show` on each.
4. If none of that applies, explain the last piece of work from this session.

Read the actual diff before explaining, and read enough of the surrounding code
to know what the change is sitting inside. Do not guess from filenames.

## How to explain it

Lead with the point. One or two sentences saying what the change does and why,
before any detail.

Then, for each meaningful part:

- Name the file and the function or block it lives in, as `path/to/file.rb:42`
  so it is clickable.
- Say what the code did before and what it does now. The before matters more
  than people think, it is usually where the reason lives.
- Explain any project-specific name, type, or helper the first time it appears.
  One clause is enough: "`ChannelSpec`, which is the parsed form of a channel
  rule".
- Explain the mechanism, not just the outcome. "It now retries" is weak. "It
  wraps the call in a retry with exponential backoff, so a single dropped
  connection no longer fails the whole sync" is useful.
- Use real terminology. Say mutex, closure, migration, idempotent, race
  condition. Then, if the term is doing heavy lifting in the explanation, add a
  short clause saying what it means here.

Cover the things a newcomer cannot infer from the diff:

- Why this approach and not the obvious alternative, if there was a real choice.
- Anything surprising, load-bearing, or easy to break later.
- Knock-on effects: what else touches this, what a caller now needs to do
  differently, whether behaviour changed for existing data or existing users.
- Risks and gaps. Say plainly what is not covered, not tested, or assumed.

## Format

- Prose with short paragraphs. Bullets for lists of genuinely parallel items,
  not as a substitute for sentences.
- Code snippets are welcome where they carry the point. Keep them to the few
  lines that matter and say what they do straight after.
- Proportional to the change. A one-line fix gets a paragraph. A new subsystem
  gets a walkthrough with sections.
- British English, no em dashes.

## What not to do

- Do not restate the diff line by line. If the explanation could be replaced by
  `git diff`, it is not an explanation.
- Do not explain general programming concepts. No defining what a for loop, an
  interface, or a unit test is.
- Do not use a name, type, or acronym from this codebase without saying what it
  is, at least once.
- Do not skip the boring plumbing if it is what makes the change work.
- Do not smooth over a bad or risky bit of the change. Point at it.

## Example

Too simple (that is eli5's job):

```
Before, the code that checks your ticket was mixed in with the code that
answers the door. Now the ticket check lives in its own little room.
```

Too advanced (assumes the reader already knows the system):

```
Extracted the token refresh into middleware so the expiry check is unit
testable in isolation.
```

About right:

```
The token refresh logic has moved out of the request handler and into its own
middleware, so it runs before the handler rather than inside it.

Previously `handleRequest` in `api/handler.go:88` did two jobs: it checked
whether the caller's access token had expired and refreshed it if so, then it
served the request. That meant every test of the request path had to set up a
valid token and a fake token endpoint, even when the test had nothing to do
with auth.

Now `RefreshMiddleware` in `api/middleware/refresh.go:24` does the expiry check
and puts a guaranteed-fresh token on the request context. `handleRequest` just
reads it. Behaviour for callers is unchanged, but there is one difference worth
knowing: the refresh now happens for every request that passes through the
middleware chain, including ones that would have returned early before, so a
request that fails validation still costs a token check.

Nothing here handles a refresh failing mid-chain yet, it returns a 500. Worth
deciding whether that should be a 401 instead.
```
