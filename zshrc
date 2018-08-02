export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(symfony2 history-substring-search sudo composer)
source $ZSH/oh-my-zsh.sh
export PROMPT="%{$fg[magenta]%}docker%{$reset_color%} $PROMPT"
alias suno="sudo nano"
