CREATE TABLE [databus].[_DatabusEmpathicaFieldOrdinalMappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [empathicaFieldDetailObjectId] [int] NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusEmpathicaFieldOrdinalMappingCTCache_empathicaFieldDetailObjectId_dataFieldOptionObjectId] PRIMARY KEY CLUSTERED ([empathicaFieldDetailObjectId], [dataFieldOptionObjectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusEmpathicaFieldOrdinalMappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusEmpathicaFieldOrdinalMappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
