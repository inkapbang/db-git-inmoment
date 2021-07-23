CREATE TABLE [dbo].[HubViewLocationCategoryType] (
   [hubViewObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_HubViewLocationCategoryType] PRIMARY KEY CLUSTERED ([hubViewObjectId], [locationCategoryTypeObjectId])
)


GO
