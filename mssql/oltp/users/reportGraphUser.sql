IF SUSER_ID('reportGraphUser') IS NULL
				BEGIN CREATE LOGIN reportGraphUser WITH PASSWORD = 0x0100F8D0520A96670A23669EFD65EA73953B686DD2CADA913E01 HASHED END
CREATE USER [reportGraphUser] FOR LOGIN [reportGraphUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER reportGraphUser*/ exec sp_addrolemember 'db_executor', 'reportGraphUser'
/*ALTER ROLE db_datareader ADD MEMBER reportGraphUser*/ exec sp_addrolemember 'db_datareader', 'reportGraphUser'
/*ALTER ROLE db_datawriter ADD MEMBER reportGraphUser*/ exec sp_addrolemember 'db_datawriter', 'reportGraphUser'
GO
