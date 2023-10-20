@ECHO OFF

SET ENV=UAT
SET UATBuildNumber=123456
SET DEVBuildNumber=654321
SET BUILD_URL=TESTTESTURL
SET BUILD_TAG=TESTTAG

SET WORKSPACE=D:\JenkinsAgent\workspace\IOS\CI-IOSTEST-DEV
Set BuildFile=global-updateversion-ApacheAnt.xml

SET ApacheAntBinPath=D:\JenkinsExtension\Customization\UpdateVersion\apache-ant-1.10.5\bin\ant.bat
SET AntExtBin=%~dp0ant.bat

xcopy /y /v /f %~dp0%BuildFile% %WORKSPACE%
ECHO "%AntExtBin%" %WORKSPACE%\%BuildFile%
call "%AntExtBin%" %WORKSPACE%\%BuildFile%