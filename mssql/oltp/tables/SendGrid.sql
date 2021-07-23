CREATE TABLE [dbo].[SendGrid] (
   [ObjectId] [int] NOT NULL
      IDENTITY (1,1),
   [SGEventID] [nvarchar](200) NULL,
   [DateUTC] [datetime] NULL,
   [DateTimeUTC] [datetime] NULL,
   [SendgridEvent] [nvarchar](200) NULL,
   [Email] [nvarchar](200) NULL,
   [Ip] [nvarchar](200) NULL,
   [Timestamp] [nvarchar](200) NULL,
   [SmtpId] [nvarchar](200) NULL,
   [Response] [nvarchar](200) NULL,
   [Attempt] [nvarchar](200) NULL,
   [Useragent] [nvarchar](200) NULL,
   [Url] [nvarchar](200) NULL,
   [Reason] [nvarchar](200) NULL,
   [Status] [nvarchar](200) NULL,
   [Type] [nvarchar](200) NULL,
   [Category] [nvarchar](200) NULL,
   [IPAddress] [nvarchar](200) NULL,
   [CountryCode] [nvarchar](200) NULL,
   [CountryName] [nvarchar](200) NULL,
   [RegionCode] [nvarchar](200) NULL,
   [RegionName] [nvarchar](200) NULL,
   [City] [nvarchar](200) NULL,
   [ZipCode] [nvarchar](200) NULL,
   [TimeZone] [nvarchar](200) NULL,
   [Latitude] [nvarchar](200) NULL,
   [Longitude] [nvarchar](200) NULL,
   [MetroCode] [nvarchar](200) NULL
)


GO
