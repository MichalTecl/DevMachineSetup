cls

$yesno = "y", "n"

Set-Location $PSScriptRoot
# load all util functions from /Modules folders
$modules = Get-ChildItem -Path .\Utils
foreach ($f in $modules){
    .($f.FullName)
}

$confirmation = Read-Host "Do you want to confirm all individual steps execution? (y/n)"
$autoConfirm = ($confirmation -eq "n");

$stepFiles = (Get-ChildItem -Path .\Steps)

foreach ($f in $stepFiles){
   $confirmation = "?";

   if ($autoConfirm) {
      $confirmation = 'y'
   }
   else {
       while (-not($yesNo.Contains($confirmation)))
       { 
           $confirmation = Read-Host "Run step" $f.BaseName  "? (y/n)"
       }
   }
   
   if ($confirmation -eq 'y') {
       echo $f.BaseName

       refreshenv

       try {
       .($f.FullName) 
       } 
        catch {
          Write-Host "An error occurred:"
          Write-Host $_ -ForegroundColor Red 
          $continue = ""
          
          while(-not($yesNo.Contains($continue))) { 
            $continue = Read-Host "Continue executing next steps? (y/n)"
          }
          if ($continue -eq "n")
          {
            exit
          }
        }      
   } else {
       echo "Step skipped"
   }

   echo "**********************************"
}

echo "ALL STEPS DONE. You may need to restart your computer to start using installed stuff"


