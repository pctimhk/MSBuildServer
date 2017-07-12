<#
This script will execute Nunit3 console program for all the *.nunit Nunit configuration project file.
The test result will generate out and the result file name same as the Nunit configuration project filename.
#>

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
    $FileFolder = (Convert-Path $file.PSParentPath);
    $NunitArgs = '"'+$file.FullName+'" --trace=Verbose -work="'+$FileFolder+'" --result="'+$OutputXML+';format=nunit3" --output "'+$OutputText+'"';
    $FullCommand = $NunitCommand + " " + $NunitArgs;
    Write-Host "Execute Nunit for '$file'";
    Start-Process -FilePath "$NunitCommand" -ArgumentList $NunitArgs -Wait;
    Write-Host "Result output to '$OutputXML'";
}