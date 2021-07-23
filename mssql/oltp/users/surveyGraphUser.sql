IF SUSER_ID('surveyGraphUser') IS NULL
				BEGIN CREATE LOGIN surveyGraphUser WITH PASSWORD = 0x01001EED2F8D3E8BC3F746752A1EADB557BB6D477A893BE9108A HASHED END
CREATE USER [surveyGraphUser] FOR LOGIN [surveyGraphUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER surveyGraphUser*/ exec sp_addrolemember 'db_executor', 'surveyGraphUser'
/*ALTER ROLE db_datareader ADD MEMBER surveyGraphUser*/ exec sp_addrolemember 'db_datareader', 'surveyGraphUser'
/*ALTER ROLE db_datawriter ADD MEMBER surveyGraphUser*/ exec sp_addrolemember 'db_datawriter', 'surveyGraphUser'
GO
