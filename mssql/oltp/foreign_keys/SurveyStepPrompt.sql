ALTER TABLE [dbo].[SurveyStepPrompt] WITH CHECK ADD CONSTRAINT [FK_SurveyStepPrompt_Prompt]
   FOREIGN KEY([promptObjectId]) REFERENCES [dbo].[Prompt] ([objectId])

GO
ALTER TABLE [dbo].[SurveyStepPrompt] WITH CHECK ADD CONSTRAINT [FK_SurveyStepPrompt_SurveyStep]
   FOREIGN KEY([surveyStepObjectId]) REFERENCES [dbo].[SurveyStep] ([objectId])

GO
