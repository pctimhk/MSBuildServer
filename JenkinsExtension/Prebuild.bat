@ECHO OFF
Set RootDir=%~dp0
Set AntExt=ant.bat
Set PreBuildScript=%WORKSPACE%\prebuild.xml

ECHO Execute the global prebuild steps

ECHO generate buildinfo.properties
call "%RootDir%generatebuildinfo.bat

ECHO Execute the update version steps
call "%RootDir%UpdateVersion\UpdateVersion.bat"

ECHO Check prebuild script exists or not in %PreBuildScript%
if exist %PreBuildScript% (
   call %RootDir%\%AntExt% %PreBuildScript%
)

ECHO Completed global prebuild steps