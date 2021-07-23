SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[_updatePromptName_DBA2757] 
AS

BEGIN

	SET NOCOUNT ON;

	-- declare variables
	declare @promptId int, @organizationObjectId int, @x int,@Old_columnA varchar(50),@New_columnB varchar(50)

	
	DECLARE dbaPrompt_Cursor CURSOR FOR SELECT orgId,promptId,Old_columnA,New_columnB FROM _DBA2757promptTable
	OPEN dbaPrompt_Cursor ;
	
	FETCH NEXT FROM dbaPrompt_Cursor INTO @organizationObjectId , @promptId , @Old_columnA ,@New_columnB
	WHILE @@FETCH_STATUS = 0
	BEGIN

		update prompt
		set name=@New_columnB
		where objectId=@promptId 
		and organizationObjectId=@organizationObjectId
		
		select @x=@@rowcount
		print cast(@x as varchar)

		
		
	    FETCH NEXT FROM dbaPrompt_Cursor into @organizationObjectId , @promptId , @Old_columnA ,@New_columnB

	END

	
	CLOSE dbaPrompt_Cursor
	DEALLOCATE dbaPrompt_Cursor

	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
