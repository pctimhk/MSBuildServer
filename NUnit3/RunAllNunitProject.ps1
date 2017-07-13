
$RootPath=$args[0]
$TestOutputPath=$args[1]

$NunitCommand = 'D:\Program Files (x86)\NUnit.org\nunit-console\nunit3-console.exe'


if(!(Test-Path -Path $TestOutputPath )){
    New-Item -ItemType directory -Path $TestOutputPath;
}

$filenames = Get-ChildItem "$RootPath" -Recurse -Include *.nunit -Exclude *Spring.Testing.NUnit*

foreach($file in $filenames) {
    $OutputXML = $TestOutputPath + $file.BaseName + ".xml";
    $OutputText = $TestOutputPath + $file.BaseName + ".txt";
    $OutputErrorText = $TestOutputPath + $file.BaseName + "_err.txt";
    $FileFolder = (Convert-Path $file.PSParentPath);
    $NunitArgs = '"'+$file.FullName+'" --trace=Verbose -work="'+$FileFolder+'" --result="'+$OutputXML+';format=nunit3" --output "'+$OutputText+'" --err="'+$OutputErrorText+'"';
    $FullCommand = "'$NunitCommand' $NunitArgs";
    Write-Host 'Execute Nunit project "'+$file+'" on '+ $(Get-Date);
    #Start-Process -FilePath "$NunitCommand" -ArgumentList $NunitArgs -Wait;
    & $($NunitCommand) $NunitArgs
    Write-Host "Result output to '$OutputXML' on " + $(Get-Date);
}