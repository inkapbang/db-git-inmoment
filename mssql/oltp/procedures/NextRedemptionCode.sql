SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[NextRedemptionCode] (@offerCodeObjectId int, @redemptionCode INT OUTPUT)
as
begin
	if (select count(*) from RedemptionCode with (nolock)where offerCodeObjectId = @offerCodeObjectId) = 0
		begin
			set @redemptionCode = 1000
			insert into RedemptionCode (offerCodeObjectId, redemptionCode, version)
			values (@offerCodeObjectId, 1000, 0)
		end
	else
		begin
			update RedemptionCode with (rowlock)
			set @redemptionCode = redemptionCode = (case when redemptionCode = 9999 then 1000 else redemptionCode + 1 end)
			where offerCodeObjectId = @offerCodeObjectId
		end
	return @redemptionCode
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
