SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC [dbo].[usp_cust_sprintAssignedcare]
@orgid INT,
@complete int,--1 is complete 0 is not
@begindt datetime,
@enddt datetime


AS
declare @res table(textvalue varchar(100),externalid varchar(25),srobjectid int)
declare @header varchar(100)
if @complete =1
	set @header='Completed surveys for '+cast(@begindt as varchar)+' to '+cast(@enddt as varchar)

else	
	set @header='Incomplete surveys for '+cast(@begindt as varchar)+' to '+cast(@enddt as varchar)



insert into @res(Textvalue,externalid,srobjectid)
select @header,Null,Null 

		insert into @res
        SELECT textvalue,externalid,objectid srobjectid

        FROM
               (SELECT sr.objectid,
                      externalid
               FROM   location l with (nolock)
                      JOIN surveyresponse sr with (nolock)
                      ON     l.objectid=sr.locationobjectid
               WHERE  l.organizationobjectid=@orgid
                  AND sr.complete           =@complete
                  AND sr.begindate BETWEEN @begindt AND @enddt
                  AND name NOT LIKE 'z%demo%'
               ) AS a
               LEFT OUTER JOIN
                      (SELECT surveyresponseobjectid,
                             textvalue
                      FROM   surveyresponseanswer with (nolock)
                      WHERE  datafieldobjectid=18913
                      ) AS b
               ON     a.objectid=b.surveyresponseobjectid

select * from @res
--                      --exec dbo.usp_cust_sprintAssignedcare 696, 0,'10/1/2008','11/1/2008'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
