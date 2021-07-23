SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.usp_maint_trimReportLogentry
as

--exec dbo.usp_maint_trimReportLogentry

--select count(*) from reportlogentry where creationdatetime < '1/1/2008'
--select count(*) from reportlogentry where creationdatetime < '10/1/2007'

declare @begindt datetime,@count int
set @begindt='6/1/2009'
--select @begindt
--while (@begindt < '1/1/2010')
while (@begindt < '7/1/2009')
	begin
		--get data
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_reportlogentrytodelete]') AND type in (N'U'))
		DROP TABLE [dbo].[_reportlogentrytodelete]

		select objectid 
		into _reportlogentrytodelete
		from reportlogentry where creationdatetime < @begindt
		
		--Process
		--select count(*) from _reportlogentrytodelete
		Begin tran
		delete from reportlogentryorganizationalunit with (rowlock)where reportLogEntryObjectId in (select objectid from [dbo].[_reportlogentrytodelete])
		commit tran
		begin tran
		delete from reportlogentryuseraccount with (rowlock) where reportLogEntryObjectId in (select objectid from [dbo].[_reportlogentrytodelete])
		commit tran
		begin tran
		delete from reportlogentry  with (rowlock)where ObjectId in (select objectid from [dbo].[_reportlogentrytodelete])
		commit tran		
	
		print @begindt
		set @begindt=dateadd(dd,1,@begindt)
		end
				
		--exec dbo.usp_maint_trimReportLogentry
		
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_reportlogentrytodelete]') AND type in (N'U'))
DROP TABLE [dbo].[_reportlogentrytodelete]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
