SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.usp_maint_trimReportlogentry2
	@dt datetime--reporting information older than this date will be deleted

as
--declare @dt datetime
--set @dt='7/1/2009'
select @dt

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rleids]') AND type in (N'U'))
DROP TABLE [dbo].[_rleids]

CREATE TABLE [dbo].[_rleids](
	[rleid] [int] NULL
) ON [PRIMARY]

insert into _rleids--reportlogentryobjectids to remove
select objectid from reportlogentry with(nolock) where creationdatetime < @dt
--rleids
select * from _rleids

---
delete ou 
--select ou.*
from _rleids rle
join reportlogentryorganizationalunit rleou with (nolock)
on rle.rleid =rleou.reportlogentryobjectid
join organizationalunit ou with (nolock)
on rleou.organizationalUnitObjectid=ou.objectid

delete rleou 
--select rleou.*
from _rleids rle
join reportlogentryorganizationalunit rleou with (nolock)
on rle.rleid =rleou.reportlogentryobjectid

delete rleuac 
--select rleuac.*
from _rleids rle
join reportlogentryuseraccount rleuac with (nolock)
on rle.rleid =rleuac.reportlogentryobjectid

delete reportlogentry 
--select reportlogentry.*
from _rleids rle
join reportlogentry 
on rle.rleid =reportlogentry.objectid

--cleanup
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_rleids]') AND type in (N'U'))
DROP TABLE [dbo].[_rleids]

--exec dbo.usp_maint_trimReportlogentry2 '7/1/2009'
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
