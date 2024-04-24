source ~/mydotfiles/nu/nu_scripts/custom-completions/auto-generate/completions/fzf.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/auto-generate/completions/grep.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/cargo/cargo-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/git/git-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/npm/npm-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/pnpm/pnpm-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/rustup/rustup-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/vscode/vscode-completions.nu

if ($nu.os-info.name == "windows") {
	source ~/mydotfiles/nu/nu_scripts/custom-completions/auto-generate/completions/cmd.nu
	# source ~/mydotfiles/nu/nu_scripts/custom-completions/scoop/scoop-completions.nu
	source ~/mydotfiles/nu/nu_scripts/custom-completions/winget/winget-completions.nu
} else {
	if ($nu.os-info.name == "linux") {
		source ~/mydotfiles/nu/nu_scripts/custom-completions/auto-generate/completions/flatpak.nu
	}
	source ~/mydotfiles/nu/nu_scripts/custom-completions/nix/nix-completions.nu
	source ~/mydotfiles/nu/nu_scripts/custom-completions/less/less-completions.nu
}
