function Setup-BbSsh {
    #$confirmation = Read-Host "Do you want to setup SSH access to BitBucket? (y/n)"
    #if ($confirmation -ne "y"){
    #    return
    #}

    $configContent = 
@"
HostkeyAlgorithms +ssh-rsa    
PubkeyAcceptedAlgorithms +ssh-rsa
"@

    $userDir = $env:USERPROFILE
    $sshDir = Join-Path $userDir -ChildPath ".ssh"
    
    $privateKeyPath = Join-Path $sshDir -ChildPath "id_rsa"
    $publicKeyPath = Join-Path $sshDir -ChildPath "id_rsa.pub"
    $configPath = Join-Path $sshDir -ChildPath "config"

    $priExists = Test-Path($privateKeyPath)
    $pubExists = Test-Path($publicKeyPath)

    if ($priExists -ne $pubExists){
        throw "Incomplete pair of public + private keys - please check " + $sshDir
    }

    if ($priExists -and $pubExists){
        Write-Host "SSH key found, skipping the generation"
    } else {
        $userName = $env:UserName + "@inwk.com"
        $customUserName = Read-Host "Enter Bitbucket user name (leave empty to use "  $userName ")" 

        if (-not([string]::IsNullOrEmpty($customUserName))){
            $userName = $customUserName
        }
        
        "ssh-keygen -t rsa -C $userName -f $privateKeyPath -N """ | cmd
    }

    if (Test-Path($configPath)){
        Write-Host "$configPath exists - skipping creation"
    } else {
        Set-Content -Path $configPath -Value $configContent
    }

    $pubKey = Get-Content $publicKeyPath
    Set-Clipboard -Value $pubKey

    Start-Process "http://gitprod01:7990/plugins/servlet/ssh/account/keys"

    Write-Host ""
    Write-Host "*****"
    Read-Host "The public key was copied to your clipboard. Go to Bitbucket -> click your account icon in top-right corner -> Manage Account -> SSH Keys -> Add Key -> Ctrl+V ;)  ...Just waiting for your ENTER to confirm you did it..."

    

}

Setup-BbSsh