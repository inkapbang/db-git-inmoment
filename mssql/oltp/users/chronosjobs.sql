IF SUSER_ID('chronosjobs') IS NULL
				BEGIN CREATE LOGIN chronosjobs WITH PASSWORD = 0x0100D6BBFB4A384DEA057121A13C96BEDCD193C6EE5A6DE7789B HASHED END
CREATE USER [chronosjobs] FOR LOGIN [chronosjobs] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER chronosjobs*/ exec sp_addrolemember 'db_owner', 'chronosjobs'
GO
