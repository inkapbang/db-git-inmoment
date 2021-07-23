SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* Used to create a new en_US localized string value
   returns the localizedStringObjectId */
CREATE procedure [dbo].[usp_app_Create_en_US_LocalizedStringValue]
	(@localizedStringValue nvarchar(max), 
	@localizedStringObjectId int output)
AS
BEGIN
	
	insert into LocalizedString(version)
	values (0) 
	
	select @localizedStringObjectId = scope_identity() 
	
	insert into LocalizedStringValue(localizedStringObjectId, localeKey, value)
	values (@localizedStringObjectId, 'en_US', @localizedStringValue)
	
	return 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
