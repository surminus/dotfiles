# The user

The user is Laura. She uses she/her pronouns. Do not refer to "the user", refer to her by name, "Laura". Address her as a woman and respect her as such.

# Workspace

At the beginning of each session, run `pwd` to view the current working directory.

Always use this directory for any future commands. You may be in a Git workspace.

# Worktrees

Worktrees live next to the repo they belong to, named `<repo path>@<branch>`, keeping the forward slashes in the branch name so they nest as subdirectories. Branch `laura/inf-7491/website-dev-stack` in `~/ably/infrastructure` therefore belongs at `~/ably/infrastructure@laura/inf-7491/website-dev-stack`.

- Create them with `git worktree add <path> <branch>`, then switch in with the `EnterWorktree` tool's `path` parameter
- Do not create them with `EnterWorktree`'s `name` parameter, which puts them under `.claude/worktrees/` and rewrites the slashes as `+`

# Models

The main session runs on Sonnet, and it should stay there. Routine work, file
edits, shell commands, searches, reading code and short questions all belong on
the default model.

Delegate work that genuinely needs a stronger model to a subagent with an
explicit model rather than switching the whole session. Doing this is
authorised: spawning subagents for model selection does not need to be asked
about first. Pick the model from the complexity of the work:

- Haiku: trivial lookups fanned out wide, so "which of these files mentions X",
  single-fact greps, reading one value out of a config. No judgement required
- Sonnet: mechanical edits, applying fixes someone else has already decided on,
  searching, locating code, summarising, running commands, anything already
  scoped
- Fable: prose where the voice matters, so ADRs, IDRs, RFCs, design documents,
  PR bodies and docs
- Opus: architecture and design decisions, debugging where the cause is
  unknown, security review, code review, large multi-file refactors, anything
  needing a plan before the first edit

Set the model with the Agent tool's `model` parameter when spawning, or with
`model:` in the frontmatter of an agent definition in `~/.claude/agents/` when
that agent should always use a particular model. Precedence is: per-spawn
`model`, then the agent definition's `model:`, then the
`CLAUDE_CODE_SUBAGENT_MODEL` environment variable, then inheriting the main
session's model.

Do not switch the main session to Opus without asking Laura first. If a task
needs it, say so and let her run `/model`.

# Dynamic Workflows

Always pick a suitable model for each research task. Do not just use the default model.

# Shell commands

- Never chain commands with `&&`, `||`, or `;`
- Use separate tool calls instead of compound commands
- Use absolute paths rather than `cd foo && ...` where possible

# Work Language

Avoid telling me how much effort something is in time, such as days, weeks and months. Instead refer to the complexity of the actual work and the steps required to complete it.

# Tone of Voice

Speak in British English.

## Commits and PRs

Do not create git commits or open/edit PRs on Laura's behalf unless she
explicitly asks. Do the engineering work and file edits; leave staging,
committing, and PR text to Laura. The guidance below applies only when she
has asked you to write a commit or PR.

When you open a PR, do not write the body. Leave a placeholder instead: a
bullet list of the commit titles on the branch, one per line, in order.
Laura writes the description herself.

Conversational, first-person voice, like talking to a teammate.

- Lead with the motivation/problem, then what was done
- First person: "I'm interested in...", "I've also...", "I think this would..."
- Short and casual body. No "Changes:" or "What's included" sections
- Title format: `area: description` for scoped changes, plain sentence for broader ones
- No passive voice, no over-explaining
- PR descriptions: plain conversational text, full lines without wrapping. No structured headers like "## Summary" or "## Test plan" unless the PR is genuinely large
- Never use em dashes. Use commas, full stops, or restructure
- Dry or slightly sarcastic tone is fine where natural (e.g. "which I don't think anyone needs anymore")

Good:
```
terraform: add cloudflare-exporter ECR repo

I'm interested in exporting metrics from Cloudflare into our
VictoriaMetrics cluster.
```

```
ruby/ably-env: clean-up some old commands

* asset-tracking-publisher-report, which I don't think anyone needs
  anymore
* ci, I don't reckon anyone uses this
```

Bad:
```
Add CloudFlare exporter ECR repository

Changes:
- Added ECR repository for cloudflare-exporter
- This will be used to export metrics from CloudFlare
```

## ADRs, IDRs, RFCs & Design Documents

Plain, clear English. Structure and detail, but not corporate strategy decks. Engineer explaining to engineers.

When creating any new document, you *must* add "This document was AI generated" as a note at the top of the page.

### Voice and tone
- First person throughout: "I am calling this ConfigDBv2", "My concern is..."
- "We" for team context: "we currently interact with", "we should use"
- Honest about downsides: "One drawback is there isn't any sort of PR approval"
- Blunt when something is bad: "it is unacceptable that our core configuration system is not IaC"
- Parenthetical asides are fine: "(which is highly likely)", "(the last release was over 2 years ago)"
- Pragmatic: "We could iterate on this later rather than increasing scope now"

### What to avoid
- Business jargon: "leverage", "synergies", "align on", "stakeholders", "action items", "going forward"
- Em dashes
- Unnecessary hedging: "potentially", "it should be noted that", "it is worth considering that perhaps"
- Passive voice where first person is more natural
- Inflated language: "presents certain advantages" instead of "is better because"

### Structure and evidence
- Use the format's required sections, keep prose natural
- Back up claims with evidence: links, metrics, code references, cost calculations
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

# Ably MCP

## Context & Tool Discovery

- For ALL Ably/work questions, ALWAYS call `getAutomaticContext` first with `conversationContext` describing your question, then proceed using `searchAblyTools` and available MCP tools.
- For Skills, use the MCP tools (`skillSearch`, `skillGet`) as priority.
- Run `checkOAuthStatus` before using the following tools: Google, Confluence, Snowflake, Figma.
- Prioritise MCP tools over `web_fetch` for Google Drive and Confluence documents.

## Confluence

### IDRs

When writing new IDRs, always set the status as "DRAFT", and do not tag anyone.

### Other documents

Do not set a status.
