IF SUSER_ID('exploreUser') IS NULL
				BEGIN CREATE LOGIN exploreUser WITH PASSWORD = 0x0100D3DC85FE4C1E1738ABC5495519A75AEFC021286E0E2756B1 HASHED END
CREATE USER [exploreUser] FOR LOGIN [exploreUser] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_executor ADD MEMBER exploreUser*/ exec sp_addrolemember 'db_executor', 'exploreUser'
/*ALTER ROLE db_datareader ADD MEMBER exploreUser*/ exec sp_addrolemember 'db_datareader', 'exploreUser'
/*ALTER ROLE db_datawriter ADD MEMBER exploreUser*/ exec sp_addrolemember 'db_datawriter', 'exploreUser'
GO
