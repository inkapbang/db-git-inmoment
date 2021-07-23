CREATE TABLE [databus].[_DatabusActionVoteCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [bigint] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusActionVoteCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusActionVoteCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusActionVoteCTCache] ([ctVersion], [ctSurrogateKey])

GO
