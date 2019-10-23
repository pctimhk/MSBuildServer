Param(
  [string]$RemoteHost,
  [string]$ProcessName,
  [int]$Timeout
)

$Script=
'
Write-Output "Get $ProcessName information"
$processes = Get-Process | Where-Object {$_.ProcessName -eq "'+$ProcessName+'"}
 
 ForEach($process in $processes)
 {
  Write-Output "Process found and wait for the program exit."
	if(!$process.WaitForExit('+$Timeout+'))
	{
		throw "Wait Remote Process Timeout!!, Process: '+$ProcessName+', TimeOut: '+$Timeout+'"
	}
 }
Write-Output "Finish and exit wait process"
'
 
remotecommand.ps1 -RemoteHost $RemoteHost -Script $Script 