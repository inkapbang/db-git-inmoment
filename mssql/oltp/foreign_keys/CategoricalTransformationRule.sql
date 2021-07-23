ALTER TABLE [dbo].[CategoricalTransformationRule] WITH CHECK ADD CONSTRAINT [FK_CategoricalTransformationRule_DataFieldOption]
   FOREIGN KEY([dataFieldOptionObjectId]) REFERENCES [dbo].[DataFieldOption] ([objectId])

GO
ALTER TABLE [dbo].[CategoricalTransformationRule] WITH CHECK ADD CONSTRAINT [FK_CategoricalTransformationRule_DataField]
   FOREIGN KEY([transformationFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
