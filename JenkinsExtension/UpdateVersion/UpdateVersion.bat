@ECHO OFF
Set RootDir=%~dp0
Set AntExt=..\ant.bat
Set BuildFile=updateversion.xml

xcopy /y /v /f %RootDir%%BuildFile% %WORKSPACE%
"%RootDir%%AntExt%" %WORKSPACE%\%BuildFile%