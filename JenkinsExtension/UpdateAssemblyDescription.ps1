# SetAssemblyVersion.ps1
#
# http://www.luisrocha.net/2009/11/setting-assembly-version-with-windows.html
# http://blogs.msdn.com/b/dotnetinterop/archive/2008/04/21/powershell-script-to-batch-update-assemblyinfo-cs-with-new-version.aspx
# http://jake.murzy.com/post/3099699807/how-to-update-assembly-version-numbers-with-teamcity
# https://github.com/ferventcoder/this.Log/blob/master/build.ps1#L6-L19

Param(
    [string]$path=$pwd
)

function Help {
    "Sets the AssemblyVersion and AssemblyFileVersion of AssemblyInfo.cs files`n"
    ".\SetAssemblyVersion.ps1 [VersionNumber] -path [SearchPath]`n"
    "   [VersionNumber]     The version number to set, for example: 1.1.9301.0"
    "   [SearchPath]        The path to search for AssemblyInfo files.`n"
}
function Update-SourceDescription
{
    Param ([string]$desctext)
    $NewVersion = 'AssemblyVersion("' + $desctext + '")';
    $NewFileVersion = 'AssemblyFileVersion("' + $desctext + '")';

    foreach ($o in $input) 
    {
        Write-Host "Updating  '$($o.FullName)' -> $desctext"
    
        $assemblyDescriptionPattern = 'AssemblyDescription\(".*"\)'
        $assemblyDescription = 'AssemblyDescription("' + $desctext + '")';
        
        (Get-Content $o.FullName) | ForEach-Object  { 
           % {$_ -replace $assemblyDescriptionPattern, $assemblyDescription }
        } | Out-File $o.FullName -encoding UTF8 -force
    }
}
function Update-AllAssemblyInfoFiles ( $desctext )
{
    Write-Host "Searching '$path'"
   foreach ($file in "AssemblyInfo.cs", "AssemblyInfo.vb" ) 
   {
        get-childitem $path -recurse |? {$_.Name -eq $file} | Update-SourceDescription $desctext ;
   }
}

# validate arguments 
if ($args -ne $null) {
    $desctext = $args[0]
    if ($desctext -eq '/?') {
        Help
        exit 1;
    }
} else {
    Help
    exit 1;
}

Update-AllAssemblyInfoFiles $desctext