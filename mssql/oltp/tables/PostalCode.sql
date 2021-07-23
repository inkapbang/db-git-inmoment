CREATE TABLE [dbo].[PostalCode] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [isoCountryCode] [char](2) NULL,
   [postalCode] [varchar](10) NOT NULL,
   [postalCodeType] [char](1) NULL,
   [cityName] [varchar](255) NOT NULL,
   [cityType] [char](1) NOT NULL,
   [localeName] [varchar](255) NOT NULL,
   [localeAbbr] [char](2) NOT NULL,
   [areaCode] [int] NULL,
   [latitude] [float] NOT NULL,
   [longitude] [float] NOT NULL,
   [dtmfCode] [varchar](10) NULL

   ,CONSTRAINT [PK_PostalCode] PRIMARY KEY CLUSTERED ([objectId])
)

CREATE NONCLUSTERED INDEX [IX_PostalCode_by_Country_PostalCode] ON [dbo].[PostalCode] ([isoCountryCode], [postalCode], [cityType], [postalCodeType]) INCLUDE ([latitude], [longitude])
CREATE NONCLUSTERED INDEX [IX_PostalCode_by_dtmfCode] ON [dbo].[PostalCode] ([dtmfCode])
CREATE NONCLUSTERED INDEX [IX_PostalCode_by_Latitude_Longitude] ON [dbo].[PostalCode] ([latitude], [longitude], [cityType], [postalCodeType])
CREATE NONCLUSTERED INDEX [IX_PostalCode_by_PostalCode] ON [dbo].[PostalCode] ([postalCode]) INCLUDE ([postalCodeType], [cityType], [latitude], [longitude])

GO
