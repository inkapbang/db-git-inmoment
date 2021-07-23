SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_app_KeyDriverRankings2](
  @modelId                INT,
  @locationId             INT,
  @locationCategoryId     INT,
  @periodTypeId           INT,
  @intervalCount          INT,
  @intervalOffset         INT,
  @date                   DATETIME,
  @includeHiddenLocations BIT) AS BEGIN

  SET NOCOUNT ON
  DECLARE @currentPeriodBegin DATETIME, @currentPeriodEnd DATETIME, @previousPeriodBegin DATETIME, @previousPeriodEnd DATETIME
  SELECT
    @currentPeriodBegin = MAX(beginDate),
    @currentPeriodEnd = MAX(endDate),
    @previousPeriodBegin = MIN(beginDate),
    @previousPeriodEnd = MIN(endDate)
  FROM
      dbo.ufn_app_PeriodRangesByPeriodValues(
          @periodTypeId,
          @date,
          @intervalCount,
          @intervalOffset,
          2,
          default) -- ranges for current period and previous period

  DECLARE @strategyType INT
  SELECT @strategyType = strategyType
  FROM UpliftModel m
    JOIN UpliftModelStrategy st ON m.upliftModelStrategyObjectId = st.objectId
  WHERE m.objectId = @modelId;

  IF @strategyType = 1

    SELECT
      [current].driverFieldObjectId,
      [current].responseCount,
      [current].peerCount,
      [current].avgScore currentScore,
      [prev].avgScore    prevScore,
      [current].peerRank currentPeerRank,
      [prev].peerRank    prevPeerRank,
      [currOLR].olrRank  strategyRecommendationRank
    FROM
          dbo.ufn_app_KeyDriverRankByAbsolutePerformance2(
              @modelId,
              @locationId,
              @locationCategoryId,
              @currentPeriodBegin,
              @currentPeriodEnd,
              @includeHiddenLocations) [current]
      LEFT OUTER JOIN
          dbo.ufn_app_KeyDriverRankByAbsolutePerformance2(
              @modelId,
              @locationId,
              @locationCategoryId,
              @previousPeriodBegin,
              @previousPeriodEnd,
              @includeHiddenLocations) [prev]
        ON [prev].driverFieldObjectId = [current].driverFieldObjectId
      LEFT OUTER JOIN
          ufn_app_KeyDriverRankByOLR(
              @modelId,
              @locationId,
              @currentPeriodBegin,
              @currentPeriodEnd) currOLR
        ON [currOLR].driverFieldObjectId = [current].driverFieldObjectId
    ORDER BY
      strategyRecommendationRank

  ELSE IF @strategyType IN (2, 3)

    SELECT
      [current].driverFieldObjectId,
      [current].responseCount,
      [current].peerCount,
      [current].avgScore currentScore,
      [prev].avgScore    prevScore,
      [current].peerRank currentPeerRank,
      [prev].peerRank    prevPeerRank,
      CASE @strategyType
      WHEN 2
        THEN [current].driverPeerRank
      WHEN 3
        THEN [current].driverScoreRank
      END                strategyRecommendationRank
    FROM
          dbo.ufn_app_KeyDriverRankByAbsolutePerformance2(
              @modelId,
              @locationId,
              @locationCategoryId,
              @currentPeriodBegin,
              @currentPeriodEnd,
              @includeHiddenLocations) [current]
      LEFT OUTER JOIN
          dbo.ufn_app_KeyDriverRankByAbsolutePerformance2(
              @modelId,
              @locationId,
              @locationCategoryId,
              @previousPeriodBegin,
              @previousPeriodEnd,
              @includeHiddenLocations) [prev]
        ON [prev].driverFieldObjectId = [current].driverFieldObjectId
    ORDER BY
      strategyRecommendationRank

  ELSE IF @strategyType = 4
    SELECT
      driverFieldObjectId,
      responseCount,
      1      AS peerCount,
      avgScore  currentScore,
      NULL   AS prevScore,
      1      AS currentPeerRank,
      NULL   AS prevPeerRank,
      [rank] AS strategyRecommendationRank
    FROM
        dbo.ufn_app_KeyDriverRankByPriority(
            @modelId,
            @locationId,
            @locationCategoryId,
            @currentPeriodBegin,
            @currentPeriodEnd,
            @date)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
