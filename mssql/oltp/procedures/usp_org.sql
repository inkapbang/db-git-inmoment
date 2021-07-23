SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure dbo.usp_org 
as

select objectid,name from organization
where enabled=1
and name not like 'z%'
order by name 

--exec dbo.usp_org 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
