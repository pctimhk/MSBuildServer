@ECHO OFF

call %~dp0\SETENV.bat

ECHO Execute the global postbuild steps

ECHO Check postbuild script exists or not in %PostBuildScriptPath%
if exist %PostBuildScriptPath% (
   ECHO Postbuild script exist and it will be executed.
   call "%AntExtBin%" "%PostBuildScriptPath%"
)

ECHO Completed global postbuild steps