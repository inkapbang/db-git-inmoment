SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc deletefromEmailQueue
as
DECLARE @DaysToKeep DATETIME,@count int,@queuesize int,@attachmentqueuesize int,@attachmentobjectid int,@objectid int
set @count=0
SET @DaysToKeep = DATEADD(day, -45, CONVERT(VARCHAR(10), GETDATE(), 101))--days to keep in email queue
--select @daystokeep

declare @res table(objectid int,attachmentobjectid int)
insert into @res
select objectid,attachmentobjectid from emailqueue where creationdatetime <= @daystokeep

--select count(attachmentobjectid) from @res where attachmentobjectid is not null
--select attachmentobjectid from @res where attachmentobjectid is not null
--
select @queuesize=(select count(*) from @res) 
select @queuesize

select @attachmentqueuesize=(select count(attachmentobjectid) from @res where attachmentobjectid is not null)
select @attachmentqueuesize

--delete
delete from emailqueue where objectid in (
select top 50000 objectid from @res order by objectid
)

--delete attachmentobjects from binarycontent
declare mycursor cursor for 
select top 10000 attachmentobjectid 
from @res 
where attachmentobjectid is not null 
order by attachmentobjectid

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
print cast (@count as varchar) + ' Attachments deleted.'



--exec dbo.deletefromEmailQueue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
