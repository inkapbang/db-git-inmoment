CREATE TABLE [dbo].[Maint_IndexRebuildStats] (
   [tableName] [varchar](200) NULL,
   [indexName] [varchar](200) NULL,
   [isPartitioned] [char](1) NULL,
   [onlineFlag] [int] NULL,
   [database_id] [smallint] NULL,
   [object_id] [int] NULL,
   [index_id] [int] NULL,
   [partition_number] [int] NULL,
   [index_type_desc] [nvarchar](60) NULL,
   [alloc_unit_type_desc] [nvarchar](60) NULL,
   [index_depth] [tinyint] NULL,
   [index_level] [tinyint] NULL,
   [avg_fragmentation_in_percent] [float] NULL,
   [fragment_count] [bigint] NULL,
   [avg_fragment_size_in_pages] [float] NULL,
   [page_count] [bigint] NULL,
   [avg_page_space_used_in_percent] [float] NULL,
   [record_count] [bigint] NULL,
   [ghost_record_count] [bigint] NULL,
   [version_ghost_record_count] [bigint] NULL,
   [min_record_size_in_bytes] [int] NULL,
   [max_record_size_in_bytes] [int] NULL,
   [avg_record_size_in_bytes] [float] NULL,
   [forwarded_record_count] [bigint] NULL,
   [compressed_page_count] [bigint] NULL
)


GO
