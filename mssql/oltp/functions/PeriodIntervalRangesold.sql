SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE function [dbo].[PeriodIntervalRangesold](@periodId int, @contextDate datetime, @localeKey nvarchar(20) = 'en_US') returns table as return
      with OtherRows as (
            select
                  row_number() over (order by r.beginDate) rowNum,
                  r.objectId rangeObjectId,
                  ---lst.[value] rangeLabel,
                                                                  (SELECT TOP 1 CAST(VALUE AS NVARCHAR(3000)) FROM dbo.ufn_app_LocalizedStringTable(r.labelObjectId, @localeKey)) [rangeLabel],
                  r.periodTypeObjectId periodTypeObjectId,
                  r.beginDate,
                  r.endDate,
                  p.objectId periodObjectId,
                  --p.[name] periodName,
                  (select TOP 1 cast(value as nvarchar(3000)) from dbo.ufn_app_LocalizedStringTable(p.nameObjectId,@localeKey)) [periodName],
                  p.[count] periodCount,
                  p.offsetValue periodOffset
            from
                  Period p
                  inner JOIN PeriodRange r
                                                                                                on r.periodTypeObjectId = p.periodTypeObjectId
                  --CROSS APPLY dbo.ufn_app_LocalizedStringTable(r.labelObjectId,@localeKey) lst 
            where
                  p.objectId = @periodId
      ),
      StartRow as (
            select
                  rowNum,
                  rangeObjectId,
                  rangeLabel,
                  periodTypeObjectId,
                  beginDate,
                  endDate,
                  periodObjectId,
                  periodName,
                  periodCount,
                  periodOffset
            from
                  OtherRows
            where
                  @contextDate between beginDate and endDate
      )
      select
            other.rowNum,
            other.rangeObjectId,
            other.rangeLabel,
            other.periodTypeObjectId,
            other.beginDate,
            other.endDate,
            other.periodObjectId,
            other.periodName
      from
            StartRow start
            JOIN OtherRows other
                                                                
	  ON (other.rowNum - start.rowNum) between ((other.periodCount - 1) * -1) + other.periodOffset and other.periodOffset
      --where
      --      (other.rowNum - start.rowNum) between ((other.periodCount - 1) * -1) + other.periodOffset and other.periodOffset

--
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
