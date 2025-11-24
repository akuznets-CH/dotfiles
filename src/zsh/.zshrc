export XDG_CONFIG_HOME=$HOME/.config

export EDITOR='nvim'
export VISUAL='nvim'

alias uvim='uv run nvim'

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

eval "$(uv generate-shell-completion zsh)"

eval "$(fnm env --use-on-cd)"

if [[ -r ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
