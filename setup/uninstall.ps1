#Requires -RunAsAdministrator

$message = "Uninstalling some Windows Programs"

function uninstall {
    param (
        [Parameter(Mandatory = $true)]
        $packages
    )
    Write-Output packages.message

    $command = $packages.command

    $count = 0
    $total = $packages.programs.Length
    
    foreach ($item in $packages.programs) {
        $count += 1
        $percent = ($count / $total).tostring("P")

        Write-Output ("($percent) [$count - $total] Installing $item")
        Invoke-Expression "${command} ${item}"
    }
}

$windows_packages = @{
    message  = "Uninstalling some default apps"
    command  = "Remove-AppPackage"
    programs = @(
        "   ",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.XboxGameOverlay",
        "Microsoft.Xbox.TCUI",
        "Microsoft.549981C3F5F10",
        "Microsoft.BingNews",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.WindowsFeedbackHub",
        "Microsoft.ZuneMusic"
    )
}

function Main {
    Write-Host $message

    uninstall $windows_packages    
}

Main