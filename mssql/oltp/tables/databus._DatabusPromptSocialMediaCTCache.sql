CREATE TABLE [databus].[_DatabusPromptSocialMediaCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptObjectId] [int] NOT NULL,
   [ordinal] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptSocialMediaCTCache_promptObjectId_ordinal] PRIMARY KEY CLUSTERED ([promptObjectId], [ordinal])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptSocialMediaCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptSocialMediaCTCache] ([ctVersion], [ctSurrogateKey])

GO
