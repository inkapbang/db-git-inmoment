IF SUSER_ID('responseServiceUser') IS NULL
				BEGIN CREATE LOGIN responseServiceUser WITH PASSWORD = 0x0100F90B7475948818BA5DABF32D3F734339721954E66291D5D3 HASHED END
CREATE USER [responseServiceUser] FOR LOGIN [responseServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER responseServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'responseServiceUser'
GO
