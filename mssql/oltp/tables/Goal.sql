CREATE TABLE [dbo].[Goal] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [name] [varchar](50) NOT NULL,
   [description] [varchar](1000) NULL,
   [minPossible] [float] NOT NULL,
   [minTarget] [float] NOT NULL,
   [maxTarget] [float] NOT NULL,
   [maxPossible] [float] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT (0)

   ,CONSTRAINT [PK_Goal] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Goal_by_Organization] ON [dbo].[Goal] ([organizationObjectId])

GO
