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
