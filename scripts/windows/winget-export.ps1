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

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function GetMsStorePackageNameById ([string]$id) {
	$output = winget search $id | Out-String
	$name = $output -split "`n" |
	Where-Object { $_.Length -gt 0 } |
	Select-Object -Last 1 |
	ForEach-Object { $_ -split $id } |
	Select-Object -First 1
	$name.Trim()
}

$COMMAND_TO_EXPORT = "winget export -o $EXPORT_FILE --accept-source-agreements"
Write-Output $COMMAND_TO_EXPORT
Invoke-Expression $COMMAND_TO_EXPORT

Write-Output "Reading $EXPORT_FILE and processing..."

Get-Content -Path $EXPORT_FILE |
ConvertFrom-Json |
ForEach-Object { $_.Sources } |
ForEach-Object {
	$source = $_.SourceDetails.name
	$_.Packages | ForEach-Object {
		$name = ""
		if ($source -eq "msstore") {
			$name = GetMsStorePackageNameById $_.PackageIdentifier
		}
		New-Object PSObject -Property @{
			id     = $_.PackageIdentifier
			name   = $name
			source = $source
		}
	}
} |
Where-Object { $_.id -notin $EXCLUEDE_ID } |
Where-Object {
	$id = $_.id
	$EXCLUEDE_GLOB.Where({ $id -like $_ }).Count -eq 0
} |
Sort-Object -Property id |
ForEach-Object {
	if ($_.name -eq "") {
		$_.id
	}
	else {
		$_ | Select-Object -Property id, name
	}
} |
ConvertTo-Json |
Set-Content -Path $EXPORT_FILE

Write-Output "Written to $EXPORT_FILE"

Get-Content -Path $EXPORT_FILE | Write-Output

Write-Output "Done!"
