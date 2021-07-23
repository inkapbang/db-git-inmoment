SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure [usp_temp_Update_UserAccount_mindshareEmployee]
AS
BEGIN
	UPDATE
		[UserAccount]
	SET
		[mindshareEmployee] = 0
	WHERE
		[mindshareEmployee] IS NULL;

	UPDATE
		[UserAccount]
	SET
		[mindshareEmployee] = 1
	WHERE
		[email] LIKE '%@mshare.net'
		and [email] NOT LIKE '%wsv%'
		and [email] NOT LIKE '%wsw%'
		and [email] NOT LIKE '%outbound%'
		and [email] NOT LIKE '%import%'
		and [email] NOT LIKE 'region%'
		and [email] NOT LIKE 'district%'
		and [email] NOT LIKE '%webservice%'
		and [lastName] NOT LIKE '%Service%'
		and [lastName] NOT LIKE '%user%'
		and [lastName] NOT LIKE '%test%'
		and [lastName] NOT LIKE '%transcribe%'
		and [lastName] NOT LIKE '%demo%'
		and enabled = 1
		and [mindshareEmployee] = 0;

	print 'Creating web service role assignments...';

	-- Variable declaration
	declare @count int, @userAccountObjectId int;
	set @count=0;

	-- Set up the cursor with the offerObjectIds
	declare webservicecursor cursor LOCAL for
		SELECT
			DISTINCT [userAccountObjectId]
		FROM
			[dbo].[UserAccountRole]
		WHERE
			[role] IN (
				101
				,102
				,105
				,106
				,107
				,108
				,109
				,110
				,112
				,113
			);

	-- Open the cursor
	open webservicecursor;

	-- Set up the while loop
	fetch next from webservicecursor into @userAccountObjectId;
	while @@fetch_status=0
	begin

		-- Add the new blocked number access policy for the organization
		INSERT INTO [dbo].[UserAccountRole]
		   ([userAccountObjectId]
		   ,[role])
		VALUES (
		   @userAccountObjectId
		   ,100);

		-- Increment the counter
		set @count=@count+1;

	fetch next from webservicecursor into @userAccountObjectId;
	end -- End of loop

	-- Close the cursor and deallocate it
	close webservicecursor;
	deallocate webservicecursor;

	-- Print out the results
	print '[' + cast(@count as varchar) + '] web service role assignments created.';

	DELETE FROM
		[dbo].[UserAccountRole]
	WHERE
		[role] IN (
			9 -- Translator
			,12 -- Customer Service Rep
			,16 -- Audit Log
			,20 -- Error Log
			,21 -- Auto provisioning bypass
			,101 -- WS data export
			,102 -- WS data import
			,103 -- WS structure export
			,104 -- WS structure import
			,105 -- WS desktop
			,106 -- WS inbound phone init
			,107 -- WS inbound web init
			,108 -- WS outbound phone init
			,109 -- WS outbound web init
			,110 -- WS bulk export
			,112 -- WS analysis
			,113 -- WS SMS init
		);


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
