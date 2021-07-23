ALTER TABLE [dbo].[SurveyResponseAlert] WITH CHECK ADD CONSTRAINT [FK_SurveyResponseAlert_Alert]
   FOREIGN KEY([alertObjectId]) REFERENCES [dbo].[Alert] ([objectId])

GO
ALTER TABLE [dbo].[SurveyResponseAlert] WITH CHECK ADD CONSTRAINT [FK__SurveyRes__trigg__705F6C42]
   FOREIGN KEY([triggerDataFieldObjectId]) REFERENCES [dbo].[DataField] ([objectId])

GO
