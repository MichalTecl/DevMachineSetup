
# add Czech language
$LanguageList = Get-WinUserLanguageList

$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'cs-CZ'))
Set-WinUserLanguageList $LanguageList -Force


$LanguageList.Add("cs-CZ")
Set-WinUserLanguageList $LanguageList -Force

# change keyboard layout to Czech QUERTY (https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-language-pack-default-values?view=windows-11)
$cz = ($LanguageList | Where-Object LanguageTag -like 'cs-CZ')
$cz.InputMethodTips.Clear()
$cz.InputMethodTips.Add('0405:00010405')
Set-WinUserLanguageList $LanguageList -Force