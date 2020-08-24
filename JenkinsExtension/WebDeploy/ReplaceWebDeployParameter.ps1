param ([string]$FilePath, [string]$ParameterName, [string]$ParameterValue)

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Import-Module -Name "$scriptDir\ReplaceStringInFile.psm1"

$orgValue = '<setParameter name="{0}" value="(.*)" />' -f $ParameterName
$newValue = '<setParameter name="{0}" value="{1}" />' -f $ParameterName, $ParameterValue

ReplaceStringInFile -FilePath $FilePath -OriginalValue $orgValue -NewValue $newValue
