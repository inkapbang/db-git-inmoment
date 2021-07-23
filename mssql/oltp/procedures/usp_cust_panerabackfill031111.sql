SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
----drop table dbo._jordanPaneraaddfield031111
--select *
--into dbo._jordanPaneraaddfield031111
--from [chest].warehouse.dbo._jordanPaneraaddfield031111
--
--ALTER TABLE _jordanPaneraaddfield031111
--ADD CONSTRAINT pk_jordanPaneraaddfield031111 PRIMARY KEY (objectid)

----dbo._jordanPaneraaddfield031111
--
--select top 10000 objectid from dbhealth.dbo._jordanPaneraaddfield031111 order by objectid desc
create procedure dbo.usp_cust_panerabackfill031111
as

--exec dbo.usp_cust_panerabackfill031111
declare @count int,@srid	int,@val varchar(50),@newsequence int

set @count=1

declare mycursor cursor for
select top 50000 objectid from dbhealth.dbo._jordanPaneraaddfield031111 order by objectid desc

open mycursor
fetch next from mycursor into @srid

while @@Fetch_Status=0
begin

set @newsequence=(select Max(sequence) + 1 from surveyresponseanswer with (nolock) where surveyresponseobjectid=@srid)

insert into surveyresponseanswer(
surveyResponseObjectId,
sequence,
dataFieldObjectId,
dataFieldOptionObjectId
)
select @srid,@newsequence,41826,113032
--case
--	when @val='1 - Exceptional Service' then 36500
--	when @val='3 - General' then 36507
--	
--end

print cast(@count as varchar)+', '+cast(@srId as varchar)+', '+cast(@newsequence as varchar)

delete from dbhealth.dbo._jordanPaneraaddfield031111 where objectid =@srid

set @count=@count+1
fetch next from mycursor into @srid

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
