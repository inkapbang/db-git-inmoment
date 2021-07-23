CREATE TABLE [dbo].[_ufmf56c] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [channelObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [icaModelObjectId] [int] NULL,
   [enableVoci] [bit] NOT NULL,
   [pearModelObjectId] [int] NULL,
   [vociLanguageModelObjectId] [int] NULL,
   [transcriptionConfidenceLevel] [tinyint] NULL,
   [oovListObjectId] [int] NULL,
   [sentimentFieldObjectId] [int] NULL,
   [tagSentimentEnabled] [bit] NOT NULL,
   [negativeSentimentThreshold] [real] NULL,
   [positiveSentimentThreshold] [real] NULL,
   [transcriptionConfidencePercentage] [float] NULL,
   [fieldSentimentWordCloudEnabled] [bit] NOT NULL,
   [useSoundAnnotations] [tinyint] NOT NULL,
   [sentimentPearObjectId] [int] NULL,
   [sentimentAnalysisMethod] [tinyint] NOT NULL,
   [wordCloudMethod] [tinyint] NOT NULL,
   [multilingual] [tinyint] NULL,
   [sentimentAnalysisMethod_Copy] [tinyint] NOT NULL,
   [autosentimentFieldObjectId] [int] NULL,
   [transcribeCustomLanguageModelObjectId] [int] NULL,
   [tagType] [int] NOT NULL,
   [sentimentModelId] [varchar](200) NULL,
   [sentimentModelVersion] [varchar](100) NULL
)


GO
