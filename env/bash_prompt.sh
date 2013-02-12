RED="\[\033[1;31m\]"
BLUE="\[\033[1;34m\]"
PURPLE="\[\033[1;35m\]"
COLOR_NONE="\[\e[0m\]"

function is_git_repository {
  git branch > /dev/null 2>&1
}

function set_git_branch {
  git_status="$(git status 2> /dev/null)"
  if [[ ${git_status} =~ "working directory clean" ]]; then
    state="${BLUE}"
  elif [[ ${git_status} =~ "Untracked files:" ]]; then
    state="${RED}"
  else
    state="${PURPLE}"
  fi
  
  remote_pattern="# Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=""
  fi
  diverge_pattern="# Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi
 
  branch_pattern="^# On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  branch_pattern="# Not currently on any branch"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    remote=""
    branch="$(git rev-parse --short HEAD)" # short commit hash
  fi

  BRANCH="${state}(${branch})${remote}${COLOR_NONE} "
}

function set_prompt_symbol () {
  if test $1 -eq 0 ; then
      PROMPT_SYMBOL="\$"
  else
      PROMPT_SYMBOL="${RED}\$${COLOR_NONE}"
  fi
}

function set_bash_prompt () {
  set_prompt_symbol $? # return value of last command
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=' '
  fi
  PS1="${BLUE}\W${COLOR_NONE}${BRANCH}${PROMPT_SYMBOL} "
}

PROMPT_COMMAND=set_bash_prompt
