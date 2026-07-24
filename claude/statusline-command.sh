#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
limit_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
limit_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
reset_5h=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
reset_7d=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
api_ms=$(echo "$input" | jq -r '.cost.total_api_duration_ms // empty')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // empty')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // empty')

# Colours
reset="\033[0m"
bold="\033[1m"
dim="\033[2m"
cyan="\033[36m"
yellow="\033[33m"
green="\033[32m"
red="\033[31m"
magenta="\033[35m"
bold_cyan="\033[1;36m"
bold_yellow="\033[1;33m"
bold_green="\033[1;32m"
bold_red="\033[1;31m"
bold_magenta="\033[1;35m"

# Git branch and dirty status
export GIT_OPTIONAL_LOCKS=0
git_part=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null)
  if [ -n "$dirty" ]; then
    git_part="${bold_cyan} ${branch}${bold_red}!${reset}"
  else
    git_part="${bold_cyan} ${branch}${reset}"
  fi
fi

# Session duration (convert ms to human-readable)
duration_part=""
if [ -n "$duration_ms" ] && [ "$duration_ms" != "null" ] && [ "$duration_ms" != "0" ]; then
  total_secs=$((duration_ms / 1000))
  hours=$((total_secs / 3600))
  mins=$(( (total_secs % 3600) / 60 ))
  if [ "$hours" -gt 0 ]; then
    duration_part="${dim}⏱ ${hours}h${mins}m${reset}"
  elif [ "$mins" -gt 0 ]; then
    duration_part="${dim}⏱ ${mins}m${reset}"
  else
    duration_part="${dim}⏱ <1m${reset}"
  fi
fi

# Context used with colour coding (higher = more consumed = worse)
ctx_part=""
if [ -n "$remaining_pct" ] && [ "$remaining_pct" != "null" ]; then
  remaining_int=$(printf '%.0f' "$remaining_pct")
  used_int=$((100 - remaining_int))
  if [ "$used_int" -lt 50 ]; then
    ctx_colour="$bold_green"
  elif [ "$used_int" -lt 75 ]; then
    ctx_colour="$bold_yellow"
  else
    ctx_colour="$bold_red"
  fi
  ctx_part="${ctx_colour}ctx ${used_int}%${reset}"
fi

# Cost
cost_part=""
if [ -n "$cost_usd" ] && [ "$cost_usd" != "null" ] && [ "$cost_usd" != "0" ]; then
  cost_part="${bold_magenta}\$$(printf '%.2f' "$cost_usd")${reset}"
fi

# Model
model_part=""
if [ -n "$model" ] && [ "$model" != "null" ]; then
  model_part="${dim}${model}${reset}"
fi

# Tokens sent
tokens_part=""
if [ -n "$total_input" ] && [ "$total_input" != "null" ] && [ "$total_input" != "0" ]; then
  if [ "$total_input" -ge 1000000 ]; then
    tokens_fmt="$(awk "BEGIN {printf \"%.1f\", $total_input/1000000}")M"
  elif [ "$total_input" -ge 1000 ]; then
    tokens_fmt="$(awk "BEGIN {printf \"%.0f\", $total_input/1000}")k"
  else
    tokens_fmt="$total_input"
  fi
  tokens_part="${dim}${tokens_fmt} tokens${reset}"
fi

# Claude usage limits (5-hour and 7-day windows, % consumed)
# Colour by how much is used: higher = worse
usage_colour() {
  local used_int="$1"
  if [ "$used_int" -ge 80 ]; then
    printf '%s' "$bold_red"
  elif [ "$used_int" -ge 60 ]; then
    printf '%s' "$bold_yellow"
  else
    printf '%s' "$bold_green"
  fi
}
# Compact "time until" from a Unix epoch (seconds), e.g. 2d / 3h / 45m
fmt_until() {
  local target="$1" now diff
  now=$(date +%s)
  diff=$((target - now))
  [ "$diff" -le 0 ] && return
  if [ "$diff" -ge 86400 ]; then
    printf '%dd' "$((diff / 86400))"
  elif [ "$diff" -ge 3600 ]; then
    printf '%dh' "$((diff / 3600))"
  else
    printf '%dm' "$((diff / 60))"
  fi
}
limit_5h_part=""
if [ -n "$limit_5h" ] && [ "$limit_5h" != "null" ]; then
  l5=$(printf '%.0f' "$limit_5h")
  limit_5h_part="$(usage_colour "$l5")limit:5h ${l5}%${reset}"
  if [ -n "$reset_5h" ] && [ "$reset_5h" != "null" ]; then
    until_5h=$(fmt_until "$reset_5h")
    [ -n "$until_5h" ] && limit_5h_part="${limit_5h_part}${dim} →${until_5h}${reset}"
  fi
fi
limit_7d_part=""
if [ -n "$limit_7d" ] && [ "$limit_7d" != "null" ]; then
  l7=$(printf '%.0f' "$limit_7d")
  limit_7d_part="$(usage_colour "$l7")limit:7d ${l7}%${reset}"
  if [ -n "$reset_7d" ] && [ "$reset_7d" != "null" ]; then
    until_7d=$(fmt_until "$reset_7d")
    [ -n "$until_7d" ] && limit_7d_part="${limit_7d_part}${dim} →${until_7d}${reset}"
  fi
fi

# Lines changed this session (+added / -removed)
lines_part=""
la=0; lr=0
[ -n "$lines_added" ] && [ "$lines_added" != "null" ] && la="$lines_added"
[ -n "$lines_removed" ] && [ "$lines_removed" != "null" ] && lr="$lines_removed"
if [ "$la" -gt 0 ] || [ "$lr" -gt 0 ]; then
  lines_part="${bold_green}+${la}${reset} ${bold_red}-${lr}${reset}"
fi

# Cost burn rate ($/hour), derived from cost and wall-clock duration
burn_part=""
if [ -n "$cost_usd" ] && [ "$cost_usd" != "null" ] && [ "$cost_usd" != "0" ] \
   && [ -n "$duration_ms" ] && [ "$duration_ms" != "null" ] && [ "$duration_ms" -gt 0 ]; then
  burn=$(awk "BEGIN {printf \"%.2f\", $cost_usd / ($duration_ms / 3600000)}")
  burn_part="${dim}\$${burn}/h${reset}"
fi

# Share of wall-clock time spent waiting on the API
api_part=""
if [ -n "$api_ms" ] && [ "$api_ms" != "null" ] && [ "$api_ms" != "0" ] \
   && [ -n "$duration_ms" ] && [ "$duration_ms" != "null" ] && [ "$duration_ms" -gt 0 ]; then
  api_pct=$(awk "BEGIN {printf \"%.0f\", ($api_ms / $duration_ms) * 100}")
  api_part="${dim}wait ${api_pct}%${reset}"
fi

# Current directory (basename only)
dir_part=""
if [ -n "$cwd" ] && [ "$cwd" != "null" ]; then
  dir_part="${bold_cyan}$(basename "$cwd")${reset}"
fi

# Assemble, joining non-empty parts with a separator
parts=()
[ -n "$dir_part" ] && parts+=("$dir_part")
[ -n "$git_part" ] && parts+=("$git_part")
[ -n "$duration_part" ] && parts+=("$duration_part")
[ -n "$ctx_part" ] && parts+=("$ctx_part")
[ -n "$cost_part" ] && parts+=("$cost_part")
[ -n "$burn_part" ] && parts+=("$burn_part")
[ -n "$api_part" ] && parts+=("$api_part")
[ -n "$limit_5h_part" ] && parts+=("$limit_5h_part")
[ -n "$limit_7d_part" ] && parts+=("$limit_7d_part")
[ -n "$model_part" ] && parts+=("$model_part")
[ -n "$tokens_part" ] && parts+=("$tokens_part")
[ -n "$lines_part" ] && parts+=("$lines_part")

sep="${dim} │ ${reset}"
output=""
for i in "${!parts[@]}"; do
  if [ "$i" -gt 0 ]; then
    output+="$sep"
  fi
  output+="${parts[$i]}"
done

printf "%b" "$output"
