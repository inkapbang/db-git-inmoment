
if not exists(select s.schema_id from sys.schemas s where s.name = 'etl') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'dbo') begin
	exec sp_executesql N'create schema [etl] authorization [dbo]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'Monitor') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'dbo') begin
	exec sp_executesql N'create schema [Monitor] authorization [dbo]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'Maintenance') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'dbo') begin
	exec sp_executesql N'create schema [Maintenance] authorization [dbo]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'emp') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'dbo') begin
	exec sp_executesql N'create schema [emp] authorization [dbo]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'rli_con') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'dbo') begin
	exec sp_executesql N'create schema [rli_con] authorization [dbo]'
end


if not exists(select s.schema_id from sys.schemas s where s.name = 'databus') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'databus') begin
	exec sp_executesql N'create schema [databus] authorization [databus]'
end
GO

