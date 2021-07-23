ALTER TABLE [dbo].[surveyresponsescore] WITH CHECK ADD CONSTRAINT [FK__surveyres__dataF__4BF8522E]
   FOREIGN KEY([dataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
