SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_RemoveDeletedRequests] as
begin

	declare @sr table(srid int, uuid varchar(100))
	insert into @sr 
	select min(objectId),uuid from SurveyRequest with (nolock) group by uuid having count(*) >1
	
	declare @count int,@srobjectId	int
	declare @uuidA varchar(100)

	set @count=0

	declare mycursor cursor for
	select * from @sr
	
	open mycursor
	fetch next from mycursor into @srobjectId, @uuidA

	while @@Fetch_Status=0
	begin
	print cast(@count as varchar)+', '+cast(@srObjectId as varchar) + ', '+@uuidA
	--DELETE from SurveyRequest where uuid=@uuidA and objectId<>@srobjectId

	set @count=@count+1
	fetch next from mycursor into @srobjectId, @uuidA

	end--while
	close mycursor
	deallocate mycursor
	Print Cast(@count as varchar) +' Records Processed'

end
--7
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
