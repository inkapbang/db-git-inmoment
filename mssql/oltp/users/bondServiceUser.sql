IF SUSER_ID('bondServiceUser') IS NULL
				BEGIN CREATE LOGIN bondServiceUser WITH PASSWORD = 0x0100565834BF929CCED878B95205C7EFF5F17E4CBD380A758EF8 HASHED END
CREATE USER [bondServiceUser] FOR LOGIN [bondServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER bondServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'bondServiceUser'
GO
