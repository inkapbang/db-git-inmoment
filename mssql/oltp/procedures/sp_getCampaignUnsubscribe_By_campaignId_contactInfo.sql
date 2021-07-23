SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
	
	CREATE PROCEDURE [dbo].[sp_getCampaignUnsubscribe_By_campaignId_contactInfo] 
		@campaignObjectId bigint,
		@contactInfo nvarchar(4000)
		
		
		AS
		
		DECLARE @campaignObjectId_P0 int, @contactInfo_P1 varchar(255)
	--	DECLARE @START_DT datetime,@END_DT datetime,@LOG_PIECE varchar(2000)

		--Capture Start Time and Parameters
	--	SELECT	@START_DT = GETDATE(),
	--			@LOG_PIECE = 'sp_getCampaignUnsubscribe_By_campaignId_contactInfo @campaignObjectId = '+convert(varchar(100),@campaignObjectId)+', @contactInfo = '+convert(varchar(1000),@contactInfo)


		SET @campaignObjectId_P0 = @campaignObjectId
		SET @contactInfo_P1 = @contactInfo
		
		SELECT	count(1) as cnt
		FROM	CampaignUnsubscribe
		WHERE	campaignObjectId = @campaignObjectId_P0 
				AND contactInfo = @contactInfo_P1
		

		--Capture End Time and INSERT INTO DBA_PerfMon
	--	SELECT @END_DT = GETDATE()
	--	INSERT INTO DBA_PerfMon VALUES (@LOG_PIECE,@START_DT,@END_DT)


		RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
