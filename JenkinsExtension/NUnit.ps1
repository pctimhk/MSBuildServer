param (
    $RootPath = 'D:\Program Files (x86)\Jenkins\workspace\SCS-DEV', 
    $TestOutputPath = 'D:\Program Files (x86)\Jenkins\workspace\SCS-DEV\NUnitTestOutput', 
    $NunitCommand = 'D:\Program Files (x86)\NUnit.org\nunit-console\nunit3-console.exe', 
    $OpenCoverCommand = 'D:\Program Files (x86)\OpenCover\OpenCover.Console.exe',
    $OpenCoverReportGenerator = 'D:\Programs\OpenCover_ReportGenerator_2_5_10\ReportGenerator.exe',
    $OpenCoverToCoberturaConverter = 'D:\Programs\OpenCoverToCoberturaConverter\OpenCoverToCoberturaConverter.exe'
)

function StartNUnitTest {
    param ($OpenCoverCommand, $NunitCommand, $Filenames, $NUnitOutputFolder, $OpenCoverOutputFolder, $OpenCoverToCoberturaConverter, $CoberturaOutputFolder)
    foreach ($file in $Filenames)
    {
        $Workspace = $NUnitOutputFolder + "\..\";
        $TempBatchCmd = $NUnitOutputFolder + "\" + $file.BaseName + ".bat";
        $OutputXML = $NUnitOutputFolder + "\" + $file.BaseName + "_NU.xml";
        $OutputText = $NUnitOutputFolder  + "\" +  $file.BaseName + ".txt";
        $OutputErrorText = $NUnitOutputFolder  + "\" +  $file.BaseName + "_err.txt";
        $OpenCoverOutputXml = $OpenCoverOutputFolder + "\" +  $file.BaseName + "_OC.xml";
        $CoberturaOutputXml = $CoberturaOutputFolder + "\" +  $file.BaseName + "_CB.xml";
        $FileFolder = (Convert-Path $file.PSParentPath);
        $FilePath = $file.FullName;

        $Command = "echo Execute Nunit with Open Cover`n";
        $Command = $Command + """$OpenCoverCommand"" -register:""D:\Program Files (x86)\opencover_4_6_519\x86\OpenCover.Profiler.dll"" -target:""$NunitCommand"" -targetargs:""""""$FilePath"""" "+'--'+"trace=Verbose -work=""""$FileFolder"""" "+'--'+"output """"$OutputText"""" "+'--'+"err=""""$OutputErrorText"""" "+'--'+"result=""""$OutputXML;format=nunit2"""" ""  -filter:+[*]* -output:""$OpenCoverOutputXml""`n";
        $Command = $Command + "echo Execute Open Cover To Cobertura Report Converter`n";
        $Command = $Command + """$OpenCoverToCoberturaConverter"" -input:""$OpenCoverOutputXml"" -output:""$CoberturaOutputXml"" -sources:""$Workspace""`n";

        Invoke-Expression -Command "echo 'Execute Nunit project $file on $(Get-Date)'";
        Invoke-Expression -Command "echo Is 64 bit process? $([Environment]::Is64BitProcess)";
        Out-File -FilePath "$TempBatchCmd" -InputObject $Command -Encoding ASCII -Force;
        Invoke-Expression "& ""$TempBatchCmd""";
        Invoke-Expression -Command "echo 'Result output to $OutputXML on $(Get-Date)'";
    }
}

workflow StartNUnitTestParallel {
    param ($OpenCoverCommand, $NunitCommand, $Filenames, $NUnitOutputFolder, $OpenCoverOutputFolder, $OpenCoverToCoberturaConverter, $CoberturaOutputFolder)
    foreach -parallel($file in $Filenames)
    {
        $Workspace = $NUnitOutputFolder + "\..\";
        $TempBatchCmd = $NUnitOutputFolder + "\" + $file.BaseName + ".bat";
        $OutputXML = $NUnitOutputFolder + "\" + $file.BaseName + "_NU.xml";
        $OutputText = $NUnitOutputFolder  + "\" +  $file.BaseName + ".txt";
        $OutputErrorText = $NUnitOutputFolder  + "\" +  $file.BaseName + "_err.txt";
        $OpenCoverOutputXml = $OpenCoverOutputFolder + "\" +  $file.BaseName + "_OC.xml";
        $CoberturaOutputXml = $CoberturaOutputFolder + "\" +  $file.BaseName + "_CB.xml";
        $FileFolder = (Convert-Path $file.PSParentPath);
        $FilePath = $file.FullName;

        $Command = "echo Execute Nunit with Open Cover`n";
        $Command = $Command + """$OpenCoverCommand"" -register:""D:\Program Files (x86)\opencover_4_6_519\x86\OpenCover.Profiler.dll"" -target:""$NunitCommand"" -targetargs:""""""$FilePath"""" "+'--'+"trace=Verbose -work=""""$FileFolder"""" "+'--'+"output """"$OutputText"""" "+'--'+"err=""""$OutputErrorText"""" "+'--'+"result=""""$OutputXML;format=nunit2"""" ""  -filter:+[*]* -output:""$OpenCoverOutputXml""`n";
        $Command = $Command + "echo Execute Open Cover To Cobertura Report Converter`n";
        $Command = $Command + """$OpenCoverToCoberturaConverter"" -input:""$OpenCoverOutputXml"" -output:""$CoberturaOutputXml"" -sources:""$Workspace""`n";

        Invoke-Expression -Command "echo 'Execute Nunit project $file on $(Get-Date)'";
        Invoke-Expression -Command "echo Is 64 bit process? $([Environment]::Is64BitProcess)";
        Out-File -FilePath "$TempBatchCmd" -InputObject $Command -Encoding ASCII -Force;
        Invoke-Expression "& ""$TempBatchCmd""";
        Invoke-Expression -Command "echo 'Result output to $OutputXML on $(Get-Date)'";
    }
}

$NUnitOutputFolder = $TestOutputPath + "\NUnit";
$OpenCoverOutputFolder = $TestOutputPath  + "\OpenCover";
$OpenCoverHtmlOutputFolder = $TestOutputPath  + "\OpenCoverHtml";
$CoberturaOutputFolder = $TestOutputPath  + "\Cobertura";

if(!(Test-Path -Path $TestOutputPath )){
    New-Item -ItemType directory -Path $TestOutputPath;
}

if(!(Test-Path -Path $NUnitOutputFolder)){
    New-Item -ItemType directory -Path $NUnitOutputFolder;
}

if(!(Test-Path -Path $OpenCoverOutputFolder )){
    New-Item -ItemType directory -Path $OpenCoverOutputFolder;
}

if(!(Test-Path -Path $CoberturaOutputFolder )){
    New-Item -ItemType directory -Path $CoberturaOutputFolder;
}

# call workflow to generate every nunit project
$filenames = Get-ChildItem "$RootPath" -Recurse -Include *.nunit -Exclude *Spring.Testing.NUnit*;
StartNUnitTest -OpenCoverCommand $OpenCoverCommand -NunitCommand $NunitCommand -Filenames $filenames -NUnitOutputFolder $NUnitOutputFolder -OpenCoverOutputFolder $OpenCoverOutputFolder -OpenCoverToCoberturaConverter $OpenCoverToCoberturaConverter -CoberturaOutputFolder $CoberturaOutputFolder;

# generate html report
$TempBatchCmd = $NUnitOutputFolder + "\GenerateOpenCoverHtmlReport.bat";
$Command = """$OpenCoverReportGenerator"" -reports:""$OpenCoverOutputFolder\*.xml"" -targetDir:""$OpenCoverHtmlOutputFolder""`n";
Out-File -FilePath "$TempBatchCmd" -InputObject $Command -Encoding ASCII -Force;
Invoke-Expression "& ""$TempBatchCmd""";