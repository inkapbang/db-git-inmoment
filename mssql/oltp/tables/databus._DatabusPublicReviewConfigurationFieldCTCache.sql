CREATE TABLE [databus].[_DatabusPublicReviewConfigurationFieldCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPublicReviewConfigurationFieldCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPublicReviewConfigurationFieldCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPublicReviewConfigurationFieldCTCache] ([ctVersion], [ctSurrogateKey])

GO
