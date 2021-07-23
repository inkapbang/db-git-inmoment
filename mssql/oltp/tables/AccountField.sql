CREATE TABLE [dbo].[AccountField] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [accountObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [textValue] [nvarchar](2000) NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_AccountField] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_AccountField_Account] ON [dbo].[AccountField] ([accountObjectId])
CREATE NONCLUSTERED INDEX [IX_AccountField_DataField] ON [dbo].[AccountField] ([dataFieldObjectId])

GO
