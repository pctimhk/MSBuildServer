@ECHO OFF

call %~dp0..\SETENV.bat
Set BuildFile=global-updateversion.xml

xcopy /y /v /f %~dp0%BuildFile% %WORKSPACE%
call "%AntExtBin%" "%WORKSPACE%\%BuildFile%"