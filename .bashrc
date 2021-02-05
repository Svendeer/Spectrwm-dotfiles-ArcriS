git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]'; else echo '\[\e[1;34m\] \[\e[0m\]\[\e[1;34m\]\u'; fi)\[\033[0;31m\]]\342\224\200[\[\033[1;32m\] \w \$(git_status)\[\033[0;31m\]] \[\033[1;36m\]\n\[\033[1;31m\]\342\224\224\342\224\200\342\224\200\342\225\274\[\033[0m\]\[\e[1;33m\] \[\e[1;37m\]"
PS1+="${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}"

# Alias
alias s="sudo"
alias p="pacman"
alias v="vim"
alias sv="sudo vim"
alias l="ls -la"
alias la="ls -la"
alias mv="mv -v"
alias cf="cd ~/.config"
alias sp="sudo pacman"
alias py="python3"
alias cl="clear"
alias sc="source"
alias r="ranger"
alias x="exit"
alias pof="poweroff"
alias gc="git clone"
alias gm="git commit -m"
alias gl="git log"
alias ga="git add"
alias gs="git status"
alias ..="cd .."
alias rm="rm -rfv"
alias cp="cp -v"
alias archfetch="sh ~/.config/ArchFetch.sh"

source ~/gitstatus/.gitstatus.prompt.sh
