# Simplified two-line prompt: time, location, git branch with dirty indicator

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX="%F{81}‹"  # bright cyan opening bracket
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{81}›%f"  # bright cyan closing bracket
ZSH_THEME_GIT_PROMPT_DIRTY="%F{226}✱%f"  # bright yellow dirty indicator
ZSH_THEME_GIT_PROMPT_CLEAN=""

function mygit() {
  if [[ "$(git config --get oh-my-zsh.hide-status)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return

    local git_status=""
    if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
      git_status="$ZSH_THEME_GIT_PROMPT_DIRTY"
    fi

    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$git_status$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Two-line prompt: time on left, then location and git branch
PROMPT=$'%F{81}┌─[%F{87}%D{%H:%M:%S}%F{81}] [%F{87}%~%F{81}]%f $(mygit)
%F{81}└─%f '
# PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '
# ~/.oh-my-zsh/themes master