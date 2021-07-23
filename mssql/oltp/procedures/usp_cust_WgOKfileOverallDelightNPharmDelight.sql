SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 CREATE procedure [dbo].[usp_cust_WgOKfileOverallDelightNPharmDelight] 
 @region varchar(30)
 as
 
   --exec dbo.usp_cust_WgOKfileOverallDelightNPharmDelight  @region='Eastern'
      --exec dbo.usp_cust_WgOKfileOverallDelightNPharmDelight  @region='WESTERN'
         --exec dbo.usp_cust_WgOKfileOverallDelightNPharmDelight  @region='MIDWEST'
            --exec dbo.usp_cust_WgOKfileOverallDelightNPharmDelight  @region='WESTERN'
            

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_WgOKfilesDat]') AND type in (N'U'))
DROP TABLE [dbo].[_WgOKfilesDat]


create table _WgOKfilesDat (score varchar(30))


declare @totalcount float, @totalscore float

---OverallDelight
set @totalcount=(select count(*) from _WG_RawDataOKfiles where expr_2=@region and expr_24 is not null)
print @totalcount
set @totalscore=( select sum(case(expr_24) when 9 then 100 else 0 end) from _WG_RawDataOKfiles where expr_2=@region and expr_24 is not null)
print @totalscore

insert into _WgOKfilesDat
select cast(@totalscore/@totalcount as varchar(30)) as score

--PharmDelightScore

set @totalcount=(select count(*) from _WG_RawDataOKfiles where expr_2=@region and expr_36 is not null)
print @totalcount
set @totalscore=( select sum(case(expr_36) when 9 then 100 else 0 end) from _WG_RawDataOKfiles where expr_2=@region and expr_36 is not null)
print @totalscore
insert into _WgOKfilesDat
select cast(@totalscore/@totalcount as varchar(30)) as score

--select expr_147,expr_24,* from _WG_RawDataOKfiles  where expr_2='Eastern' --and expr_147 is not null 
--order by surveyresponseobjectid
--select * from _WgOKfilesDat
--select (36900./486.)
return
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
