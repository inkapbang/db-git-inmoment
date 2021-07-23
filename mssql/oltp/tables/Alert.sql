CREATE TABLE [dbo].[Alert] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NULL,
   [name] [varchar](100) NOT NULL,
   [type] [int] NOT NULL,
   [labelObjectId] [int] NOT NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [Alert_name_org] UNIQUE NONCLUSTERED ([name], [organizationObjectId])
   ,CONSTRAINT [PK_Alert] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Alert_labelObjectId] ON [dbo].[Alert] ([labelObjectId])
CREATE NONCLUSTERED INDEX [IX_Alert_organizationObjectId] ON [dbo].[Alert] ([organizationObjectId])

GO
