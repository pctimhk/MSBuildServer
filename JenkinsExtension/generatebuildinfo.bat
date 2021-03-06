@ECHO OFF
SET BUILDINFO_PATH=%WORKSPACE%\Release\buildinfo.properties

MD %WORKSPACE%\Release
ECHO Generate %BUILDINFO_PATH% file
ECHO ENV=%ENV%> %BUILDINFO_PATH%
ECHO BUILD_NUMBER=^%BUILD_NUMBER%>> %BUILDINFO_PATH%
ECHO BUILD_ID=^%BUILD_ID%>> %BUILDINFO_PATH%
ECHO BUILD_DISPLAY_NAME=%BUILD_DISPLAY_NAME%>> %BUILDINFO_PATH%
ECHO JOB_NAME=%JOB_NAME%>> %BUILDINFO_PATH%
ECHO JOB_BASE_NAME=%JOB_BASE_NAME%>> %BUILDINFO_PATH%
ECHO BUILD_TAG=%BUILD_TAG%>> %BUILDINFO_PATH%
ECHO EXECUTOR_NUMBER=^%EXECUTOR_NUMBER%>> %BUILDINFO_PATH%
ECHO NODE_NAME=%NODE_NAME%>> %BUILDINFO_PATH%
ECHO NODE_LABELS=%NODE_LABELS%>> %BUILDINFO_PATH%
ECHO WORKSPACE=%WORKSPACE%>> %BUILDINFO_PATH%
ECHO JENKINS_HOME=%JENKINS_HOME%>> %BUILDINFO_PATH%
ECHO JENKINS_URL=%JENKINS_URL%>> %BUILDINFO_PATH%
ECHO BUILD_URL=%BUILD_URL%>> %BUILDINFO_PATH%
ECHO JOB_URL=%JOB_URL%>> %BUILDINFO_PATH%
ECHO GIT_COMMIT=%GIT_COMMIT%>> %BUILDINFO_PATH%
ECHO GIT_PREVIOUS_COMMIT=%GIT_PREVIOUS_COMMIT%>> %BUILDINFO_PATH%
ECHO GIT_PREVIOUS_SUCCESSFUL_COMMIT=%GIT_PREVIOUS_SUCCESSFUL_COMMIT%>> %BUILDINFO_PATH%
ECHO GIT_BRANCH=%GIT_BRANCH%>> %BUILDINFO_PATH%
ECHO GIT_LOCAL_BRANCH=%GIT_LOCAL_BRANCH%>> %BUILDINFO_PATH%
ECHO GIT_URL=%GIT_URL%>> %BUILDINFO_PATH%
ECHO GIT_COMMITTER_NAME=%GIT_COMMITTER_NAME%>> %BUILDINFO_PATH%
ECHO GIT_AUTHOR_NAME=%GIT_AUTHOR_NAME%>> %BUILDINFO_PATH%
ECHO GIT_COMMITTER_EMAIL=%GIT_COMMITTER_EMAIL%>> %BUILDINFO_PATH%
ECHO GIT_AUTHOR_EMAIL=%GIT_AUTHOR_EMAIL%>> %BUILDINFO_PATH%
ECHO GIT_TAG_NAME=%GIT_TAG_NAME%>> %BUILDINFO_PATH%
ECHO GIT_TAG_MESSAGE=%GIT_TAG_MESSAGE%>> %BUILDINFO_PATH%