
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

if not exists(select s.schema_id from sys.schemas s where s.name = 'MSHAREX\sql2k8svcact') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'MSHAREX\sql2k8svcact') begin
	exec sp_executesql N'create schema [MSHAREX\sql2k8svcact] authorization [MSHAREX\sql2k8svcact]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'MSHAREX\drobinson') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'MSHAREX\drobinson') begin
	exec sp_executesql N'create schema [MSHAREX\drobinson] authorization [MSHAREX\drobinson]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'MSHAREX\btenney') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'MSHAREX\btenney') begin
	exec sp_executesql N'create schema [MSHAREX\btenney] authorization [MSHAREX\btenney]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'MSHAREX\shart') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'MSHAREX\shart') begin
	exec sp_executesql N'create schema [MSHAREX\shart] authorization [MSHAREX\shart]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'MSHAREX\tpeterson') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'MSHAREX\tpeterson') begin
	exec sp_executesql N'create schema [MSHAREX\tpeterson] authorization [MSHAREX\tpeterson]'
end

if not exists(select s.schema_id from sys.schemas s where s.name = 'databus') 
	and exists(select p.principal_id from sys.database_principals p where p.name = 'databus') begin
	exec sp_executesql N'create schema [databus] authorization [databus]'
end
GO

