SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE view tmp_respcount_20160614 as

select beginDateUTC,objectId,complete,exclusionReason,modeType,minutes 
from dbo.SurveyResponse with (nolock)
where	(beginDateUTC >= 'Jun 14, 2016' and beginDateUTC < 'Jun 15, 2016')
		and modeType = 2
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
