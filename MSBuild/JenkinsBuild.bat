REM Build command to execute in windows batch command in Jenkins
"C:\Program Files (x86)\MSBuild\12.0\bin\amd64\MSBuild.exe" /verbosity:minimal /property:WarningLevel=0 /consoleloggerparameters:Summary /fl1 /flp1:logfile=MSBuild.log;verbosity=errorsonly /fl2 /flp2:logfile=MSBuildWarn.log;verbosity=warningsonly /fl3 /flp3:logfile=MSBuildDiag.log;verbosity=diagnostic  