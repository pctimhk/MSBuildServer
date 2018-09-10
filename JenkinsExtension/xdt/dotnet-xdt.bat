@ECHO OFF
Set RootDir=%~dp0
Set XdtBin=%RootDir%\dotnet-xdt.exe

ECHO transform %2 using %1 xdt file
"%XdtBin%" --source %2 --transform %1 --output %2