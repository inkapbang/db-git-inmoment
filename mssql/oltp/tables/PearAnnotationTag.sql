CREATE TABLE [dbo].[PearAnnotationTag] (
   [pearModelObjectId] [int] NOT NULL,
   [annotation] [varchar](200) NOT NULL,
   [tagObjectId] [int] NOT NULL,
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [childPearModelObjectId] [int] NULL,
   [version] [int] NOT NULL
       DEFAULT ((0))

   ,CONSTRAINT [PK_PearAnnotationTag] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UC_PearAnnotationTag] UNIQUE NONCLUSTERED ([pearModelObjectId], [annotation], [tagObjectId], [childPearModelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PearAnnotationTag_Tag] ON [dbo].[PearAnnotationTag] ([tagObjectId])

GO
