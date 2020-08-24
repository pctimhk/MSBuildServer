Function ReplaceStringInFile([string]$FilePath, [string]$OriginalValue, [string]$NewValue) {
    if (Test-Path $FilePath)
    {
        Copy-Item "$FilePath" -Destination "$FilePath.org" -force

        $content = Get-Content -path "$FilePath"    
        $content -replace "$OriginalValue", "$NewValue" |  Out-File $FilePath -encoding utf8
    }
    else
    {
        Write-Error "$FilePath file not found."
    }
}