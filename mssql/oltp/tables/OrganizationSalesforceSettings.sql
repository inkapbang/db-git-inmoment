CREATE TABLE [dbo].[OrganizationSalesforceSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [organizationObjectId] [int] NOT NULL,
   [salesforceId] [nvarchar](60) NULL,
   [billingCategory] [int] NULL,
   [lastModifiedTime] [datetime] NOT NULL
       DEFAULT (getdate())

   ,CONSTRAINT [PK_OrganizationSalesforceSettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UC_OrganizationSalesforceSettings] UNIQUE NONCLUSTERED ([organizationObjectId])
)


GO
