CREATE TABLE [dbo].[PeriodType] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [type] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [labelObjectId] [int] NOT NULL,
   [name] [nvarchar](100) NULL,
   [supportsRolling] [bit] NULL

   ,CONSTRAINT [PK_PeriodType] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_PeriodType_label] UNIQUE NONCLUSTERED ([labelObjectId])
)


GO
