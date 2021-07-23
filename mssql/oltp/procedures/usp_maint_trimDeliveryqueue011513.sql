SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--select top 5 * from deliveryqueue
--
--select count(*)
--select * 
--from deliveryqueue
--where creationdatetime < dateadd(dd,-86,getdate())
--and reportscheduleobjectid is  not null
--
--
--declare @dt datetime
--set @dt= dateadd(dd,-86,getdate())
--
--select objectid,contenttype
----select distinct contenttype
--from binarycontent
--where objectid in (
--select fileobjectid 
--from deliveryqueue
--where creationdatetime < @dt
--and reportscheduleobjectid is  not null
--)
--and contenttype='text/csv'
-----------------
CREATE procedure [dbo].[usp_maint_trimDeliveryqueue011513]
as 

/*
This procedure removes entries pdf and .csv files from binarycontent in the deliveryqueue table

Bob Luther 10/26/10
exec dbo.usp_maint_trimDeliveryqueue011513
*/



declare @dt datetime,@daystokeep int
set @daystokeep=161

While @daystokeep >140
begin

set @dt= dateadd(dd,-@daystokeep,getdate());--days to keep
--select @dt



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_trimdeliveryqueue]') AND type in (N'U'))
DROP TABLE [dbo].[_trimdeliveryqueue];

create table _trimdeliveryqueue (dqid int,dfid int);

insert into _trimdeliveryqueue
select objectid,fileobjectid
from deliveryqueue
where creationdatetime < @dt;

--select * from _trimdeliveryqueue where bcid is not null
--select * from deliveryfile where objectid=54517453
------------------------------
--top of loop

declare @count int,@dqid int,@dfid int;
set @count=0;

declare mycursor cursor for
select dqid,dfid from _trimdeliveryqueue

open mycursor
fetch next from mycursor into @dqid,@dfid

while @@Fetch_Status=0
begin

--select @dqid,@bcid

delete from deliveryqueue where objectid=@dqid
if @dfid is not null
	--update DeliveryFile with (rowlock) set content = null where objectid=@dfid
	delete from DeliveryFile with (rowlock) where objectid=@dfid
print cast(@count as varchar)+', '+cast(@dqid as varchar)+', '+isnull(cast(@dfid as varchar),'null')

set @count=@count+1
fetch next from mycursor into @dqid,@dfid

end--while
close mycursor
deallocate mycursor
Print Cast(@count as varchar) +' Records Processed'

set @daystokeep=@daystokeep-1
end--while

--select 
----------
----top of loop
--
--declare @count int,@dqid2 int,@bcid2 int
--set @count=0
--
--declare mycursor2 cursor for
--select dqid,bcid from _trimdeliveryqueue where bcid is not null
--
--open mycursor2
--fetch next from mycursor2 into @dqid2,@bcid2
--
--while @@Fetch_Status=0
--begin
--
----select @dqid,@bcid
--
--delete from binarycontent with (rowlock) where objectid=@bcid2
--
--print cast(@count as varchar)+', '+isnull(cast(@bcid2 as varchar),'null')
--
--set @count=@count+1
--fetch next from mycursor2 into @dqid2,@bcid2
--
--end--while
--close mycursor2
--deallocate mycursor2
--Print Cast(@count as varchar) +' Records Processed'
--
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
