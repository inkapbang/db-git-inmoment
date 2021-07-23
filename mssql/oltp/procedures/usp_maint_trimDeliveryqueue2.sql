SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_maint_trimDeliveryqueue2]
as 

/*
This procedure removes entries pdf and .csv files from binarycontent in the deliveryqueue table

Bob Luther 02/20/13
exec dbo.usp_maint_trimDeliveryqueue2
*/
--select top 50 * from DeliveryQueue order by objectId --desc

--select DATEDIFF(dd,'08/27/2012', CAST(getdate() as DATE))

--select CAST(getdate() as DATE)


---
declare @begindate date=(select dateadd(dd,-120,CAST(getdate() as DATE)))
declare @currentdate date=@begindate
declare @enddt date=(select dateadd(dd,-90,CAST(getdate() as DATE)))

select @begindate,@currentdate,DATEADD(dd,1,@currentdate),@enddt

while @currentdate <=@enddt
begin
	select @begindate,@currentdate,DATEADD(dd,1,@currentdate),@enddt;

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_trimdeliveryqueue]') AND type in (N'U'))
	DROP TABLE [dbo].[_trimdeliveryqueue];

	create table _trimdeliveryqueue (dqid int,dfid int);

	insert into _trimdeliveryqueue
	select objectid,fileobjectid
	from deliveryqueue
	where creationdatetime between @currentdate And DATEADD(dd,1,@currentdate)
	--added by Bob Luther to keep tesco orgs for 400 days
	and organizationObjectId not in(1508,1996,2096,1903,1746,2106,2115,2171,2062,1214);
	insert into _trimdeliveryqueue
		select objectid,fileobjectid
	from deliveryqueue
	where creationdatetime <  DATEADD(dd,-401,GETDATE())
		and organizationObjectId in(1508,1996,2096,1903,1746,2106,2115,2171,2062,1214);
	--select * from _trimdeliveryqueue
	------------------------------
	--top of loop

		declare @count int,@dqid int,@dfid int
		set @count=0

		declare mycursor cursor for
		select dqid,dfid from _trimdeliveryqueue

		open mycursor
		fetch next from mycursor into @dqid,@dfid

		while @@Fetch_Status=0
		begin

		--select @dqid,@bcid

		delete from deliveryqueue where objectid=@dqid
		if @dfid is not null

			delete from DeliveryFile where objectId=@dfid
			--update Comment with (rowlock) set commentText = null where objectid=@dfid

		print cast(@count as varchar)+', '+cast(@dqid as varchar)+', '+isnull(cast(@dfid as varchar),'null')

		set @count=@count+1
		fetch next from mycursor into @dqid,@dfid

		end--while
		close mycursor
		deallocate mycursor
		Print Cast(@count as varchar) +' Records Processed'
----------

set @currentdate=DATEADD(dd,1,@currentdate)
end --while
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
