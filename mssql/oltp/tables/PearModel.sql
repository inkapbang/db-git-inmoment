CREATE TABLE [dbo].[PearModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NULL,
   [pearObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [employeeNameAnnotation] [nvarchar](200) NULL,
   [tagType] [int] NOT NULL
       DEFAULT ((0)),
   [name] [varchar](200) NULL

   ,CONSTRAINT [PK_PearModel] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PearModel_Organization] ON [dbo].[PearModel] ([organizationObjectId])
CREATE NONCLUSTERED INDEX [IX_PearModel_Pear] ON [dbo].[PearModel] ([pearObjectId])

GO
