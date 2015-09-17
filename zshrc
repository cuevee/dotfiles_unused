# modify the prompt to contain git branch name if applicable
export ZSH_THEME_GIT_PROMPT_DIRTY=' *'
export ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=' <-'
export ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=' ->'
export ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=' <->'

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo " %{$fg_bold[green]%}${ref#refs/heads/}$(parse_git_dirty)$(git_remote_status)%{$reset_color%}"
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

setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%2c%{$reset_color%}$(git_prompt_info) %# '

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

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
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
# bindkey -v
# bindkey "^F" vi-cmd-mode
# bindkey jj vi-cmd-mode

# handy keybindings
# bindkey "^A" beginning-of-line
# bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
# bindkey "^P" history-search-backward
# bindkey "^Y" accept-and-hold
# bindkey "^N" insert-last-word
# bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# use vim as the visual editor
export VISUAL=vim
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
export PYENV_VIRTUALENV_CACHE_PATH=$HOME/Library/Caches/pyenv-virtualenv
export PIP_DOWNLOAD_CACHE=$HOME/Library/Caches/pip

## use distribute instead of setuptools
export VIRTUALENV_DISTRIBUTE=true

# GoLang
export GOPATH=$HOME/source/go

# Android
# export JAVA_HOME=$(/usr/libexec/java_home)
# export ANDROID_HOME=/usr/local/Cellar/android-sdk/24.0.2

# look for ey config in project dirs
export EYRC=./.eyrc

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

export PATH="$HOME/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH=$PATH:/usr/local/share/npm/bin
export PATH=$PATH:$GOPATH/bin

export MANPATH=$MANPATH:/usr/local/opt/erlang/lib/erlang/man

# android
export ANDROID_HOME="/usr/local/Cellar/android-sdk/23.0.2"

# rust
export RUST_SRC_PATH="$HOME/source/rust/src"

# load rbenv if available
if which rbenv &>/dev/null; then eval "$(rbenv init - zsh --no-rehash)"; fi

# load pyenv if available
if which pyenv &>/dev/null; then eval "$(pyenv init - --no-rehash)"; fi
export PATH="/Users/quintis/.pyenv/shims:$PATH"

# load exenv if available
if which exenv > /dev/null; then eval "$(exenv init -)"; fi
# source ~/.exenv/completions/exenv.zsh

# load nodenv if available
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.nodenv/shims:$PATH"

# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
