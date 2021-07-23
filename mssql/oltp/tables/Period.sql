CREATE TABLE [dbo].[Period] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [userSelectable] [bit] NOT NULL,
   [count] [int] NOT NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [periodTypeObjectId] [int] NOT NULL,
   [nameObjectId] [int] NOT NULL,
   [offsetValue] [int] NOT NULL,
   [rolling] [bit] NULL

   ,CONSTRAINT [PK_Period] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_Period_name] UNIQUE NONCLUSTERED ([nameObjectId])
)

CREATE NONCLUSTERED INDEX [IX_Period_Organization_PeriodType] ON [dbo].[Period] ([organizationObjectId], [periodTypeObjectId]) INCLUDE ([nameObjectId])
CREATE NONCLUSTERED INDEX [IX_Period_PeriodType_Organization] ON [dbo].[Period] ([periodTypeObjectId], [organizationObjectId]) INCLUDE ([objectId], [nameObjectId], [offsetValue], [count])

GO
