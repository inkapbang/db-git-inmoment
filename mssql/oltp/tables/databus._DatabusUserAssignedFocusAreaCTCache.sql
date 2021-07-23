CREATE TABLE [databus].[_DatabusUserAssignedFocusAreaCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusUserAssignedFocusAreaCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusUserAssignedFocusAreaCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusUserAssignedFocusAreaCTCache] ([ctVersion], [ctSurrogateKey])

GO
