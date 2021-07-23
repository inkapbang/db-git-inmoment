SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		In-Kap Bang
-- Create date: 2015.10.29
-- Description:	Collect Index Statistics
-- =============================================
CREATE PROCEDURE [dbo].[usp_maint_Reindex_CollectStats]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--truncate table _IndexRebuildStats


	declare @TName varchar(200),@IName varchar(200),@INumber int,@isPartitioned char(1),@onlineFlag int
	declare tt_cur cursor for
	select tableName,indexName,indexNumber,isPartitioned,onlineFlag from _IndexRebuildList with (nolock) order by tableName,indexName,indexNumber
	open tt_cur
	fetch next from tt_cur into @TName,@IName,@INumber,@isPartitioned,@onlineFlag
	while @@fetch_status = 0
	begin
		insert into _IndexRebuildStats
		select  CONVERT(VARCHAR(8), SYSDATETIME(), 112) as DT,@TName as tableName,@IName as indexName,@isPartitioned as isPartitioned,@onlineFlag as onlineFlag,* from sys.dm_db_index_physical_stats(DB_ID(),OBJECT_ID(@TName),@INumber,NULL,'LIMITED') --where avg_fragmentation_in_percent >= 10.0

		fetch next from tt_cur into @TName,@IName,@INumber,@isPartitioned,@onlineFlag

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
