#!/usr/bin/env bash
# EnterWorktree with a path outside .claude/worktrees/ is a safety-check ask
# that the auto-mode classifier cannot approve and that offers no persistable
# allow rule, so pre-approval has to happen in a hook. Only a directory git
# already registers as a worktree of the repo named by the <repo path>@<branch>
# prefix qualifies.
set -uo pipefail

pass() { printf '%s\n' '{}'; exit 0; }

path=$(jq -r '.tool_input.path // empty')
[ -n "$path" ] || pass

case $path in
  "~/"*) path="$HOME/${path#\~/}" ;;
  /*) ;;
  *) path="$PWD/$path" ;;
esac

repo=${path%%@*}
[ "$repo" != "$path" ] || pass
[ -d "$repo" ] && [ -d "$path" ] || pass

repo_real=$(git -C "$repo" rev-parse --show-toplevel 2>/dev/null) || pass
path_real=$(cd "$path" 2>/dev/null && pwd -P) || pass

git -C "$repo_real" worktree list --porcelain 2>/dev/null |
  sed -n 's/^worktree //p' |
  grep -qxF "$path_real" || pass

jq -n --arg r "$repo_real" '{
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "allow",
    permissionDecisionReason: ("registered git worktree of " + $r)
  }
}'
