SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create function dbo.GetMcDonaldsLocationsFromRegion (@locationCategoryId int)
    returns @locations table( locationId int )
as
begin

   declare @mylocationId int
   declare @mylocCatTypObjId int
   declare @locCatTypeObjIdForMcDRegion int
   declare @locCatTypeObjIdForMcDCountry int
   declare @orgId int
   
   set @locCatTypeObjIdForMcDRegion=1023
   set @locCatTypeObjIdForMcDCountry=1003
   select @orgId=569 -- McDonalds
   set @mylocationId=@locationCategoryId
   select @mylocCatTypObjId = LocationCategoryTypeObjectId from LocationCategory where objectId=@mylocationId
   
   if @locCatTypeObjIdForMcDCountry=@mylocCatTypObjId
   begin
      insert @locations
      select
         locationObjectId locationId
      from
         LocationCategoryLocation
      where
         locationCategoryObjectId in (
            select
               objectId
            from
               LocationCategory lc
            where
               lc.organizationObjectId=@orgId
               and lc.parentObjectId=@mylocationId
               and lc.LocationCategoryTypeObjectId=@locCatTypeObjIdForMcDRegion
         )                
   end
   
   
   if @locCatTypeObjIdForMcDRegion=@mylocCatTypObjId
   begin
      insert @locations select locationObjectId locationId from LocationCategoryLocation where locationCategoryObjectId=@mylocationId
   end

   return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
