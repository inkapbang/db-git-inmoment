CREATE TABLE [dbo].[PromptEventLocationCategoryType] (
   [promptEventObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PromptEventLocationCategoryType] PRIMARY KEY CLUSTERED ([promptEventObjectId], [locationCategoryTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventLocationCategoryType_locationCategoryTypeObjectId] ON [dbo].[PromptEventLocationCategoryType] ([locationCategoryTypeObjectId])

GO
