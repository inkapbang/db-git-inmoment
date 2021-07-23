SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [dbo].[usp_maint_NullOutBinarycontent]
@begindt datetime,@enddt datetime
as

/*
This procedure puts nulls in the [content] field of binarycontent
it checks to see that the content exists in [chest].archive.dbo.binarycontent
should be run after dbo.usp_maint_ArchiveMindshareiBinarycontent on server [Chest]

--Bob Luther 7/29/2010
*/
/*
--use mindsharei

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_bcobjectidstodelete]') AND type in (N'U'))
begin
	CREATE TABLE [dbo].[_bcobjectidstodelete](
		[binarycontentobjectid] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
	(
		[binarycontentobjectid] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
end--if

--exec dbo.usp_maint_NullOutBinarycontent '1/1/2008','2/1/2008'

truncate table _bcobjectidstodelete
print @begindt

while @begindt < @enddt
	begin

		truncate table _bcobjectidstodelete

		insert into [_bcobjectidstodelete]
		select csra.binarycontentobjectid
		from [chest].warehouse.dbo.surveyresponse csr with (nolock)
		join [chest].warehouse.dbo.surveyresponseanswer csra with (nolock)
		on csr.objectid=csra.surveyresponseobjectid
		join [chest].archive.dbo.binarycontent cbc with (nolock)
		on cbc.objectid=csra.binarycontentobjectid 
		join binarycontent bc with (nolock)
		on bc.objectid=cbc.objectid
		where csr.begindate >= @begindt
		and csr.begindate < dateadd(dd,1,@begindt)
		and cbc.content is not null
		and bc.content is not null

		--select * from _bcobjectidstodelete

		declare @count int,@bcid int

		set @count=0

		declare mycursor cursor for
		select * from _bcobjectidstodelete

		open mycursor
		fetch next from mycursor into
		@bcid

		while @@Fetch_Status=0
		begin
		
		update binarycontent with (rowlock) set [content] = NULL where objectid=@bcid
		print cast(@count as varchar)+', '+cast(@bcId as varchar)

		set @count=@count+1
		fetch next from mycursor into 
		@bcid

		end--while
		close mycursor
		deallocate mycursor
		Print Cast(@count as varchar) +' Records Processed'

		set @begindt=dateadd(dd,1,@begindt)
		print @begindt


	end--while


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_bcobjectidstodelete]') AND type in (N'U'))
DROP TABLE [dbo].[_bcobjectidstodelete]


*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
