CREATE TABLE [dbo].[PageCriterionDeviceType] (
   [pageCriterionObjectId] [int] NOT NULL,
   [deviceType] [int] NOT NULL

   ,CONSTRAINT [PK_PageCriterionDeviceType] PRIMARY KEY CLUSTERED ([pageCriterionObjectId], [deviceType])
)


GO
