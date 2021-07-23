CREATE TABLE [dbo].[UnstructuredFeedbackModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [channelObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [icaModelObjectId] [int] NULL,
   [enableVoci] [bit] NOT NULL
       DEFAULT ((0)),
   [pearModelObjectId] [int] NULL,
   [vociLanguageModelObjectId] [int] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL
       DEFAULT ((0)),
   [oovListObjectId] [int] NULL,
   [sentimentFieldObjectId] [int] NULL,
   [tagSentimentEnabled] [bit] NOT NULL
      CONSTRAINT [DF_UnstructuredFeedbackModel_tagSentimentEnabled] DEFAULT ((0)),
   [negativeSentimentThreshold] [real] NULL,
   [positiveSentimentThreshold] [real] NULL,
   [transcriptionConfidencePercentage] [float] NULL,
   [fieldSentimentWordCloudEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [useSoundAnnotations] [tinyint] NOT NULL,
   [sentimentPearObjectId] [int] NULL,
   [sentimentAnalysisMethod] [tinyint] NOT NULL
      CONSTRAINT [DefaultSentimentTypeConstraint] DEFAULT ((0)),
   [wordCloudMethod] [tinyint] NOT NULL
      CONSTRAINT [DefaultWordCloudMethodConstraint] DEFAULT ((0)),
   [multilingual] [tinyint] NULL,
   [sentimentAnalysisMethod_Copy] [tinyint] NOT NULL
      CONSTRAINT [df_sentimentAnalysisMethod_Copy] DEFAULT ((0)),
   [autosentimentFieldObjectId] [int] NULL,
   [transcribeCustomLanguageModelObjectId] [int] NULL,
   [tagType] [int] NOT NULL
       DEFAULT ((0)),
   [sentimentModelId] [varchar](200) NULL,
   [sentimentModelVersion] [varchar](100) NULL

   ,CONSTRAINT [PK_UnstructuredFeedbackModel] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UN_UnstructuredFeedbackModel_Name] UNIQUE NONCLUSTERED ([organizationObjectId], [name])
)

CREATE NONCLUSTERED INDEX [IX_UFM_by_OOVList] ON [dbo].[UnstructuredFeedbackModel] ([oovListObjectId])
CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackModel_autosentimentFieldObjectId] ON [dbo].[UnstructuredFeedbackModel] ([autosentimentFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackModel_channelObjectId] ON [dbo].[UnstructuredFeedbackModel] ([channelObjectId])
CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackModel_DataField] ON [dbo].[UnstructuredFeedbackModel] ([sentimentFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackModel_PearModel] ON [dbo].[UnstructuredFeedbackModel] ([pearModelObjectId])
CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackModel_SentimentPear] ON [dbo].[UnstructuredFeedbackModel] ([sentimentPearObjectId])
CREATE NONCLUSTERED INDEX [IX_UnstructuredFeedbackModel_transcribeCustomLanguageModelObjectId] ON [dbo].[UnstructuredFeedbackModel] ([transcribeCustomLanguageModelObjectId])

GO
