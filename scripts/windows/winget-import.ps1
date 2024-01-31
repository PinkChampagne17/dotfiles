$EXPORT_FILE = "$HOME\winget-export.json"

$ID_TO_INSTALL = @(
	"9MVZQVXJBQ9V" # AV1 Video Extension
)

$ID_TO_INTERACTIVE_INSTALL = @(
	"Git.Git"
	"Oracle.VirtualBox"
	"qBittorrent.qBittorrent"
	"Valve.Steam"
)

function installPackageById ([string]$id, [bool]$interactive) {
	$command = "winget install $id --accept-package-agreements --accept-source-agreements"
	if ($interactive) {
		$command = "$command --interactive"
	}
	Write-Output $command
	Invoke-Expression $command
}

$GPU = (Get-WmiObject Win32_VideoController).Name
If ($GPU -like "*NVIDIA*") {
	installPackageById("Nvidia.NVIDIAControlPanel", $false)
	installPackageById("Guru3D.Afterburner", $false)
}

winget install Microsoft.VisualStudioCode --override '/mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

Get-Content -Path $EXPORT_FILE |
ConvertFrom-Json |
ForEach-Object { $_ } |
ForEach-Object {
	$type = $_.GetType().Name
	if ($type -eq "String") {
		$_
	}
	else {
		$_.Id
	}
} |
ForEach-Object {
	installPackageById($_, $_ -in $ID_TO_INTERACTIVE_INSTALL)
}

$ID_TO_INSTALL |
ForEach-Object {
	installPackageById($_, $false)
}
