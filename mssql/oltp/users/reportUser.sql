IF SUSER_ID('reportUser') IS NULL
				BEGIN CREATE LOGIN reportUser WITH PASSWORD = 0x01007553ED478915FD8573ABCADC4675EB3B44B5AA1DAE1C6CE6 HASHED END
CREATE USER [reportUser] FOR LOGIN [reportUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER reportUser*/ exec sp_addrolemember 'db_executor', 'reportUser'
/*ALTER ROLE db_datareader ADD MEMBER reportUser*/ exec sp_addrolemember 'db_datareader', 'reportUser'
/*ALTER ROLE db_datawriter ADD MEMBER reportUser*/ exec sp_addrolemember 'db_datawriter', 'reportUser'
GO
