SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select * from [jonas].warehouse.dbo._res
--
--select objectid from emailqueue where objectid in 
--(
--select objectid 
--from [jonas].warehouse.dbo._res)
--
--select * from emailqueue where objectid in 
--(
--select objectid 
--from [jonas].warehouse.dbo._res)
--
--select * into _emailqueue from  emailqueue where creationdatetime <= '5/15/2008'

--select * 
--from emailqueue 
--where creationdatetime <=DATEADD(day, -60, CONVERT(VARCHAR(10), GETDATE(), 101))

----------------------------------------------------------------------------
CREATE procedure usp_admin_clearEmailQueue
as

IF  EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[_emailqueue]') 
	AND type in (N'U'))
drop table _emailqueue

select objectid,attachmentobjectid
into _emailqueue 
from emailqueue
where creationdatetime <=DATEADD(day, -45, CONVERT(VARCHAR(10), GETDATE(), 101))


declare @count int,@objectid int,@attachmentobjectid int


--delete objectid from emailqueue
declare mycursor cursor for 
select objectid 
from _emailqueue

set @count=0

open mycursor
fetch next from mycursor into @objectid
while @@fetch_status =0
begin

--print @attachmentobjectid
delete emailqueue with (rowlock)where objectid = @objectid
set @count=@count+1

fetch next from mycursor into @objectid
end--while
close mycursor
deallocate mycursor
select cast (@count as varchar) + ' emails deleted.'

set @count=0
--delete attachmentobjects from binarycontent
declare mycursor cursor for 
select  attachmentobjectid 
from _emailqueue 
where attachmentobjectid is not null 

open mycursor
fetch next from mycursor into @attachmentobjectid
while @@fetch_status =0
begin

--print @attachmentobjectid
delete binarycontent with (rowlock)where objectid = @attachmentobjectid
set @count=@count+1

fetch next from mycursor into @attachmentobjectid
end--while
close mycursor
deallocate mycursor
select cast (@count as varchar) + ' Attachments deleted.'

IF  EXISTS (SELECT * FROM sys.objects 
	WHERE object_id = OBJECT_ID(N'[dbo].[_emailqueue]') 
	AND type in (N'U'))
drop table _emailqueue

--exec dbo.usp_admin_clearEmailQueue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
