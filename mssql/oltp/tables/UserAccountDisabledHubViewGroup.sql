CREATE TABLE [dbo].[UserAccountDisabledHubViewGroup] (
   [userAccountObjectId] [int] NOT NULL,
   [hubViewEnumValue] [int] NOT NULL

   ,CONSTRAINT [PK_UserAccountDisabledHubViewGroup] PRIMARY KEY CLUSTERED ([userAccountObjectId], [hubViewEnumValue])
)


GO
