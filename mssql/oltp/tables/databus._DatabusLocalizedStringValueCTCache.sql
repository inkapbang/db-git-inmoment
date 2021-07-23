CREATE TABLE [databus].[_DatabusLocalizedStringValueCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [localizedStringObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusLocalizedStringValueCTCache_localizedStringObjectId_localeKey] PRIMARY KEY CLUSTERED ([localizedStringObjectId], [localeKey])
)

CREATE NONCLUSTERED INDEX [IX__DatabusLocalizedStringValueCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusLocalizedStringValueCTCache] ([ctVersion], [ctSurrogateKey])

GO
