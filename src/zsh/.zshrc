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

if [[ -r ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
