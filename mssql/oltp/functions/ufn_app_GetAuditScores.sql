SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
	CREATE FUNCTION ufn_app_GetAuditScores(@locationId INT, @modelId INT, @auditSourceId INT, @beginDate DATETIME, @endDate DATETIME, @contextDate DATETIME, @count INT)

		RETURNS @AuditScore TABLE (
			driverFieldObjectId INT,
			responseCount INT,
			avgScore FLOAT)
		AS
		BEGIN
			DECLARE @responseIds TABLE (id int primary key)
			IF (@count IS NULL)
				INSERT INTO @responseIds
				SELECT objectId 
				FROM surveyResponse sr
				WHERE sr.beginDate BETWEEN @beginDate AND @endDate
					AND sr.responseSourceObjectId = @auditSourceId
					AND sr.locationObjectId = @locationId
					AND sr.exclusionReason = 0
					AND sr.complete = 1
				ORDER BY sr.beginDate DESC, sr.objectId DESC
			ELSE 
			BEGIN
				INSERT INTO @responseIds
				SELECT top (@count) objectId 
				FROM surveyResponse sr
				WHERE sr.beginDate <= @contextDate
					AND sr.responseSourceObjectId = @auditSourceId
					AND sr.locationObjectId = @locationId
					AND sr.exclusionReason = 0
					AND sr.complete = 1
				ORDER BY sr.beginDate DESC, sr.objectId DESC
			END
		
			INSERT INTO @AuditScore
				SELECT  
					driverFieldObjectId,
					count(driverFieldObjectId) AS responseCount,
					avg(score) AS avgScore
			FROM (
				SELECT 
					pa.fieldObjectId AS driverFieldObjectId,
					COALESCE(score.score, dfo.scorePoints, sra.numericValue) AS score
				FROM UpliftModelPerformanceAttribute pa
					LEFT JOIN SurveyResponseScore score 
						ON score.dataFieldObjectId = pa.auditFieldObjectId
							AND score.surveyResponseObjectId IN (SELECT id FROM @responseIds)
					LEFT JOIN SurveyResponseAnswer sra
						ON sra.dataFieldObjectId = pa.auditFieldObjectId
							AND sra.surveyResponseObjectId IN (SELECT id FROM @responseIds)
					LEFT JOIN DataFieldOption dfo
						ON dfo.objectId = sra.dataFieldOptionObjectId
				WHERE pa.modelObjectId = @modelId
			) data
			WHERE score IS NOT NULL
			GROUP BY driverFieldObjectId
		RETURN
		END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
