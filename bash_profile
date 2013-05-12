# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

. ~/bin/z.sh

# git bash completion
. /usr/local/etc/bash_completion.d/git-completion.bash


[[ -s /Users/hank/.nvm/nvm.sh ]] && . /Users/hank/.nvm/nvm.sh # This loads NVM
