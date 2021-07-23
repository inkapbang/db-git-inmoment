SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.reviewOptInCursor
as

--exec dbo.reviewOptInCursor

/****** Object:  Table [dbo].[_bob77]    Script Date: 09/10/2012 08:25:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_bob77]') AND type in (N'U'))
DROP TABLE [dbo].[_bob77]


--get data
select top 10000000 objectid
into _bob77 
from surveyresponse with (nolock)
where reviewOptIn is null
order by objectId desc

--select 
--update data
declare @count int,@srobjectId	int--, @ocid int,@gateid int

set @count=0

declare mycursor cursor for
select objectid from _Bob77

open mycursor
fetch next from mycursor into @srobjectId--,@ocid,@gateid

while @@Fetch_Status=0
begin
print cast(@count as varchar)+', '+cast(@srObjectId as varchar)
--
update surveyresponse
set reviewoptin=0
where objectid=@srobjectid

set @count=@count+1
fetch next from mycursor into @srobjectId--,@ocid,@gateid

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
