SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_LocalizedStringTable](@localizedStringId INT, @localeKey VARCHAR(25))
RETURNS TABLE
AS
RETURN (
    select isnull(
            (
                SELECT TOP(1)
                    v.[value]
                FROM dbo.LocalizedStringValue v
                WHERE v.localizedStringObjectId = @localizedStringId
                    AND v.localeKey IN (@localeKey, 'en_US')
                ORDER BY
                    CASE WHEN (v.localeKey = @localeKey) THEN 0 ELSE 1 END -- order by exact match on locale
            ), '' ) [value]
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
