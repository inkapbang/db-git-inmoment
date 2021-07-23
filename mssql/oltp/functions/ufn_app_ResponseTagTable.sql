SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_ResponseTagTable] (@responseId INT, @localeKey VARCHAR(25) = 'en_US')
RETURNS TABLE
AS
RETURN
    SELECT DISTINCT
        list.[value] [tag]
    FROM
        Tag t
        JOIN ResponseTag srt
            ON t.objectId = srt.tagObjectId
            AND srt.responseObjectId = @responseId
        CROSS APPLY dbo.ufn_app_LocalizedStringTable(t.nameObjectId, @localeKey) list 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
