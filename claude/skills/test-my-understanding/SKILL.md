---
name: test-my-understanding
description: >
  Quiz Laura with multiple choice questions on work Claude has done, so she can
  prove to herself she understands it before putting her name to it. Use when
  Laura runs /test-my-understanding, asks to "test my understanding", "quiz me", or
  check she has understood a change. Only run when Laura invokes it; never
  start it on your own after opening a PR. Covers why the change exists, how
  it works, what it changes in behaviour, and what it risks.
user-invocable: true
disable-model-invocation: true
---

# Test my understanding

Laura signs off on work Claude has done. This skill checks she understands it
well enough to defend it in review, debug it at 3am, and explain it to a
teammate. It is not a formality: the questions should be hard enough that
skimming the PR is not enough to pass.

## What to quiz on

Work out the subject in this order:

1. Whatever Laura names (a PR, a branch, a commit, "what you just did").
2. The PR opened most recently in this session.
3. The commits on the current branch against its base.

Read the actual diff and enough surrounding code before writing a single
question. Also use what this session knows that the diff does not: the
decisions taken, the alternatives rejected, review findings, and anything
tested by hand. Those are exactly the things Laura could miss.

## Writing the questions

Write 6 to 10 questions, scaled to the size of the change. Spread them across
these areas, and cover every one that applies:

- **Why**: the problem being solved, and what was wrong before.
- **Mechanism**: how the change actually works, at the level of the code
  path, not the commit title.
- **Behaviour change**: what a caller, operator or system now sees
  differently, including the cases that did not change.
- **Edge cases**: what happens on the unhappy path, under failure, at startup
  or shutdown, or in the case the code treats specially.
- **Decisions**: why this approach over the alternative that was considered.
- **Risk and rollout**: what could break, what the blast radius is, how it
  reaches production and how it would be rolled back.
- **Gaps**: what the change deliberately does not do, or leaves to later.

Rules for a good question:

- Ask about consequences and reasoning, not trivia. "Which file was changed"
  and "what is the function called" are useless. "What happens to a gated
  service that is disabled at boot" is useful.
- Every distractor must be plausible to someone who skimmed. Use the
  misreadings a reviewer would actually make, the previous behaviour, or the
  rejected alternative. No joke answers, no "all of the above".
- Exactly one correct answer, unless the question says "select all that
  apply" and uses multiSelect.
- Vary the position of the correct answer. Never mark it "(Recommended)" and
  never hint at it in the option descriptions.
- Option descriptions add detail to each choice, they do not argue for it.
- Write questions and options in plain British English, no em dashes.

## Asking

Use AskUserQuestion, up to 4 questions per call, in rounds until every
question has been asked. Keep each header to a short topic label ("Why",
"Startup", "Rollback"). Do not reveal any answers until a round's answers are
in.

If Laura answers with "Other" and free text, judge it on its substance: a
right answer in her own words is right.

## Marking

After each round, for every question:

- Say whether she got it right.
- When she got it wrong, say what the right answer is and why, pointing at the
  evidence as `path/to/file:line`, a commit, or the decision taken in the
  session. Explain why the option she picked is wrong, since that is the
  misunderstanding to fix.
- When she got it right, one line confirming it is enough.

Be direct. Don't soften a wrong answer, and don't praise a right one beyond
saying it is right.

## Follow-up

For every question she got wrong, ask one fresh follow-up question on the same
point from a different angle, in a final round. A rephrase of the same
question doesn't count, because she has just been told the answer. Mark the
follow-ups the same way.

## Summary

Finish with:

- The score, first round and follow-ups separately.
- The areas she is solid on and the areas she is not, in a line each.
- For any weak area, the specific files or commits to reread before the PR
  goes for review.

Keep a record of nothing. This is between Laura and the session.
