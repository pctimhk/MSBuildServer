Param(
  [string]$RemoteHost,
  [string]$ServiceName
)

$Script=
'
$serviceStatus = (get-service $args).Status;

if ($serviceStatus -eq "Running") {
Write-Host "Ready to stop $args";
net stop $args
}
else {
    Write-Host "$args status is $serviceStatus";
}
'

remotecommand.ps1 -RemoteHost $RemoteHost -Script $Script -InputArgument $ServiceName