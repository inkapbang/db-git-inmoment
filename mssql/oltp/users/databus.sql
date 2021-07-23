IF SUSER_ID('databus') IS NULL
				BEGIN CREATE LOGIN databus WITH PASSWORD = 0x0100A75308FDEF1DBFED697BEEDC56948CD6770A33B61ABB80D1 HASHED END
CREATE USER [databus] FOR LOGIN [databus] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER databus*/ exec sp_addrolemember 'db_datareader', 'databus'
/*ALTER ROLE db_datawriter ADD MEMBER databus*/ exec sp_addrolemember 'db_datawriter', 'databus'
GO
