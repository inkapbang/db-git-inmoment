SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_maint_DeleteDqBc]
@begindt datetime,@enddt datetime
as

/*

--Bob Luther 7/29/2010
*/

--exec [dbo].[usp_maint_DeleteDqBc] '12/1/2009','12/3/2009'

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_dqbcobjectidstodelete]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[_dqbcobjectidstodelete](
		[Delveryqueueobjectid] [int],
		[binarycontentobjectid] [int]
)
end--if

truncate table _dqbcobjectidstodelete
--print @begindt

while @begindt < @enddt
	begin

		truncate table _dqbcobjectidstodelete

		insert into [_dqbcobjectidstodelete]
		select dq.objectid,bc.objectid
	    from deliveryqueue dq  with (nolock)
        left join binarycontent bc with (nolock)
        on bc.objectid = dq.fileobjectid
        where dq.creationdatetime >= @begindt 
        and dq.creationdatetime < dateadd(dd,1,@begindt)
		
		--IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_bob]') AND type in (N'U'))
		select * 
		----into _bob 
		from _dqbcobjectidstodelete 

		declare @count int,@dqid int,@bcid int

		set @count=0

		declare mycursor cursor for
		select * from _dqbcobjectidstodelete

		open mycursor
		fetch next from mycursor into
		@dqid,@bcid

		while @@Fetch_Status=0
		begin
		
		delete from deliveryqueue with (rowlock) where objectid =@dqid
		if  @bcid is not null
		begin
		    update binarycontent set content=NULL where objectid =@BcId
			--delete from binarycontent with (rowlock) where objectid =@BcId
		end

		    
		print cast(@count as varchar)+', '+cast(@DqId as varchar)+', '+cast(@bcId as varchar)

		set @count=@count+1
		fetch next from mycursor into 
		@Dqid,@bcid

		end--while
		close mycursor
		deallocate mycursor
		Print Cast(@count as varchar) +' Records Processed'

		set @begindt=dateadd(dd,1,@begindt)
		print @begindt


	end--while


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_dqbcobjectidstodelete]') AND type in (N'U'))
DROP TABLE [dbo].[_dqbcobjectidstodelete]

--select * from deliveryqueue dq left join binarycontent bc on dq.fileobjectid=bc.objectid where dq.objectid=23886
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
