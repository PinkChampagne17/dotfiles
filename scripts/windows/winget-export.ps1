$EXPORT_FILE = "$HOME\winget-export.json"

$EXCLUEDE_ID = @(
	"Guru3D.Afterburner"
	"Microsoft.AppInstaller"
	"Microsoft.DotNet.DesktopRuntime.6"
	"Microsoft.OneDrive"
	"Microsoft.VCLibs.Desktop.14"
	"Microsoft.VisualStudioCode"
	"ParadoxInteractive.ParadoxLauncher"
	"TechPowerUp.GPU-Z"
)

$EXCLUEDE_GLOB = @(
	"*NVIDIA*"
	"*VCRedist*"
	"Microsoft.Edge*"
	"Microsoft.UI.Xaml*"
)

# [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Get-WinGetPackage |
Where-Object { $_.Source -ne $null } |
Select-Object -Property Id, Name, Source |
Where-Object { $_.Id -notin $EXCLUEDE_ID } |
Where-Object {
	$id = $_.Id
	$EXCLUEDE_GLOB.Where({ $id -like $_ }).Count -eq 0
} |
Sort-Object -Property id |
ForEach-Object {
	if ($_.Name -eq "") {
		$_.Id
	}
	else {
		$_ | Select-Object -Property Id, Name
	}
} |
ConvertTo-Json |
Set-Content -Path $EXPORT_FILE

Write-Output "Written to $EXPORT_FILE"

Get-Content -Path $EXPORT_FILE | Write-Output

Write-Output "Done!"
