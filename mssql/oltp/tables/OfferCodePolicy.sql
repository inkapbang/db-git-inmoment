CREATE TABLE [dbo].[OfferCodePolicy] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [organizationObjectId] [int] NOT NULL,
   [version] [int] NOT NULL,
   [name] [varchar](100) NOT NULL,
   [apiKey] [varchar](100) NOT NULL

   ,CONSTRAINT [PK_OfferCodePolicy] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_OfferCodePolicy_apiKey_Org] UNIQUE NONCLUSTERED ([apiKey], [organizationObjectId])
   ,CONSTRAINT [UK_OfferCodePolicy_Name_Org] UNIQUE NONCLUSTERED ([name], [organizationObjectId])
)

CREATE NONCLUSTERED INDEX [IX_offercodePolicy_orgId] ON [dbo].[OfferCodePolicy] ([organizationObjectId])

GO
