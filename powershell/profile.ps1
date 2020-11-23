. (Join-Path -Path (Split-Path -Parent -Path $PROFILE) -ChildPath Set-SolarizedDarkColorDefaults.ps1)
Import-Module oh-my-posh
Set-Prompt

Set-Alias ws GotoPriveWorkspace

function GotoPriveWorkspace {
	Set-Location D:\Workspace
	Clear-Host
}