REM NUnit test command to execute in windows batch command in Jenkins
powershell.exe -Command "& 'D:\Program Files (x86)\NUnit.org\nunit-console\RunAllNunitProject.ps1' '%WORKSPACE%\' '%WORKSPACE%\TestOutput\'"