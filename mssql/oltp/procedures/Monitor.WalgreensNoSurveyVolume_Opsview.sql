SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--CREATE PROCEDURE sp_cust_wsvWalgreensCallCenterGateway_vDoctor
--CREATE PROCEDURE [dbo].[sp_cust_wsvWalgreensCallCenterGateway_vDoctor]

CREATE PROCEDURE Monitor.WalgreensNoSurveyVolume_Opsview
AS

-- This creates a between for last hour, even when it crosses midnight.
DECLARE @UtcDateTime		dateTime
		, @StartUtcDateTime dateTime
		, @EndUtcDateTime	dateTime
		--, @adjHour			int
		, @adjMinute		int
		, @adjSec			int
		, @adjMilsec		int



SET		@UtcDateTime		= ( SELECT GETUTCDATE() )
SET		@adjMinute			= DATEPART( Minute		, @UtcDateTime )
SET		@adjSec				= DATEPART( Second		, @UtcDateTime )
SET		@adjMilsec			= DATEPART( Millisecond	, @UtcDateTime )


SET		@EndUtcDateTime		= DATEADD( Minute, -(@adjMinute), DATEADD( Second, -(@adjSec),  DATEADD( Millisecond, -(@adjMilsec), @UtcDateTime ) ) )
SET		@StartUtcDateTime	= DATEADD( Hour, -1, @EndUtcDateTime )



DECLARE @SurveyVolume		int

SET		@SurveyVolume		= 
								(
									SELECT
											count(1)
																			
									FROM

											Mindshare.dbo.surveyResponse		t10					WITH (NOLOCK)
																			
									WHERE
											surveyGatewayObjectId = 3301		-- @sg
										AND 
											(
												t10.beginDateUTC	BETWEEN 
																			@StartUtcDateTime
																		AND 
																			@EndUtcDateTime
											)
										AND
											complete		= 1
										AND
											exclusionReason = 0
										AND
											modeType		= 1		-- Phone
								)

								
								
IF 	@SurveyVolume = 0
Select 'Current Survey Volume'+ cast(@SurveyVolume as varchar)+' |  ''Survey Volume''='+ cast(@SurveyVolume as varchar) as output, 2 as stateValue
ELSE
Select 'Current Survey Volume'+ cast(@SurveyVolume as varchar)+' |  ''Survey Volume''='+ cast(@SurveyVolume as varchar) as output, 0 as stateValue
								
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
