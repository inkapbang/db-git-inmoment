SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
----select top 5 * from emailqueue
--
--select * from emailqueue
--where sentdatetime > '5/5/2009'
--and attachmentobjectid is not null
--
--14668061
-----------------
--select * from organization where name like 'regis%'
--select top 5 * from emailqueue
----------------
--declare @oid int,@startdt datetime,@enddt datetime
-------------------
CREATE procedure [dbo].[usp_cust_reportLinks3]
@oid int, @begindt datetime,@enddt datetime
as

--select @oid,@begindt,@enddt

declare @res table(reportname varchar(50),subject nvarchar(max),email varchar(max),url varchar(max))
insert into @res
select
[dbo].[ufn_app_LocalizedString] (r.nameobjectid,'en_us') as reportname,
E.subject,
e.validsentAddresses,
'http://www.mshare.net/report/servlet/BinaryContentServlet?id='+cast(e.attachmentobjectid as varchar)
from report r with (nolock)
join reportschedule rs with (nolock)
on r.objectid=rs.reportobjectid
left outer join emailqueue e with (nolock)
on rs.objectid=e.generatedScheduleObjectId
where r.organizationobjectid=@oid
and sentdatetime >= @begindt
and sentdatetime <@enddt

--select * from @res

create table #link(links varchar(max))

declare @count int, @reportname varchar(50),@email varchar(max),@url varchar(max),@sql nvarchar(4000),@oname varchar(50),@subject nvarchar(max)
set @count=0
set @oname=(select name from organization where objectid=@oid)

insert into #link
select '<html><head>'+@oname+' Links From '+cast(@begindt as varchar)+' to '+cast(@enddt as varchar)+'</head>'
insert into #link
select '<body><br>'

declare mycursor cursor for
select reportname,subject,email,url from @res

open mycursor
fetch next from mycursor into @reportname,@subject,@email,@url
while @@fetch_status=0
begin
--
--select @reportname,@email,@url
set @sql='insert into #link select''<a href="'+@url+'">'+@reportname+' </a> '+' '+@subject+' '+@email+'<br>'''
print @sql
exec (@sql)
--
set @count=@count+1
print cast(@count as varchar)+' ,'+@sql
fetch next from mycursor into @reportname,@subject,@email,@url
end

close mycursor
deallocate mycursor

insert into #link
select '</body></htm>'

select * from #link

--exec dbo.usp_cust_reportLinks3 569,'4/14/2010','4/15/2010'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
