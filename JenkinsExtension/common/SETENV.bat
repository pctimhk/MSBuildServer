@ECHO OFF

IF not defined %RootDir GOTO SETENV ELSE GOTO END

GOTO END
:SETENV

Set RootDir=%~dp0
Set ApacheAntBinPath=D:\JenkinsExtension\ApacheAnt\apache-ant-1.10.5\bin\ant.bat
Set AntExtBin=%RootDir%ant.bat
Set PreBuildScriptPath=%WORKSPACE%\prebuild.xml
Set PostBuildScriptPath=%WORKSPACE%\build.xml
Set PmdScriptPath=D:\JenkinsExtension\pmd_6.7.0\bin\cpd.bat

GOTO END
:END