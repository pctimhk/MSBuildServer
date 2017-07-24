# MSBuildServer for .NET 4.0.0 - 4.5.2

Extra script or customize program to create a Microsoft .NET 4.0.0 - 4.5.2 Build Server with Unit Test feature.

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
    

Folder
=============
NUnit3  - All program or script for NUnit3
- Powershell script to execute Nunit3 console program for all the *.nunit Nunit configuration project file. The test result will generate out and the result file name same as the Nunit configuration project filename.

OpenCover
- Execute nunit test with open cover and html report generation