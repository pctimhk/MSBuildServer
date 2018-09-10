@ECHO OFF
Set RootDir=%~dp0
Set AntExt="%RootDir%..\ant.bat
Set BuildFile=global-xdtbuild.xml

xcopy /y /v /f %RootDir%%BuildFile% %WORKSPACE%
%AntExt%" %WORKSPACE%\%BuildFile%