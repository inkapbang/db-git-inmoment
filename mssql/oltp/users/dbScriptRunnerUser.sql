IF SUSER_ID('dbScriptRunnerUser') IS NULL
				BEGIN CREATE LOGIN dbScriptRunnerUser WITH PASSWORD = 0x0100667BBD78AC9B04E9C4A23C0290365160AFD7792A34AD62FC HASHED END
CREATE USER [dbScriptRunnerUser] FOR LOGIN [dbScriptRunnerUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER dbScriptRunnerUser*/ exec sp_addrolemember 'db_executor', 'dbScriptRunnerUser'
/*ALTER ROLE db_ddladmin ADD MEMBER dbScriptRunnerUser*/ exec sp_addrolemember 'db_ddladmin', 'dbScriptRunnerUser'
/*ALTER ROLE db_datareader ADD MEMBER dbScriptRunnerUser*/ exec sp_addrolemember 'db_datareader', 'dbScriptRunnerUser'
/*ALTER ROLE db_datawriter ADD MEMBER dbScriptRunnerUser*/ exec sp_addrolemember 'db_datawriter', 'dbScriptRunnerUser'
GO
