SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_app_KeyDriverRankByAbsolutePerformance2](
  @modelId                INT,
  @locationId             INT,
  @locationCategoryId     INT,
  @beginDate              DATETIME,
  @endDate                DATETIME,
  @includeHiddenLocations BIT)
  RETURNS @results TABLE(
    driverFieldObjectId INT,
    responseCount       INT,
    avgScore            FLOAT,
    peerRank            INT,
    peerCount           INT,
    driverPeerRank      INT,
    driverScoreRank     INT
  )
  -- Ranks a specified location within its peer group by absolute performance.  Returns the score
  -- for each driver, plus the relative rank within the peer group.
AS
  BEGIN
    DECLARE @aggregationType INT, @thresholdType INT, @minResponseCount INT, @feedbackChannelId INT, @scoreFieldId INT;
    SELECT
      @aggregationType = strategy.aggregationType,
      @thresholdType = strategy.thresholdType,
      @minResponseCount = strategy.minimumResponseCount,
      @feedbackChannelId = model.channelObjectId,
      @scoreFieldId = model.performanceIndicatorFieldObjectId
    FROM UpliftModel model
      JOIN UpliftModelStrategy strategy ON strategy.objectId = model.upliftModelStrategyObjectId
    WHERE model.objectId = @modelId;

    DECLARE @scoreFieldIdList INTLIST
    INSERT INTO @scoreFieldIdList SELECT @scoreFieldId val

    DECLARE @CategoryLocations INTLIST
    INSERT INTO @CategoryLocations
      SELECT cl.locationObjectId
      FROM dbo.GetCategoryLocations(@locationCategoryId) cl

    -- restructure: create table var with primary key to assist with join syntax in next step
    DECLARE @RecommendationScoresTableByLocation TABLE(
      locationObjectId       INT,
      surveyResponseObjectId INT PRIMARY KEY,
      dataFieldObjectId      INT,
      score                  INT,
      count                  INT)
    INSERT INTO @RecommendationScoresTableByLocation
      SELECT *
      FROM ufn_app_getRecommendationScoresTableByLocation(
          @modelId,
          @CategoryLocations,
          @beginDate,
          @endDate,
          @scoreFieldIdList
      )

    DECLARE @peers INTLIST

    IF @locationCategoryId IS NULL
      INSERT INTO @peers SELECT @locationId val
    ELSE
      DECLARE @responseThreshold INT = COALESCE(
          CASE WHEN @aggregationType = 2 AND @thresholdType IN (0, 2)
            THEN 0 ELSE @minResponseCount END, 0)

    IF @responseThreshold = 0
      INSERT INTO @peers
        SELECT cl.val
        FROM @CategoryLocations cl
          JOIN Location l ON l.objectId = cl.val AND (l.hidden = 0 OR @includeHiddenLocations = 1)
        GROUP BY cl.val
    ELSE
      INSERT INTO @peers
        SELECT cl.val
        FROM
          @CategoryLocations cl
          JOIN Location l
            ON l.objectId = cl.val AND (l.hidden = 0 OR @includeHiddenLocations = 1)
          JOIN SurveyResponse sr
            ON sr.locationObjectId = cl.val
          JOIN Offer o
            ON o.objectId = sr.offerObjectId
               AND channelObjectId = @feedbackChannelId
               AND sr.beginDate BETWEEN @beginDate AND @endDate
               AND sr.complete = 1
               AND sr.exclusionReason = 0
          -- 0 is no exclusion reason, i.e. no reason to be excluded from results
          -- restructure: remove embedded call to function with table var
          --JOIN ufn_app_getRecommendationScoresTableByLocation(@modelId, @CategoryLocations, @beginDate, @endDate, @scoreFieldIdList) srs
          JOIN
          @RecommendationScoresTableByLocation srs
            ON srs.surveyResponseObjectId = sr.objectId
        GROUP BY
          cl.val
        HAVING
          COUNT(sr.objectId) >= @responseThreshold

    DECLARE @peerCount INT
    SELECT @peerCount = count(val)
    FROM @peers


    DECLARE @driverFieldIds INTLIST
    INSERT INTO @driverFieldIds
      SELECT driver.fieldObjectId
      FROM UpliftModelPerformanceAttribute driver
      WHERE driver.modelObjectId = @modelId AND driver.attributeRole = 0

    INSERT INTO @results
      SELECT
        driverFieldId,
        responseCount,
        avgScore,
        peerRank,
        @peerCount,
        rank()
        OVER ( ORDER BY
          peerRank DESC )          driverPeerRank,
        rank()
        OVER ( ORDER BY avgScore ) driverScoreRank
      FROM (
             SELECT locationId, driverFieldId, responseCount, avgScore, rank()
                                                                        OVER ( PARTITION BY driverFieldId
                                                                          ORDER BY
                                                                            avgScore DESC ) peerRank
             FROM (
                    SELECT
                      locationId,
                      driverFieldId,
                      avg(score) AS avgScore,
                      count(1)   AS responseCount
                    FROM (
                           SELECT
                             answerDetail.locationId AS locationId,
                             driver.fieldObjectId    AS driverFieldId,
                             answerDetail.score      AS score
                           FROM
                             UpliftModelPerformanceAttribute driver
                             LEFT OUTER JOIN
                             (
                               SELECT
                                 r.responseId,
                                 r.locationId,
                                 r.answerFieldId,
                                 dfo.scorePoints score
                               FROM
                                 @peers peers
                                 JOIN
                                 ResponseAnswerView r
                                   ON r.locationId = peers.val
                                      AND r.beginDate BETWEEN @beginDate AND @endDate
                                      AND r.complete = 1
                                      AND r.channelId = @feedbackChannelId
                                      AND r.exclusionReason = 0
                                 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
                                 JOIN
                                 DataFieldOption dfo
                                   ON dfo.objectId = r.answerCategoricalId
                                 JOIN
                                     ufn_app_getRatingCounts(
                                         @peers,
                                         @feedbackChannelId,
                                         @beginDate,
                                         @endDate) rc
                                   ON rc.locationObjectId = r.locationId
                                      AND rc.dataFieldObjectId = r.answerFieldId
                                      AND
                                      rc.[count]
                                      >=
                                      COALESCE(
                                          CASE WHEN
                                            @aggregationType = 2
                                            AND
                                            @thresholdType IN (0, 2)
                                            THEN @minResponseCount ELSE 0 END,
                                          0)
                                 JOIN @driverFieldIds dfi ON dfi.val = rc.dataFieldObjectId
                               UNION
                               SELECT
                                 sr.objectId           responseId,
                                 sr.locationObjectId   locationId,
                                 srs.dataFieldObjectId fieldObjectId,
                                 srs.score
                               FROM
                                 @peers peers
                                 JOIN SurveyResponse sr
                                   ON sr.locationObjectId = peers.val
                                      AND sr.beginDate BETWEEN @beginDate AND @endDate
                                      AND sr.complete = 1
                                      AND sr.exclusionReason = 0
                                 -- 0 is no exclusion reason, i.e. no reason to be excluded from results
                                 JOIN
                                 Offer o
                                   ON
                                     o.objectId = sr.offerObjectId
                                     AND
                                     o.channelObjectId = @feedbackChannelId
                                 JOIN
                                     ufn_app_getRecommendationScoresTableByLocation(
                                         @modelId,
                                         @peers,
                                         @beginDate,
                                         @endDate,
                                         @driverFieldIds) srs
                                   ON srs.surveyResponseObjectId = sr.objectId
                                 JOIN @driverFieldIds dfi ON dfi.val = srs.dataFieldObjectId
                             ) answerDetail ON answerDetail.answerFieldId = driver.fieldObjectId
                                               AND driver.modelObjectId = @modelId
                                               AND driver.attributeRole = 0
                         ) AS detail
                    GROUP BY locationId, driverFieldId
                  ) Data
           ) ByLocation
      WHERE
        locationId = @locationId
      ORDER BY
        driverFieldId, peerRank
    RETURN
  END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
