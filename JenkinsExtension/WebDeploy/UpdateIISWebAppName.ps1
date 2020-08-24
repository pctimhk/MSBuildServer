param ([string]$FilePath, [string]$NewIISWebAppName)

$ParameterName = "IIS Web Application Name"
$ParameterValue = $NewIISWebAppName

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Write-host $scriptDir
& $scriptDir\ReplaceWebDeployParameter.ps1 -FilePath $FilePath -ParameterName $ParameterName -ParameterValue $NewIISWebAppName