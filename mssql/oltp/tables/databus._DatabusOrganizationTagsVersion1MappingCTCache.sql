CREATE TABLE [databus].[_DatabusOrganizationTagsVersion1MappingCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [onTags1] [bit] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusOrganizationTagsVersion1MappingCTCache_organizationObjectId_onTags1] PRIMARY KEY CLUSTERED ([organizationObjectId], [onTags1])
)

CREATE NONCLUSTERED INDEX [IX__DatabusOrganizationTagsVersion1MappingCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusOrganizationTagsVersion1MappingCTCache] ([ctVersion], [ctSurrogateKey])

GO
