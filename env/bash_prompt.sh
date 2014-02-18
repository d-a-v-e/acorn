RED="\[\033[1;31m\]"
BLUE="\[\033[1;34m\]"
PURPLE="\[\033[1;35m\]"
COLOR_NONE="\[\e[0m\]"

function is_git_repository {
  git branch > /dev/null 2>&1
}

function set_git_branch {
  git_status="$(git status 2> /dev/null)"
  state_tracked="${BLUE}"
  state_untracked="${BLUE}"
  if [[ ${git_status} =~ "Untracked files:" ]]; then
    state_untracked="${RED}"
  fi
  if [[ ${git_status} =~ "Changes not staged for commit:" ]]; then
    state_tracked="${PURPLE}"
  fi
  if [[ ${git_status} =~ "Changes to be committed:" ]]; then
    state_tracked="${PURPLE}"
  fi
  remote_pattern="Your branch is (.*) of"
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="↑"
    else
      remote="↓"
    fi
  else
    remote=" "
  fi
  diverge_pattern="Your branch and (.*) have diverged"
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="↕"
  fi
 
  branch_pattern="On branch ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
  fi

  branch_pattern="HEAD detached at ([^${IFS}]*)"
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    remote=" "
    branch=${BASH_REMATCH[1]} # short commit hash
  fi

  BRANCH="${state_untracked}(${state_tracked}${branch}${state_untracked})${remote}"
}

function set_bash_prompt () {
  if is_git_repository ; then
    set_git_branch
  else
    BRANCH=' '
  fi
  PS1="${BLUE}\W${COLOR_NONE}${BRANCH}\$${COLOR_NONE} "
}

PROMPT_COMMAND=set_bash_prompt
