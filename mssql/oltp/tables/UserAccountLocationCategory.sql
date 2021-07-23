CREATE TABLE [dbo].[UserAccountLocationCategory] (
   [locationCategoryObjectId] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_UserAccountLocationCategory] PRIMARY KEY CLUSTERED ([locationCategoryObjectId], [userAccountObjectId])
)

CREATE NONCLUSTERED INDEX [IX_UserAccountLocationCategory_by_LocationCategory] ON [dbo].[UserAccountLocationCategory] ([locationCategoryObjectId])
CREATE NONCLUSTERED INDEX [IX_UserAccountLocationCategory_by_UserAccount] ON [dbo].[UserAccountLocationCategory] ([userAccountObjectId])

GO
