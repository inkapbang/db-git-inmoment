CREATE TABLE [dbo].[ImageAnalyticsSettings] (
   [objectId] [int] NOT NULL
      IDENTITY (1,1),
   [version] [int] NOT NULL
       DEFAULT ((0)),
   [organizationObjectId] [int] NOT NULL,
   [tagEnabled] [bit] NOT NULL
       DEFAULT ((1)),
   [faceEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [nlcEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [ocrEnabled] [bit] NOT NULL
       DEFAULT ((0)),
   [safeSearchAdultThreshold] [float] NOT NULL
       DEFAULT ((0.5)),
   [safeSearchMedicalThreshold] [float] NOT NULL
       DEFAULT ((1.5)),
   [safeSearchRacyThreshold] [float] NOT NULL
       DEFAULT ((1.5)),
   [safeSearchSpoofThreshold] [float] NOT NULL
       DEFAULT ((1.5)),
   [safeSearchViolenceThreshold] [float] NOT NULL
       DEFAULT ((0.5))

   ,CONSTRAINT [PK_ImageAnalyticsSettings] PRIMARY KEY CLUSTERED ([objectId])
   ,CONSTRAINT [UC_ImageAnalyticsSettings] UNIQUE NONCLUSTERED ([organizationObjectId])
)


GO
