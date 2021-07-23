SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW _TableReferences
AS
SELECT DISTINCT 
                      TOP 100 PERCENT syso1.name AS TableName, sysc1.name AS ColumnName, syso2.name AS MasterTableName, 
                      sysc2.name AS MasterColumnName, _ConstraintAndTableName.ConstraintName, sysc1.colid
FROM         dbo.sysforeignkeys sysfk INNER JOIN
                      dbo.sysobjects syso1 ON sysfk.fkeyid = syso1.id INNER JOIN
                      dbo.sysobjects syso2 ON sysfk.rkeyid = syso2.id INNER JOIN
                      dbo.syscolumns sysc1 ON sysfk.fkey = sysc1.colid AND sysc1.id = syso1.id INNER JOIN
                      dbo.syscolumns sysc2 ON sysfk.rkey = sysc2.colid AND sysc2.id = syso2.id INNER JOIN
                      _ConstraintAndTableName ON sysfk.constid = _ConstraintAndTableName.id AND 
                      syso1.name = _ConstraintAndTableName.ChildTablename
ORDER BY syso2.name
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
