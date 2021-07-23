SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION GetLocationCategoryPath(@locationCategoryObjectId INT)
RETURNS VARCHAR(1000) AS
BEGIN
	DECLARE @lineage VARCHAR(1000)
	SELECT @lineage=lineage FROM LocationCategory WHERE objectId=@locationCategoryObjectId
	DECLARE @path VARCHAR(1000)
	SET @path = '/'

	DECLARE idCursor CURSOR LOCAL FOR
		SELECT token FROM dbo.Split(@lineage, '/')
	OPEN idCursor

	DECLARE @token VARCHAR(200)
	FETCH NEXT FROM idCursor INTO @token
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@token IS NOT NULL)
		BEGIN
			DECLARE @name VARCHAR(200)
			SELECT @name=name FROM LocationCategory WHERE objectId = CAST(@token AS INT)
			SET @path = @path + @name + '/'
		END
		FETCH NEXT FROM idCursor INTO @token
	END

	CLOSE idCursor
	DEALLOCATE idCursor

	SELECT @path=@path+name+'/' FROM LocationCategory WHERE objectId = @locationCategoryObjectId	

	RETURN @path
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
