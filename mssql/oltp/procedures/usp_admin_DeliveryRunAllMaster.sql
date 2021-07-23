SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[usp_admin_DeliveryRunAllMaster]
as
BEGIN
	DECLARE @usr varchar(25), @email varchar(25), @qry nvarchar(max)

	DECLARE @delim char(1)
	SET @delim = CHAR(9)

	DECLARE @usrs table (
		email varchar(50),
		uname varchar(50),
		minrole int
	)

	insert into @usrs (email,uname,minrole)
		select 
			email, firstname +' '+lastname as uname, min(uar.role) as minrole
		from useraccount ua with (Nolock)
			join useraccountrole uar with (Nolock)
				on ua.objectid =uar.useraccountobjectid
		where role <=12
			and email like '%@mshare.net'
		group by email,firstname +' '+lastname
		order by uname

	DECLARE mailcursor cursor for 
		select email,uname from @usrs  where minrole in (1,2) 
	--set @email='bluther@mshare.net'
	open mailcursor
	fetch next from mailcursor into @email,@usr

	while @@fetch_status=0
	begin
		--
		--set @usr='Erich Dietz'
		set @email='bluther@mshare.net'
		set @qry ='exec usp_admin_DeliveryRunAll'--''+@usr+''','''+@email+''''

		select @qry
		 
	--	EXEC msdb.dbo.sp_send_dbmail
	--		@profile_name = 'Alert',
	--		@recipients = @email,
	--		@body = 'Reports Run Results for last night',
	--		@subject = 'Report Run Results for last night',
	--		@query =@qry,
	--		@query_result_width = 32767,
	--		@exclude_query_output = 1,
	--		@execute_query_database = 'mindshare',
	--		@attach_query_result_as_file = 1,
	--		@query_result_separator = @delim,
	--		@query_attachment_filename = 'ReportRunAllResults.csv',
	--		@importance = 'Normal'

		fetch next from mailcursor into  @email,@usr
	end
	close mailcursor
	deallocate mailcursor
	return
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
