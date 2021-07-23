SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_KeyDriverRankByPriority](@modelId INT, @locationId INT, @locationCategoryId INT, @beginDate DATETIME, @endDate DATETIME, @contextDate DATETIME) 
RETURNS @PriorityRank TABLE (
  driverFieldObjectId INT, 
  responseCount INT, 
  avgScore FLOAT, 
  threshold FLOAT, 
  criticalThreshold FLOAT, 
  metThreshold BIT, 
  metCriticalThreshold BIT, 
  [priority] INT, 
  [rank] INT) 
AS 
BEGIN 
DECLARE @auditSourceId INT, @auditCount INT, @auditWeight FLOAT, @vocWeight FLOAT
SELECT @auditSourceId = strategy.auditResponseSourceObjectId,
       @auditCount = strategy.VocRangeNumOfAudits,
       @auditWeight = CAST(strategy.auditWeightPercent AS FLOAT)/100,
       @vocWeight = (100 - CAST(strategy.auditWeightPercent AS FLOAT))/100
FROM UpliftModel model
JOIN UpliftModelStrategy strategy ON strategy.objectId = model.upliftModelStrategyObjectId
WHERE model.objectId = @modelId;
  INSERT INTO @PriorityRank
  SELECT driverFieldObjectId,
         responseCount,
         avgScore,
         threshold,
         criticalThreshold,
         metThreshold,
         metCriticalThreshold,
         [priority],
         DENSE_RANK() OVER (
ORDER BY metCriticalThreshold, metThreshold, (CASE WHEN metThreshold = 1 THEN avgScore END), [priority]) AS [rank]
FROM
  (SELECT driverFieldObjectId,
          SUM(responseCount) AS responseCount,
          CASE
              WHEN count(driverFieldObjectId) = 1 THEN MAX(score)
              ELSE SUM(weightedScore)
          END AS avgScore,
          pa.priorityThreshold AS threshold,
          pa.criticalThreshold AS criticalThreshold,
          CASE
              WHEN (CASE WHEN count(driverFieldObjectId) = 1 THEN MAX(score) ELSE SUM(weightedScore) END) < pa.priorityThreshold THEN 0
              ELSE 1
          END AS metThreshold,
          CASE
              WHEN (CASE WHEN count(driverFieldObjectId) = 1 THEN MAX(score) ELSE SUM(weightedScore) END) < pa.criticalThreshold THEN 0
              ELSE 1
          END AS metCriticalThreshold,
          pa.sequence AS [priority]
   FROM (
           (SELECT driverFieldObjectId,
                   responseCount,
                   avgScore AS score,
                   avgScore * @vocWeight AS weightedScore
            FROM dbo.ufn_app_KeyDriverRankByAbsolutePerformance(@modelId, @locationId, @locationCategoryId, @beginDate, @endDate))
         UNION
           (SELECT driverFieldObjectId,
                   responseCount,
                   avgScore AS score,
                   avgScore * @auditWeight AS weightedScore
            FROM ufn_app_GetAuditScores(@locationId, @modelId, @auditSourceId, @beginDate, @endDate, @contextDate, @auditCount))) DATA
   INNER JOIN UpliftModelPerformanceAttribute pa ON pa.fieldObjectId = DATA.driverFieldObjectId
   AND pa.modelObjectId = @modelId
   GROUP BY driverFieldObjectId,
            pa.priorityThreshold,
            pa.criticalThreshold,
            pa.sequence) agg RETURN 
END 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
