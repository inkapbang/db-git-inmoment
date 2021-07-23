SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW _ConstraintAndTableName
AS
SELECT     sysobjects_1.name AS ChildTablename, dbo.sysobjects.id, dbo.sysobjects.parent_obj, dbo.sysobjects.name AS ConstraintName
FROM         dbo.sysforeignkeys INNER JOIN
                      dbo.sysobjects ON dbo.sysforeignkeys.constid = dbo.sysobjects.id AND dbo.sysforeignkeys.fkeyid = dbo.sysobjects.parent_obj INNER JOIN
                      dbo.sysobjects sysobjects_1 ON dbo.sysobjects.parent_obj = sysobjects_1.id
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
