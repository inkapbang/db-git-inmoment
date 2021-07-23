CREATE TABLE [dbo].[TimeZoneIdentifier] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [timeZoneIndex] [int] NOT NULL,
   [timeZoneIdentifier] [varchar](255) NOT NULL,
   [version] [int] NOT NULL

   ,CONSTRAINT [PK__TimeZoneIdentifi__590C94FF] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UK_TimeZoneIndex] UNIQUE NONCLUSTERED ([timeZoneIndex])
)


GO
