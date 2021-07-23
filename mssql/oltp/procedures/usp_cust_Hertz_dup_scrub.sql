SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[usp_cust_Hertz_dup_scrub] as
--get survey and surveyrsponse data for last 30 days from hertz
select s.objectId sobjectid,
s.name,
s.description,
s.organizationObjectId,
s.version sversion,
sr.* 
into #tmp
from survey s with (nolock)join surveyresponse sr with (nolock)
on s.objectid =sr.surveyobjectid
where organizationobjectid =444
--where iscomplete
and sr.begindate >= dateadd(dd,-30,getdate())
--select * from #tmp
--select * from surveyresponse where loyaltynumber ='245848223' 
-------------------------
--get surveys from #tmp with a duplicate loyaltynumber 
--select * from offercode where objectid=349890
--drop table #tmp2
select loyaltyNumber,count(loyaltyNumber) as countofdups
into #tmp2
from #tmp
where complete=1
and not (offerCode='99999999' and offerObjectId=646 and locationObjectId=151248) --349890
and not (offerCode='99999997' and offerObjectId=827 and locationObjectId=297046) --855211
--the following filter is for employee surveys
and offerobjectid  in (
1803,
1783,
1785,
637,
646,
827
)
group by loyaltyNumber
having count(loyaltyNumber) >1
--chk 
--select * from #tmp2
--select * from surveyresponse where loyaltynumber ='582625643'
-------------------------------------
--update cursor
--get earliest sr.objecti
declare @LoyaltyNumber varchar(25)
declare @objectid bigint

declare mycursor cursor for 
select LoyaltyNumber from #tmp2

open mycursor
fetch next from mycursor into @LoyaltyNumber
while @@fetch_status =0
begin

--get srobjectid of min begintime dupe
set @objectid=(select objectid 
				from #tmp 
				where loyaltynumber=@loyaltynumber 
				and begindateutc=
					(select min(begindateutc) from #tmp where loyaltynumber=@loyaltynumber))

--select @loyaltynumber,@objectid,* 
--from surveyresponse 
--where loyaltynumber='@loyaltynumber'

--update all complete survyeresponses except @objectid to offercode 349890
update surveyresponse with(rowlock)
set offerCode='99999999', offerObjectId=646, locationObjectId=151248 --349890
where loyaltynumber =@loyaltynumber
and objectid != @objectid

fetch next from mycursor into @LoyaltyNumber
--select @loyaltynumber,@objectid
End
close mycursor
deallocate mycursor
--------------
--scrub for Hertz defined Rental numbers
--drop table #tmp3
select *
into #tmp3
from [dbo].[v_locOfferSurvResponseSRADatafield] with (nolock)
where lorgid =444
and begindate >= dateadd(dd,-30,getdate())
and dfobjectid in (12639,12634)
and not (offerCode='99999999' and offerObjectId=646 and lobjectid=151248)

SELECT distinct srobjectid into #tmp4 FROM #TMP3 WHERE textvalue IN (

'1843342',
'0055729',
'0079219',
'0103403',
'0500021',
'0500030',
'0501013',
'0511358',
'0518312',
'0518315',
'0537567',
'0540067',
'0548280',
'0551207',
'0567639',
'0569990',
'0569991',
'0572026',
'0575455',
'0600378',
'0604970',
'0605226',
'0605553',
'0609729',
'0614821',
'0615582',
'0625000',
'0649100',
'0658512',
'0668282',
'0669913',
'0669914',
'0669917',
'0673480',
'0680181',
'0680581',
'0680808',
'0698222',
'0698405',
'0698655',
'0698821',
'0699180',
'0716905',
'0737980',
'0738428',
'0791898',
'0807846',
'0822860',
'0823665',
'0832800',
'0840600',
'0855660',
'0857850',
'0858123',
'0858643',
'0860700',
'0920092',
'0924040',
'0926200',
'0968350',
'1119578',
'1346214',
'1346215',
'1346216',
'1346217',
'1459393',
'1760345',
'1760346',
'1843342')
--select * from #tmp4
update surveyresponse with (rowlock)
set offerCode='99999998', offerObjectId=646, locationObjectId=154269 --357112
where objectid in (select srobjectid from #tmp4)

drop table #tmp
drop table #tmp2
drop table #tmp3
drop table #tmp4


--exec [dbo].[usp_cust_Hertz_dup_scrub]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
