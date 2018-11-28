Param(
  [string]$RemoteHost,
  [string]$ApplicationPoolName
)

$Script=
'
Import-Module WebAdministration
 IIS:
Set-Location AppPools

Write-Host "Ready to start AppPool $args";
Start-WebAppPool -Name "'+$ApplicationPoolName+'"
'

remotecommand.ps1 -RemoteHost $RemoteHost -Script $Script -InputArgument $ApplicationPoolName