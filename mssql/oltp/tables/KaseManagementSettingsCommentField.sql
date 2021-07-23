CREATE TABLE [dbo].[KaseManagementSettingsCommentField] (
   [kaseManagementSettingsObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL

   ,CONSTRAINT [PK_KaseManagementSettingsCommentField] PRIMARY KEY CLUSTERED ([kaseManagementSettingsObjectId], [dataFieldObjectId], [sequence])
)


GO
