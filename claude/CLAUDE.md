# Ably MCP

## Context & Tool Discovery

- For ALL Ably/work questions, ALWAYS call `getAutomaticContext` first with `conversationContext` describing your question, then proceed using `searchAblyTools` and available MCP tools.
- For Skills, use the MCP tools (`skillSearch`, `skillGet`) as priority.
- Run `checkOAuthStatus` before using the following tools: Google, Confluence, Snowflake, Figma.
- Prioritise MCP tools over `web_fetch` for Google Drive and Confluence documents.

## Confluence

### IDRs

When writing new IDRs, always set the status as "DRAFT", and do not tag anyone.

## Commit & PR Tone of Voice

Write commits and PRs in a conversational, first-person voice, like talking to a teammate.

- Lead with the motivation/problem, then explain what was done
- Use first person naturally: "I'm interested in...", "I've also...", "I think this would..."
- Keep the body short and casual, no formal "Changes:" or "What's included" sections
- Title format: `area: description` for scoped changes, or plain sentence for broader ones
- Avoid passive voice, over-explaining, and documentation-style language
- PR descriptions should read like commit messages, just plain conversational text. No structured headers like "## Summary" or "## Test plan" unless the PR is genuinely large
- Never use em dashes. Use commas, full stops, or just restructure the sentence
- It's fine to be slightly dry, sarcastic, or passive aggressive where it fits naturally (e.g. "which I don't think anyone needs anymore", "I don't reckon anyone uses this")

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

Write in plain, clear English. These documents need structure and detail, but should not read like corporate strategy decks. The voice should sound like an engineer explaining something to other engineers.

### Voice and tone
- Use first person naturally throughout: "I am calling this ConfigDBv2", "I've started to wonder whether...", "My other concern is that..."
- Use "we" for team context: "we currently interact with", "we should use"
- Be honest about downsides: "One drawback for this proposed workflow is that there isn't any sort of PR approval"
- Let thinking evolve in the document: "Since I crafted the initial proposal, I've started to wonder whether trying to strictly copy the previous workflow was suitable"
- Be blunt when something is bad: "it is unacceptable that our core configuration system is not IaC", "Hashicorp Cloud would likely be very expensive"
- Parenthetical asides are fine: "(which is highly likely)", "(the last release was over 2 years ago)", "(note: this does create a bit of a catch-22, which is worth thinking about)"
- Pragmatic recommendations: "This probably is an option we could iterate on at a later date rather than now, since it would increase the scope of the work"

### What to avoid
- Business jargon: "leverage", "synergies", "align on", "stakeholders", "action items", "going forward"
- Em dashes. Use commas, full stops, or restructure the sentence
- Unnecessary hedging: "potentially", "it should be noted that", "it is worth considering that perhaps"
- Passive voice where first person would be more natural: "it was determined" instead of "I think", "it is recommended" instead of "I would recommend"
- Inflated language: "presents certain advantages" instead of "is better because"

### Structure and evidence
- Use the structured sections the document format calls for, but keep the prose inside them natural
- Always back up claims with evidence: links, metrics, code references, cost calculations
- When comparing costs, do the actual maths rather than saying "cost effective" or "expensive"
- Tables, diagrams, and bullet points are good when they make things clearer, not as filler

### Examples from real writing

Good (direct, evidence-led, first person):
```
As an Infrastructure engineer, my preference is for Generic Alerts
because not maintaining infrastructure and hardcoded configuration is
always my preferred option. We lose the ability for threshold tuning
and alert context, but being able to dynamically flip alerting on and
off with no other action outweighs this.
```

```
I would argue there are two "types" of secret we require to be used on
an instance: application secret values, and SSL certificates. I propose
these are handled separately because they have slightly different
workflows.
```

```
With each Secret Manager secret value costing $0.40, 406 secrets costs
$162.40 pcm, and flat secrets would cost $240.00 pcm. For the reduced
logic of having to manage these secrets, I would suggest this cost is
negligible.
```

Bad (corporate, passive, jargon-heavy):
```
It is recommended that the team considers adopting a Generic Alerts
approach, as this would potentially leverage dynamic configuration
capabilities while reducing ongoing maintenance overhead. Going forward,
this approach aligns with our strategic goal of operational efficiency.
```

```
A comprehensive analysis of the secret management landscape reveals
that there are potentially multiple viable paradigms for credential
storage. Key stakeholders should align on the optimal solution that
best addresses cross-functional requirements.
```
