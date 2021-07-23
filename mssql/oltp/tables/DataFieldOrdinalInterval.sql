CREATE TABLE [dbo].[DataFieldOrdinalInterval] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [minValue] [float] NOT NULL,
   [maxValue] [float] NOT NULL,
   [ordinalLevel] [int] NOT NULL,
   [version] [int] NOT NULL,
   [dataFieldOrdinalModelObjectId] [int] NOT NULL

   ,CONSTRAINT [IX_DataFieldOrdinalInterval] UNIQUE CLUSTERED ([dataFieldOrdinalModelObjectId], [ordinalLevel])
   ,CONSTRAINT [PK_DataFieldOrdinalInterval] PRIMARY KEY NONCLUSTERED ([objectId])
)


GO
