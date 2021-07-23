CREATE TABLE [dbo].[SsoFilteredIP] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [ip] [varchar](20) NOT NULL

   ,CONSTRAINT [PK_SsoFilteredIP] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_SsoFilteredIP_filteredIP] UNIQUE NONCLUSTERED ([ip])
)

CREATE NONCLUSTERED INDEX [IX_SsoFilteredIP_org_filteredIP] ON [dbo].[SsoFilteredIP] ([organizationObjectId], [ip])

GO
