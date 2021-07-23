CREATE TABLE [dbo].[HubViewFilter] (
   [objectId] [bigint] NOT NULL
      IDENTITY (1,1),
   [type] [int] NOT NULL,
   [hubViewObjectId] [int] NOT NULL,
   [name] [varchar](200) NULL,
   [sequence] [int] NOT NULL,
   [disable] [tinyint] NOT NULL,
   [dataFieldObjectId] [bigint] NULL,
   [responseCriterionObjectId] [bigint] NULL

   ,CONSTRAINT [PK_HubViewFilter] PRIMARY KEY CLUSTERED ([objectId])
)


GO
