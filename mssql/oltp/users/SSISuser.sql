IF SUSER_ID('SSISuser') IS NULL
				BEGIN CREATE LOGIN SSISuser WITH PASSWORD = 0x0100C7A5C88BAE038CAA83FF976EF312D6F2849ACCE97D05EC50 HASHED END
CREATE USER [SSISuser] FOR LOGIN [SSISuser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER SSISuser*/ exec sp_addrolemember 'db_datareader', 'SSISuser'
/*ALTER ROLE db_datawriter ADD MEMBER SSISuser*/ exec sp_addrolemember 'db_datawriter', 'SSISuser'
GO
