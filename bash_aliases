# .bash_aliases -*- mode: shell-script -*-

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  alias ls="ls --color"
else # OS X `ls`
  if gls > /dev/null 2>&1; then
    alias ls='gls --color=always'
  else
    alias ls='ls -G'
  fi
fi

alias ll='ls -l'
alias la='ls -A'
alias lc='ls -CF'
alias lsd='ls -l | grep "^d"'  # List only directories
alias hosts='sudo $EDITOR /etc/hosts'

# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"

# gnu diff does not have DIFFOPTIONS like FreeBSD so:
alias diff='diff -u'

alias reb='find . -name \*~ -print -delete'

# `cat` with beautiful colors. requires Pygments installed.
#                  sudo easy_install Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

export LESS="-iR"

if which eie > /dev/null 2>&1
then
  alias edit="eie --no-frame"
  alias ed="eie --no-wait"
  export EDITOR="eie"
elif which vim > /dev/null 2>&1
then
  alias edit="vim"
  alias ed="vim"
  export EDITOR="vim"
elif which mg > /dev/null 2>&1
then
  alias edit="mg"
  alias ed="mg"
  export EDITOR="mg"
elif which jove > /dev/null 2>&1
then
  alias edit="jove"
  alias ed="jove"
  export EDITOR="jove"
fi

# give lynx a custom configuration
alias lynx='lynx -nopause'

# this is a quick fix for roxterm tab names
if [ -n "${ROXTERM_ID}" -a -z "${PROMPT_COMMAND}" ]
then
  cd
  PROMPT_COMMAND='echo -ne "\033]0;${PWD/${HOME}/~}\007"'
fi

mkcd()
{
  local dir
  dir="$1"; shift

  if [ -z "${dir}" ]
  then
    pwd
  elif [ -d "${dir}" ]
  then
    cd "${dir}"
  elif [ -f "${dir}" ]
  then
   echo A file of that name already exists
   return 1
  else
    mkdir -p "${dir}"
    cd "${dir}"
  fi
  return 0
}

# remove items from PATH
pathrm()
{
  local item pa p IFS old_ifs
  old_ifs="${IFS}"
  IFS=':'
  pa=(${PATH})
  IFS="${old_ifs}"

  for item in $@
  do
    pa=("${pa[@]/${item}/}")
  done

  p=
  for item in "${pa[@]}"
  do
    [ -n "${item}" ] && p="${p}:${item}"
  done
  pa="${pa[@]}"
  PATH="${p:1}"
}

# add items to front of PATH
# move existing items to front of PATH
pathfront()
{
  local item p
  pathrm "$@"

  p=
  for item in $@
  do
    [ -n "${item}" ] && p="${p}:${item}"
  done
  PATH="${p:1}:${PATH}"
}

# Start an HTTP server from a directory, optionally specifying the port
server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/" && python -m SimpleHTTPServer "$port"
}

# include machine specific aliases
if [ -f ~/.bash_aliases_extra ]; then
    . ~/.bash_aliases_extra
fi
