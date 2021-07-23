SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure sp_FlattenTableColumnsForInsertList
--ALTER Procedure sp_FlattenTableColumnsForInsertList
	@TableNameColumnList	varchar(max) = NULL
AS



---- Table Value Version
--DECLARE @TableNameColumnList	varchar(max)
--SET @TableNameColumnList		= 'Page'
--SET @TableNameColumnList		= '##_Level00_TABLE_Page_COLUMN_ObjectId_BASED_ON_TABLE_##MainTableObjectIdList_COLUMN_ObjectId'


DECLARE @dtt01 TABLE
(
	RowId			int Identity(1,1)
	, Column_Name	varchar(max)
)

INSERT INTO  @dtt01 ( Column_Name )
SELECT
		column_name
FROM
		information_schema.columns

WHERE
		table_name	LIKE @TableNameColumnList
ORDER BY 
		ordinal_position



DECLARE @Count				int
		, @CnMin			int
		, @CnMax			int
		, @Cname			varchar(max)
		, @FlattenResult	varchar(max)


SET		@Count = ( SELECT COUNT(1)		FROM   @dtt01 )
SET		@CnMin = ( SELECT MIN(RowId)	FROM   @dtt01 )
SET		@CnMax = ( SELECT MAX(RowId)	FROM   @dtt01 )

SET		@FlattenResult	= '( '



IF @Count > 0
BEGIN
	WHILE @CnMin <= @CnMax
		BEGIN

			SET @Cname = ( SELECT column_name	FROM  @dtt01	WHERE RowId = @CnMin )

			SET @FlattenResult	= @FlattenResult + @Cname + ', '

			SET @CnMin = @CnMin + 1
		
		END


	SET @FlattenResult	= @FlattenResult + ')'

	SET @FlattenResult	= ( SELECT REPLACE( @FlattenResult, ', )', ' )' )	)


END
ELSE
	SET		@FlattenResult	= ''




SELECT @FlattenResult
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
