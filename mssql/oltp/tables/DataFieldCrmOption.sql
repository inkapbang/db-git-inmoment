CREATE TABLE [dbo].[DataFieldCrmOption] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [dataFieldObjectId] [int] NULL,
   [sequence] [int] NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_DataFieldCrmOption] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_DataFieldCrmOption_Label] UNIQUE NONCLUSTERED ([labelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_DataFieldCrmOption_datafieldObjectId] ON [dbo].[DataFieldCrmOption] ([dataFieldObjectId])
CREATE NONCLUSTERED INDEX [IX_DataFieldCrmOption_labelObjectId] ON [dbo].[DataFieldCrmOption] ([labelObjectId])

GO
