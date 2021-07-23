CREATE TABLE [dbo].[AreaCodeTimeZoneLookup] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [timeZoneObjectId] [int] NOT NULL,
   [areaCode] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK__AreaCodeTimeZone__5BE901AA] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_TimeZone_AreaCode] UNIQUE NONCLUSTERED ([areaCode])
)

CREATE NONCLUSTERED INDEX [IX_AreaCodeTimeZoneLookup_timeZoneObjectId] ON [dbo].[AreaCodeTimeZoneLookup] ([timeZoneObjectId])

GO
