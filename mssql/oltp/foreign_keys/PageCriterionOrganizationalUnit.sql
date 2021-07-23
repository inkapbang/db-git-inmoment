ALTER TABLE [dbo].[PageCriterionOrganizationalUnit] WITH CHECK ADD CONSTRAINT [FK_PageCriterionOrganizationalUnit_OrganizationalUnit]
   FOREIGN KEY([organizationalUnitObjectId]) REFERENCES [dbo].[OrganizationalUnit] ([objectId])

GO
ALTER TABLE [dbo].[PageCriterionOrganizationalUnit] WITH CHECK ADD CONSTRAINT [FK_PageCriterionOrganizationalUnit_PageCriterion]
   FOREIGN KEY([pageCriterionObjectId]) REFERENCES [dbo].[PageCriterion] ([objectId])

GO
