@ECHO Execute all Unit Test from Visual Studio
"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe" %1 %2 %3 %4 %5 %6 %7 %8 %9 /Enablecodecoverage /UseVsixExtensions:true /Logger:trx 
@ECHO Completed to execute Unit Test from Visual Studio and the error level is %ERRORLEVEL%
EXIT %ERRORLEVEL%