---
name: interview
description: >
  Interview Laura about a piece of work before it starts, one decision at a
  time, until Claude and Laura share the same understanding of what is being
  built and why. Use when Laura runs /interview or asks to be interviewed or
  grilled about a plan, ticket or idea before any code is written.
user-invocable: true
disable-model-invocation: true
---

# Interview

Before writing anything, get to the point where Claude could build the work
without guessing, and Laura could predict what Claude would build. Every
decision that would change the code, the rollout or the PR gets made here, out
loud, rather than silently during implementation.

This is a conversation, not a form. Ask, listen, push back, and follow the
answer wherever it leads.

## Work out the subject

In this order:

1. Whatever Laura names: a Jira ticket, a PR, an idea in the arguments.
2. The ticket or work being discussed in this session.
3. If neither, ask what she wants to build, in one line.

## Do the homework first

Before the first question, read everything that can answer questions without
Laura:

- The ticket, its parent epic and any linked tickets or documents.
- The code the work will touch, and the code that calls it.
- The relevant architecture documents in `docs/`, if the repo has them.
- Recent commits and open PRs in the same area.

Never ask Laura something the code, the ticket or the docs already answer. If
the code answers it, state what you found as a fact she can correct ("The
lease is renewed by the caller, `lock.go:88`, so I'm assuming that stays"),
rather than asking.

Then open with two or three sentences saying what you think the work is, so
she can correct the framing before anything else.

## Map the decisions

List the open decisions privately, as a tree: some decisions only exist
because of how an earlier one was answered. Ask the ones higher up the tree
first, and drop branches an answer makes irrelevant.

Cover whichever of these apply, and skip the rest:

- **Problem**: what is wrong today, who feels it, and how we would know it is
  fixed.
- **Scope**: what is in, what is explicitly out, and what is left for later.
- **Approach**: the shape of the solution, and the alternative it beats.
- **Interfaces**: what callers, operators or other systems see change.
- **State and data**: what is stored, where, and what happens to what exists
  already.
- **Failure**: what happens when a dependency is down, slow or wrong, and on
  startup and shutdown.
- **Rollout**: how it reaches production, in what order, what the blast radius
  is, and how it is rolled back.
- **Testing**: how we prove it works before it ships, and where (local, dev
  cluster, staging).
- **Shape of the work**: how the commits and PRs split, and what ships first.

## Asking

- One decision at a time. Batch only questions that are genuinely independent
  of each other, and never more than four.
- Every question comes with a recommended answer and a sentence of reasoning,
  backed by what the homework found. Laura should be able to reply "yes" and
  move on.
- When the choice is between a few concrete options, use AskUserQuestion with
  the recommended option first, marked "(Recommended)". When it is open-ended,
  ask in plain text.
- Keep each question short. The context she needs goes in the option
  descriptions or one line before the question, not a paragraph.

## Listening

- When an answer conflicts with the code, an earlier answer or the ticket, say
  so straight away and with evidence. Don't quietly accept it.
- When an answer opens a new decision, add it to the tree and ask it when its
  turn comes.
- When an answer is vague ("it should handle errors properly"), ask what that
  means concretely before moving on.
- When Laura doesn't know, offer to find out from the code or the system now,
  or record it as an open question. Don't invent an answer for her.
- If you need to look something up to ask the next question well, do it
  between questions.

Don't start writing code, editing files or creating tickets during the
interview.

## Stopping

Stop when no open decision would change what gets built, or when Laura says
so. Don't pad the interview with questions that wouldn't change anything.

## Summary

Finish with a short write-up in chat:

- What we are building and why, in two or three sentences.
- The decisions taken, each with its reason in a line.
- What is out of scope.
- Open questions, and who or what answers each one.
- The plan: the order of the work and how it splits into commits and PRs.

Then offer to record the decisions and out-of-scope list on the Jira ticket,
since decisions belong there rather than in the PR. Only write to the ticket
if she says yes.

Write everything in British English, with no em dashes.
