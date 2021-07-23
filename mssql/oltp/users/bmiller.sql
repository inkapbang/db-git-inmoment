IF SUSER_ID('bmiller') IS NULL
				BEGIN CREATE LOGIN bmiller WITH PASSWORD = 0x0100F16DF59D124AEC86C6C7FFC76B5CFF87D7A0BCF99CA8A49B HASHED END
CREATE USER [bmiller] FOR LOGIN [bmiller] WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER bmiller*/ exec sp_addrolemember 'db_owner', 'bmiller'
/*ALTER ROLE db_datareader ADD MEMBER bmiller*/ exec sp_addrolemember 'db_datareader', 'bmiller'
/*ALTER ROLE db_datawriter ADD MEMBER bmiller*/ exec sp_addrolemember 'db_datawriter', 'bmiller'
GO
