CREATE TABLE [dbo].[EmpathicaFieldOrdinalMapping] (
   [empathicaFieldDetailObjectId] [int] NOT NULL,
   [mapping] [varchar](100) NOT NULL,
   [dataFieldOptionObjectId] [int] NOT NULL

   ,CONSTRAINT [PK__Empathic__DEEB1F4B42CBAD4B] PRIMARY KEY NONCLUSTERED ([empathicaFieldDetailObjectId], [dataFieldOptionObjectId])
)


GO
