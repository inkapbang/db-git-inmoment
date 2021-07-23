SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE trigger [dbo].[PostalCodeAfterInsert] on [dbo].[PostalCode]
after insert
NOT FOR REPLICATION
as
begin
	update PostalCode set dtmfCode = dbo.StringToDTMFCode(postalCode)
	where objectId in (select objectId from INSERTED)
	and dtmfCode is null

	update PostalCode set isoCountryCode = case when len(postalCode)=5 then 'us'
												when len(postalCode)=7 then 'ca'
												else ''
											end
	where objectId in (select objectId from INSERTED)
	and isoCountryCode is null
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [dbo].[PostalCodeAfterInsert] ON [dbo].[PostalCode]
GO

GO
