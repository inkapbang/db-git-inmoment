SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create Procedure [dbo].[usp_cust_McDExtractCounts110514]
as

--exec dbo.usp_cust_McDExtractCounts110514

declare @begindt datetime,@enddt datetime
set @begindt='10/1/2014'
set @enddt='11/1/2014'


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_tmpbob]') AND type in (N'U'))
DROP TABLE [dbo].[_tmpbob]

select distinct sra.objectid,sra.surveyresponseobjectid,sra.binarycontentobjectid,sra.numericvalue,sra.textvalue,sra.datevalue,sra.booleanvalue,sra.datafieldobjectid,sra.datafieldoptionobjectid,
df.name dfname--,dfo.name
into _tmpbob
from location l
join surveyresponse sr
on l.objectid=sr.locationobjectid
join surveyresponseanswer sra
on sr.objectid=sra.surveyresponseobjectid
join datafield df 
on df.objectid=sra.datafieldobjectid
--left outer join datafieldoption dfo
--on df.objectid=dfo.datafieldobjectid
--join localizedstringvalue lsv
--on lsv.localizedstringobjectid=df.reportlabelobjectid
where l.organizationobjectid=569
and begindate >=@begindt
and begindate < @enddt
--and l.enabled=1
and l.hidden=0
--and l.enabled=1
and sr.complete=1
and sr.offerobjectid in (1223,1222,2829)
and l.objectid in (
select locationobjectid 
from dbo.ufn_app_LocationsInCategoryOfType(1003) 
where locationcategoryobjectid=14999
and exclusionReason=0
)
----
---
--ifdupes, keep the max datafieldoptionobjectid
;with mycte2 (surveyresponseobjectid,datafieldobjectid,Ranking)
as
(
select surveyresponseobjectid,datafieldobjectid,
Ranking = DENSE_RANK() OVER(PARTITION BY surveyresponseobjectid,datafieldobjectid ORDER BY datafieldoptionobjectid desc)	
from _tmpbob
)
--select * from mycte2 where ranking >1 order by surveyresponseobjectid-- datafieldobjectid
delete from mycte2
where ranking>1
---

--select * from _tmpbob where datafieldobjectid=25791
--select datafieldoptionobjectid,count(datafieldoptionobjectid)from _tmpbob where datafieldobjectid=25791 group by datafieldoptionobjectid
;with mycte (surveyresponseobjectid,datafieldobjectid,Ranking)
as
(
select surveyresponseobjectid,datafieldobjectid,
Ranking = DENSE_RANK() OVER(PARTITION BY surveyresponseobjectid,datafieldobjectid ORDER BY NEWID() ASC)	
from _tmpbob
)
--select * from mycte where ranking >1 order by datafieldobjectid
delete from mycte
where ranking>1

---
--total answers
--select datafieldobjectid,dfname,count(dfname) as TotalAnswers 
--from #tmpbob 
----where datafieldobjectid=26979
--group by datafieldobjectid,dfname
--order by datafieldobjectid,dfname

----select * from #tmpBob
--answer detail

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_McDExtractCounts]') AND type in (N'U'))
DROP TABLE [dbo].[_McDExtractCounts]

create table _McDExtractCounts(
id int identity(1,1),
dfobjectid int,
dfname varchar(100),
totalanswers int,
dfoobjectid int,
dfoname varchar(100),
answercount int,
percentoftotal float
)
insert into _McDExtractCounts
(dfobjectid,dfname,totalanswers,dfoobjectid,dfoname,answercount)

select a.datafieldobjectid,dfname,totalanswers,b.datafieldoptionobjectid,dfoname,answercount 
from (
select datafieldobjectid,dfname,count(dfname) as TotalAnswers 
from _tmpbob 
--where datafieldobjectid=26979
group by datafieldobjectid,dfname
--order by datafieldobjectid,dfname
)as a
join 
(
select t.datafieldobjectid,t.datafieldoptionobjectid,dfo.name dfoname,count(t.datafieldoptionobjectid) as answercount
from _tmpbob t
join datafieldoption dfo
on dfo.objectid=t.datafieldoptionobjectid
--where datafieldobjectid=26979
group by t.datafieldobjectid,t.datafieldoptionobjectid,dfo.name
--order by t.datafieldobjectid,t.datafieldoptionobjectid,dfo.name
) as b 
on a.datafieldobjectid=b.datafieldobjectid
-----

--select * from _McDExtractCounts
--remove dupes
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_tmpbob2]') AND type in (N'U'))
DROP TABLE [dbo].[_tmpbob2]
create table _tmpbob2(dfobjectid int,counter int);

--insert into #tmpbob2
with bobcte as(
select surveyresponseobjectid ,datafieldobjectid ,count(datafieldobjectid) counter
from _tmpbob
group by surveyresponseobjectid,datafieldobjectid
having count(datafieldobjectid)>1
)
--select * from bobcte
insert into _tmpbob2
select datafieldobjectid,sum(counter) from bobcte group by datafieldobjectid
--select * from _tmpbob2

--update _McDextractCounts
--set totalanswers=m.totalanswers - (b2.counter-1)--,
----answercount=m.answercount-(b2.counter-1)
--from _McDextractCounts m join #tmpbob2 b2
--on m.dfobjectid=b2.dfobjectid

--exec dbo.usp_cust_McDExtractCounts2
--select * from _McDExtractCounts  order by dfname 

----ad hoc fixes
--update _McDextractCounts set answercount=answercount+1 
--where dfoobjectid in (69322,69323,69469,69437,69434,69436,69435)
--
--update _McDextractCounts set answercount=answercount+2 
--where dfoobjectid in (69431,69432)
--
--update _McDextractCounts set answercount=answercount+3 
--where dfoobjectid in (69433)
--
--update _McDextractCounts set answercount=answercount+4 
--where dfoobjectid in (69468)

--select * from _McDExtractCounts
update _McDExtractCounts set percentoftotal=(cast(answercount as float)/cast(totalanswers as float))*100.00

--answers that have uinary responses
insert into _McDExtractCounts(dfobjectid,dfname,totalanswers)
select datafieldobjectid,dfname,count(datafieldobjectid) as countofbinarycontentanswers
from _tmpbob where binarycontentobjectid is not null
group by datafieldobjectid,dfname

insert into _McDExtractCounts(dfobjectid,dfname,totalanswers)
select datafieldobjectid,dfname,count(datafieldobjectid) as countofnumericanswers
from _tmpbob where numericvalue is not null
group by datafieldobjectid,dfname

insert into _McDExtractCounts(dfobjectid,dfname,totalanswers)
select datafieldobjectid,dfname,count(datafieldobjectid) as countoftextvalueanswers
from _tmpbob where textvalue is not null
group by datafieldobjectid,dfname

insert into _McDExtractCounts(dfobjectid,dfname,totalanswers)
select datafieldobjectid,dfname,count(datafieldobjectid) as countofdatevalueanswers
from _tmpbob where datevalue is not null
group by datafieldobjectid,dfname

insert into _McDExtractCounts(dfobjectid,dfname,totalanswers)
select datafieldobjectid,dfname,count(datafieldobjectid) as countofbooleanvalueanswers
from _tmpbob where booleanvalue is not null
group by datafieldobjectid,dfname

--exec dbo.usp_cust_McDExtractCounts2
--select * from _McDExtractCounts  order by dfname ,id
--select * from _McDExtractCounts  order by dfoname 
--select dfname as QuestionName,totalanswers,dfoname as AnswerName,AnswerCount,PercentOfTotal from _McDExtractCounts

--select * from _McDExtractCounts where dfname like '%menu%'

--select * from _tmpbob
--select * from _tmpbob2
--select * from _McDExtractCounts  order by dfname 
-------------
----new find sr with duplicates
----select * from _tmpbob2
----
--select surveyresponseobjectid ,datafieldobjectid ,count(datafieldobjectid) counter
--from _tmpbob
--group by surveyresponseobjectid,datafieldobjectid
--having count(datafieldobjectid)>1
--order by datafieldobjectid
----------------
----check sra for explicit dup valuesvalues
--select * from surveyresponseanswer 
--where surveyresponseobjectid in (
--92859061,
--92558855,
--92882719
--)
--and datafieldobjectid  =12875
-----
----remove dupes
--select * into _tmpbob11 from _tmpbob
----chk for dupes
--select surveyresponseobjectid ,datafieldobjectid ,count(datafieldobjectid) counter
--from _tmpbob11
--group by surveyresponseobjectid,datafieldobjectid
--having count(datafieldobjectid)>1
--order by datafieldobjectid
--
-----
--;with mycte (surveyresponseobjectid,datafieldobjectid,Ranking)
--as
--(
--select surveyresponseobjectid,datafieldobjectid,
--Ranking = DENSE_RANK() OVER(PARTITION BY surveyresponseobjectid,datafieldobjectid ORDER BY NEWID() ASC)	
--from _tmpbob11
--)
----select * from mycte where ranking >1 order by datafieldobjectid
--delete from mycte
--where ranking>1
--
--
----
----
--select * from _McDExtractCounts where dfobjectid=
--12875

----
--select * from SurveyResponseAnswer where surveyResponseObjectId in (
--162305328,
--163125079,
--167166746,
--166107114,
--166486359,
--166953885,
--162210998,
--161688691,
--164857353,
--164780178,
--163130091,
--163602856,
--166226635,
--167375694,
--164621852,
--166118589,
--164177249,
--164060479
--)
--and dataFieldObjectId=25791
--and dataFieldOptionObjectId=69326
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
