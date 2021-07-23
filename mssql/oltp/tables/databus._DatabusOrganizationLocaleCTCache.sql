CREATE TABLE [databus].[_DatabusOrganizationLocaleCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [localeKey] [varchar](25) NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationLocaleCTCache_organizationObjectId_localeKey] PRIMARY KEY CLUSTERED ([organizationObjectId], [localeKey])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationLocaleCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationLocaleCTCache] ([ctVersion], [ctSurrogateKey])

GO
