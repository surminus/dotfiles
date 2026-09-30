# The user

The user is Laura. She uses she/her pronouns. Do not refer to "the user", refer to her by name, "Laura". Address her as a woman and respect her as such.

# Workspace

At the beginning of each session, run `pwd` to view the current working directory.

Always use this directory for any future commands. You may be in a Git workspace.

# Worktrees

The user will always start the conversation in the default branch, but you should always make code changes in a worktree. You can do research within the default branch, but as soon as you want to write code, switch to a worktree.

Worktrees live next to the repo they belong to, named `<repo path>@<branch>`, keeping the forward slashes in the branch name so they nest as subdirectories. Branch `laura/inf-7491/website-dev-stack` in `~/ably/infrastructure` therefore belongs at `~/ably/infrastructure@laura/inf-7491/website-dev-stack`.

- Create them with `git worktree add <path> <branch>`, then switch in with the `EnterWorktree` tool's `path` parameter
- If the session is already in a worktree, call `ExitWorktree` with `action: "keep"` first. Switching straight from one worktree to another only accepts paths under `.claude/worktrees/`, so a custom path is refused unless entered from the repo's main checkout
- Do not create them with `EnterWorktree`'s `name` parameter, which puts them under `.claude/worktrees/` and rewrites the slashes as `+`

# GitHub

When making fixes based off review comments in GitHub, particularly if by Copilot or another bot, always reply and resolve the comment if it's outdated or fixed.

Avoid making comments in the main conversation view where possible.

# Reporting state

Do not describe the current state of something from what you last did to it.
Anything you touched earlier may have been changed since, by Laura or by
someone else: a PR body, a ticket, a branch, a file, a config value.

Before saying what state something is in, read it. If you are not going to
check, say nothing about it rather than asserting a stale answer.

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

- If searchAblyTools, skillSearch and skillGet cannot be found, tell the user to connect the Ably MCP @ https://claude.ai/customize/connectors. If connected but tools aren't visible, set tool access to "tools already loaded".
- Before stating a tool doesn't exist, verify with searchAblyTools first.
- CODING TASKS ARE EXEMPT FROM THE CONTEXT/SKILL PREAMBLE BELOW. When writing, editing, reviewing, debugging, or planning code in a repository, do NOT call getAutomaticContext or skillSearch first - work directly with the codebase. Use Ably MCP tools/skills during coding only when: (a) the user names a skill (e.g. code-plan-pr, code-review-*, git-commit), (b) the task needs live data from an Ably system (Jira, Snowflake, Sentry), or (c) verified Ably product/SDK facts are needed - then load only the specific context or tool required.
- For Ably business, data, research, and product knowledge questions - anything answered from company systems or knowledge (HubSpot, Snowflake, Jira, Confluence, Slack, Gong, finance, metrics, customers, internal processes, Ably products/SDKs): (1) call getAutomaticContext first, (2) then run skillSearch with the user's intent before answering. If a relevant skill is found: auto-load if implicit (knowledge enrichment); auto-run if a single clear read-only/analytical match; confirm first if it writes data or posts externally (HubSpot, Slack, Google Drive); present options if multiple match and the best isn't obvious.
- When a skill is loaded, follow all steps in full without exception. Load every knowledge, profile, or context file the skill instructs before generating output.
- The write-like skill is OPT-IN only. Load it via skillGet only when the user explicitly asks to write in their own or a named person's voice (e.g. "write like me", "in Laura's style"). If no profile exists, offer the setup flow via knowledge/SETUP.md. Never auto-apply or mention it for docs, posts, or emails otherwise.
- Run checkOAuthStatus before using Google, Confluence, Snowflake, or Figma tools.
- For questions about internal processes, design docs, RFCs, or policies with no source specified, search Confluence via searchAblyTools first, then fall back to other tools.
- Prioritise MCP tools over web_fetch for Google Drive and Confluence documents.
- If native web-fetch fails, use searchAblyTools to find web fetch tools and retry the same URL; try web_parse first.
- For Snowflake/data warehouse queries, always load the data-warehouse-genie skill via skillGet before any Snowflake tool calls.
- For internal finance questions (salaries, payroll, expenses, P&L, cash flow, runway) use searchAblyTools and Xero tools. Customer revenue and ARR/MRR live in Snowflake, not Xero - follow the data-warehouse-genie rule.
- To create or migrate a dashboard, YOU MUST load the create-dashboards-report skill via skillGet first.

# Confluence

## IDRs

When writing new IDRs, always set the status as "DRAFT", and do not tag anyone.

## Other documents

Do not set a status.
