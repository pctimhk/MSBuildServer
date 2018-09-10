@ECHO OFF
Set RootDir=%~dp0
Set AntExt=ant.bat
Set PostBuildScript=%WORKSPACE%\build.xml

ECHO Execute the global postbuild steps

ECHO Check prebuild script exists or not in %PostBuildScript%
if exist %PostBuildScript% (
   call %RootDir%\%AntExt% %PostBuildScript%
)

ECHO Completed global postbuild steps