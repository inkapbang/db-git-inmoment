CREATE TABLE [dbo].[ApiLimit] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [orgApiLimitObjectId] [int] NOT NULL,
   [readLimit] [int] NOT NULL,
   [readLimitOverride] [bit] NOT NULL,
   [createLimit] [int] NOT NULL,
   [createLimitOverride] [bit] NOT NULL,
   [updateLimit] [int] NOT NULL,
   [updateLimitOverride] [bit] NOT NULL,
   [apiType] [int] NOT NULL

   ,CONSTRAINT [PK_ApiLimit] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ApiLimit_OrganizationApiLimit] ON [dbo].[ApiLimit] ([orgApiLimitObjectId])

GO
