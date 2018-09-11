@ECHO OFF

call %~dp0\SETENV.bat

ECHO execute ant for %1 build file
"%ApacheAntBinPath%" -buildfile %1 -propertyfile %WORKSPACE%\Release\buildinfo.properties