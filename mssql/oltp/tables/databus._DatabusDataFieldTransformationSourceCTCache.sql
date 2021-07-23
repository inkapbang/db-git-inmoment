CREATE TABLE [databus].[_DatabusDataFieldTransformationSourceCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [dataFieldObjectId] [int] NOT NULL,
   [sourceDataFieldObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusDataFieldTransformationSourceCTCache_dataFieldObjectId_sourceDataFieldObjectId] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [sourceDataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusDataFieldTransformationSourceCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusDataFieldTransformationSourceCTCache] ([ctVersion], [ctSurrogateKey])

GO
