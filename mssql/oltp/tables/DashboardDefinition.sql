CREATE TABLE [dbo].[DashboardDefinition] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [varchar](50) NOT NULL,
   [width] [int] NOT NULL,
   [height] [int] NOT NULL,
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NULL

   ,CONSTRAINT [PK_DashboardDefinition] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_DashboardDefinition_organizationObjectId] ON [dbo].[DashboardDefinition] ([organizationObjectId])

GO
