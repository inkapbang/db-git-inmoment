CREATE TABLE [dbo].[ImportDefault] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL,
   [timeZone] [varchar](50) NULL,
   [userPassword] [nvarchar](150) NULL,
   [userForcePassword] [bit] NOT NULL,
   [userLocaleKey] [varchar](25) NULL,
   [organizationObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_ImportDefault] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_ImportDefault_organizationObjectId] ON [dbo].[ImportDefault] ([organizationObjectId])

GO
