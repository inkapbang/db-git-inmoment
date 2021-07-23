SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE RebuildLCLineage (@id int) AS
BEGIN
	BEGIN TRANSACTION
	
	UPDATE LocationCategory
		SET lineage = 'X'
		WHERE objectId = @id OR lineage LIKE '%/' + LTrim(Str(@id,6)) + '/%'
	
	UPDATE LocationCategory
	SET depth = 0,
		lineage = '/'
	WHERE lineage = 'X' AND parentObjectId IS NULL
	
	WHILE EXISTS (SELECT * FROM LocationCategory WHERE lineage = 'X')
		UPDATE Child
		SET Child.depth = Parent.depth + 1,
			Child.lineage = Parent.lineage +
	LTrim(Str(Parent.objectId,6))  + '/'
		FROM LocationCategory AS Child
		INNER JOIN LocationCategory AS Parent
			ON (Child.parentObjectId = Parent.objectId)
		WHERE Parent.lineage <> 'X'
			AND Child.lineage = 'X'
	
	COMMIT TRANSACTION
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
