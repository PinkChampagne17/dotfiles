# Nushell Config File
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/default_files/doc_config.nu

# External completer example
# let carapace_completer = {|spans|
#     carapace $spans.0 nushell $spans | from json
# }

$env.config = {
    show_banner: false

    rm: {
        always_trash: true
    }

    completions: {
        algorithm: "fuzzy"
        # external: {
        #     completer: null # check 'carapace_completer' above as an example
        # }
    }

    filesize: {
        unit: 'binary'
    }

    shell_integration: {
    	osc133: false # https://github.com/nushell/nushell/issues/6214#issuecomment-2261788482
    }

    hooks: {
        env_change: {
            PWD: [
				{|before, after| null }
				(source ~/mydotfiles/nu/nu_scripts/nu-hooks/nu-hooks/direnv/config.nu)
			]
        }
    }
}

source ~/mydotfiles/nu/aliases.nu
source ~/mydotfiles/nu/completions.nu
source ~/.cache/starship/init.nu
source ~/.zoxide.nu
