SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [Monitor].[DatabaseSize]
as
DECLARE @lastDate datetime,@lastDate24hours datetime,@lastDate7 datetime,@lastDate30 datetime,@lastDate90 datetime
DECLARE @totalToday int, @tableToday int, @indexToday int, @unusedToday int
DECLARE @space bigint

Select @lastDate = max(date) from ProductionStats
Select @lastDate24hours = max(date) from ProductionStats where date < getdate() -1
Select @lastDate7 = max(date) from ProductionStats where date < getdate() -7
Select @lastDate30 = max(date) from ProductionStats where date < getdate() -30
Select @lastDate90 = max(date) from ProductionStats where date < getdate() -90


Select 
	@totalToday = sum(total)/1024/1024,
	@tableToday = sum(data)/1024/1024,
	@indexToday = sum(indexSize)/1024/1024, 
	@unusedToday = sum(unUsed)/1024/1024
from ProductionStats where date = @lastDate

IF object_id('tempdb..#drives') IS NOT NULL
drop table #drives

CREATE TABLE #drives (drive varchar(10), MBFree bigint)

INSERT INTO #drives
exec xp_fixeddrives

select @space = sum(MBFree/1024) from #drives where drive in (SELECT left(physical_name,1) FROM sys.master_files where name like 'Mindshare%' and physical_name not like '%.ldf')

Select 
	@space as [Total Space Remaining],
	@space/[Total 24 Hour Growth in GB] as [Days until out of space],
	[Total Size in GB],	
	[Table Size in GB],	
	[Index Size in GB],	
	[unUsed in GB],	
	[Total 24 Hour Growth in GB],	
	[Table 24 Hour Growth in GB],	
	[Index 24 Hour Growth in GB],	
	[unUsed 24 Hour Growth in GB],
	[Total Week Growth in GB],
	[Table Week Growth in GB],	
	[Index Week Growth in GB],
	[unUsed Week Growth in GB],
	[Total Month Growth in GB],
	[Table Month Growth in GB],
	[Index Month Growth in GB],
	[unUsed Month Growth in GB],
	[Total Quarter Growth in GB],
	[Table Quarter Growth in GB],
	[Index Quarter Growth in GB],
	[unUsed Quarter Growth in GB]
	from (
Select
	1 as id, 
	@totalToday as [Total Size in GB],
	@tableToday as [Table Size in GB],
	@indexToday as [Index Size in GB], 
	@unusedToday as [unUsed in GB] ) as i1
join(
Select 
	1 as id,
	@totalToday - sum(total)/1024/1024 as [Total 24 Hour Growth in GB],
	@tableToday - sum(data)/1024/1024 as [Table 24 Hour Growth in GB],
	@indexToday - sum(indexSize)/1024/1024 as [Index 24 Hour Growth in GB], 
	@unusedToday - sum(unUsed)/1024/1024 as [unUsed 24 Hour Growth in GB] 
from ProductionStats where date = @lastDate24hours) as i2
	on i1.id = i2.id
join(
Select
	1 as id, 
	@totalToday - sum(total)/1024/1024 as [Total Week Growth in GB],
	@tableToday - sum(data)/1024/1024 as [Table Week Growth in GB],
	@indexToday - sum(indexSize)/1024/1024 as [Index Week Growth in GB], 
	@unusedToday - sum(unUsed)/1024/1024 as [unUsed Week Growth in GB] 
from ProductionStats where date = @lastDate7) as i3
	on i1.id=i3.id
join(Select 
1 as id,
	@totalToday - sum(total)/1024/1024 as [Total Month Growth in GB],
	@tableToday - sum(data)/1024/1024 as [Table Month Growth in GB],
	@indexToday - sum(indexSize)/1024/1024 as [Index Month Growth in GB], 
	@unusedToday - sum(unUsed)/1024/1024 as [unUsed Month Growth in GB] 
from ProductionStats where date = @lastDate30) as i4
on i1.id = i4.id
join (Select 
1 as id,
	@totalToday - sum(total)/1024/1024 as [Total Quarter Growth in GB],
	@tableToday - sum(data)/1024/1024 as [Table Quarter Growth in GB],
	@indexToday - sum(indexSize)/1024/1024 as [Index Quarter Growth in GB], 
	@unusedToday - sum(unUsed)/1024/1024 as [unUsed Quarter Growth in GB] 
from ProductionStats where date = @lastDate90) as i5
on i1.id=i5.id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
