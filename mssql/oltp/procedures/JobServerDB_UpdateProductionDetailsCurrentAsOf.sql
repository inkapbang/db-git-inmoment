SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[JobServerDB_UpdateProductionDetailsCurrentAsOf]
AS

--Updates JobServerDB
DECLARE @ServerName				varchar(50)
DECLARE @DatabaseName			varchar(15)
DECLARE @CurrentAsOf			dateTime
DECLARE @ReportingEnabled		bit
DECLARE @Eligible				bit


SET @ServerName					= ( SELECT	@@ServerName )
SET @DatabaseName				= ( SELECT	db_name() )
SET @CurrentAsOf				= ( SELECT TOP 1 CurrentAsOf		FROM CurrentAsOf )
SET @ReportingEnabled			= ( SELECT TOP 1 ReportingEnabled	FROM GlobalSettings )



/*
UPDATE	PutWh01.JobServerDB.dbo.ProductionDetailsCurrentAsOf
SET		CurrentAsOf			= @CurrentAsOf
		, ReportingEnabled	= @ReportingEnabled
WHERE
		ServerName			= @ServerName
	AND
		DatabaseName		= @DatabaseName

*/


		
		
		



		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
