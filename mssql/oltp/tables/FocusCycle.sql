CREATE TABLE [dbo].[FocusCycle] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NULL,
   [organizationObjectId] [int] NOT NULL,
   [beginDate] [datetime] NOT NULL,
   [endDate] [datetime] NOT NULL

   ,CONSTRAINT [PK_FocusCycle] PRIMARY KEY CLUSTERED ([objectId])
)


GO
