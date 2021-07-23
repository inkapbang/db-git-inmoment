SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc dbo.usp_cust_arbyslocationCategoryswithoutlocations
as
select lct.name [level],lc.objectid lcobjectid,lc.name locationcategoryname
from locationcategory lc
left outer join locationcategorylocation lcl
on lc.objectid=lcl.locationcategoryobjectid
join locationcategorytype lct
on lct.objectid=lc.LocationCategoryTypeObjectId
where lc.organizationobjectid=537
and lcl.locationcategoryobjectid is null
and lc.locationcategorytypeobjectid in (
634,
635,
636,
637,
638
)
order by lct.name

--exec dbo.usp_cust_arbyslocationCategoryswithoutlocations
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
