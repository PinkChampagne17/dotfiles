$env.EDITOR = match $nu.os-info.name {
	"linux" => "zeditor"
	_ => "zed"
}

# https://nextjs.org/telemetry
$env.NEXT_TELEMETRY_DEBUG = 1

$env.STARSHIP_CONFIG = $"($nu.home-dir)/mydotfiles/starship/pure.toml"

zoxide init nushell --cmd j | save -f ~/.zoxide.nu

if ($nu.os-info.name == "macos") {
	# pnpm
	$env.PNPM_HOME = $"($nu.home-dir)/Library/pnpm"
	$env.PATH = ($env.PATH | split row (char esep) | prepend ($env.PNPM_HOME | path join "bin") )
	# pnpm end
}
