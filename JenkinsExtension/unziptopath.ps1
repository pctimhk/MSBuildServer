Param(
  [string]$zipPath,
  [string]$remoteUNC
)

$fileName = [System.IO.Path]::GetFileNameWithoutExtension($zipPath)
$folderPath = [System.IO.Path]::GetDirectoryName($zipPath)
$BinFolderPath = "$folderPath\$fileName"

if(Test-Path -Path $BinFolderPath ) {
    Remove-Item "$BinFolderPath" -Force -Recurse
}
Try 
{
    $command = "`"D:\Programs\JenkinsExtension\7z.bat`" x `"$zipPath`" -o`"$BinFolderPath`""
    Invoke-Expression "& $command"

    if (!($lastExitCode) -eq 0) {
        Write-Host "unzip file error." -ForegroundColor Red
        exit 1
        break
    }


    if (![string]::IsNullOrEmpty($remoteUNC))
    {
        Write-Output "Copy unzip folder from $BinFolderPath to $remoteUNC"
        Copy-Item -Force -Recurse "$BinFolderPath\*" -Destination "$remoteUNC"
    }
}
Catch 
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName
    Write-Host "Error found. Error: $ErrorMessage, Item: $FailedItem" -ForegroundColor Red
    exit 1
    break
}