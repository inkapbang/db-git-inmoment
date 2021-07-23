SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view UnusedIndexes
as
	select objectname=object_name(s.object_id), s.object_id, indexname=i.name, i.index_id
				, user_seeks, user_scans, user_lookups, user_updates,
				(user_seeks + user_scans + user_lookups + user_updates) total_usage
	from sys.dm_db_index_usage_stats s,
				sys.indexes i
	where database_id = db_id() and objectproperty(s.object_id,'IsUserTable') = 1
	and i.object_id = s.object_id
	and i.index_id = s.index_id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
