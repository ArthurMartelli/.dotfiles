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
        }
    }

    end {
        exit
    }
}

$packages = @(
    @{
        name    = "Chocolatey"
        command = "choco upgrade all"
    },
    @{
        name    = "PIP"
        command = "pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}"
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