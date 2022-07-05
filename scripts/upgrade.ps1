#Requires -RunAsAdministrator

function UpgradePackages {
    param (
        [Parameter(Mandatory = $true)]
        $packages
    )

    begin {}

    process {
        foreach ($package in $packages) {
            Write-Output "Upgrading all packages in $($package.name)"
            Invoke-Expression $package.command
            RefreshEnv
        }
    }

    end {
        exit
    }
}

function Upgradepip {
    # Not sure why, but using IEX on this expression as a String will not work.
    pip list --outdated --format=freeze | ForEach-Object { pip install --upgrade ($_ -split '==')[0] }
}

$packages = @(
    @{
        name    = "Chocolatey"
        command = "choco upgrade all"
    },
    @{
        name    = "PIP"
        command = "Upgradepip"
    },
    @{
        name    = "NPM"
        command = "npm update -g"
    },
    @{
        name    = "Winget"
        command = "winget upgrade --all"
    }
)

function Main {
    UpgradePackages($packages)
}

Main