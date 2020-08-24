# MSBuildServer for .NET 4.0.0 - 4.5.2

Extra script or customize program to create a Microsoft .NET 4.0.0 - 4.5.2 Build Server with Unit Test feature in Windows Jenkins Build Server.

Prerequisite
=============
- Gitblit 1.8.0
- Jenkins
- Git Extension 2.50.01
- Microsoft Build Tools 2013
- NUnit Console 3.6.1
- SQL Express 2012
- Windows SDK 7 SDK
- Windows SDK 8.1
- Microsoft WebDeploy 3.6
- Open Cover 4.6.519
    https://github.com/OpenCover/opencover/releases
- Open Cover Report Generator 2.5.10
    https://github.com/danielpalme/ReportGenerator/releases
- OpenCoverToCoberturaConverter 2.0.4
    https://github.com/danielpalme/OpenCoverToCoberturaConverter
    

Feature
=============
NUnit3  - All program or script for NUnit3
- Powershell script to execute Nunit3 console program for all the *.nunit Nunit configuration project file. The test result will generate out and the result file name same as the Nunit configuration project filename.
> VSTest.bat for Visual Studio 2013 installed
> VS2017Test.bat for Visual Studio 2017 installed

OpenCover
- Execute nunit test with open cover and html report generation

IIS Web Deploy and Control
- Rename the application name
> WebDeploy/UpdateIISWebAppName.ps1
- Change the web deploy parameter
> WebDeploy/ReplaceWebDeployParameter.ps1
- Start the IIS app pool
> remoteStartAppPool.ps1

Powershell execute remote command
> remotecommand.ps1

