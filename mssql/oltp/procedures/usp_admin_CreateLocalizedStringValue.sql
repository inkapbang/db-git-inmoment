SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_admin_CreateLocalizedStringValue] 
	@stringValue NVARCHAR(MAX),
	@locale VARCHAR(25),
	@localizedStringID INT OUTPUT
as
BEGIN
	-- Create the LocalizedString
	INSERT INTO [dbo].[LocalizedString]
			   ([version])
		 VALUES
			   (1);

	-- Retrieve the newly created object ID
	SET @localizedStringID = SCOPE_IDENTITY();

	-- Add the Localized string's value
	INSERT INTO [dbo].[LocalizedStringValue]
			   ([localizedStringObjectId]
			   ,[localeKey]
			   ,[value])
		 VALUES
			   (@localizedStringID
			   ,@locale
			   ,@stringValue);
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
