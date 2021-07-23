SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_OLTPHealthCheck] (@cpuUtilCutoff int = 80, @diskIoCutoff int=5)
AS
BEGIN
--exec  usp_app_OLTPHealthCheck 0
SET NOCOUNT ON;

DECLARE @isHealthy bit 
SET @isHealthy = 1
--SET @isHealthy = 0
--DECLARE @isCpuUtilLow bit
--SET @isCpuUtilLow= 0
--DECLARE @isDiskIOLow bit
--SET @isDiskIOLow= 0
--DECLARE @isMemoryUseLow bit
--SET @isMemoryUseLow = 0

----IS CPU UTIL LOW?
--DECLARE @cpuUtil int 
--SET @cpuUtil= (SELECT TOP 1 100-SystemIdle as [CPU Util] 
--FROM (
--      SELECT record.value('(./Record/@id)[1]', 'int') AS record_id,
--             record.value('(./Record/SchedulerMonitorEvent/SystemHealth/SystemIdle)[1]', 'int')
--             AS [SystemIdle]
--      FROM (
--            SELECT [timestamp], CONVERT(xml, record) AS [record]
--            FROM sys.dm_os_ring_buffers
--            WHERE ring_buffer_type = N'RING_BUFFER_SCHEDULER_MONITOR'
--            AND record LIKE N'%<SystemHealth>%') AS x
--      ) AS y
--ORDER BY record_id DESC)

--IF @cpuUtil < @cpuUtilCutoff 
--SET @isCpuUtilLow = 1 


----IS DISKIO LOW?
--DECLARE @avgDiskCount int
--SET @avgDiskCount = (SELECT AVG(pending_disk_io_count) AS [AvgPendingDiskIOCount]
--FROM sys.dm_os_schedulers 
--WHERE [status] = 'VISIBLE ONLINE');

--IF @avgDiskCount < @diskIoCutoff
--SET @isDiskIOLow = 1


----IS ENOUGH MEMORY AVAILABLE?
--DECLARE @memoryState varchar(45) 
--SET @memoryState = (SELECT system_memory_state_desc
--FROM sys.dm_os_sys_memory); 

--IF @memoryState != 'Available physical memory is low' 
--SET @isMemoryUseLow = 1 


-----FINAL CHECK
--IF @isCpuUtilLow=1 and  @isMemoryUseLow=1 and @isDiskIOLow=1
--SET @isHealthy=1

select @isHealthy
return @isHealthy

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
