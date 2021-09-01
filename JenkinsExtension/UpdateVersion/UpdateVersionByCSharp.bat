@ECHO off
Echo Start execute the c# code

Echo Get the dotnet v4 csc.exe path
FOR /F "tokens=* USEBACKQ" %%F IN (`dir %WINDIR%\Microsoft.NET\Framework64\csc.exe /s/b | findstr "v4"`) DO (
  SET cscPath=%%F
)

setlocal
cd /d %~dp0
set csDir=%cd%\UpdateVersionByCSharp.cs
powershell set-executionpolicy remotesigned; $source = Get-Content -Raw -Path %csDir%; Add-Type -TypeDefinition "$source"; [Program]::Main()