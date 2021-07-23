ALTER TABLE [dbo].[AreaCodeTimeZoneLookup] WITH CHECK ADD CONSTRAINT [FK_AreaCodeTimeZoneLookup_TimeZoneIdentifier]
   FOREIGN KEY([timeZoneObjectId]) REFERENCES [dbo].[TimeZoneIdentifier] ([objectId])

GO
