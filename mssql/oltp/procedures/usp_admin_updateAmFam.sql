SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[usp_admin_updateAmFam]
@claimID char(11),
@correctadjuster varchar(15)
as
declare @offerobjid bigint, @locationObjectId bigint, @offerCode nvarchar(max)
declare @srObjectid bigint

set @srObjectId = (select srObjectid from v_surveys where datafieldobjectid =13541 and textvalue =@claimid)--claim id
select @offerobjid=offerObjectId, @locationObjectId=locationObjectId, @offerCode=offerCode from offercode where surveygatewayobjectid =649 and offercode = @correctadjuster--correct adjuster

--select @srObjectID,@Offercodeobjid,@correctadjuster,@claimID
update  surveyresponse set offerobjectid=@Offerobjid, locationObjectId=@locationObjectId, offerCode=@offerCode where objectid=@srObjectID

--exec dbo.usp_admin_updateAmFam @claimid='00181461790',@correctadjuster='180623'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
