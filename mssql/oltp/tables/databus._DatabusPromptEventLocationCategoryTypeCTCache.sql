CREATE TABLE [databus].[_DatabusPromptEventLocationCategoryTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventLocationCategoryTypeCTCache_promptEventObjectId_locationCategoryTypeObjectId] PRIMARY KEY CLUSTERED ([promptEventObjectId], [locationCategoryTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventLocationCategoryTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventLocationCategoryTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
