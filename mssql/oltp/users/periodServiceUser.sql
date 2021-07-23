IF SUSER_ID('periodServiceUser') IS NULL
				BEGIN CREATE LOGIN periodServiceUser WITH PASSWORD = 0x01007808AFF69DD422F2953C4D83D1413B2A9A9F64AC3AC59885 HASHED END
CREATE USER [periodServiceUser] FOR LOGIN [periodServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER periodServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'periodServiceUser'
GO
