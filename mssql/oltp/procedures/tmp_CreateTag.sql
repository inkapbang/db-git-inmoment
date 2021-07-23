SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[tmp_CreateTag](@orgId int, @sequence int, @tagCategoryId int, @label nvarchar(50), @reportText nvarchar(50)) as begin

/*
    set nocount on

    declare @labelId int
    declare @reportTextId int

    insert LocalizedString (version) values (0)
    select @labelId = SCOPE_IDENTITY()
    insert LocalizedStringValue (localizedStringObjectId,localeKey,value) values (@labelId,'en_US',@label)

    insert LocalizedString (version) values (0)
    select @reportTextId = SCOPE_IDENTITY()
    insert LocalizedStringValue (localizedStringObjectId,localeKey,value) values (@reportTextId,'en_US',@reportText)

    insert Tag (organizationObjectId, nameObjectId, reportLabelObjectId, sequence, tagCategoryObjectId, version)
    values (@orgId, @labelId, @reportTextId, @sequence, @tagCategoryId, 0) 

*/
print 'Done'
end 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
