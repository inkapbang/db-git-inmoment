SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[ufn_app_KeyDriverFindRegression](@modelId int, @locationId int)
returns int
/*
	Find a set of regression parameters (intercepts and coefficents) for a given location and uplift model
*/
as
begin
	declare @id int
	select top 1
		@id = reg.objectId
	from
		LocationUpliftModelRegression locReg
		join UpliftModelRegression reg
			on locReg.regressionObjectId = reg.objectId
			and reg.modelObjectId = @modelId
	where
		locationObjectId = @locationId

	if @id is null
	begin
		select top 1
			@id = reg.objectId
		from
			LocationCategoryUpliftModelRegression lcReg
			join GetLocationLineage (@locationId) lc
				on lc.locationCategoryObjectId = lcReg.locationCategoryObjectId
			join UpliftModelRegression reg
				on lcReg.regressionObjectId = reg.objectId
				and reg.modelObjectId = @modelId
	end

	return @id
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
