CREATE TABLE [dbo].[AppFeature] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [featureType] [int] NOT NULL,
   [selectedOption] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_AppFeature] PRIMARY KEY CLUSTERED ([objectId])
)


GO
