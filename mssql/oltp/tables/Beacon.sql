CREATE TABLE [dbo].[Beacon] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [name] [nvarchar](100) NOT NULL,
   [uuid] [nvarchar](36) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [locationObjectId] [int] NOT NULL,
   [majorId] [smallint] NOT NULL,
   [minorId] [smallint] NOT NULL,
   [enterBeaconActionObjectId] [int] NULL,
   [exitBeaconActionObjectId] [int] NULL

   ,CONSTRAINT [PK_Beacon] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Beacon_EnterBeaconAction] ON [dbo].[Beacon] ([enterBeaconActionObjectId])
CREATE NONCLUSTERED INDEX [IX_Beacon_ExitBeaconAction] ON [dbo].[Beacon] ([exitBeaconActionObjectId])
CREATE NONCLUSTERED INDEX [IX_Beacon_Location_Major_Minor] ON [dbo].[Beacon] ([locationObjectId], [majorId], [minorId]) INCLUDE ([objectId], [enterBeaconActionObjectId], [exitBeaconActionObjectId])
CREATE NONCLUSTERED INDEX [IX_Beacon_Organization] ON [dbo].[Beacon] ([organizationObjectId])

GO
