CREATE TABLE [dbo].[PageDataField] (
   [pageObjectId] [int] NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__PageData__BB2042386E224FDF] PRIMARY KEY CLUSTERED ([pageObjectId], [dataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageDataField_dataFieldObjectId] ON [dbo].[PageDataField] ([dataFieldObjectId])

GO
