CREATE TABLE [dbo].[GoRecommendText] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [phraseObjectId] [int] NOT NULL,
   [noThanksText] [nvarchar](200) NULL,
   [ghostText] [nvarchar](2000) NULL,
   [policyDescription] [nvarchar](max) NULL

   ,CONSTRAINT [PK_GoRecommendText] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_GoRecommendText_phraseObjectId] ON [dbo].[GoRecommendText] ([phraseObjectId])

GO
