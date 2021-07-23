SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[sp_AutoDeliveryList]
AS

/***************  View Contents of Stored Procedures  ***************

	Input name of Stored Proc OR Exclude WHERE clause to get
	entire list of stored procs.
	
	Copy/Paste sp name between parenthesis of last command to
	read contents of Stored Procedure
exec [sp_AutoDeliveryList]
*********************************************************************/



DECLARE @dTT100 TABLE
      (
            rowId				int Identity( 1, 1 )
            , serverName		varchar(50)
            , spName			varchar(255)
      )
 
 
INSERT INTO @dTT100 ( serverName, spName )
SELECT
            'PUTOLTPSql'
            , name
FROM
            oltp.sys.procedures          
 
--UNION ALL

--SELECT
--            'Bat'
--            , name
--FROM
--            Bat.Warehouse.sys.procedures          
 
--UNION ALL

--SELECT
--            'Cannonball'
--            , name
--FROM
--            Cannonball.Warehouse.sys.procedures          
 
--UNION ALL

--SELECT
--            'Chest'
--            , name
--FROM
--            Chest.Warehouse.sys.procedures          
 
--UNION ALL

--SELECT
--            'Roy'
--            , name
--FROM
--            Roy.Warehouse.sys.procedures          
 
--UNION ALL

--SELECT
--            'Treasure'
--            , name
--FROM
--            Treasure.Warehouse.sys.procedures          
 

 
 
SELECT 
            serverName
            , spName      
            
FROM 
            @dTT100

			
									
WHERE
            spName LIKE '%AutoDelivery%'     --Input Name OR just exclude WHERE clause for full list 
 
ORDER BY 	spName
			, serverName
 


/*****************
 
sp_helpText ''
 
******************/ 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
