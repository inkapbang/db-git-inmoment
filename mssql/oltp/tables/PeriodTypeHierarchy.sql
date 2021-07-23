CREATE TABLE [dbo].[PeriodTypeHierarchy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [organizationObjectId] [int] NOT NULL,
   [name] [nvarchar](50) NOT NULL,
   [labelObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PeriodTypeHierarchy] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PeriodTypeHierarchy_label_LocalizedString] ON [dbo].[PeriodTypeHierarchy] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_PeriodTypeHierarchy_Organization] ON [dbo].[PeriodTypeHierarchy] ([organizationObjectId])

GO
