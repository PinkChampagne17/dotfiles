alias cwd="code ." # code work dir
alias ll="ls -AFhl"
alias md=mkdir
alias ni=touch
alias pn=pnpm
alias pipd="pn i && pn dev"
alias pnl="git restore -SW pnpm-lock.yaml && pnpm i --lockfile-only && pnpm dedupe --lockfile-only && git add pnpm-lock.yaml"

if [[ "$OSTYPE" == "msys" ]]; then
    alias open=explorer
fi
