param ([string]$ParamFilePath, [string]$NewIISWebAppName)


if (Test-Path $ParamFilePath)
{
    Copy-Item "$ParamFilePath" -Destination "$ParamFilePath.org" -force

    $content = Get-Content -path "$ParamFilePath"    
    $content -replace "<setParameter name=`"IIS Web Application Name`" value=`"(.*)`" />", "<setParameter name=`"IIS Web Application Name`" value=`"$NewIISWebAppName`" />" |  Out-File $ParamFilePath -encoding utf8
}
else
{
    Write-Warning "$ParamFilePath file not found."
}