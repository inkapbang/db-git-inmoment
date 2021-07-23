CREATE TABLE [dbo].[FocusUpliftModel] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [upliftModelObjectId] [int] NOT NULL,
   [locationAttributeObjectId] [int] NULL,
   [sequence] [int] NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK_FocusUpliftModel] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_FocusUpliftModel_UpliftModel] UNIQUE NONCLUSTERED ([upliftModelObjectId])
)

CREATE NONCLUSTERED INDEX [IX_FocusUpliftModel_locationAttributeObjectId] ON [dbo].[FocusUpliftModel] ([locationAttributeObjectId])

GO
