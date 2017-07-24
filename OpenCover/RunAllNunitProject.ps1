param (
    $RootPath = 'D:\Program Files (x86)\Jenkins\jobs\SCS-DEV\workspace\default', 
    $TestOutputPath = 'D:\Program Files (x86)\Jenkins\jobs\SCS-DEV\workspace\default\TestOutput', 
    $NunitCommand = 'D:\Program Files (x86)\NUnit.org\nunit-console\nunit3-console.exe', 
    $OpenCoverCommand = 'D:\Program Files (x86)\opencover_4_6_519\OpenCover.Console.exe',
    $OpenCoverReportGenerator = 'D:\Program Files (x86)\OpenCover_ReportGenerator_2_5_10\ReportGenerator.exe'
)

if(!(Test-Path -Path $TestOutputPath )){
    New-Item -ItemType directory -Path $TestOutputPath;
}

workflow StartNUnitTest {
    param ($OpenCoverCommand, $NunitCommand, $Filenames, $NUnitOutputFolder, $OpenCoverOutputFolder)
    foreach -parallel($file in $Filenames)
    {
        $TempBatchCmd = $NUnitOutputFolder + "\" + $file.BaseName + ".bat";

        $OutputXML = $NUnitOutputFolder + "\NUnit\" + $file.BaseName + "_NU.xml";
        $OutputText = $NUnitOutputFolder  + "\NUnit\" +  $file.BaseName + ".txt";
        $OutputErrorText = $NUnitOutputFolder  + "\NUnit\" +  $file.BaseName + "_err.txt";
        $OpenCoverOutputXml = $NUnitOutputFolder  + "\OpenCover\" +  $file.BaseName + "_OC.xml";
        $FileFolder = (Convert-Path $file.PSParentPath);
        $FilePath = $file.FullName;
        $Command = """$OpenCoverCommand"" -register:user -target:""$NunitCommand"" -targetargs:""""""$FilePath"""" "+'--'+"trace=Verbose -work=""""$FileFolder"""" "+'--'+"output """"$OutputText"""" "+'--'+"err=""""$OutputErrorText"""" "+'--'+"result=""""$OutputXML;format=nunit2"""" ""  -filter:+[*]* -output:""$OpenCoverOutputXml""`n";
        $FullCommand = """$NunitCommand"" $NunitArgs";
        Invoke-Expression -Command "echo 'Execute Nunit project $file on $(Get-Date)'";
        Out-File -FilePath "$TempBatchCmd" -InputObject $Command -Encoding ASCII -Force;
        Invoke-Expression "& ""$TempBatchCmd""";
        Invoke-Expression -Command "echo 'Result output to $OutputXML on $(Get-Date)'";
    }
}

$NUnitOutputFolder = $TestOutputPath + "\NUnit";
$OpenCoverOutputFolder = $TestOutputPath  + "\OpenCover";
$OpenCoverHtmlOutputFolder = $TestOutputPath  + "\OpenCoverHtml";

# call workflow to generate every nunit project
$filenames = Get-ChildItem "$RootPath" -Recurse -Include *.nunit -Exclude *Spring.Testing.NUnit*;
StartNUnitTest -OpenCoverCommand $OpenCoverCommand -NunitCommand $NunitCommand -OpenCoverReportGenerator $OpenCoverReportGenerator -Filenames $filenames -NUnitOutputFolder $NUnitOutputFolder -OpenCoverOutputFolder $OpenCoverOutputFolder;

# generate html report
$TempBatchCmd = $NUnitOutputFolder + "\GenerateOpenCoverHtmlReport.bat";
$Command = """$OpenCoverReportGenerator"" -reports:""$OpenCoverOutputFolder\*.xml"" -targetDir:""$OpenCoverHtmlOutputFolder""`n";
Out-File -FilePath "$TempBatchCmd" -InputObject $Command -Encoding ASCII -Force;
Invoke-Expression "& ""$TempBatchCmd""";