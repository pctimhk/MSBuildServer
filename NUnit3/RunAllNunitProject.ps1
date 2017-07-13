
$RootPath=$args[0]
$TestOutputPath=$args[1]

$NunitCommand = 'D:\Program Files (x86)\NUnit.org\nunit-console\nunit3-console.exe'

if(!(Test-Path -Path $TestOutputPath )){
    New-Item -ItemType directory -Path $TestOutputPath;
}

workflow StartNUnitTest {
    param ($NunitCommand, $Filenames, $TestOutputPath)
    foreach -parallel($file in $Filenames)
    {
        $OutputXML = $TestOutputPath + $file.BaseName + ".xml";
        $OutputText = $TestOutputPath + $file.BaseName + ".txt";
        $OutputErrorText = $TestOutputPath + $file.BaseName + "_err.txt";
        $FileFolder = (Convert-Path $file.PSParentPath);
        $FilePath = $file.FullName;
        $NunitArgs = '"'+$FilePath+'" --trace=Verbose -work="'+$FileFolder+'" --result="'+$OutputXML+';format=nunit3" --output "'+$OutputText+'" --err="'+$OutputErrorText+'"';
        $FullCommand = """$NunitCommand"" $NunitArgs";
        Invoke-Expression -Command "echo 'Execute Nunit project $file on $(Get-Date)'";
        Invoke-Expression "& ""$NunitCommand"" $NunitArgs";
        Invoke-Expression -Command "echo 'Result output to $OutputXML on $(Get-Date)'";
    }
}

$filenames = Get-ChildItem "$RootPath" -Recurse -Include *.nunit -Exclude *Spring.Testing.NUnit*;
StartNUnitTest -NunitCommand $NunitCommand -Filenames $filenames -TestOutputPath $TestOutputPath;
