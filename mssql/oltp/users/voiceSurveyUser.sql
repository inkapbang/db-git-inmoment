IF SUSER_ID('voiceSurveyUser') IS NULL
				BEGIN CREATE LOGIN voiceSurveyUser WITH PASSWORD = 0x0100D50B54604CEE5D6C6B43CD6F78F8171E97F19F58E16009C2 HASHED END
CREATE USER [voiceSurveyUser] FOR LOGIN [voiceSurveyUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER voiceSurveyUser*/ exec sp_addrolemember 'db_executor', 'voiceSurveyUser'
/*ALTER ROLE db_datareader ADD MEMBER voiceSurveyUser*/ exec sp_addrolemember 'db_datareader', 'voiceSurveyUser'
/*ALTER ROLE db_datawriter ADD MEMBER voiceSurveyUser*/ exec sp_addrolemember 'db_datawriter', 'voiceSurveyUser'
GO
