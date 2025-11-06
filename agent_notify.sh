#!/usr/bin/env bash
set -euo pipefail

# macOS notification helper for CLI agents (e.g. Claude Code, Codex)

title="Agent Notification"
sound="Basso"

usage() {
  cat <<'EOF' >&2
Usage: agent_notify.sh [--title <title>] [--sound <sound>] <message>
EOF
  exit 1
}

escape_osascript_string() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

while (($#)); do
  case "$1" in
    --title)
      (($# >= 2)) || usage
      title="$2"
      shift 2
      ;;
    --sound)
      (($# >= 2)) || usage
      sound="$2"
      shift 2
      ;;
    --help|-h)
      usage
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      ;;
    *)
      break
      ;;
  esac
done

if [ "$#" -lt 1 ]; then
  usage
fi

message="$1"
escaped_message=$(escape_osascript_string "$message")
escaped_title=$(escape_osascript_string "$title")

osascript_command="display notification \"$escaped_message\" with title \"$escaped_title\""

if [ -n "$sound" ]; then
  escaped_sound=$(escape_osascript_string "$sound")
  osascript_command+=" sound name \"$escaped_sound\""
fi

osascript -e "$osascript_command"
