CREATE TABLE [databus].[_DatabusFeedbackChannelCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusFeedbackChannelCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusFeedbackChannelCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusFeedbackChannelCTCache] ([ctVersion], [ctSurrogateKey])

GO
