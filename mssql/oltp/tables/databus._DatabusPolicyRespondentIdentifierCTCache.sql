CREATE TABLE [databus].[_DatabusPolicyRespondentIdentifierCTCache] (
   [ctSurrogateKey] [bigint] NOT NULL
      IDENTITY (1,1),
   [objectId] [int] NOT NULL,
   [ctVersion] [bigint] NOT NULL,
   [ctOperation] [nvarchar](1) NULL

   ,CONSTRAINT [PK__DatabusPolicyRespondentIdentifierCTCache_objectId] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX__DatabusPolicyRespondentIdentifierCTCache_by_ctVersion_ctSurrogateKey] ON [databus].[_DatabusPolicyRespondentIdentifierCTCache] ([ctVersion], [ctSurrogateKey])

GO
