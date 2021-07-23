SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_CreateSystemDataField] 
	@name varchar(50),
	@fieldType int,
	@readOnly bit,
	@scriptBinding varchar(40),
	@formatter int,
	@visibleInDetail bit,
	@answerType int = NULL
as
BEGIN
	IF NOT EXISTS (SELECT objectId FROM [dbo].[DataField] where fieldType=@fieldType)
	BEGIN
		DECLARE @labelStringId INT;
		DECLARE @textStringId INT;
		EXEC [dbo].[usp_admin_CreateLocalizedStringValue] @name, 'en_US', @labelStringId OUTPUT;
		EXEC [dbo].[usp_admin_CreateLocalizedStringValue] @name, 'en_US', @textStringId OUTPUT;
		INSERT INTO [dbo].[DataField]
				   ([fieldType]
				   ,[systemField]
				   ,[organizationObjectId]
				   ,[name]
				   ,[readOnly]
				   ,[scorePointsPossible]
				   ,[scoreType]
				   ,[locationCategoryTypeObjectId]
				   ,[version]
				   ,[defaultGoalObjectId]
				   ,[encrypted]
				   ,[enabled]
				   ,[scriptBindingName]
				   ,[personalInfo]
				   ,[labelObjectId]
				   ,[textObjectId]
				   ,[formatter]
				   ,[visibleInDetail]
				   ,[answerType])
			 VALUES
				   (@fieldType
				   ,1
				   ,NULL
				   ,@name
				   ,@readOnly
				   ,NULL
				   ,NULL
				   ,NULL
				   ,0
				   ,NULL
				   ,NULL
				   ,NULL
				   ,@scriptBinding
				   ,0
				   ,@labelStringId
				   ,@textStringId
				   ,@formatter
				   ,@visibleInDetail
				   ,@answerType);
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
