$destinationPath = "~/.config/chezmoi/chezmoi.toml"

if (-Not (Test-Path -Path $destinationPath)) {
	Copy-Item -Path ./templates/chezmoi.toml -Destination $destinationPath
}

Start-Process -FilePath $destinationPath
