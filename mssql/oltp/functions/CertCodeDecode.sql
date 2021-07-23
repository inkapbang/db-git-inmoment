SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create function CertCodeDecode (@Certcode varchar(50), @organizationId int)
returns @results table (
	[Store] varchar(5)
	, [StoreAssociate] varchar(6)
	, [Cert] varchar(11)
	, [LocationObjectId] int
)
as
begin
	-- Created: 20170523
	-- Author: TAR
	-- Purpose: DBA-4391 - supports decode of CertCode values into Store, StoreAssociate and attempts the
	--		lookup of the associated LocationObjectId
	-- internalvars
	declare @store varchar(5), @storeAssociate varchar(6), @cert varchar(11), @locationId int

	select @store = case when len(@Certcode) = 29 then left(@CertCode, 5)
						when len(@Certcode) = 22 then '00' + left(@CertCode, 3)
						else null end
						
	select @storeAssociate = case when len(@Certcode) = 29 then substring(@Certcode, 21, 6)
								when len(@Certcode) = 22 then substring(@Certcode, 14, 6)
								else null end

	select @cert = @store + @storeAssociate

	if @cert is not null
	begin
		select @locationId = l.objectId
		from location (nolock) l
		where l.organizationObjectId = @organizationId
		and l.locationNumber = @store
	end

	-- outputs
	insert into @results
	select @store as Store, @storeAssociate as StoreAssociate, @cert as [Cert], @locationId as LocationObjectId

	return
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
