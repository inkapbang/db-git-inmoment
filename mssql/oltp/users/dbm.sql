CREATE USER [dbm] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER dbm*/ exec sp_addrolemember 'db_datareader', 'dbm'
GO
