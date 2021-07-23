SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[GetMcDonaldsCoLocations] (@locationId int)
    returns @coLocations table( name nvarchar(50), locationId int )
as
   /*  From McDonalds:
       If a restaurant is not in the Pittsburgh, Rocky Mountain or Chicago(US) or Atlantic Region(Canada),
       then the top and bottom 20% is based upon the total number of restaurants in that country.
       The ranking is based off the trailing 3 months activity.

       Pittsburgh: 15942
       Rocky Mountain: 15940
       Chicago: 15954
       Atlantic (Canada Region) : 15958
   */
   
begin
   --set nocount on

   declare @myLocationId int
   set @myLocationId=@locationId
   
   -- define the special regions in a memory table
   declare @pilotRegions table ( regionId int )
   insert @pilotRegions values(15942)
   insert @pilotRegions values(15940)
   insert @pilotRegions values(15954)
   insert @pilotRegions values(15958)

   -- define the McDonalds region type id
   declare @locCatTypeObjIdForMcDRegion int
   declare @locCatTypeObjIdForMcDCountry int
   set @locCatTypeObjIdForMcDRegion=1023
   set @locCatTypeObjIdForMcDCountry=1003

   -- determine the region the given location is assigned to
   declare @regionId int
   select @regionId = locationCategoryObjectId
   from dbo.GetLocationLineage(@myLocationId)
   where locationCategoryTypeObjectId=@locCatTypeObjIdForMcDRegion   

   -- check to see if we need to go nationally or if the region is ok
   if @regionId in (select regionId from @pilotRegions)
      begin
         -- locationId is in one of the pilot regions, so return the info on the other stores in the region
         insert @coLocations(name,locationId)
         select
            l.name,
            l.objectId
         from
            LocationCategoryLocation lcl inner join Location l on lcl.locationObjectId=l.objectId
            inner join LocationCategory lc on lc.objectId = lcl.locationCategoryObjectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
         where
            lcl.locationCategoryObjectId in (select locationCategoryObjectId from LocationCategoryLocation where locationObjectId=@myLocationId)
            and lc.locationCategoryTypeObjectId=@locCatTypeObjIdForMcDRegion
      end
   else
      begin
         -- locationId is not in a pilot region, so return the locationIds for the other stores in the country
         insert @coLocations(name,locationId)
         select
            l.name,
            l.objectId    
         from
            LocationCategoryLocation lcl
            inner join LocationCategory lc on lcl.locationCategoryObjectId=lc.objectId AND lc.snapshotFromLocationCategoryObjectId IS NULL
            inner join Location l on l.objectId=lcl.locationObjectId
            inner join (
               select distinct
                  locationCategoryObjectId
               from
                  dbo.GetLocationLineage(@myLocationId)
               where
                  locationCategoryTypeObjectId=@locCatTypeObjIdForMcDCountry
            ) t on t.locationCategoryObjectId=lc.parentObjectId 
      end
   return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
