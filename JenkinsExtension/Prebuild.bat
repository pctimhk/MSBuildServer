@ECHO OFF

call %~dp0\SETENV.bat

ECHO Execute the global prebuild steps

ECHO generate buildinfo.properties
call "%~dp0%generatebuildinfo.bat

ECHO Execute the update version steps
call "%~dp0%UpdateVersion\UpdateVersion.bat"

ECHO Execute XDT (XML Documentation Transformation) for different environment
call "%~dp0xdt\xdt.bat"

ECHO Check prebuild script exists or not in %PreBuildScriptPath%
if exist %PreBuildScriptPath% (
   ECHO Prebuild script exists and the script will be executed.
   call "%AntExtBin%" "%PreBuildScriptPath%"
)

ECHO Completed global prebuild steps