ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK__Prompt__dataFiel__69B26EB3]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK_Prompt_EmailInformation]
   FOREIGN KEY([emailInformationObjectId]) REFERENCES [dbo].[EmailInformation] ([objectId])

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK_Prompt_Hierarchy]
   FOREIGN KEY([hierarchyObjectId]) REFERENCES [dbo].[Hierarchy] ([objectId])

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK_Prompt_Prompt]
   FOREIGN KEY([naOptionPromptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK_Prompt_Organization]
   FOREIGN KEY([organizationObjectId]) REFERENCES [dbo].[Organization] ([objectId])
   ON DELETE CASCADE

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK__Prompt__outputDa__0B13627E]
   FOREIGN KEY([outputDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK_Prompt_PromptHierarchyMap]
   FOREIGN KEY([promptHierarchyMapObjectId]) REFERENCES [dbo].[PromptHierarchyMap] ([objectId])

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK_Prompt_DataField_secondaryField]
   FOREIGN KEY([secondaryDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
ALTER TABLE [dbo].[Prompt] WITH CHECK ADD CONSTRAINT [FK_Prompt_SweepstakesInstantWinPromptConfig]
   FOREIGN KEY([sweepstakesInstantWinPromptConfigObjectId]) REFERENCES [dbo].[SweepstakesInstantWinPromptConfig] ([objectId])

GO
