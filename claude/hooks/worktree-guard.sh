#!/bin/bash
# PreToolUse hook: rewrite Bash commands that reference the main repo path
# to use the current worktree path instead.

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command')

# Determine if we're in a worktree by comparing git-dir to git-common-dir.
# In the main repo they resolve to the same path. In a worktree, git-dir
# points to .git/worktrees/<name> while common-dir points to the main .git.
git_dir=$(cd "$(git rev-parse --git-dir 2>/dev/null)" 2>/dev/null && pwd) || exit 0
common_dir=$(cd "$(git rev-parse --git-common-dir 2>/dev/null)" 2>/dev/null && pwd) || exit 0

[ "$git_dir" = "$common_dir" ] && exit 0

main_repo=$(dirname "$common_dir")
worktree=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0

if echo "$command" | grep -qF "$main_repo"; then
  fixed=$(echo "$command" | sed "s|$main_repo|$worktree|g")
  jq -n \
    --arg command "$fixed" \
    '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "allow",
        updatedInput: { command: $command }
      }
    }'
fi
