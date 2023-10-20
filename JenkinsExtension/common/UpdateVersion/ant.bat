@ECHO OFF

ECHO execute ant for %1 build file
"%ApacheAntBinPath%" -buildfile %1 -propertyfile %WORKSPACE%\Release\buildinfo.properties