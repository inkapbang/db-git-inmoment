SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2016.09.23
-- Description:	Gather Index Statistics Per Index
-- =============================================
CREATE PROCEDURE [dbo].[usp_maint_index_gatherStatistics]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	-- Truncate Table
	TRUNCATE TABLE dbo.Maint_IndexStatistics

	-- Capture Index Statistics For All Tables Except SRA and SRSC


	DECLARE @TblId int, @TblName varchar(256),@NumRows bigint,@SchemaName varchar(10),@IndexName varchar(512),@IndexId int,@LOB_Flag int

	DECLARE INDEX_CUR CURSOR FOR


	select	TblRow.object_id as table_id,
			TblRow.name as table_name,
			TblRow.rows,
			IndexDetail.SchemaName,
			IndexDetail.IndexName,
			IndexDetail.index_id,
			IndexDetail.Contain_LOB
	FROM
			(
			SELECT TBL.object_id, TBL.name, SUM(PART.rows) AS rows
			FROM sys.tables TBL
			INNER JOIN sys.partitions PART ON TBL.object_id = PART.object_id
			INNER JOIN sys.indexes IDX ON PART.object_id = IDX.object_id
			AND PART.index_id = IDX.index_id
			WHERE  IDX.index_id < 2
					AND TBL.is_ms_shipped = 0
			GROUP BY TBL.object_id, TBL.name
			) TblRow
			INNER JOIN
			(
				select	SchemaName,ObjectName,IndexName,PartitionId,index_id,max(Contain_LOB) as Contain_LOB
				from
				(
				SELECT  SchemaName = OBJECT_SCHEMA_NAME(p.object_id)
						,ObjectName = OBJECT_NAME(p.object_id)
						,IndexName  = si.name
						,PartitionId = p.object_id
						,p.index_id
						,case au.type_desc WHEN 'LOB_DATA' then 1 else 0 end as Contain_LOB
				   FROM sys.system_internals_allocation_units au --Has allocation type
				   JOIN sys.system_internals_partitions p        --Has an Index_ID
					 ON au.container_id = p.partition_id
				   JOIN sys.indexes si                           --For the name of the index
					 ON si.object_id    = p.object_id
					AND si.index_id     = p.index_id
				  WHERE --p.object_id     = OBJECT_ID('IndexTest')
					--AND 
					--au.type_desc    = 'LOB_DATA'				
					--and 
					object_name(p.object_id) not like '[_]%'
					--order by OBJECT_NAME(p.object_id)
				)DetailTbl
				where index_id > 0
				group by SchemaName,ObjectName,IndexName,PartitionId,index_id
				)IndexDetail on TblRow.name = IndexDetail.ObjectName


	WHERE	TblRow.name not like  '[_]%'
			and TblRow.rows between 1 and 10000000000
	ORDER BY TblRow.rows,TblRow.name,IndexDetail.index_id

	OPEN INDEX_CUR
	FETCH NEXT FROM INDEX_CUR INTO @TblId, @TblName,@NumRows,@SchemaName,@IndexName,@IndexId,@LOB_Flag
	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO dbo.Maint_IndexStatistics(tableName,LOBPresent,numRows,indexName,indexId,avg_fragmentation_in_percent,completeFlag)
		--SELECT	@TblName as tableName,@LOB_Flag as LOB_Present,@NumRows as num_rows,
		--		@IndexName as IndexName,@IndexId as index_id,0,0
				
		SELECT	@TblName as tableName,@LOB_Flag as LOB_Present,@NumRows as num_rows,
				@IndexName as IndexName,@IndexId as index_id,max(IPS.avg_fragmentation_in_percent) as avg_fragmentation_in_percent,0
		FROM	sys.dm_db_index_physical_stats(DB_ID(),@TblId,@IndexId,NULL,'LIMITED') IPS

		FETCH NEXT FROM INDEX_CUR INTO @TblId, @TblName,@NumRows,@SchemaName,@IndexName,@IndexId,@LOB_Flag
	END

	CLOSE INDEX_CUR
	DEALLOCATE INDEX_CUR


	UPDATE dbo.Maint_IndexStatistics SET LOBPresent = 1 WHERE tableName in ('Organization','UnstructuredFeedbackModel')


	RETURN 0


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
