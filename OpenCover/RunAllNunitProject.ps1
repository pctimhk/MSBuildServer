param ($RootPath = 'D:\Program Files (x86)\Jenkins\jobs\SCS-DEV\workspace\default\', $TestOutputPath = 'D:\Program Files (x86)\Jenkins\jobs\SCS-DEV\workspace\default\TestOutput\', $NunitCommand = 'D:\Program Files (x86)\NUnit.org\nunit-console\nunit3-console.exe', $OpenCoverCommand = 'D:\Program Files (x86)\opencover_4_6_519\OpenCover.Console.exe')

if(!(Test-Path -Path $TestOutputPath )){
    New-Item -ItemType directory -Path $TestOutputPath;
}

workflow StartNUnitTest {
    param ($OpenCoverCommand, $NunitCommand, $Filenames, $TestOutputPath)
    foreach -parallel($file in $Filenames)
    {
        $TempBatchCmd = $TestOutputPath + $file.BaseName + ".bat";

        $OutputXML = $TestOutputPath + $file.BaseName + ".xml";
        $OutputText = $TestOutputPath + $file.BaseName + ".txt";
        $OutputErrorText = $TestOutputPath + $file.BaseName + "_err.txt";
        $OpenCoverOutputXml = $TestOutputPath + $file.BaseName + "_OC.xml";
        $FileFolder = (Convert-Path $file.PSParentPath);
        $FilePath = $file.FullName;
        #$NunitArgs = '"'+$FilePath+'" --trace=Verbose -work="'+$FileFolder+'" --result="'+$OutputXML+';format=nunit3" --output "'+$OutputText+'" --err="'+$OutputErrorText+'"';
        $Command = """$OpenCoverCommand"" -register:user -target:""$NunitCommand"" -targetargs:""""""$FilePath"""" "+'--'+"trace=Verbose -work=""""$FileFolder"""" "+'--'+"output """"$OutputText"""" "+'--'+"err=""""$OutputErrorText"""" "+'--'+"result=""""$OutputXML;format=nunit2"""" ""  -filter:+[*]* -output:""$OpenCoverOutputXml""";
        $FullCommand = """$NunitCommand"" $NunitArgs";
        Invoke-Expression -Command "echo 'Execute Nunit project $file on $(Get-Date)'";
        Out-File -FilePath "$TempBatchCmd" -InputObject $Command -Encoding ASCII -Force;
        Invoke-Expression "& ""$TempBatchCmd""";
        #Invoke-Expression "& ""$NunitCommand"" $NunitArgs";
        Invoke-Expression -Command "echo 'Result output to $OutputXML on $(Get-Date)'";
    }
}

$filenames = Get-ChildItem "$RootPath" -Recurse -Include *.nunit -Exclude *Spring.Testing.NUnit*;
StartNUnitTest -OpenCoverCommand $OpenCoverCommand -NunitCommand $NunitCommand -Filenames $filenames -TestOutputPath $TestOutputPath;