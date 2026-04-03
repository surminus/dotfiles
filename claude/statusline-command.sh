#!/usr/bin/env bash

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
remaining_pct=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
total_input=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')

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

# Context remaining with colour coding
ctx_part=""
if [ -n "$remaining_pct" ] && [ "$remaining_pct" != "null" ]; then
  remaining_int=$(printf '%.0f' "$remaining_pct")
  if [ "$remaining_int" -gt 50 ]; then
    ctx_colour="$bold_green"
  elif [ "$remaining_int" -gt 25 ]; then
    ctx_colour="$bold_yellow"
  else
    ctx_colour="$bold_red"
  fi
  ctx_part="${ctx_colour}ctx ${remaining_int}%${reset}"
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

# CPU load (1-min average)
load_avg=$(cut -d' ' -f1 /proc/loadavg 2>/dev/null)
cpu_part=""
if [ -n "$load_avg" ]; then
  cpu_part="${dim}cpu ${load_avg}${reset}"
fi

# Memory usage
mem_part=""
mem_info=$(free -m 2>/dev/null | awk '/^Mem:/ {printf "%.0f", ($3/$2)*100}')
if [ -n "$mem_info" ]; then
  if [ "$mem_info" -gt 80 ]; then
    mem_colour="$bold_red"
  elif [ "$mem_info" -gt 60 ]; then
    mem_colour="$bold_yellow"
  else
    mem_colour="$dim"
  fi
  mem_part="${mem_colour}mem ${mem_info}%${reset}"
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

# Current time
time_part="${dim}$(date +%H:%M)${reset}"

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
[ -n "$model_part" ] && parts+=("$model_part")
[ -n "$tokens_part" ] && parts+=("$tokens_part")
[ -n "$cpu_part" ] && parts+=("$cpu_part")
[ -n "$mem_part" ] && parts+=("$mem_part")
parts+=("$time_part")

sep="${dim} │ ${reset}"
output=""
for i in "${!parts[@]}"; do
  if [ "$i" -gt 0 ]; then
    output+="$sep"
  fi
  output+="${parts[$i]}"
done

printf "%b" "$output"
