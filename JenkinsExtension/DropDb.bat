SET CURRENT_DBSERVER=%1
SET CURRENT_DBNAME=%2
SET DBSERVER_PATH=%3

sqlcmd -b -S devdnp01 -Q "USE [master];DECLARE @kill varchar(8000) = '';  SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), req_spid) + ';'  FROM master.dbo.syslockinfo WHERE rsc_type = 2 AND rsc_dbid  = db_id('SCS-DEV2'); EXEC(@kill);"
if %errorlevel% neq 0 exit /b %errorlevel%

sqlcmd -b -S %CURRENT_DBSERVER% -Q "EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'%CURRENT_DBNAME%'"
if %errorlevel% neq 0 exit /b %errorlevel%

sqlcmd -b -S %CURRENT_DBSERVER% -Q "ALTER DATABASE [%CURRENT_DBNAME%] SET OFFLINE;"
if %errorlevel% neq 0 exit /b %errorlevel%

sqlcmd -b -S %CURRENT_DBSERVER% -Q "DROP DATABASE [%CURRENT_DBNAME%];"
if %errorlevel% neq 0 exit /b %errorlevel%

IF NOT %DBSERVER_PATH%=="" powershell.exe -Command "%~dp0\remotecommand.ps1 -RemoteHost %CURRENT_DBSERVER% -Script 'DEL %DBSERVER_PATH%\%CURRENT_DBNAME%.mdf'"
if %errorlevel% neq 0 exit /b %errorlevel%

IF NOT %DBSERVER_PATH%=="" powershell.exe -Command "%~dp0\remotecommand.ps1 -RemoteHost %CURRENT_DBSERVER% -Script 'DEL %DBSERVER_PATH%\%CURRENT_DBNAME%_log.ldf'"
if %errorlevel% neq 0 exit /b %errorlevel%