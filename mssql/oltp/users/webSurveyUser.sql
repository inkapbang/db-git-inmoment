IF SUSER_ID('webSurveyUser') IS NULL
				BEGIN CREATE LOGIN webSurveyUser WITH PASSWORD = 0x01006CD81BFF35390F29452DC1881188508B9DB9F20D576D33B9 HASHED END
CREATE USER [webSurveyUser] FOR LOGIN [webSurveyUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER webSurveyUser*/ exec sp_addrolemember 'db_executor', 'webSurveyUser'
/*ALTER ROLE db_datareader ADD MEMBER webSurveyUser*/ exec sp_addrolemember 'db_datareader', 'webSurveyUser'
/*ALTER ROLE db_datawriter ADD MEMBER webSurveyUser*/ exec sp_addrolemember 'db_datawriter', 'webSurveyUser'
GO
