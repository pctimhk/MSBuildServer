Param(
  [string]$RemoteHost,
  [string]$ServiceName
)

$Script=
'
net start $args
'

remotecommand.ps1 -RemoteHost $RemoteHost -Script $Script -InputArgument $ServiceName