CREATE TABLE [dbo].[KaseCloseApplicableReportingFields] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [ordinal] [int] NOT NULL,
   [kaseManagementSettingsObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_KaseCloseApplicableReportingFields] PRIMARY KEY CLUSTERED ([objectId])
)


GO
