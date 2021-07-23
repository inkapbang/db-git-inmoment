IF SUSER_ID('viewServiceUser') IS NULL
				BEGIN CREATE LOGIN viewServiceUser WITH PASSWORD = 0x0100B80A6DF9EC2EFD0EE2BFDCA3A43C98B35E58F39C5840F4C4 HASHED END
CREATE USER [viewServiceUser] FOR LOGIN [viewServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER viewServiceUser*/ exec sp_addrolemember 'db_datareader', 'viewServiceUser'
/*ALTER ROLE db_datawriter ADD MEMBER viewServiceUser*/ exec sp_addrolemember 'db_datawriter', 'viewServiceUser'
GO
