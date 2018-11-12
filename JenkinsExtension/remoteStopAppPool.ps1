Param(
  [string]$RemoteHost,
  [string]$ApplicationPoolName
)

$Script=
'
Import-Module WebAdministration
 IIS:
Set-Location AppPools
 
 $ApplicationPoolStatusValue = (Get-WebAppPoolState "'+$ApplicationPoolName+'").Value

Write-Host "$args status is $ApplicationPoolStatusValue"

if($ApplicationPoolStatusValue -ne "Started")
 {
 Write-Host "$args status is $ApplicationPoolStatusValue."

 }else{
Write-Host "Ready to Stop AppPool $args";
Stop-WebAppPool -Name "'+$ApplicationPoolName+'"
}
'

remotecommand.ps1 -RemoteHost $RemoteHost -Script $Script -InputArgument $ApplicationPoolName