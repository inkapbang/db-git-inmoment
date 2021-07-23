IF SUSER_ID('organizationGraphUser') IS NULL
				BEGIN CREATE LOGIN organizationGraphUser WITH PASSWORD = 0x0100D74775D6AC8CA7500456F715DCF9CEE61218C8A8FBE04A00 HASHED END
CREATE USER [organizationGraphUser] FOR LOGIN [organizationGraphUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER organizationGraphUser*/ exec sp_addrolemember 'db_executor', 'organizationGraphUser'
/*ALTER ROLE db_datareader ADD MEMBER organizationGraphUser*/ exec sp_addrolemember 'db_datareader', 'organizationGraphUser'
/*ALTER ROLE db_datawriter ADD MEMBER organizationGraphUser*/ exec sp_addrolemember 'db_datawriter', 'organizationGraphUser'
GO
