SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_ClubCorpLastlogin]
as
-----------------
with mycte as(
select uac.objectid uacobjectid,uac.lastname,uac.firstname,uac.email,uac.lastlogin, uac.enabled uacenabled,
l.objectid lobjectid,l.name lname,l.locationnumber,
--lcl.*,
lc.objectid lcobjectid,lc.name lcname,lc.parentobjectid,lc.depth,lc.version
--into _tmp
from useraccount uac 
left outer join organizationuseraccount ouac
on uac.objectid =ouac.useraccountobjectid
left outer join useraccountlocation uacl
on uac.objectid=uacl.useraccountobjectid
left outer join location l
on l.objectid=uacl.locationobjectid 
left outer join locationcategorylocation lcl
on l.objectid=lcl.locationobjectid
join locationcategory lc
on lc.objectid=lcl.locationcategoryobjectid
join locationcategorytype lct
on lct.objectid=lc.locationcategorytypeobjectid
where ouac.organizationobjectid=613
and email not like '%@mshare.net'
and lct.objectid=1426
and uac.enabled=1

)

select 
firstname+' '+Lastname as name,email,lastlogin,lname,lcname as RVP from mycte order by RVP,email

--exec [dbo].[usp_cust_ClubCorpLastlogin]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
