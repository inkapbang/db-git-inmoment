CREATE TABLE [dbo].[PageScheduleSubscription] (
   [pageScheduleObjectId] [int] NOT NULL,
   [locationCategoryTypeObjectId] [int] NOT NULL

   ,CONSTRAINT [PK_PageScheduleSubscription] PRIMARY KEY CLUSTERED ([pageScheduleObjectId], [locationCategoryTypeObjectId])
)

CREATE NONCLUSTERED INDEX [IX_PageScheduleSubscription_locationCategoryTypeObjectId] ON [dbo].[PageScheduleSubscription] ([locationCategoryTypeObjectId])

GO
