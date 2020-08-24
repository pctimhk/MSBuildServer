@ECHO Execute all Unit Test from Visual Studio
REM "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9 /Enablecodecoverage /UseVsixExtensions:true /Logger:trx 
"%LOCALAPPDATA%\Apps\OpenCover\OpenCover.Console.exe" -output:"%WORKSPACE%\OpenCover.xml" -target:"C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" -targetargs:"%1 %2 %3 %4 %5 %6 %7 %8 %9 /Enablecodecoverage /UseVsixExtensions:true /Logger:trx"
@ECHO Completed to execute Unit Test from Visual Studio and the error level is %ERRORLEVEL%
EXIT %ERRORLEVEL%