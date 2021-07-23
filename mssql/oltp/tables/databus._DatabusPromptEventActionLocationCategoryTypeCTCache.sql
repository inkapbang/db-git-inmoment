CREATE TABLE [databus].[_DatabusPromptEventActionLocationCategoryTypeCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [promptEventActionObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPromptEventActionLocationCategoryTypeCTCache_promptEventActionObjectId_locationCategoryTypeObjectId] PRIMARY KEY CLUSTERED ([promptEventActionObjectId], [locationCategoryTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPromptEventActionLocationCategoryTypeCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPromptEventActionLocationCategoryTypeCTCache] ([ctVersion], [ctSurrogateKey])

GO
