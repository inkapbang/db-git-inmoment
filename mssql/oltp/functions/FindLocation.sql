SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create function FindLocation(@orgId int, @locationNumber varchar(50), @offerId int, @gatewayId int)
returns int
as
begin
	declare @id int
	select @id = l.objectId from location l
	inner join offerCode oc on
		oc.locationObjectId = l.objectId and
		oc.offerObjectId = @offerId and
		oc.surveyGatewayObjectId = @gatewayId
	where
	l.organizationObjectId = @orgId and l.locationNumber = @locationNumber
	return @id
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
