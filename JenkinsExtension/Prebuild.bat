@ECHO ON
Set RootDir=%~dp0
Set AntExt=%RootDir%\ant.bat
Set PreBuildScript=%WORKSPACE%\prebuild.xml

ECHO Execute the global prebuild steps

ECHO generate buildinfo.properties
call "%~dp0%generatebuildinfo.bat

ECHO Execute the update version steps
call "%~dp0%UpdateVersion\UpdateVersion.bat"

ECHO Execute XDT (XML Documentation Transformation) for different environment
call "%~dp0xdt\xdt.bat"

ECHO Check prebuild script exists or not in %PreBuildScript%
if exist %PreBuildScript% (
   call %AntExt% %PreBuildScript%
)

ECHO Completed global prebuild steps