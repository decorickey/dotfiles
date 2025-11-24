#!/usr/bin/env bash
#
# go.sh - Go 開発ツールセットアップ
# gopls / delve を go install で、golangci-lint を公式 install.sh で導入する
# GOBIN は未指定でも GOPATH/bin になるが、場所を明示して運用を安定させる

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

source "$ROOT_DIR/scripts/common.sh"
source "$ROOT_DIR/scripts/logging.sh"
source "$ROOT_DIR/scripts/shell_utils.sh"

readonly FEATURE_NAME="Go tools"
readonly DEFAULT_GOLANGCI_LINT_VERSION="${GOLANGCI_LINT_VERSION:-v1.60.3}"

resolve_gobin() {
  local gobin
  gobin="$(go env GOBIN 2>/dev/null || true)"
  if [[ -n "$gobin" ]]; then
    echo "$gobin"
    return 0
  fi

  local gopath
  gopath="$(go env GOPATH 2>/dev/null || echo "$HOME/go")"
  echo "$gopath/bin"
}

add_path_if_missing() {
  local dir="$1"
  local export_line="export PATH=\"$dir:\$PATH\""

  if [[ ":$PATH:" == *":$dir:"* ]]; then
    log_info "PATH already contains $dir"
    return 0
  fi

  if [[ -f "$ZSHRC" ]] && grep -Fxq "$export_line" "$ZSHRC"; then
    log_info "$ZSHRC already has PATH entry for $dir"
  else
    add_to_shell_config "$export_line" "Go tools path"
  fi

  export PATH="$dir:$PATH"
}

install_go_tool() {
  local name="$1"
  local module="$2"
  local bin="$3"
  local version_cmd="$4"

  log_info "Installing $name via go install ($module)"

  if GO111MODULE=on go install "$module"; then
    log_success "$name installed"
  else
    log_warn "$name install failed"
    return 1
  fi

  if command_exists "$bin"; then
    $version_cmd || true
  fi
}

install_golangci_lint() {
  local version="$DEFAULT_GOLANGCI_LINT_VERSION"
  local url="https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh"

  log_info "Installing golangci-lint ($version) via official script"

  if ! curl -sSfL "$url" | sh -s -- -b "$GOBIN" "$version"; then
    log_warn "golangci-lint install failed"
    return 1
  fi

  if command_exists golangci-lint; then
    golangci-lint version || true
  fi

  if command -v golangci-lint >/dev/null 2>&1; then
    local loc
    loc="$(command -v golangci-lint)"
    if [[ "$loc" == *"/brew/"* || "$loc" == *"/opt/homebrew"* ]]; then
      log_warn "Homebrew golangci-lint detected at $loc. PATH order will prefer $GOBIN."
    fi
  fi
}

main() {
  log_section "$FEATURE_NAME Setup"

  if ! require_command go "Please install Go first (run packages step)"; then
    return 1
  fi
  if ! require_command curl "curl is required to download installers"; then
    return 1
  fi

  show_command_version go

  export GOBIN="${GOBIN:-$(resolve_gobin)}" # GOBIN は未指定でも GOPATH/bin だが、明示しておく
  log_info "GOBIN set to $GOBIN"

  add_path_if_missing "$GOBIN"

  local status=0

  install_go_tool "gopls" "golang.org/x/tools/gopls@latest" "gopls" "gopls version" || status=1
  install_go_tool "delve" "github.com/go-delve/delve/cmd/dlv@latest" "dlv" "dlv version" || status=1
  install_golangci_lint || status=1

  if [[ $status -eq 0 ]]; then
    log_success "$FEATURE_NAME setup completed!"
  else
    log_warn "Some $FEATURE_NAME steps failed. Check logs above."
  fi

  return $status
}

main "$@"
