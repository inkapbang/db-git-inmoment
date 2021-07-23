CREATE TABLE [dbo].[tmp_ikpbang_av_test] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [vote] [int] NOT NULL,
   [actionObjectId] [int] NOT NULL,
   [unitObjectId] [int] NULL,
   [version] [int] NOT NULL,
   [userAccountObjectId] [int] NOT NULL,
   [createdDateTime] [datetime] NOT NULL
)


GO
