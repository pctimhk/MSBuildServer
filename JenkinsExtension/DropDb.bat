SET CURRENT_DBSERVER=%1
SET CURRENT_DBNAME=%2

sqlcmd -S devdnp01 -Q "USE [master];DECLARE @kill varchar(8000) = '';  SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), req_spid) + ';'  FROM master.dbo.syslockinfo WHERE rsc_type = 2 AND rsc_dbid  = db_id('SCS-DEV2'); EXEC(@kill);"
if %errorlevel% neq 0 exit /b %errorlevel%

sqlcmd -S %CURRENT_DBSERVER% -Q "EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'%CURRENT_DBNAME%'"
if %errorlevel% neq 0 exit /b %errorlevel%

sqlcmd -S %CURRENT_DBSERVER% -Q "ALTER DATABASE [%CURRENT_DBNAME%] SET OFFLINE; DROP DATABASE [%CURRENT_DBNAME%];"
if %errorlevel% neq 0 exit /b %errorlevel%