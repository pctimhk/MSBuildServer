@ECHO OFF
Set ApacheAntBinPath=D:\Programs\ApacheAnt\apache-ant-1.10.5\bin\ant.bat

ECHO execute ant for %1 build file
"%ApacheAntBinPath%" -buildfile %1 -propertyfile %WORKSPACE%\Release\buildinfo.properties
REM "%ApacheAntBinPath%" -buildfile %1 -DWORKSPACE=%WORKSPACE% -DBUILD_NUMBER=%BUILD_NUMBER% -DBUILD_ID=%BUILD_ID% -DBUILD_DISPLAY=%BUILD_DISPLAY% -DJOB_NAME=%JOB_NAME% -DJOB_BASE_NAME=%JOB_BASE_NAME% -DBUILD_TAG=%BUILD_TAG% -DEXECUTOR_NUMBER=%EXECUTOR_NUMBER% -DNODE_NAME=%NODE_NAME% -DNODE_LABELS=%NODE_LABELS% -DJENKINS_HOME=%JENKINS_HOME% -DJENKINS_URL=%JENKINS_URL% -DBUILD_URL=%BUILD_URL% -DJOB_URL=%JOB_URL%