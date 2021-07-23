CREATE TABLE [dbo].[ResponseNoteComment] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [responseNoteObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [comment] [nvarchar](1500) NOT NULL

   ,CONSTRAINT [PK__SurveyRe__6786D75916824B62] PRIMARY KEY CLUSTERED ([responseNoteObjectId], [localeKey])
)

CREATE NONCLUSTERED INDEX [IX_ResponseNoteComment_FK_SurveyResponseNoteComment_Locale] ON [dbo].[ResponseNoteComment] ([localeKey])
CREATE NONCLUSTERED INDEX [IX_ResponseNoteComment_responseNoteObjectId] ON [dbo].[ResponseNoteComment] ([responseNoteObjectId])

GO
