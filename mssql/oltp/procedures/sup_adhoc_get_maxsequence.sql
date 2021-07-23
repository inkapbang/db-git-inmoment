SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc sup_adhoc_get_maxsequence
@srid bigint
as
select max(sequence) from surveyresponseanswer where surveyresponseobjectid=@srid
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
