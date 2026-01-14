$DotfilesPath = $PSScriptRoot

function Link-Resource {
    param (
        [string]$LinkPath,
        [string]$RepoPath
    )

    $Source = "$DotfilesPath\$RepoPath"

    if (-not (Test-Path $Source)) {
        Write-Warning "$RepoPath not found in repository."
        return
    }

    if (Test-Path $LinkPath) {
        $Item = Get-Item $LinkPath
        if ($Item.LinkType -eq "Junction" -or $Item.LinkType -eq "SymbolicLink") {
            Write-Host "$RepoPath is already linked."
            return
        }

        $BackupName = "$LinkPath.backup.$(Get-Date -Format 'yyyyMMdd-HHmm')"
        Write-Warning "Existing resource found. Renamed to $BackupName"
        Rename-Item -Path $LinkPath -NewName $BackupName
    }

    $IsDir = (Get-Item $Source).PSIsContainer
    $Type = if ($IsDir) { "Junction" } else { "SymbolicLink" }

    New-Item -ItemType $Type -Path $LinkPath -Target $Source | Out-Null
    Write-Host "Linked $RepoPath ($Type)"
}

# --- Configs ---

# Neovim
Link-Resource -LinkPath "$env:LOCALAPPDATA\nvim" -RepoPath "nvim"

# Windows Terminal
Link-Resource -LinkPath "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -RepoPath "windows-terminal\settings.json"

# PowerShell Profile
Link-Resource -LinkPath $PROFILE -RepoPath "powershell\Microsoft.PowerShell_profile.ps1"
