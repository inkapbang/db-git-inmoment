IF SUSER_ID('oddjobServiceUser') IS NULL
				BEGIN CREATE LOGIN oddjobServiceUser WITH PASSWORD = 0x010018B14A96F65343F7E710BB68AC2AF6DDCD2B0039CAF691D9 HASHED END
CREATE USER [oddjobServiceUser] FOR LOGIN [oddjobServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER oddjobServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'oddjobServiceUser'
GO
