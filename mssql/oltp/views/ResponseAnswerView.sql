SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE VIEW [dbo].[ResponseAnswerView]
AS
SELECT
	sr.objectId responseId,
	sr.beginDate,
	sr.complete,
	sr.offerObjectId offerId,

	--Offer
	o.channelObjectId channelId,
	
	-- Location
	sr.locationObjectId locationId,
	l.hidden,
	l.name,
	l.locationNumber,
	l.startDate,
	l.organizationObjectId organizationId,
	-- Response
	sr.beginTime,
	sr.beginDateUTC,
	sr.minutes,
	sr.surveyObjectId surveyId,
	sr.surveyGatewayObjectId gatewayId,
	sr.ani,
	sr.dateOfService,
	sr.redemptionCode,
	sr.loyaltyNumber,
	sr.cookieUID,
	sr.externalId,
	sr.IPAddress,
	sr.employeeCode,
	sr.instantAlertSent,
	sr.modeType,
	sr.exclusionReason,

	-- Response Answer
	sra.objectId answerId,
	sra.dataFieldObjectId answerFieldId,
	sra.dataFieldOptionObjectId answerCategoricalId,
	sra.numericValue answerNumeric,
	sra.textValue answerText,
	sra.dateValue answerDate,
	sra.booleanValue answerBoolean,
	sra.binaryContentObjectId answerBinaryId,
	sra.sequence answerSequence
FROM
	SurveyResponse sr
	JOIN Offer o
		ON o.objectId = sr.offerObjectId
	JOIN Location l
		ON l.objectId = sr.locationObjectId
	JOIN SurveyResponseAnswer sra
		ON sra.surveyResponseObjectId = sr.objectId
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
