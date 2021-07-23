SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC usp_admin_RemoveDTAIndexStats
AS
BEGIN
	DECLARE @strSQL nvarchar(1024)
	DECLARE @objid int
	DECLARE @indid tinyint
	DECLARE @count int
	SET @count = 0

	DECLARE ITW_Stats CURSOR FOR SELECT id, indid FROM sysindexes WHERE name LIKE '_dta_%' ORDER BY name
	OPEN ITW_Stats

	FETCH NEXT FROM ITW_Stats INTO @objid, @indid
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		SELECT @strSQL = (SELECT case when INDEXPROPERTY(i.id, i.name, 'IsStatistics') = 1 then 'drop statistics [' else 'drop index [' end + OBJECT_NAME(i.id) + '].[' + i.name + ']'
			FROM sysindexes i join sysobjects o on i.id = o.id
			WHERE i.id = @objid and i.indid = @indid AND
			(INDEXPROPERTY(i.id, i.name, 'IsHypothetical') = 1 OR
			(INDEXPROPERTY(i.id, i.name, 'IsStatistics') = 1 AND
			INDEXPROPERTY(i.id, i.name, 'IsAutoStatistics') = 0)))

		EXEC(@strSQL)

		FETCH NEXT FROM ITW_Stats INTO @objid, @indid
		SET @count = @count + 1
	END

	CLOSE ITW_Stats
	DEALLOCATE ITW_Stats

	PRINT cast(@count as varchar) + ' _dta_ indexes/stats deleted'
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
