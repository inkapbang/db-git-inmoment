CREATE TABLE [dbo].[PageCriterionOrganizationalUnit] (
   [pageCriterionObjectId] [int] NOT NULL,
   [organizationalUnitObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionOrganizationalUnit] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [organizationalUnitObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageCriterionOrganizationalUnit_OrganizationalUnit] ON [dbo].[PageCriterionOrganizationalUnit] ([organizationalUnitObjectId])

GO
