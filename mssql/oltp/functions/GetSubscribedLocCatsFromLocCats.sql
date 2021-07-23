SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE  FUNCTION GetSubscribedLocCatsFromLocCats(@locCatCriteriaList VARCHAR(200), @subscribedLocCatTypeList VARCHAR(200))
RETURNS TABLE
AS
RETURN (select Subscribed.objectId from 
	(select objectId, lineage, name from locationcategory 
	where objectid in (select token from Split(@locCatCriteriaList, ','))) as RunFor,
	(select objectId, lineage, name from locationcategory
	where locationcategorytypeobjectid in (select token from Split(@subscribedLocCatTypeList, ','))) as Subscribed
	where
	  Subscribed.objectId = RunFor.objectId or
	  (Subscribed.lineage like '%/' + cast(RunFor.objectId as VARCHAR(10)) + '/%' OR
	   RunFor.lineage like '%/' + cast (Subscribed.objectId as VARCHAR(10)) + '/%'))
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
