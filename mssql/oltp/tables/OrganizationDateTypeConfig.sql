CREATE TABLE [dbo].[OrganizationDateTypeConfig] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [dataFieldObjectId] [int] NULL,
   [enabled] [bit] NULL,
   [isDefaultConfig] [bit] NOT NULL,
   [localizedStringObjectId] [int] NULL

   ,CONSTRAINT [PK_OrganizationDateTypeConfig] PRIMARY KEY CLUSTERED ([objectId])
)


GO
