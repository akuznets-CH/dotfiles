export EDITOR='nvim'
export VISUAL='nvim'

if [[ -d "$HOME/.local/bin" && ! ("$path"[(Ie)"$HOME/.local/bin"]) ]]; then
    path=("$HOME/.local/bin" $path)
fi

[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

autoload -U compinit && compinit
