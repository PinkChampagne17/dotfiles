alias cwd="code ." # code work dir
alias ll="ls -AFhl"
alias md=mkdir
alias ni=touch
alias pn=pnpm
alias pips="pn i && pn start"
alias pipd="pn i && pn dev"

if [[ "$OSTYPE" == "msys" ]]; then
    alias open=explorer
fi
