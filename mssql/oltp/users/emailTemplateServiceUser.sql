IF SUSER_ID('emailTemplateServiceUser') IS NULL
				BEGIN CREATE LOGIN emailTemplateServiceUser WITH PASSWORD = 0x010082E09AD3CC961787872DAABD9AF5AB68DB76A77A6C522AF6 HASHED END
CREATE USER [emailTemplateServiceUser] FOR LOGIN [emailTemplateServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER emailTemplateServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'emailTemplateServiceUser'
GO
