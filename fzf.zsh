# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/q/.vim/plugged/fzf/bin* ]]; then
  export PATH="$PATH:/Users/q/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/q/.vim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/q/.vim/plugged/fzf/shell/key-bindings.zsh"

