#!/usr/bin/env bash
# Block until Copilot has finished reviewing a PR.
#
# Usage: wait-for-review.sh <owner/repo> <pr number> <copilot reviews already on the PR>
#
# Copilot sits in the PR's requested reviewers while it works, and drops out
# once its review is submitted. Done means it is no longer requested and it has
# submitted more reviews than the baseline count.

set -euo pipefail

repo=$1
pr=$2
baseline=$3
interval=${INTERVAL:-30}
timeout=${TIMEOUT:-1800}

bot=copilot-pull-request-reviewer

query='query($owner: String!, $name: String!, $pr: Int!) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $pr) {
      reviewRequests(first: 50) { nodes { requestedReviewer { ... on Bot { login } } } }
      reviews(first: 100) { nodes { author { login } } }
    }
  }
}'

deadline=$((SECONDS + timeout))

while ((SECONDS < deadline)); do
  state=$(gh api graphql -f query="$query" -F owner="${repo%/*}" -F name="${repo#*/}" -F pr="$pr" \
    --jq "[
      ([.data.repository.pullRequest.reviewRequests.nodes[] | select(.requestedReviewer.login == \"$bot\")] | length),
      ([.data.repository.pullRequest.reviews.nodes[] | select(.author.login == \"$bot\")] | length)
    ] | @tsv")
  read -r requested reviews <<<"$state"

  if ((requested == 0 && reviews > baseline)); then
    echo "Copilot review submitted ($reviews Copilot reviews on #$pr)"
    exit 0
  fi

  sleep "$interval"
done

echo "Timed out after ${timeout}s waiting for Copilot on #$pr (requested=$requested, reviews=$reviews)" >&2
exit 1
