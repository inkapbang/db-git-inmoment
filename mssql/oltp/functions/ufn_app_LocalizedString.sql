SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION ufn_app_LocalizedString(@localizedStringId INT, @localeKey VARCHAR(25))
RETURNS NVARCHAR(3000)
AS
BEGIN
	DECLARE @value NVARCHAR(3000)
	SELECT TOP(1)
		@value = v.[value]
	FROM dbo.LocalizedStringValue v
	WHERE v.localizedStringObjectId = @localizedStringId
		AND (v.localeKey = @localeKey
			OR v.localeKey = 'en_US')
	ORDER BY
		CASE WHEN (v.localeKey = @localeKey) THEN 0 ELSE 1 END -- order by exact match on locale
	RETURN (@value)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
