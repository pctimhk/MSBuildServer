@ECHO OFF

IF "%MyVar%"=="" GOTO SETENV ELSE GOTO END

GOTO END
:SETENV

Set RootDir=%~dp0
Set ApacheAntBinPath=D:\Programs\ApacheAnt\apache-ant-1.10.5\bin\ant.bat
Set AntExtBin=%RootDir%ant.bat
Set PreBuildScriptPath=%WORKSPACE%\prebuild.xml
Set PostBuildScriptPath=%WORKSPACE%\build.xml

GOTO END
:END