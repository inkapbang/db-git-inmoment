IF SUSER_ID('yelpReviewConsumerUser') IS NULL
				BEGIN CREATE LOGIN yelpReviewConsumerUser WITH PASSWORD = 0x01001DBBBFE42056E1EBDB84FEECB388663B661A4AAFAD21D28F HASHED END
CREATE USER [yelpReviewConsumerUser] FOR LOGIN [yelpReviewConsumerUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE oltp_readonly ADD MEMBER yelpReviewConsumerUser*/ exec sp_addrolemember 'oltp_readonly', 'yelpReviewConsumerUser'
/*ALTER ROLE db_datawriter ADD MEMBER yelpReviewConsumerUser*/ exec sp_addrolemember 'db_datawriter', 'yelpReviewConsumerUser'
GO
