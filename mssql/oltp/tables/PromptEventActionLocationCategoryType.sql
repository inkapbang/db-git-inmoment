CREATE TABLE [dbo].[PromptEventActionLocationCategoryType] (
   [promptEventActionObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__PromptEv__BDE1DD42406E9557] PRIMARY KEY CLUSTERED ([promptEventActionObjectId], [locationCategoryTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PromptEventActionLocationCategoryType_locationCategoryType] ON [dbo].[PromptEventActionLocationCategoryType] ([locationCategoryTypeObjectId])

GO
