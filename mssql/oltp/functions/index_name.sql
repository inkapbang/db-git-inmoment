SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION dbo.index_name (@object_id int, @index_id int)
RETURNS sysname
AS
BEGIN
  RETURN(SELECT name FROM sys.indexes WHERE object_id = @object_id and index_id = @index_id)
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
