CREATE TABLE [dbo].[DataFieldTransformationSource] (
   [dataFieldObjectId] [int] NOT NULL,
   [sourceDataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NULL

   ,CONSTRAINT [PK_DataFieldTransformationSource] PRIMARY KEY CLUSTERED ([dataFieldObjectId], [sourceDataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldTransformationSource_sourceDataFieldObjectId] ON [dbo].[DataFieldTransformationSource] ([sourceDataFieldObjectId])

GO
