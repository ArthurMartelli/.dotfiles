#Requires -RunAsAdministrator

function uninstall {
    param (
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
        "Microsoft.GamingApp_8wekyb3d8bbwe",
        "Microsoft.XboxIdentityProvider_8wekyb3d8bbwe",
        "Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe",
        "Microsoft.XboxGameOverlay_8wekyb3d8bbwe",
        "Microsoft.Xbox.TCUI_8wekyb3d8bbwe",
        "Microsoft.549981C3F5F10_8wekyb3d8bbwe",
        "Microsoft.BingNews_8wekyb3d8bbwe",
        "Microsoft.GetHelp_8wekyb3d8bbwe",
        "Microsoft.Getstarted_8wekyb3d8bbwe",
        "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe",
        "Microsoft.WindowsFeedbackHub_8wekyb3d8bbwe",
        "Microsoft.ZuneMusic_8wekyb3d8bbwe"
    )
}

function Main {
    uninstall $windows_packages    
}

Main