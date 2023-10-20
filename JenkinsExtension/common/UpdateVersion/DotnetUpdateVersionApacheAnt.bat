@ECHO OFF

SET ApacheAntBinPath=%~dp0\apache-ant-1.10.5\bin\ant.bat
SET AntExtBin=%~dp0ant.bat

Set BuildFile=global-updateversion-ApacheAnt.xml

ECHO Current Environment Variables

xcopy /y /v /f %~dp0%BuildFile% %WORKSPACE%
ECHO "%AntExtBin%" "%WORKSPACE%\%BuildFile%"
call "%AntExtBin%" "%WORKSPACE%\%BuildFile%"