CREATE TABLE [dbo].[HubViewFilterDataFieldOption] (
   [hubViewFilterObjectId] [bigint] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HubViewFilterDataFieldOption] PRIMARY KEY CLUSTERED ([hubViewFilterObjectId], [dataFieldOptionObjectId])
)


GO
