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
}

source ~/mydotfiles/nu/aliases.nu
source ~/mydotfiles/nu/completions.nu
source ~/.zoxide.nu

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# https://www.nushell.sh/cookbook/direnv.html#how-direnv-works
use std/config *

# Initialize the PWD hook as an empty list if it doesn't exist
$env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default []

$env.config.hooks.env_change.PWD ++= [{||
  if (which direnv | is-empty) {
    # If direnv isn't installed, do nothing
    return
  }

  direnv export json | from json | default {} | load-env
  # If direnv changes the PATH, it will become a string and we need to re-convert it to a list
  $env.PATH = do (env-conversions).path.from_string $env.PATH
}]
