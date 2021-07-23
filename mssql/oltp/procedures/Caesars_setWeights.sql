SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[Caesars_setWeights]
(
	@fdt datetime = null
	, @tdt datetime = null
)

as

/*
	Usage: 

	exec Caesars_setWeights '20161212', '20161218'

*/

begin

  set nocount on

  declare @now datetime
  set @now = CAST(convert(varchar(10), getdate(), 112) as datetime)


	if (@fdt is null or @tdt is null)

	begin

		set @tdt= @now -  datepart(dw, @now) + 1
		set @fdt= @tdt - 6

	end



	if exists(select * from sys.tables where name = '__weight__') drop table __weight__
	if exists(select * from sys.tables where name = 'surveyMix') drop table surveyMix
	if exists(select * from sys.tables where name = '__weight_res') drop table __weight_res


	create table surveyMix(offerCode varchar(100), DIA int, GLD int, PLT int, SEV int, HSP int, SEV_DIA float, PLT_PLT float, GLD_HSP float)

	print '__weight__'


  select sr.objectid, sr.offercode, dfo.name 
	into __weight__
  from surveyresponse sr (nolock)
  join Location l (nolock) on sr.locationObjectId = l.objectId
  join surveyresponseanswer sra (nolock) on sr.objectid = sra.surveyresponseobjectid and sra.datafieldObjectId = 210126
  join datafield df (nolock) on sra.datafieldObjectId = df.objectId   
  join datafieldOption dfo (nolock) on df.objectId = dfo.dataFieldObjectId and sra.dataFieldOptionObjectId = dfo.objectId 

  where 1=1
  and sr.begindate between @fdt and @tdt
  and l.organizationOBjectid = 1700
  and sr.offerObjectId = 7999
  and sr.complete = 1
  and sr.exclusionReason = 0



	print 'surveyMix'


	insert surveyMix
	select offercode, [DIA], [GLD], [PLT], [SEV], [HSP], null, null, null
	from 
	(
	select * from  __weight__
	) as srv
	pivot 
	(
	count(objectid) for name in ([SEV], [DIA], [PLT], [GLD], [HSP])
        
	) as pvt;


	update surveyMix
	set
	[sev_dia] =  case when sev+dia = 0 then 0 else 0.3334/(1.0*(sev+dia)/(sev+dia+plt+hsp+gld)) end
	, [plt_plt] = case when plt = 0 then 0 else 0.3333/(1.0*(plt)/(sev+dia+plt+hsp+gld)) end
	, [gld_hsp] = case when gld+hsp = 0 then 0 else 0.3333/(1.0*(gld+hsp)/(sev+dia+plt+hsp+gld)) end 



	print '__Weight_res'

	select 
	ROW_NUMBER() over(order by objectid) 'id'
	, objectId as responseId
	, w.name
	, sm.*
	--, w.offerCode
	, case when name = 'dia' or name = 'sev'  then CAST (SEV_DIA as decimal(12, 8))
		when name = 'gld' or name = 'hsp' then CAST (gld_hsp as decimal(12, 8))
		when name = 'plt' then CAST (plt_plt as decimal(12, 8)) end as Weight_tier
	into __weight_res      
	from __weight__ w
	join surveyMix sm on w.offerCode = sm.offerCode
	order by objectId


end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
