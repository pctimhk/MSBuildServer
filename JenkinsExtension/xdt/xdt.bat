@ECHO OFF

call %~dp0..\SETENV.bat
Set BuildFile=global-xdtbuild.xml

xcopy /y /v /f %~dp0%BuildFile% %WORKSPACE%
ECHO "%AntExtBin%" "%WORKSPACE%\%BuildFile%"
call "%AntExtBin%" "%WORKSPACE%\%BuildFile%"