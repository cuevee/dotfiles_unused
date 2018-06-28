export LANG=en_US.UTF-6
export LC_ALL=en_US.UTF-8

ulimit -n 10000

# modify the prompt to contain git branch name if applicable
export ZSH_THEME_GIT_PROMPT_DIRTY=' *'
export ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=' <-'
export ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=' ->'
export ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=' <->'
export ZSH_THEME_JOBS_INDICATOR='_'

function check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  if [[ $LAST_EXIT_CODE -ne 0 ]]; then
    local EXIT_CODE_PROMPT=' '
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    echo "$EXIT_CODE_PROMPT"
  fi
}

jobs_prompt_info() {
	if [[ `jobs | wc -l` -ne 0 ]]; then
		echo " %{$fg[red]%}$(jobs | tr -d \"+\-\" | tr -s ' ' | awk '{print $3}' | xargs)%{$reset_color%}"
	fi
}

direnv_info() {
        [ "$DIRENV_DIR" != "" ] && echo " 🔗"
}

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
		echo " %{$fg[green]%}${ref#refs/heads/}$(parse_git_dirty)$(git_remote_status)%{$reset_color%}"
	fi
}

git_stash_info() {
  # if [[ -f "${stash_file}" ]]; then
  if [[ -d .git && -f "$( git rev-parse --git-dir )/logs/refs/stash" ]]; then
    echo "%{$fg[green]%} ⚑%{$reset_color%}"
  fi
}

parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# get the difference between the local and remote branches
git_remote_status() {
    remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
    if [[ -n ${remote} ]] ; then
        ahead=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
        behind=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)

        if [ $ahead -eq 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE"
        elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]
        then
            echo "$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE"
        fi
    fi
}

# edit current command in $VISUAL
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

setopt promptsubst
PS1='%{$reset_color%}%{$fg[blue]%}%2c%{$reset_color%}$(git_prompt_info)$(git_stash_info)$(direnv_info)$(jobs_prompt_info) %# '
RPROMPT='$(check_last_exit_code)'

# load our own completion functions
fpath=(~/.zsh/completion $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(/usr/local/share/zsh/site-functions $fpath)

# completion
setopt no_case_glob
autoload -Uz compinit && compinit -i
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
      'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=15

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# handy keybindings
# bindkey "^A" beginning-of-line
# bindkey "^E" end-of-line
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"
# bindkey "^P" history-search-backward
# bindkey "^Y" accept-and-hold
# bindkey "^N" insert-last-word

# use vim as the visual editor
export VISUAL=nvim
export EDITOR=$VISUAL

# Caches
export HOMEBREW_CACHE=$HOME/Library/Caches/Homebrew

# Ruby
export RUBY_BUILD_CACHE_PATH='$HOME/.rbenv/cache'

# Python
## Defaults for virtualenv
export VIRTUALENV_ARGS='--no-site-packages'

## pip with virtualenv
export PIP_REQUIRE_VIRTUALENV=false    # only run when virtualenv active
export PIP_RESPECT_VIRTUALENV=true     # automatically use active virtualenv

## use distribute instead of setuptools
export VIRTUALENV_DISTRIBUTE=true

# GoLang
export GOPATH=$HOME/source/go

# Docker
export DOCKER_DATA_DIR=$HOME/.docker-data

# look for ey config in project dirs
export EYRC=./.eyrc

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.fastlane/bin:$PATH"

export MANPATH=$MANPATH:/usr/local/opt/erlang/lib/erlang/man

# load exenv if available
if which exenv &>/dev/null; then eval "$(exenv init - zsh)"; fi
export PATH="$HOME/.exenv/bin:$PATH"

# load rbenv if available
if which rbenv &>/dev/null; then eval "$(rbenv init - zsh)"; fi

# load pyenv if available
# export PYENV_ROOT="$HOME/.pyenv"
# if which pyenv &>/dev/null; then eval "$(pyenv init -)"; fi

# load nodenv if available
# if which nodenv &>/dev/null; then eval "$(nodenv init - zsh)"; fi
if which nodenv &>/dev/null; then eval "$(nodenv init -)"; fi
export PATH="$HOME/.nodenv/shims:$PATH"

# anacondas
export PATH="/usr/local/anaconda3/bin:/usr/local/anaconda2/bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# fzf
export PATH=$PATH:$HOME/.vim/plugged/fzf/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

# direnv
eval "$(direnv hook zsh)"
