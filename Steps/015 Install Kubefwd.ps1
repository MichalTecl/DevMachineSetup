function Install-Kubefwd {

    if($env:Path -like "*kubefwd*"){
        Write-Host "Kubefwd is already installed, skipping"    
        return
    } 


    $installDir = Join-Path $env:PROGRAMFILES -ChildPath "Kubefwd"

    mkdir $installDir -Force

    $tempZip = Join-Path $installDir -ChildPath "kubefwd_Windows_x86_64.zip" 

    Invoke-WebRequest "https://github.com/txn2/kubefwd/releases/download/1.22.4/kubefwd_Windows_x86_64.zip" -OutFile $tempZip

    Expand-Archive -Path $tempZip -DestinationPath $installDir -Force

    Remove-Item $tempZip -Force
        
    $path = "$env:Path;$installDir"

    Write-Host "Adding '$exePath' to Path statement now..."       
    [Environment]::SetEnvironmentVariable("Path", $path, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "Done"       
}

Install-Kubefwd