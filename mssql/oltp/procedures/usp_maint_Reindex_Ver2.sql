SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2015.10.29
-- Description:	Collect Index Statistics
-- =============================================
CREATE PROCEDURE [dbo].[usp_maint_Reindex_Ver2]
@PageCount_Threshold int,
@Frag_Lower int,
@Frag_Upper int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @DT varchar(10)
	set @DT = convert(varchar(8),SYSDATETIME(),112)


	declare @cmd varchar(2000)
	declare tt_cur cursor for
	select case when isPartitioned = 'Y' THEN 'ALTER INDEX '+indexName+' ON '+tableName+' REORGANIZE PARTITION='+convert(varchar(10),partition_number)
				when onlineFlag = 0 THEN 'ALTER INDEX '+indexName+' ON '+tableName+' REORGANIZE '
				when page_count > @PageCount_Threshold and isPartitioned = 'N' THEN 'ALTER INDEX '+indexName+' ON '+tableName+' REORGANIZE'
				when page_count <= @PageCount_Threshold and isPartitioned = 'N' and avg_fragmentation_in_percent < @Frag_Upper THEN 'ALTER INDEX '+indexName+' ON '+tableName+' REORGANIZE'
				when page_count <= @PageCount_Threshold and isPartitioned = 'N' and avg_fragmentation_in_percent >= @Frag_Upper THEN  'ALTER INDEX '+indexName+' ON '+tableName+' REBUILD WITH (SORT_IN_TEMPDB=ON,ONLINE=ON,MAXDOP=10)'
				ELSE NULL end as stmt
	from _IndexRebuildStats with (nolock) where DT = @DT and avg_fragmentation_in_percent >= @Frag_Lower
	order by page_count asc
	open tt_cur
	fetch next from tt_cur into @cmd
	while @@fetch_status = 0
	begin
		
		insert into _IndexRebuildLog values (@DT,@cmd,getdate(),NULL)
		exec(@cmd)

		update _IndexRebuildLog set endTime = getdate() where DT = @DT and cmd = @cmd


		fetch next from tt_cur into @cmd
	end

	close tt_cur
	deallocate tt_cur



END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
