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
    

Features
=============
7zip
- Extract the zip file
> JenkinsExtension/7z.bat
- Unzip the file to folder (UNC path support)
> JenkinsExtension/unziptopath.ps1

Apache Ant
- Start the apache ant based on the Jenkins build file and build properties
> JenkinsExtension/ant.bat

Microsoft SQL Server
- Drop the database
> JenkinsExtension/DropDb.bat

NUnit3  - All program or script for NUnit3
- Powershell script to execute Nunit3 console program for all the *.nunit Nunit configuration project file. The test result will generate out and the result file name same as the Nunit configuration project filename.
> JenkinsExtension/VSTest.bat for Visual Studio 2013 installed
> JenkinsExtension/VS2017Test.bat for Visual Studio 2017 installed

OpenCover
- Execute nunit test with open cover and html report generation

IIS Web Deploy and Control
- Rename the application name
> JenkinsExtension/WebDeploy/UpdateIISWebAppName.ps1
- Change the web deploy parameter
> JenkinsExtension/WebDeploy/ReplaceWebDeployParameter.ps1
- Remote start the IIS app pool
> JenkinsExtension/remoteStartAppPool.ps1
- Remote start the IIS app pool
> JenkinsExtension/remoteStopAppPool.ps1

Microsoft Windows Remote Control
- Start the Microsoft Windows Service
> JenkinsExtension/remoteStartWinService.ps1
- Stop the Microsoft Windows Service
> JenkinsExtension/remoteStopWinService.ps1
- Wait the process end in windows task
> JenkinsExtension/remoteWaitProcess.ps1

Microsoft XDT for Visual Studio 2013 and non web.config and app.config file
> JenkinsExtension/xdt

Powershell execute remote command
> JenkinsExtension/remotecommand.ps1

StyleCop
- Start the Style Cop to check the source code
> JenkinsExtension/StyleCopCLI.bat