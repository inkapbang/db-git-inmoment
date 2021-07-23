SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Import_Empathica_Recalc_Pizzahut]
@SurveyResponseObjectId int,
@dataFieldObjectId int,
@points float,
@pointsPossible float,
@score float,
@count int,
@totalWeight float,
@FlagVal char(5),
@objectId_Current bigint

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @error int,@rowcnt int

	if (@FlagVal = 'UPD' and @objectId_Current is not null)
	begin
		update surveyResponseScore
			set points = @points,
				pointsPossible = @pointsPossible,
				score = @score,
				[count] = @count,
				[version] = [version]+1,
				totalWeight = @totalWeight
		where	objectId = @objectId_Current
				and surveyResponseObjectId = @SurveyResponseObjectId 
				and dataFieldObjectId = @dataFieldObjectId
		select @error = @@error,@rowcnt = @@rowcount
	end
	else if (@FlagVal = 'INS' and @objectId_Current is null)
	begin
		insert into surveyResponseScore (surveyResponseObjectId,dataFieldObjectId,points,pointsPossible,score,[count],[version],totalWeight)
		values (@SurveyResponseObjectId,@dataFieldObjectId,@points,@pointsPossible,@score,@count,0,@totalWeight)
		select @error = @@error,@rowcnt = @@rowcount
	end

	print 'SRID: '+convert(varchar(100),@SurveyResponseObjectId)+' DFID: '+convert(varchar(100),@dataFieldObjectId)+' FLAG: '+@FlagVal+' Current OBJECTID: '+convert(varchar(100),@objectId_Current)+' ERROR: '+convert(varchar(10),@error)+' ROWCOUNT: '+convert(varchar(10),@rowcnt)


	if (@error = 0 and @rowcnt = 1) return 0 else return 1


END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
