IF SUSER_ID('migrationUser') IS NULL
				BEGIN CREATE LOGIN migrationUser WITH PASSWORD = 0x0100D61B0E8E1083981139533DBB7F52AD633A9FAFED4BE9CCA4 HASHED END
CREATE USER [migrationUser] FOR LOGIN [migrationUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER migrationUser*/ exec sp_addrolemember 'db_executor', 'migrationUser'
/*ALTER ROLE db_datareader ADD MEMBER migrationUser*/ exec sp_addrolemember 'db_datareader', 'migrationUser'
/*ALTER ROLE db_datawriter ADD MEMBER migrationUser*/ exec sp_addrolemember 'db_datawriter', 'migrationUser'
GO
