CREATE TABLE [dbo].[_1144ReportHierarchyMap] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [name] [nvarchar](100) NOT NULL,
   [labelId] [int] NOT NULL,
   [hierarchyObjectId] [int] NOT NULL,
   [includeLocations] [bit] NOT NULL,
   [version] [int] NOT NULL
)


GO
