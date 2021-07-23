CREATE TABLE [dbo].[OrganizationalUnitTarget] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [organizationalUnitObjectId] [int] NOT NULL,
   [beginDate] [datetime] NULL,
   [endDate] [datetime] NULL,
   [upliftModelObjectId] [int] NOT NULL,
   [minValue] [int] NULL,
   [maxValue] [int] NULL,
   [dataFieldObjectId] [int] NULL

   ,CONSTRAINT [PK_ OrganizationalUnitTarget] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_OrganizationalUnitTarget_organizationalUnitObjectId_upliftModelObjectId_dataFieldObjectId_beginDate_endDate] ON [dbo].[OrganizationalUnitTarget] ([organizationalUnitObjectId], [upliftModelObjectId], [dataFieldObjectId], [beginDate], [endDate])

GO
