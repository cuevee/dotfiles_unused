# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/quintis/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/quintis/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/quintis/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/quintis/.fzf/shell/key-bindings.zsh"

