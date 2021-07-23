CREATE TABLE [dbo].[OrganizationApiLimit] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [responsesPerDay] [int] NOT NULL,
   [enabled] [bit] NOT NULL

   ,CONSTRAINT [PK_OrganizationApiLimit] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationApiLimit_Organization] ON [dbo].[OrganizationApiLimit] ([organizationObjectId])

GO
