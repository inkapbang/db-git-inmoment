CREATE TABLE [dbo].[HubViewLocationAttribute] (
   [hubViewObjectId] [int] NOT NULL,
   [locationAttributeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HubViewLocationAttribute] PRIMARY KEY CLUSTERED ([hubViewObjectId], [locationAttributeObjectId])
)


GO
