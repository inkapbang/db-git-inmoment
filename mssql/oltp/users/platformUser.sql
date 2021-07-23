IF SUSER_ID('platformUser') IS NULL
				BEGIN CREATE LOGIN platformUser WITH PASSWORD = 0x01002C41D612E18D68F9774E0D6B9D1B15A42A74BBF85CECF704 HASHED END
CREATE USER [platformUser] FOR LOGIN [platformUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER platformUser*/ exec sp_addrolemember 'db_executor', 'platformUser'
/*ALTER ROLE db_datareader ADD MEMBER platformUser*/ exec sp_addrolemember 'db_datareader', 'platformUser'
/*ALTER ROLE db_datawriter ADD MEMBER platformUser*/ exec sp_addrolemember 'db_datawriter', 'platformUser'
GO
