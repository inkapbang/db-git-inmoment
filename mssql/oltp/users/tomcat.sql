CREATE USER [tomcat] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo]
/*ALTER ROLE db_owner ADD MEMBER tomcat*/ exec sp_addrolemember 'db_owner', 'tomcat'
GO
