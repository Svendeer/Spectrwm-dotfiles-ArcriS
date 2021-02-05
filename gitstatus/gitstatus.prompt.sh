# Simple Bash prompt with Git status.

# Source gitstatus.plugin.sh from $GITSTATUS_DIR or from the same directory
# in which the current script resides if the variable isn't set.
if [[ -n "${GITSTATUS_DIR:-}" ]]; then
  source "$GITSTATUS_DIR"                           || return
elif [[ "${BASH_SOURCE[0]}" == */* ]]; then
  source "${BASH_SOURCE[0]%/*}/gitstatus.plugin.sh" || return
else
  source gitstatus.plugin.sh                        || return
fi

# Sets GITSTATUS_PROMPT to reflect the state of the current git repository.
# The value is empty if not in a git repository. Forwards all arguments to
# gitstatus_query.
#
# Example value of GITSTATUS_PROMPT: master ⇣42⇡42 ⇠42⇢42 *42 merge ~42 +42 !42 ?42
#
#   master  current branch
#      ⇣42  local branch is 42 commits behind the remote
#      ⇡42  local branch is 42 commits ahead of the remote
#      ⇠42  local branch is 42 commits behind the push remote
#      ⇢42  local branch is 42 commits ahead of the push remote
#      *42  42 stashes
#    merge  merge in progress
#      ~42  42 merge conflicts
#      +42  42 staged changes
#      !42  42 unstaged changes
#      ?42  42 untracked files
function gitstatus_prompt_update() {
  GITSTATUS_PROMPT=""

  gitstatus_query "$@"                  || return 1  # error
  [[ "$VCS_STATUS_RESULT" == ok-sync ]] || return 0  # not a git repo

  local      reset=$'\e[0m'         # no color
  local      clean=$'\e[38;5;076m'  # green foreground
  local  untracked=$'\e[38;5;014m'  # teal foreground
  local   modified=$'\e[38;5;011m'  # yellow foreground
  local conflicted=$'\e[38;5;196m'  # red foreground

  local p

  local where  # branch name, tag or commit
  if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
    where="$VCS_STATUS_LOCAL_BRANCH"
  elif [[ -n "$VCS_STATUS_TAG" ]]; then
    p+="${reset}#"
    where="$VCS_STATUS_TAG"
  else
    p+="${reset}@"
    where="${VCS_STATUS_COMMIT:0:8}"
  fi

  (( ${#where} > 32 )) && where="${where:0:12}…${where: -12}"  # truncate long branch names and tags
  p+="${clean}${where}"

  # ⇣42 if behind the remote.
  (( VCS_STATUS_COMMITS_BEHIND )) && p+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
  # ⇡42 if ahead of the remote; no leading space if also behind the remote: ⇣42⇡42.
  (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && p+=" "
  (( VCS_STATUS_COMMITS_AHEAD  )) && p+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
  # ⇠42 if behind the push remote.
  (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
  (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && p+=" "
  # ⇢42 if ahead of the push remote; no leading space if also behind: ⇠42⇢42.
  (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && p+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
  # *42 if have stashes.
  (( VCS_STATUS_STASHES        )) && p+=" ${clean}*${VCS_STATUS_STASHES}"
  # 'merge' if the repo is in an unusual state.
  [[ -n "$VCS_STATUS_ACTION"   ]] && p+=" ${conflicted}${VCS_STATUS_ACTION}"
  # ~42 if have merge conflicts.
  (( VCS_STATUS_NUM_CONFLICTED )) && p+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
  # +42 if have staged changes.
  (( VCS_STATUS_NUM_STAGED     )) && p+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
  # !42 if have unstaged changes.
  (( VCS_STATUS_NUM_UNSTAGED   )) && p+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
  # ?42 if have untracked files. It's really a question mark, your font isn't broken.
  (( VCS_STATUS_NUM_UNTRACKED  )) && p+=" ${untracked}?${VCS_STATUS_NUM_UNTRACKED}"

  GITSTATUS_PROMPT="${p}${reset}"
}

# Start gitstatusd in the background.
gitstatus_stop && gitstatus_start -s -1 -u -1 -c -1 -d -1

# On every prompt, fetch git status and set GITSTATUS_PROMPT.
PROMPT_COMMAND=gitstatus_prompt_update

# Enable promptvars so that ${GITSTATUS_PROMPT} in PS1 is expanded.
shopt -s promptvars

# Customize prompt. Put $GITSTATUS_PROMPT in it reflect git status.
#
# Example:
#
#   user@host ~/projects/skynet master ⇡42
#   $ █

# Alias
alias ls="lsd"
alias s="sudo"
alias p="pacman"
alias v="vim"
alias sv="sudo vim"
alias l="ls -la"
alias dk="cd ~/Desktop"
alias doc="cd ~/Documents"
alias vd="cd ~/Videos"
alias dw="cd ~/Downloads"
alias pic="cd ~/Pictures"
alias nv="nvim ~/.config/nvim/init.vim"
alias qtc="nvim ~/.config/qtile/config.py"
alias gt="cd ~/GitHub"
alias sp="nvim ~/.spectrwm.conf"
alias spc="cd ~/.config/spectrwm/"
alias t="tmux -u"
alias cf="cd ~/.config"
alias sp="sudo pacman"
alias py="python3"
alias nv="nvim ~/.config/nvim/init.vim"
alias e="emacs -nw"
alias cl="clear"
alias sc="source"
alias r="ranger"
alias x="exit"
alias pof="poweroff"
alias aw="cd ~/.config/awesome/"
alias awc="n ~/.config/awesome/rc.lua"
alias jc="javac"
alias ja="java"
alias gc="git clone"
alias gm="git commit -m"
alias gl="git log"
alias ga="git add"
alias gs="git status"
alias pywallpaper="python3 ~/Scripts/Pywallpaper.py"
alias ..="cd .."

git_status(){
    status="${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}"
    echo $status
}

PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]'; else echo '\[\e[1;34m\] \[\e[0m\]\[\e[1;34m\]\u'; fi)\[\033[0;31m\]]\342\224\200[\[\033[1;32m\] \w \$(git_status)\[\033[0;31m\]] \[\033[1;36m\]\n\[\033[1;31m\]\342\224\224\342\224\200\342\224\200\342\225\274\[\033[0m\]\[\e[1;33m\] \[\e[1;37m\]"

#PS1+='\n\[\033[01;$((31+!$?))m\]\$\[\033[00m\] '  # green/red (success/error) $/# (normal/root)

