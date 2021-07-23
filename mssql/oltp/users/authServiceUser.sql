IF SUSER_ID('authServiceUser') IS NULL
				BEGIN CREATE LOGIN authServiceUser WITH PASSWORD = 0x01005C5D0406551E68EAAF1279F4F03148CAFFE5111A0373F09E HASHED END
CREATE USER [authServiceUser] FOR LOGIN [authServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER authServiceUser*/ exec sp_addrolemember 'db_datareader', 'authServiceUser'
/*ALTER ROLE db_datawriter ADD MEMBER authServiceUser*/ exec sp_addrolemember 'db_datawriter', 'authServiceUser'
GO
