CREATE TABLE [dbo].[OfferSurvey] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [offerObjectId] [int] NOT NULL,
   [surveyObjectId] [int] NOT NULL,
   [audioOptionObjectId] [int] NULL,
   [frequencyWeight] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT (0)

   ,CONSTRAINT [PK_OfferSurvey] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OfferSurvey_audioOptionObjectId] ON [dbo].[OfferSurvey] ([audioOptionObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferSurvey_By_Offer] ON [dbo].[OfferSurvey] ([offerObjectId])
CREATE NONCLUSTERED INDEX [IX_OfferSurvey_surveyObjectId] ON [dbo].[OfferSurvey] ([surveyObjectId])

GO
