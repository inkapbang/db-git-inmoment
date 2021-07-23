CREATE TABLE [dbo].[_MetaDataField] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [upliftModelObjectId] [int] NULL,
   [sequence] [int] NULL,
   [metaDataFieldType] [int] NOT NULL,
   [version] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL
)


GO
