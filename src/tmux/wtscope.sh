#!/bin/zsh
source "$HOME/.zshrc" 2>/dev/null

list_worktrees() {
  local main_root
  main_root=$(_wt_repo_root) || exit 1
  local sessions
  sessions=$(tmux list-sessions -F '#S' 2>/dev/null | tr '\n' '|')

  git -C "$main_root" worktree list --porcelain | awk \
    -v main_root="$main_root" \
    -v sessions="$sessions" \
    '
    /^worktree / { path = substr($0, 10) }
    /^branch /   { sub(/refs\/heads\//, "", $2); branch = $2; emit() }
    /^detached/  { branch = "detached"; emit() }

    function emit() {
      if (path == main_root) return
      n = split(path, parts, "/")
      name = parts[n]
      has_session = (index(sessions, name "|") > 0) ? "*" : " "
      printf "%-30s %-40s %s\n", name, branch, has_session
    }
    '
}

# Called by fzf reload action after delete
if [[ "$1" == "--list" ]]; then
  list_worktrees
  exit 0
fi

main_root=$(_wt_repo_root) || exit 1
self=$(realpath "$0")

result=$(list_worktrees | fzf --reverse \
    --header 'Enter=switch  Ctrl-X=delete  Ctrl-N=new  Ctrl-P=PR review' \
    --expect 'ctrl-n,ctrl-p' \
    --bind "ctrl-x:execute(zsh -c 'source \$HOME/.zshrc 2>/dev/null; dwt {1}')+reload($self --list)" \
    --prompt="> " \
    --nth=1 \
    --with-nth=1,2,3)

key=$(head -1 <<< "$result")
entry=$(tail -1 <<< "$result")

if [[ -z "$result" ]]; then
    exit 0
fi

case "$key" in
  ctrl-n)
    printf 'Branch name: '
    read -r name
    [[ -n "$name" ]] && cwt -n "$name"
    ;;
  ctrl-p)
    printf 'PR number: '
    read -r pr
    [[ -n "$pr" ]] && prwt "$pr"
    ;;
  *)
    name=$(awk '{print $1}' <<< "$entry")
    [[ -z "$name" ]] && exit 0
    wt_dir="${main_root}-worktrees/$name"
    tmux new-session -d -s "$name" -c "$wt_dir" 2>/dev/null
    if [[ -z "$TMUX" ]]; then
        tmux attach-session -t "$name"
    else
        tmux switch-client -t "$name"
    fi
    ;;
esac
