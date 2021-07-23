IF SUSER_ID('datafieldServiceUser') IS NULL
				BEGIN CREATE LOGIN datafieldServiceUser WITH PASSWORD = 0x0100F9735990B714910963A5052FE71841F8A0575B84631CEAAD HASHED END
CREATE USER [datafieldServiceUser] FOR LOGIN [datafieldServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER datafieldServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'datafieldServiceUser'
GO
