CREATE TABLE [dbo].[DataFieldOption] (
   [objectId] [int] NOT NULL
      IDENTITY (100,1),
   [dataFieldObjectId] [int] NULL,
   [name] [varchar](200) NULL,
   [sequence] [int] NULL,
   [scorePoints] [float] NULL,
   [version] [int] NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [ordinalLevel] [int] NULL,
   [externalId] [varchar](255) NULL

   ,CONSTRAINT [PK_DataFieldOption] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_DataFieldOption_Label] UNIQUE NONCLUSTERED ([labelObjectId])
)

CREATE UNIQUE NONCLUSTERED INDEX [IX_DataFieldOption_by_DataField_id] ON [dbo].[DataFieldOption] ([dataFieldObjectId], [objectId]) INCLUDE ([labelObjectId], [scorePoints], [sequence], [name], [version], [ordinalLevel])

GO
