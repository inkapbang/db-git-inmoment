CREATE TABLE [dbo].[Employee] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [locationObjectId] [int] NOT NULL,
   [employeeCode] [varchar](50) NOT NULL,
   [lastName] [varchar](100) NULL,
   [firstName] [varchar](100) NULL,
   [email] [varchar](50) NULL,
   [version] [int] NOT NULL
       DEFAULT (0),
   [vxml] [varchar](500) NULL

   ,CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_Employee_by_Location] ON [dbo].[Employee] ([locationObjectId])
CREATE UNIQUE NONCLUSTERED INDEX [IX_Employee_by_Location_employeeCode] ON [dbo].[Employee] ([locationObjectId], [employeeCode])
CREATE NONCLUSTERED INDEX [IX_Employee_locationObjectId] ON [dbo].[Employee] ([locationObjectId])
CREATE NONCLUSTERED INDEX [ix_Employee_locationObjectId2] ON [dbo].[Employee] ([locationObjectId]) INCLUDE ([objectId], [employeeCode], [lastName], [firstName], [email], [version], [vxml])

GO
