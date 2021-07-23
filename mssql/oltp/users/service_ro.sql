IF SUSER_ID('service_ro') IS NULL
				BEGIN CREATE LOGIN service_ro WITH PASSWORD = 0x01001DC1ED6947D217FA57CCB416DF13472D6182BB6A86106B49 HASHED END
CREATE USER [service_ro] FOR LOGIN [service_ro] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER service_ro*/ exec sp_addrolemember 'db_datareader', 'service_ro'
GO
