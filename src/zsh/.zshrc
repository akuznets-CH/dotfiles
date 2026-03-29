typeset -U path

export XDG_CONFIG_HOME=$HOME/.config

export EDITOR='nvim'
export VISUAL='nvim'

# Add ~/.local/bin to the PATH if it exists and is not already there
if [ -d "$HOME/.local/bin" ]; then
  case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
  esac
fi

[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

autoload -U compinit && compinit
autoload -U edit-command-line && zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

# Vi mode: cursor shape feedback and snappy Escape
KEYTIMEOUT=1
zle-keymap-select() {
  case $KEYMAP in
    vicmd)      printf '\e[2 q' ;;
    viins|main) printf '\e[6 q' ;;
  esac
}
zle -N zle-keymap-select
zle-line-init() { printf '\e[6 q' }
zle -N zle-line-init

eval "$(uv generate-shell-completion zsh)"

eval "$(fnm env --use-on-cd)"

# Git worktree helpers
# Convention: worktrees live at <repo>-worktrees/<name>
# Claude Code memory is symlinked so all worktrees share context

_wt_repo_root() {
  local toplevel
  if toplevel=$(git rev-parse --show-toplevel 2>/dev/null); then
    local common_dir
    common_dir=$(git -C "$toplevel" rev-parse --git-common-dir 2>/dev/null)
    case "$common_dir" in
      /*) echo "${common_dir%/.git}"; return ;;
      *)  echo "$toplevel"; return ;;
    esac
  fi
  if [ -n "$WT_DEFAULT_REPO" ] && [ -d "$WT_DEFAULT_REPO/.git" ]; then
    echo "$WT_DEFAULT_REPO"
  else
    echo "Not in a git repo. cd into one or set WT_DEFAULT_REPO in ~/.zshrc.local" >&2
    return 1
  fi
}

_wt_claude_memory() {
  local main_root="$1" wt="$2"
  local main_key=$(echo "$main_root" | sed 's|^/||; s|[/.@]|-|g; s|^|-|')
  local wt_key=$(echo "$wt" | sed 's|^/||; s|[/.@]|-|g; s|^|-|')
  local main_memory="$HOME/.claude/projects/$main_key/memory"
  if [ -d "$main_memory" ]; then
    mkdir -p "$HOME/.claude/projects/$wt_key"
    [ ! -e "$HOME/.claude/projects/$wt_key/memory" ] && \
      ln -s "$main_memory" "$HOME/.claude/projects/$wt_key/memory"
  fi
}

_wt_tmux_attach() {
  local name="$1" wt="$2"
  tmux new-session -d -s "$name" -c "$wt" 2>/dev/null
  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$name"
  else
    tmux attach-session -t "$name"
  fi
}

cwt() {
  local new_branch=0
  if [ "$1" = "-n" ] || [ "$1" = "--new" ]; then
    new_branch=1
    shift
  fi
  local name="${1:?Usage: cwt [-n|--new] <name> [base-branch]}"
  local base="${2:-main}"
  local main_root
  main_root=$(_wt_repo_root) || return 1
  local wt="${main_root}-worktrees/$name"

  if [ -d "$wt" ]; then
    _wt_tmux_attach "$name" "$wt"
    return
  fi

  echo "Fetching origin..."
  git -C "$main_root" fetch origin --quiet

  local has_local has_remote
  has_local=$(git -C "$main_root" show-ref --verify "refs/heads/$name" 2>/dev/null)
  has_remote=$(git -C "$main_root" show-ref --verify "refs/remotes/origin/$name" 2>/dev/null)

  if [ -n "$has_local" ]; then
    git -C "$main_root" worktree add "$wt" "$name"
  elif [ -n "$has_remote" ]; then
    git -C "$main_root" worktree add --track -b "$name" "$wt" "origin/$name"
  elif [ "$new_branch" -eq 1 ]; then
    git -C "$main_root" worktree add -b "$name" "$wt" "$base"
  else
    echo "No local or remote branch '$name'. Use 'cwt -n $name' to create a new branch." >&2
    return 1
  fi

  if [ $? -ne 0 ]; then
    echo "Failed to create worktree" >&2
    return 1
  fi

  _wt_claude_memory "$main_root" "$wt"
  echo "Created: $wt"
  _wt_tmux_attach "$name" "$wt"
}

dwt() {
  local force=0
  if [ "$1" = "-f" ]; then
    force=1
    shift
  fi
  local name="${1:?Usage: dwt [-f] <name>}"
  local main_root
  main_root=$(_wt_repo_root) || return 1
  local wt="${main_root}-worktrees/$name"

  [ ! -d "$wt" ] && { echo "No worktree at: $wt" >&2; return 1; }

  tmux kill-session -t "$name" 2>/dev/null

  if [ "$force" -eq 1 ]; then
    git -C "$main_root" worktree remove --force "$wt"
  else
    if ! git -C "$main_root" worktree remove "$wt"; then
      echo "Worktree has uncommitted changes. Use 'dwt -f $name' to force." >&2
      return 1
    fi
  fi

  local wt_key=$(echo "$wt" | sed 's|^/||; s|[/.@]|-|g; s|^|-|')
  rm -rf "$HOME/.claude/projects/$wt_key"

  echo "Removed: $wt"
}

lwt() {
  local main_root
  main_root=$(_wt_repo_root) || return 1
  git -C "$main_root" worktree list
}

prwt() {
  local pr="${1:?Usage: prwt <pr-number>}"
  local name="pr-$pr"
  local main_root
  main_root=$(_wt_repo_root) || return 1
  local wt="${main_root}-worktrees/$name"

  if [ -d "$wt" ]; then
    _wt_tmux_attach "$name" "$wt"
    return
  fi

  local branch
  branch=$(gh pr view "$pr" --repo "$(git -C "$main_root" remote get-url origin)" \
    --json headRefName -q '.headRefName' 2>/dev/null)
  if [ -z "$branch" ]; then
    echo "Could not resolve branch for PR #$pr" >&2
    return 1
  fi

  echo "PR #$pr -> $branch"
  git -C "$main_root" fetch origin "$branch" --quiet

  git -C "$main_root" worktree add --detach "$wt" "origin/$branch"

  if [ $? -ne 0 ]; then
    echo "Failed to create worktree for PR #$pr" >&2
    return 1
  fi

  _wt_claude_memory "$main_root" "$wt"
  echo "Created: $wt"
  _wt_tmux_attach "$name" "$wt"
}

if [[ -r ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
