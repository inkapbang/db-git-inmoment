IF SUSER_ID('filtersServiceUser') IS NULL
				BEGIN CREATE LOGIN filtersServiceUser WITH PASSWORD = 0x010036BDD2CF0395B6424E041B71413212478A097CB44A65B281 HASHED END
CREATE USER [filtersServiceUser] FOR LOGIN [filtersServiceUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_datareader ADD MEMBER filtersServiceUser*/ exec sp_addrolemember 'db_datareader', 'filtersServiceUser'
GO
