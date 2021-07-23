CREATE TABLE [dbo].[DataFieldGroup] (
   [dataFieldObjectId] [int] NOT NULL,
   [memberDataFieldObjectId] [int] NOT NULL,
   [sequence] [int] NULL,
   [insertOrder] [bigint] NOT NULL
      IDENTITY (1,1)

   ,CONSTRAINT [PK__DataFiel__62C36E315EE00C4F] PRIMARY KEY CLUSTERED ([dataFieldObjectId] DESC, [memberDataFieldObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldGroup_memberDataFieldObjectId] ON [dbo].[DataFieldGroup] ([memberDataFieldObjectId])

GO
