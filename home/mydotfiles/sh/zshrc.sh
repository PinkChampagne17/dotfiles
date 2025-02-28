source ~/mydotfiles/sh/base.sh

# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/tokyonight_storm.omp.json)"
    # starship preset pure-preset -o ~/starship/pure.toml
# fi

# eval "$(fnm env --shell zsh --use-on-cd --corepack-enabled)"
eval "$(starship init zsh)"
eval "$(zoxide init --cmd j zsh)"

# alias flushdns='sudo killall -HUP mDNSResponder'

if [[ "$OSTYPE" == "darwin"* ]]; then
	source ~/mydotfiles/sh/zshrc_darwin.sh
fi

# eval "$(atuin init zsh)"
