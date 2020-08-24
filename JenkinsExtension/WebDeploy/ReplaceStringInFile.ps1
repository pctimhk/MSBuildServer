param([string]$FilePath, [string]$OriginalValue, [string]$NewValue)

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Import-Module -Name "$scriptDir\ReplaceStringInFile.psm1"

ReplaceStringInFile -FilePath $FilePath -OriginalValue $OriginalValue -NewValue $NewValue