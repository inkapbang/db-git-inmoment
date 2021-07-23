IF SUSER_ID('apiUser') IS NULL
				BEGIN CREATE LOGIN apiUser WITH PASSWORD = 0x01002BEC83146232BED0EB23D8A98965581D6828C09A2DD69108 HASHED END
CREATE USER [apiUser] FOR LOGIN [apiUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER apiUser*/ exec sp_addrolemember 'db_executor', 'apiUser'
/*ALTER ROLE db_datareader ADD MEMBER apiUser*/ exec sp_addrolemember 'db_datareader', 'apiUser'
/*ALTER ROLE db_datawriter ADD MEMBER apiUser*/ exec sp_addrolemember 'db_datawriter', 'apiUser'
GO
