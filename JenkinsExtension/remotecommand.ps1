Param(
  [string]$RemoteHost,
  [string]$Script,
  [object[]]$InputArgument
)

$scriptBlock = [Scriptblock]::Create($Script)

try {
    write-host "start sending remote powershell command '$Script' to the host $RemoteHost"
    Invoke-Command -ComputerName $RemoteHost -ErrorAction Stop -ScriptBlock $scriptBlock -ArgumentList $InputArgument
    write-host "remote powershell command completed"
} catch {
    $string_err = $_ | Out-String
    write-host $string_err -BackgroundColor Red
    exit 1
    #break
}