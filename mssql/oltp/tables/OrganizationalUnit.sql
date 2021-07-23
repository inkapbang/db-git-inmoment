CREATE TABLE [dbo].[OrganizationalUnit] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [locationObjectId] [int] NULL,
   [locationCategoryObjectId] [int] NULL

   ,CONSTRAINT [PK_OrganizationalUnit] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [UX_OrganizationalUnit_Location_LocationCategory] ON [dbo].[OrganizationalUnit] ([locationObjectId], [locationCategoryObjectId]) INCLUDE ([version], [objectId])
CREATE UNIQUE NONCLUSTERED INDEX [UX_OrganizationalUnit_LocationCategory_Location] ON [dbo].[OrganizationalUnit] ([locationCategoryObjectId], [locationObjectId]) INCLUDE ([version])

GO
