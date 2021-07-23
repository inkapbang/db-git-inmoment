CREATE TABLE [dbo].[MetaDataField] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [upliftModelObjectId] [int] NULL,
   [sequence] [int] NULL,
   [metaDataFieldType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_MetaDataField] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_MetaDataField_DataFieldObjectId] ON [dbo].[MetaDataField] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_MetaDataField_UpliftModelObjectId] ON [dbo].[MetaDataField] ([upliftModelObjectId])

GO
