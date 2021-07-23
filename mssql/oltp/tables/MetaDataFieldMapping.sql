CREATE TABLE [dbo].[MetaDataFieldMapping] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [metaDataObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_MetaDataFieldMapping] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_MetaDataFieldMapping_ChannelMetaData] ON [dbo].[MetaDataFieldMapping] ([metaDataObjectId])
CREATE NONCLUSTERED INDEX [IX_MetaDataFieldMapping_DataField] ON [dbo].[MetaDataFieldMapping] ([dataFieldObjectId])

GO
