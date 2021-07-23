IF SUSER_ID('radiantuser') IS NULL
				BEGIN CREATE LOGIN radiantuser WITH PASSWORD = 0x01006FF9F4F2348DB229ECC775D64A91A6EBBAD20C78F5900975 HASHED END
CREATE USER [radiantuser] FOR LOGIN [radiantuser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER radiantuser*/ exec sp_addrolemember 'db_datareader', 'radiantuser'
/*ALTER ROLE db_datawriter ADD MEMBER radiantuser*/ exec sp_addrolemember 'db_datawriter', 'radiantuser'
GO
