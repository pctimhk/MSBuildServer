@ECHO OFF

ECHO ==============================================
ECHO Reset Git Repo
git reset --hard 

call %~dp0\SETENV.bat

ECHO Execute the global prebuild steps

ECHO DRY checking (duplicated code checking)
call "D:\Programs\pmd_6.7.0\bin\cpd.bat" --ignore-usings --exclude "**/Migrations" --exclude "**/Initializer --exclude "**/*Test.cs --exclude "**/*.Designer.cs" --minimum-tokens 100 --files %cd% --language cs --format xml > %cd%\cpd.xml
SET ERRORLEVEL=0

ECHO generate buildinfo.properties
call "%~dp0%generatebuildinfo.bat

REM this will handle in CI pipeline script
REM ECHO Execute the update version steps
REM call "%~dp0%UpdateVersion\UpdateVersion.bat"

ECHO Execute XDT (XML Documentation Transformation) for different environment
ECHO Execute the command 'call "%~dp0xdt\xdt.bat" "%CD%"'
ECHO CurrentBuildEnvironment = %CurrentBuildEnvironment%
call "%~dp0xdt\xdt.bat" "%CD%" ".%CurrentBuildEnvironment%.xdt.xml"

ECHO Check prebuild script exists or not in %PreBuildScriptPath%
if exist %PreBuildScriptPath% (
   ECHO Prebuild script exists and the script will be executed.
   call "%AntExtBin%" "%PreBuildScriptPath%"
)

ECHO Completed global prebuild steps
ECHO ==============================================