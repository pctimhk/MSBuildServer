@ECHO OFF

call %~dp0\SETENV.bat

ECHO Execute the global postbuild steps

ECHO Check prebuild script exists or not in %PostBuildScriptPath%
if exist %PostBuildScript% (
   call "%AntExtBin%" "%PostBuildScriptPath%"
)

ECHO Completed global postbuild steps