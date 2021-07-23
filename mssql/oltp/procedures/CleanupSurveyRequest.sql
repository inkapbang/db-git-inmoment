SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[CleanupSurveyRequest] as
begin

--set transaction isolation level snapshot

--exec [dbo].[CleanupSurveyRequest]

	declare @sr table(srid int)
	insert into @sr 
	select objectid from surveyrequest with (nolock) 
	where purgeTime < GetDate()
	--select * from @sr

declare @count int,@srobjectId	int

set @count=0

declare mycursor cursor for
	select * from @sr

open mycursor
fetch next from mycursor into @srobjectId

while @@Fetch_Status=0
begin
print cast(@count as varchar)+', '+cast(@srObjectId as varchar)
delete from SurveyRequest with (rowlock) where objectid = @srObjectId

set @count=@count+1
fetch next from mycursor into @srobjectId

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'

--	delete from SurveyRequest  with (rowlock) where purgeTime < GetDate()
---
	declare @sr2 table(srid int)
	insert into @sr2 
	select objectid from surveyrequest with (nolock) 
	where (not state = 3) and expirationTime < GETDATE()

--select * from @sr2
declare @count2 int,@srobjectId2	int

set @count2=0

declare mycursor2 cursor for
	select * from @sr2

open mycursor2
fetch next from mycursor2 into @srobjectId2

while @@Fetch_Status=0
begin
print cast(@count2 as varchar)+', '+cast(@srObjectId as varchar)
update SurveyRequest with (rowlock) 
set state = 3, failurereason = 7, failuremessage = 'Request automatically expired.', version = version + 1 
where objectid = @srObjectId2

set @count2=@count2+1
fetch next from mycursor2 into @srobjectId2

end--while
close mycursor2
deallocate mycursor2
Print Cast(@count2 as varchar) +' Records Processed'

--	update SurveyRequest with (rowlock) set state = 3, failurereason = 7, failuremessage = 'Request automatically expired.', version = version + 1 where (not state = 3) and expirationTime < GETDATE()
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
