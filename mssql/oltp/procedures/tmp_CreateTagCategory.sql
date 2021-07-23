SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[tmp_CreateTagCategory](@orgId int, @sequence int, @label nvarchar(50), @reportText nvarchar(50)) as begin
    set nocount on
/*    
    declare @labelId int
    declare @reportTextId int

    insert LocalizedString (version) values (0)
    select @labelId = SCOPE_IDENTITY()
    insert LocalizedStringValue (localizedStringObjectId,localeKey,value) values (@labelId,'en_US',@label)

    insert LocalizedString (version) values (0)
    select @reportTextId = SCOPE_IDENTITY()
    insert LocalizedStringValue (localizedStringObjectId,localeKey,value) values (@reportTextId,'en_US',@reportText)

    insert TagCategory (organizationObjectId, nameObjectId, reportLabelObjectId, sequence, version)
    values (@orgId, @labelId, @reportTextId, @sequence, 0)
    
    select @sequence, objectId from TagCategory where organizationObjectId=@orgId and nameObjectId=@labelId and reportLabelObjectId=@reportTextId 

*/
end 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
