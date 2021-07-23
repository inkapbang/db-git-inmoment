SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure Monitor.internalSpaceUsed_Opsview
(@warning int, @critical int)
AS
--warning and critical are the number of minutes SQL can be behind before we are alerted
DECLARE @diffPct float, @dbSize float, @space float

-- Taken from and modified sp_spaceused:
SELECT @dbSize = ltrim(str((convert(DECIMAL(15, 2), dbsize) + convert(DECIMAL(15, 2), logsize)) * 8192 / 1048576, 15, 2))
    ,@space = ltrim(str((CASE WHEN dbsize >= reservedpages THEN (convert(DECIMAL(15, 2), dbsize) - convert(DECIMAL(15, 2), reservedpages)) * 8192 / 1048576 ELSE 0 END), 15, 2))
FROM (SELECT dbsize = sum(convert(BIGINT, CASE WHEN STATUS & 64 = 0 THEN size ELSE 0 END)) ,logsize = sum(convert(BIGINT, CASE WHEN STATUS & 64 <> 0 THEN size ELSE 0 END))
    FROM dbo.sysfiles) AS files,
	(SELECT reservedpages = sum(a.total_pages),usedpages = sum(a.used_pages),pages = sum(CASE WHEN it.internal_type IN (202,204,211,212,213,214,215,216) THEN 0 WHEN a.type <> 1 THEN a.used_pages
    WHEN p.index_id < 2 THEN a.data_pages  ELSE 0  END) FROM sys.partitions p  INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id LEFT JOIN sys.internal_tables it
	 ON p.object_id = it.object_id) AS partitions

select @diffPct = ( (@space / @dbSize) * 100.0)

IF (@diffPct > @warning and @diffPct < @critical)
Select 'Internal Percent Free: '+ cast(@diffPct as varchar)+' |  ''GB free''='+ cast(@space/1024.0 as varchar) as output, 1 as stateValue

IF (@diffPct > @critical)
Select 'Internal Percent Free: '+ cast(@diffPct as varchar)+' | ''GB free''='+ cast(@space/1024.0 as varchar) as output, 2 as stateValue

IF (@diffPct < @warning)
Select 'Internal Percent Free: '+ cast(@diffPct as varchar)+' | ''GB free''='+ cast(@space/1024.0 as varchar) as output, 0 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
