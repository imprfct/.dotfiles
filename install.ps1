$DotfilesPath = $PSScriptRoot

function Link-Config {
    param (
        [string]$LinkPath,
        [string]$TargetName
    )

    $Target = "$DotfilesPath\$TargetName"

    if (-not (Test-Path $Target)) {
        Write-Warning "$TargetName not found in repository."
        return
    }

    if (Test-Path $LinkPath) {
        $Item = Get-Item $LinkPath
        if ($Item.LinkType -eq "Junction" -or $Item.LinkType -eq "SymbolicLink") {
            Write-Host "$TargetName is already linked."
            return
        }

        $BackupName = "$LinkPath.backup.$(Get-Date -Format 'yyyyMMdd-HHmm')"
        Write-Warning "Existing $TargetName found. Renamed to $BackupName"
        Rename-Item -Path $LinkPath -NewName $BackupName
    }

    New-Item -ItemType Junction -Path $LinkPath -Target $Target | Out-Null
    Write-Host "Linked $TargetName"
}

Link-Config -LinkPath "$env:LOCALAPPDATA\nvim" -TargetName "nvim"
