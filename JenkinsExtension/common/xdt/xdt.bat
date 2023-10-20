ECHO The following command will be executed
ECHO dotnet run --no-build --project %~dp0FilePatternExecuteScript\FilePatternExecuteScript.csproj -- -d %1 -c "%~dp0dotnet-xdt.exe --source {1} --transform {0} --output {1}"
ECHO ----------------------------------
dotnet run --no-build --project %~dp0FilePatternExecuteScript\FilePatternExecuteScript.csproj -- -d %1 -c "%~dp0dotnet-xdt.exe --source {1} --transform {0} --output {1}"
ECHO ----------------------------------