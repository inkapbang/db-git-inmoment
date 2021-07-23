IF SUSER_ID('feedbackChannelServiceUser') IS NULL
				BEGIN CREATE LOGIN feedbackChannelServiceUser WITH PASSWORD = 0x0100AC4AD733CC9A36DF297B2071514CAC31F0BF64149D554591 HASHED END
CREATE USER [feedbackChannelServiceUser] FOR LOGIN [feedbackChannelServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER feedbackChannelServiceUser*/ exec sp_addrolemember 'oltp_readonly', 'feedbackChannelServiceUser'
GO
