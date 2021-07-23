SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_mcd_GetLocationRegion]      (@locationId int)asbegin	   set nocount on   declare @myLocationId int   set @myLocationId=@locationId      -- define the special regions in a memory table   declare @pilotRegions table (regionId int)   insert @pilotRegions values(15942) -- PITTSBURGH REGION   insert @pilotRegions values(15940) -- ROCKY MOUNTAIN REGION   insert @pilotRegions values(15954) -- CHICAGO REGION   insert @pilotRegions values(15958) -- 15958   -- define the McDonalds region type id   declare @locCatTypeObjIdForMcDRegion int   declare @locCatTypeObjIdForMcDCountry int   set @locCatTypeObjIdForMcDRegion=1023   set @locCatTypeObjIdForMcDCountry=1003   -- determine the region the given location is assigned to   declare @regionId int   select @regionId = locationCategoryObjectId   from dbo.GetLocationLineage(@myLocationId)   where locationCategoryTypeObjectId=@locCatTypeObjIdForMcDRegion   	select 		(case when @regionId in (select regionId from @pilotRegions) then @regionId		      else (select distinct                  locationCategoryObjectId               from                  dbo.GetLocationLineage(@myLocationId)               where                  locationCategoryTypeObjectId=@locCatTypeObjIdForMcDCountry)		 end)end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
