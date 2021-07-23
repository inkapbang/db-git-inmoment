IF SUSER_ID('analyticsGraphUser') IS NULL
				BEGIN CREATE LOGIN analyticsGraphUser WITH PASSWORD = 0x01006E47E5D9B49998E3A06A3D473F8BC074D6798E7B0F59CA23 HASHED END
CREATE USER [analyticsGraphUser] FOR LOGIN [analyticsGraphUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER analyticsGraphUser*/ exec sp_addrolemember 'db_executor', 'analyticsGraphUser'
/*ALTER ROLE db_datareader ADD MEMBER analyticsGraphUser*/ exec sp_addrolemember 'db_datareader', 'analyticsGraphUser'
/*ALTER ROLE db_datawriter ADD MEMBER analyticsGraphUser*/ exec sp_addrolemember 'db_datawriter', 'analyticsGraphUser'
GO
