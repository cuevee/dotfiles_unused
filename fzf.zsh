# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/quintis/.vim/plugged/fzf/bin* ]]; then
  export PATH="$PATH:/Users/quintis/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/quintis/.vim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/quintis/.vim/plugged/fzf/shell/key-bindings.zsh"

