IF SUSER_ID('hierarchyServiceUser') IS NULL
				BEGIN CREATE LOGIN hierarchyServiceUser WITH PASSWORD = 0x01009E8EA1105D6C96BD53EA4A0E699EA62C1D519601EE0A1F9E HASHED END
CREATE USER [hierarchyServiceUser] FOR LOGIN [hierarchyServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER hierarchyServiceUser*/ exec sp_addrolemember 'db_datareader', 'hierarchyServiceUser'
/*ALTER ROLE db_datawriter ADD MEMBER hierarchyServiceUser*/ exec sp_addrolemember 'db_datawriter', 'hierarchyServiceUser'
GO
