SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc usp_admin_showhierarchy2 
@root int
as
begin
--set nocount on
--select * from organization where name like 'McDonald''s'
--get root objectid  RUN THE FOLLOWING LINE
--select min(objectid) from locationcategory where organizationobjectid =444 and parentobjectid is null
--select * from locationcategory where organizationobjectid =569 and parentobjectid is null

	declare @objectid int,@name varchar(50)

	set @name=(select name from locationcategory where objectid=@root)
	print replicate('-',@@nestlevel*4)+@name

	set @objectid=(select min(objectid) from locationcategory where parentobjectid=@root)

	while @objectid is not null
	begin
		exec usp_admin_showhierarchy2 @objectid
		set @objectid=(select min(objectid) from locationcategory where parentobjectid=@root and objectid>@objectid)
	end
end--Proc

--exec usp_admin_showhierarchy2 14996
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
