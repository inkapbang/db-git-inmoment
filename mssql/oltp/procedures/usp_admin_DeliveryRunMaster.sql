SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_admin_DeliveryRunMaster] as
BEGIN
	DECLARE @usr varchar(25), @email varchar(25), @qry nvarchar(max)
	DECLARE @delim char(1)
	SET @delim = CHAR(9)

	declare mailcursor cursor for  
	select
		email,
		firstname +' '+lastname as name 
	from useraccount
	where firstname +' '+lastname in ('Andrew Park', 'Lonnie Mayne', 'Brad Clark',
			'Derrick Royce', 'Doug Wilson', 'Erich Dietz', --'Jeremiah Powless',
			'Jillian Bruening', 'John Sperry', 'Jon Grover', 'Rich Hanks', 'Rick Banovich', 
			'Suzanne Simmons', 'Tyler Rees', 'Will Frazier', 'Brett Butler')
		and email like '%mshare.net'
		and email not like '%2%'
		and email not like '%Comcast%'

	open mailcursor
	fetch next from mailcursor into @email,@usr

	while @@fetch_status=0
	begin
		--
		--set @usr='Erich Dietz'
		--set @email='bluther@mshare.net'
		set @qry ='exec usp_admin_DeliveryRunAuto '''+@usr+''','''+@email+''''

		--select @qry
		 
		EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'Alert',
			@recipients = @email,
			@body = 'Delivery Run Results for last night',
			@subject = 'Delivery Run Results for last night',
			@query =@qry,
			@query_result_width = 32767,
			@exclude_query_output = 1,
			@execute_query_database = 'mindshare',
			@attach_query_result_as_file = 1,
			@query_result_separator = @delim,
			@query_attachment_filename = 'DeliveryRunResults.csv',
			@importance = 'Normal'

	fetch next from mailcursor into  @email,@usr
	end
	close mailcursor
	deallocate mailcursor
	return
END

--exec usp_admin_reportrunmaster
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
