IF SUSER_ID('dbusUser') IS NULL
				BEGIN CREATE LOGIN dbusUser WITH PASSWORD = 0x01004EB5D627FC213243A7186380A529B74D2442D5B8539A7FAB HASHED END
CREATE USER [dbusUser] FOR LOGIN [dbusUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER dbusUser*/ exec sp_addrolemember 'db_owner', 'dbusUser'
/*ALTER ROLE db_datareader ADD MEMBER dbusUser*/ exec sp_addrolemember 'db_datareader', 'dbusUser'
/*ALTER ROLE db_datawriter ADD MEMBER dbusUser*/ exec sp_addrolemember 'db_datawriter', 'dbusUser'
GO
