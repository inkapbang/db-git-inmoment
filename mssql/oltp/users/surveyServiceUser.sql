IF SUSER_ID('surveyServiceUser') IS NULL
				BEGIN CREATE LOGIN surveyServiceUser WITH PASSWORD = 0x0100AC8735E4B990F72DECA6F7231697396F770264EB37CC0011 HASHED END
CREATE USER [surveyServiceUser] FOR LOGIN [surveyServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER surveyServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'surveyServiceUser'
GO
