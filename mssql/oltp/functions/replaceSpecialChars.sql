SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[replaceSpecialChars] 
(
        @nstring nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN
        RETURN CASE 
			WHEN len(@nstring)< 1 THEN NULL 
			ELSE replace(replace(replace(replace(replace(replace(replace(replace(@nstring,CHAR(10),' '),CHAR(13), ' '),CHAR(9), ' '), '|', ':'),CHAR(19), ' '),CHAR(1), ' '),CHAR(29), ' ') ,char(0),'')
		END 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
