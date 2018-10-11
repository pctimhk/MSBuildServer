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

$command = "`"D:\Programs\JenkinsExtension\7z.bat`" x `"$zipPath`" -o`"$BinFolderPath`""
iex "& $command"

if (![string]::IsNullOrEmpty($remoteUNC))
{
    Write-Output "Copy unzip folder from $BinFolderPath to $remoteUNC"
    Copy-Item -Force -Recurse "$BinFolderPath\*" -Destination "$remoteUNC"
}