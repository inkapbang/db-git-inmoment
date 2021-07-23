SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_McD_LocalizedStringTable](@key nvarchar(25), @localeKey nvarchar(25)) RETURNS TABLE AS RETURN (
    SELECT TOP(1) lsv.[value]
    FROM dbo._McDonaldsLocalizedStringValue lsv
    WHERE lsv.[key] = @key
        AND lsv.localeKey IN (@localeKey, 'en_US')
    ORDER BY
        CASE WHEN (lsv.localeKey = @localeKey) THEN 0 ELSE 1 END -- order by exact match on locale
)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
