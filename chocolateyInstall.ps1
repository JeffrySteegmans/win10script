#     > powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/Jk6b8')"

$tweaks = @(
	### Require administrator privileges ###
	"RequireAdmin",
	"CreateRestorePoint",

	### Chris Titus Tech Additions,
	"InstallTitusProgs", #REQUIRED FOR OTHER PROGRAM INSTALLS!
	"Install7Zip",
	"InstallNotepadplusplus",
	"InstallIrfanview",
	"InstallVLC",
	"InstallAdobe",
	"InstallBrave",
	"InstallChrome",
	"InstallFirefox",
	"InstallPutty",
	"InstallVSCode",
	"InstallConEmu",
	"InstallmRemoteNg",
	"InstallNextcloud",
	"InstallOpenVPN",
	"InstallWindirStat",
	"InstallWindowsTerminal",
  "InstallGreenshot"
)

Function RequireAdmin {
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
		Exit
	}
}

Function CreateRestorePoint {
	Write-Output "Creating Restore Point incase something bad happens"
	Enable-ComputerRestore -Drive "C:\"
	Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"
}

Function InstallTitusProgs {
	Write-Output "Installing Chocolatey"
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	choco install chocolatey-core.extension -y
}

function Show-Choco-Menu {
	param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$Title,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$ChocoInstall
	)

	do {
		Clear-Host
		Write-Host "================ $Title ================"
		Write-Host "Y: Press 'Y' to do this."
		Write-Host "2: Press 'N' to skip this."
		Write-Host "Q: Press 'Q' to stop the entire script."
		$selection = Read-Host "Please make a selection"
		switch ($selection) {
			'y' { choco install $ChocoInstall -y }
			'n' { Break }
			'q' { Exit }
		}
	}
	until ($selection -match "y" -or $selection -match "n" -or $selection -match "q")
}

function Import-Reg-settings {
	param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$Title,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$Filename
	)

	do {
		Clear-Host
		Write-Host "================ $Title ================"
		Write-Host "Y: Press 'Y' to do this."
		Write-Host "2: Press 'N' to skip this."
		Write-Host "Q: Press 'Q' to stop the entire script."
		$selection = Read-Host "Please make a selection"
		switch ($selection) {
			'y' { REG IMPORT C:\sysprep\$Filename.reg }
			'n' { Break }
			'q' { Exit }
		}
	}
	until ($selection -match "y" -or $selection -match "n" -or $selection -match "q")
}

Function InstallAdobe {
	Show-Choco-Menu -Title "Do you want to install Adobe Acrobat Reader?" -ChocoInstall "adobereader"
}

Function InstallBrave {
	do {
		Clear-Host
		Write-Host "================ Do You Want to Install Brave Browser? ================"
		Write-Host "Y: Press 'Y' to do this."
		Write-Host "2: Press 'N' to skip this."
		Write-Host "Q: Press 'Q' to stop the entire script."
		$selection = Read-Host "Please make a selection"
		switch ($selection) {
			'y' { 
				Invoke-WebRequest -Uri "https://laptop-updates.brave.com/download/CHR253" -OutFile $env:USERPROFILE\Downloads\brave.exe
				~/Downloads/brave.exe
			}
			'n' { Break }
			'q' { Exit }
		}
	}
	until ($selection -match "y" -or $selection -match "n" -or $selection -match "q")
}

Function InstallChrome {
	Show-Choco-Menu -Title "Do you want to install Chrome?" -ChocoInstall "googlechrome"
}

Function InstallFirefox {
	Show-Choco-Menu -Title "Do you want to install Firefox?" -ChocoInstall "firefox"
}

Function Install7Zip {
	Show-Choco-Menu -Title "Do you want to install 7-Zip?" -ChocoInstall "7zip"
}

Function InstallNotepadplusplus {
	Show-Choco-Menu -Title "Do you want to install Notepad++?" -ChocoInstall "notepadplusplus"
}

Function InstallVLC {
	Show-Choco-Menu -Title "Do you want to install VLC?" -ChocoInstall "vlc"
}

Function InstallIrfanview {
	Show-Choco-Menu -Title "Do you want to install Irfanview?" -ChocoInstall "irfanview"
}

function InstallPutty {
	Show-Choco-Menu -Title "Do you want to install Putty?" -ChocoInstall "putty"
	Import-Reg-settings -Title "Do you want to import Putty settings?" -Filename "putty"
}

function InstallVSCode {
	Show-Choco-Menu -Title "Do you want to install Visual Studio Code?" -ChocoInstall "vscode"
}

function InstallConEmu {
	Show-Choco-Menu -Title "Do you want to install ConEmu?" -ChocoInstall "conemu"
}

function InstallGit {
	Show-Choco-Menu -Title "Do you want to install Git?" -ChocoInstall "git"
	Show-Choco-Menu -Title "Do you want to install PoshGit?" -ChocoInstall "poshgit"
	Add-PoshGitToProfile -AllUsers -AllHosts
	Show-Choco-Menu -Title "Do you want to install Git Extensions?" -ChocoInstall "gitextensions"
}

function InstallmRemoteNg {
	Show-Choco-Menu -Title "Do you want to install mRemoteNg?" -ChocoInstall "mremoteng"
}

function InstallNextcloud {
	Show-Choco-Menu -Title "Do you want to install Nextcloud?" -ChocoInstall "nextcloud-client"
}

function InstallOpenVPN {
	Show-Choco-Menu -Title "Do you want to install OpenVPN?" -ChocoInstall "openvpn"
}

function InstallWindirStat {
	Show-Choco-Menu -Title "Do you want to install WindirStat?" -ChocoInstall "windirstat"
}

function InstallWindowsTerminal {
	Show-Choco-Menu -Title "Do you want to install Windows Terminal?" -ChocoInstall "microsoft-windows-terminal"
}

function InstallGreenshot {
	Show-Choco-Menu -Title "Do you want to install Greenshot?" -ChocoInstall "greenshot"
}