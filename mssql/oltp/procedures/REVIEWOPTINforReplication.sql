SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [dbo].[REVIEWOPTINforReplication]
as
--exec [dbo].[REVIEWOPTINforReplication]
DECLARE @message nvarchar (1000), @count bigint

select @count = COUNT(*) from SurveyResponse where reviewOptIn is null 
--and complete = 1 --remove on weekends 

WHILE @count > 50000
BEGIN
	set @message = 'Remaining '+cast(@count as varchar) + ' @ '+ CAST( GETDATE() as varchar)
	raiserror(@message,0,1) with NOWAIT
	update top(50000) SurveyResponse set reviewOptIn = 0 where reviewoptin is null
--	and complete = 1 --remove on weekends 
	select @count = COUNT(*) from SurveyResponse where reviewOptIn is null
--	and complete = 1 --remove on weekends 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
