IF SUSER_ID('userDetailServiceUser') IS NULL
				BEGIN CREATE LOGIN userDetailServiceUser WITH PASSWORD = 0x01001C9CEDDE4B86B8E21D8F8D6D7BE8904DE10275B327DDEF3B HASHED END
CREATE USER [userDetailServiceUser] FOR LOGIN [userDetailServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER userDetailServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'userDetailServiceUser'
GO
