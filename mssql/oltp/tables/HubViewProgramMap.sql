CREATE TABLE [dbo].[HubViewProgramMap] (
   [hubViewObjectId] [int] NOT NULL,
   [xiProgramId] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_HubViewID_XiProgramID] PRIMARY KEY CLUSTERED ([hubViewObjectId], [xiProgramId])
)

CREATE NONCLUSTERED INDEX [IX_HubViewProgramMap_hubViewObjectId] ON [dbo].[HubViewProgramMap] ([hubViewObjectId])

GO
