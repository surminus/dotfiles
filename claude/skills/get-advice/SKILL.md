---
name: get-advice
description: >
  Ask a context-free agent for a second opinion on a decision, plan or stuck
  problem, so the answer isn't anchored on the assumptions this session has
  built up. Use when Laura runs /get-advice or asks for a second opinion, and
  on your own initiative when you are stuck (two or three attempts at a bug or
  approach have failed) or before committing to a choice that is costly to
  reverse, such as an architectural decision, a data migration or an
  interface other code will depend on. Not for code review of a diff, which is
  what /local-review is for.
user-invocable: true
---

# Get advice

A long session builds up assumptions: alternatives rejected early, a framing
of the problem nobody has questioned since, a fix that has been tweaked three
times instead of rethought. An agent with none of that context can see what
this session can't. This skill is only worth running if the brief gives the
agent the facts without handing it the conclusion.

## When to use it on your own

- You have tried two or three fixes for the same problem and none has worked.
- You are about to make a choice that is expensive to undo, and you got there
  by reasoning rather than evidence.
- Laura has pushed back on your approach and you aren't sure whether she's
  right.

Don't use it for questions with a factual answer you can look up, for
questions whose context is mostly the conversation itself, or more than once
on the same question. Tell Laura in one line when you start it and why.

## Writing the brief

The brief is everything the agent knows. Write it as if for a capable engineer
who has never seen this repository or this session.

Include:

- **The problem or decision**, stated as neutrally as you can. Describe the
  situation, not your diagnosis of it. "Requests to X intermittently time out
  after deploy" rather than "the connection pool is too small".
- **The goal and the constraints**: what must be true of a good answer, and
  what is fixed.
- **The evidence**: error output, measurements, what you observed. Quote the
  shortest decisive lines rather than summarising them.
- **Where to look**: file paths, docs, tickets, commands. Let the agent read
  the code itself rather than paraphrasing it.
- **What has been tried**, with what happened each time, as facts.
- **The options considered**, unranked and in neutral wording, and an explicit
  question about what is missing from the list.

Leave out:

- Which option you prefer, or which one Laura prefers.
- Your confidence in any option, or adjectives that rank them ("the simple
  approach", "the hacky fix").
- Session history that doesn't bear on the decision.

Before sending, reread the brief and ask whether someone could guess your
preferred answer from it. If they could, rewrite it.

## Running the agent

- Use a fresh agent, never a fork: a fork inherits this session's context,
  which defeats the point.
- Use the `Plan` agent type, so it can read and search but not edit, and the
  `opus` model.
- Ask it to return:
  - its recommendation and the reasoning behind it,
  - the risks and failure modes it sees in the recommended option and in the
    others,
  - anything in the framing it thinks is wrong,
  - what it would check first to confirm or refute its recommendation.

For a high-stakes decision, run two agents in parallel with independently
worded briefs. If they disagree, the answer depends on framing, and that is
worth telling Laura.

## Reporting back

Report the advice in full to Laura, not just the parts that support the
current plan:

- What the agent recommended and why, in a few lines.
- Where it disagrees with what you were going to do, stated plainly.
- What you now think, and whether the plan changes. If you are not following
  the advice, say why with evidence.

If it recommended a check, run it before deciding, where it is cheap and
read-only.

Write in British English, with no em dashes.
