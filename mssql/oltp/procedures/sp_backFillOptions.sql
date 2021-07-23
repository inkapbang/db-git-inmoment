SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE sp_backFillOptions
		@dataFieldId	bigInt
AS
			
SELECT
		objectId		AS dataFieldOptionObjectId
		, dataFieldObjectId
		, name
		, sequence
		, scorePoints
		, version
		, labelObjectId
		, ordinalLevel
FROM
		DataFieldOption
WHERE
		dataFieldObjectId = @dataFieldId
ORDER BY
		sequence						
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
