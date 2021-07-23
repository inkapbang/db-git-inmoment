SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.usp_cleanuprequest 
as
--exec dbo.usp_cleanuprequest 

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_srq]') AND type in (N'U'))
DROP TABLE [dbo].[_srq];

select objectid into _srq  from SurveyRequest with (nolock) where sendReminder=1 AND [state] <> 3;

alter table _srq add  Primary key (objectid);

declare @count int,@srobjectId	int

set @count=0

declare mycursor cursor for
select objectid from _srq
open mycursor
fetch next from mycursor into @srobjectId

while @@Fetch_Status=0
begin
print cast(@count as varchar)+', '+cast(@srObjectId as varchar)
Update SurveyRequest set sendReminder=0   where objectid =@srobjectid

set @count=@count+1
fetch next from mycursor into @srobjectId

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
