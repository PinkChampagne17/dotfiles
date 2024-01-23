source ~/mydotfiles/nu/nu_scripts/custom-completions/cargo/cargo-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/git/git-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/npm/npm-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/pnpm/pnpm-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/rustup/rustup-completions.nu
source ~/mydotfiles/nu/nu_scripts/custom-completions/vscode/vscode-completions.nu

if ($nu.os-info.name == "windows") {
	# source ~/mydotfiles/nu/nu_scripts/custom-completions/scoop/scoop-completions.nu
	source ~/mydotfiles/nu/nu_scripts/custom-completions/winget/winget-completions.nu
} else {
	source ~/mydotfiles/nu/nu_scripts/custom-completions/nix/nix-completions.nu
}
