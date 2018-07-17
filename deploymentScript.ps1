[xml]$xml = Get-Content -Path "C:\Repos\VSTSDemo-WebApp\SNWebApp2018.PublishSettings" # Get publishing profile for the web app
$userName = $xml.SelectNodes("//publishProfile[@publishMethod=`"MSDeploy`"]/@userName").value
$password = $xml.SelectNodes("//publishProfile[@publishMethod=`"MSDeploy`"]/@userPWD").value
$url = $xml.SelectNodes("//publishProfile[@publishMethod=`"MSDeploy`"]/@publishUrl").value
$filePath = "C:\Repos\VSTSDemo-WebApp\appContent.zip"
$apiUrl = "https://SNWebApp2018.scm.azurewebsites.net/api/ZipDeploy"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))
$userAgent = "powershell/1.0"
Invoke-RestMethod -Uri $apiUrl -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -UserAgent $userAgent -Method POST -InFile $filePath -ContentType "multipart/form-data"
