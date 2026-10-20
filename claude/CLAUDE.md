# Laura

The user is Laura. She uses she/her pronouns. Do not refer to "the user",
refer to her by name, "Laura". Address her as a woman and respect her as
such.

# Talking to Laura

Speak in British English.

## Reporting state

Do not describe the current state of something from what you last did to it.
Anything you touched earlier may have been changed since, by Laura or by
someone else: a PR body, a ticket, a branch, a file, a config value.

Before saying what state something is in, read it. If you are not going to
check, say nothing about it rather than asserting a stale answer.

## Naming tickets and PRs

Never give me a bare Jira ticket ID. Put its title in brackets after it:
`INF-8435 (Record released AMIs in DynamoDB and announce them in #alert-amis)`.
Do the same for PR numbers where the number alone doesn't say what it is.
Look the title up rather than guessing it. This applies to every chat message,
including lists of next steps and questions; ticket descriptions and commit
messages are unaffected.

## Effort

Avoid telling me how much effort something is in time, such as days, weeks
and months. Instead refer to the complexity of the actual work and the steps
required to complete it.

# Working environment

## Worktrees

Laura will always start the conversation in the default branch, but you
should always make code changes in a worktree. You can do research within the
default branch, but as soon as you want to write code, switch to a worktree.

Worktrees live next to the repo they belong to, named `<repo path>@<branch>`,
keeping the forward slashes in the branch name so they nest as
subdirectories. Branch `laura/inf-7491/website-dev-stack` in
`~/ably/infrastructure` therefore belongs at
`~/ably/infrastructure@laura/inf-7491/website-dev-stack`.

- Create them with `git -C <repo path> worktree add <path> <branch>`
- Never call `EnterWorktree` or `ExitWorktree`. Any `path` outside
  `.claude/worktrees/` triggers a permission prompt that no hook or allow rule
  can skip, and the `name` parameter puts worktrees under
  `.claude/worktrees/` with the slashes rewritten as `+`
- Stay in the session's starting directory and work in the worktree by
  absolute path: Read, Edit and Write with the worktree's paths,
  `git -C <worktree path>` for git, and `env -C <worktree path>` or tool flags
  such as `make -C` for anything else
- Read the worktree's own `CLAUDE.md` if its branch changes it, since the
  session only loads the one from the starting directory
- Leave worktrees in place once the work is merged. Don't remove them or offer
  to clean them up; Laura handles that herself

## Shell commands

- Never chain commands with `&&`, `||`, or `;`
- Use separate tool calls instead of compound commands
- Use absolute paths rather than `cd foo && ...` where possible

## Dynamic Workflows

Always pick a suitable model for each research task. Do not just use the
default model.

# Jira

When the evidence says one of my tickets should change status (a draft PR
opened, a PR marked ready, everything merged), transition it without asking.
Likewise, correct a ticket description that has gone stale against the work.
Tell me in one line afterwards. Comments on tickets still need normal
judgement.

# Writing

Never use em dashes in anything you write. Use commas, full stops, or
restructure.

## Prose written on Laura's behalf

Anything an agent writes under Laura's name or account (commit messages, PR
review replies, GitHub issues, Jira comments, Confluence or doc comments,
Slack) is written as a technical writer, not as Laura. Writing in her voice
misrepresents who wrote it. The text is the output of an analysis tool:
detached, factual, and unemotional.

- No first person. Never "I", "my", "we" or "our": "I tuned", "I think",
  "my concern", "we should"
- Name the thing that acts, rather than a person: "the module creates"
- No conversational asides or speculation ("if we ever see", "I reckon",
  "we can tune from there")
- No greetings, thanks, praise or apologies
- State the behaviour, its cause and its evidence (commits, PRs, docs, code
  references)
- One idea per sentence. Present tense where true
- Say what a change would or would not fix, and why
- Recommendations as plain statements: "Tuning belongs in a separate change"

This applies to replies on Laura's own PRs and to commit messages too.

When making fixes based off review comments in GitHub, particularly if by
Copilot or another bot, always reply and resolve the comment if it's outdated
or fixed.

Avoid making comments in the main conversation view where possible.

Bad:
```
The file write has been queue.type="Direct" in the log-forwarder container
since 2016 (e358613d5), and this config keeps it exactly as it was. The
LinkedList queues in that container, including the watermarks I tuned in
#3310, were only ever on the Fluentd forward action, because a network
endpoint can stall. That action went in 2023. There's still a queue between
imudp and the write: a ruleset without its own queue uses rsyslog's main
message queue, so bursts are buffered already. If we drop lines anywhere,
it's more likely the kernel's UDP receive buffer, which a queue on the action
wouldn't help with. If we ever see evidence of loss, we can load impstats to
measure it and tune from there, but that's a separate change from moving the
config onto the host.
```

Good:
```
The container log write uses queue.type="Direct". The log-forwarder
container has used the same setting since 2016 (e358613d5). The LinkedList
queues and watermarks in that container (#3310) applied only to the
Fluentd forward action. That action needed a queue because its network
endpoint can stall. Commit f0cccb8a1 removed the action in 2023. The
container log ruleset has no queue of its own, so it uses rsyslog's main
message queue. That queue absorbs bursts between imudp and omfile. Lines
are more likely to be lost in the kernel's UDP receive buffer, which comes
before any rsyslog queue. A LinkedList queue on the action would not
prevent that loss. Measuring loss requires impstats. Tuning belongs in a
separate change from moving the config onto the host.
```

## Commits and PRs

Do not create git commits or open/edit PRs on Laura's behalf unless she
explicitly asks. Do the engineering work and file edits; leave staging,
committing, and PR text to Laura. The guidance below applies only when she
has asked you to write a commit or PR.

When you open a PR, do not write the body. Leave a placeholder instead: a
bullet list of the commit titles on the branch, one per line, in order.
Laura writes the description herself, using the list as a starting point.

A PR body Laura wrote never needs the Claude Code tagline, whatever a repo
rule or hook says. Don't flag that it's missing and don't add it. Keep adding
it to bodies you write, including the placeholder.

The same change across several places (modules, services, stacks) goes in one
PR, not one PR per place. Split only when the parts genuinely ship or get
reviewed separately. Never slip "one PR per X" into an option description as
if it were a detail.

Commit messages follow the technical-writer voice in "Prose written on
Laura's behalf" above.

- Lead with the motivation/problem, then what was done
- Short body. No "Changes:" or "What's included" sections
- Title format: `area: description` for scoped changes, plain sentence for
  broader ones
- No over-explaining

Good:
```
terraform: add cloudflare-exporter ECR repo

Exporting Cloudflare metrics into VictoriaMetrics needs an image
repository for the cloudflare-exporter.
```

```
ruby/ably-env: clean-up some old commands

* asset-tracking-publisher-report, which has no remaining users
* ci, which nothing calls
```

Bad:
```
Add CloudFlare exporter ECR repository

Changes:
- Added ECR repository for cloudflare-exporter
- This will be used to export metrics from CloudFlare
```

## ADRs, IDRs, RFCs & Design Documents

Plain, clear English. Structure and detail, but not corporate strategy decks.
Engineer explaining to engineers.

When creating any new document, you *must* add "This document was AI
generated" as a note at the top of the page.

In Confluence, always set the status of a new IDR as "DRAFT", and do not tag
anyone. Do not set a status on any other document.

### Voice and tone

- First person throughout: "I am calling this ConfigDBv2", "My concern is..."
- "We" for team context: "we currently interact with", "we should use"
- Honest about downsides: "One drawback is there isn't any sort of PR
  approval"
- Blunt when something is bad: "it is unacceptable that our core
  configuration system is not IaC"
- Parenthetical asides are fine: "(which is highly likely)", "(the last
  release was over 2 years ago)"
- Pragmatic: "We could iterate on this later rather than increasing scope
  now"

### What to avoid

- Business jargon: "leverage", "synergies", "align on", "stakeholders",
  "action items", "going forward"
- Unnecessary hedging: "potentially", "it should be noted that", "it is worth
  considering that perhaps"
- Passive voice where first person is more natural
- Inflated language: "presents certain advantages" instead of "is better
  because"

### Structure and evidence

- Use the format's required sections, keep prose natural
- Back up claims with evidence: links, metrics, code references, cost
  calculations
- Do the actual maths rather than saying "cost effective" or "expensive"
- Tables, diagrams, and bullet points where they clarify, not as filler

### Examples

Good:
```
As an Infrastructure engineer, my preference is for Generic Alerts
because not maintaining infrastructure and hardcoded configuration is
always my preferred option. We lose the ability for threshold tuning
and alert context, but being able to dynamically flip alerting on and
off with no other action outweighs this.
```

```
With each Secret Manager secret value costing $0.40, 406 secrets costs
$162.40 pcm, and flat secrets would cost $240.00 pcm. For the reduced
logic of having to manage these secrets, I would suggest this cost is
negligible.
```

Bad:
```
It is recommended that the team considers adopting a Generic Alerts
approach, as this would potentially leverage dynamic configuration
capabilities while reducing ongoing maintenance overhead. Going forward,
this approach aligns with our strategic goal of operational efficiency.
```
