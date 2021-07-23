CREATE TABLE [dbo].[DataFieldOrdinalModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](100) NOT NULL,
   [dataFieldObjectId] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [IX_DataFieldOrdinalModel] UNIQUE CLUSTERED ([dataFieldObjectId], [name])
   ,CONSTRAINT [PK_DataFieldOrdinalModel] PRIMARY KEY NONCLUSTERED ([objectId])
)


GO
