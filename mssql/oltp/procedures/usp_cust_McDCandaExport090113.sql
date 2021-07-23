SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure [dbo].[usp_cust_McDCandaExport090113]
as

set nocount on
set fmtonly off
/* McDonaldsExportForAnalysis
Bob Luther 8/18/09
With exclustionreason added 05232012
*/
--exec [dbo].[usp_cust_McDCandaExport090113]

--select * from _mcdextract
/*
select COUNT(*) from _mcdextract where [AMDRPCW - Crispy or Grilled Chicken - Chicken Snac]='Crispy Chicken'--is not null
select COUNT(*) from _mcdextract where [AMDRPMBC - Crispy or Grilled - McBistro Chicken BL]='Crispy Chicken'--is not null
select COUNT(*) from _mcdextract where [AMDRPMC - Crispy or Grilled Chicken - Caesar Salad]='Crispy Chicken'--is not null
select COUNT(*) from _mcdextract where [AMDRPMSC - Crispy or Grilled - McBistro Southwest]='Crispy Chicken'--is not null
 select COUNT(*) from _mcdextract where[AMDRPMSM - Crispy or Grilled - McBistro Swiss Mush]='Crispy Chicken'--is not null
 select COUNT(*) from _mcdextract where[AMDRPST - Crispy or Grilled Chicken - Spicy Thai S]='Crispy Chicken'--is not null
select COUNT(*) from _mcdextract where[AMDRPTS - Crispy or Grilled Chicken - Tuscan Salad]='Crispy Chicken'--is not null

select * from _mcdextract where [AMDRPTMBC09 - The sandwich was not flavorful] is not null
select * from _mcdextract where [AMDRPTMSM12 - The sandwich was not flavorful] is not null
select * from _mcdextract where [AMDRPTMSC10 - The sandwich was not flavorful ] is not null
*/

declare @enddt datetime,@begindt datetime,@bcobjectid int

--set @enddt=(select DATEADD(dd, DATEDIFF(dd,0,getdate()), 0))
--set @begindt=dateadd(dd,-1,@enddt)
SET @begindt='8/1/2013 00:00:00'
SET @enddt='9/1/2013 00:00:00'


if OBJECT_ID(N'tempdb..#cat1003', N'U') IS NOT NULL drop table #cat1003; 
create table #cat1003 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1003

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1003) ;
--select * from #cat1003
if OBJECT_ID(N'tempdb..#cat997', N'U') IS NOT NULL drop table #cat997; 
create table #cat997 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat997 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(997) ;

--select * from #cat997
if OBJECT_ID(N'tempdb..#cat995', N'U') IS NOT NULL drop table #cat995; 
create table #cat995 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat995 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(995) ;

--select * from #cat995
if OBJECT_ID(N'tempdb..#cat996', N'U') IS NOT NULL drop table #cat996; 
create table #cat996 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat996 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(996) ;
if OBJECT_ID(N'tempdb..#cat998', N'U') IS NOT NULL drop table #cat998; 
create table #cat998 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat998 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(998) ;

if OBJECT_ID(N'tempdb..#cat1032', N'U') IS NOT NULL drop table #cat1032; 
create table #cat1032 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1032 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(8349) ;
--select * from #cat1032
if OBJECT_ID(N'tempdb..#cat1014', N'U') IS NOT NULL drop table #cat1014; 
create table #cat1014 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1014 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1014) ;

if OBJECT_ID(N'tempdb..#cat1008', N'U') IS NOT NULL drop table #cat1008; 
create table #cat1008 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1008 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1008) ;

if OBJECT_ID(N'tempdb..#cat1013', N'U') IS NOT NULL drop table #cat1013; 
create table #cat1013 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1013 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1013) ;

if OBJECT_ID(N'tempdb..#cat1007', N'U') IS NOT NULL drop table #cat1007; 
create table #cat1007 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1007 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1007) ;

if OBJECT_ID(N'tempdb..#cat1012', N'U') IS NOT NULL drop table #cat1012; 
create table #cat1012 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1012 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1012) ;

if OBJECT_ID(N'tempdb..#cat1006', N'U') IS NOT NULL drop table #cat1006; 
create table #cat1006 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1006 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1006) ;

if OBJECT_ID(N'tempdb..#cat1011', N'U') IS NOT NULL drop table #cat1011; 
create table #cat1011 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1011 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1011) ;

if OBJECT_ID(N'tempdb..#cat1005', N'U') IS NOT NULL drop table #cat1005; 
create table #cat1005 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1005 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1005) ;

if OBJECT_ID(N'tempdb..#cat1010', N'U') IS NOT NULL drop table #cat1010; 
create table #cat1010 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1010 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1010) ;
--
--if OBJECT_ID(N'tempdb..#cat887', N'U') IS NOT NULL drop table #cat887; 
--create table #cat887 (
--        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
--    );
--insert 
--    into
--        #cat887 
--
--select
--            locationObjectId,
--            locationCategoryObjectId,
--            locationCategoryName 
--        from
--            dbo.ufn_app_LocationsInCategoryOfType(887) ;
--
----select * from #cat887

if OBJECT_ID(N'tempdb..#cat886', N'U') IS NOT NULL drop table #cat886; 
create table #cat886 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat886 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(886) ;

if OBJECT_ID(N'tempdb..#cat1002', N'U') IS NOT NULL drop table #cat102; 
create table #cat1002 (
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat1002 

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(1002) ;
--select * from #cat997

if OBJECT_ID(N'tempdb..#cat3478', N'U') IS NOT NULL drop table #cat3478; 
create table #cat3478(
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat3478

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(3478) ;
--select * from #cat3478

if OBJECT_ID(N'tempdb..#cat3479', N'U') IS NOT NULL drop table #cat3479; 
create table #cat3479(
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat3479

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(3479) ;
--select * from #cat3479

if OBJECT_ID(N'tempdb..#cat3480', N'U') IS NOT NULL drop table #cat3480; 
create table #cat3480(
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat3480

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(3480) ;
--select * from #cat3480

if OBJECT_ID(N'tempdb..#cat3481', N'U') IS NOT NULL drop table #cat3481; 
create table #cat3481(
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat3481

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(3481) ;
--select * from #cat3481

if OBJECT_ID(N'tempdb..#cat3482', N'U') IS NOT NULL drop table #cat3482; 
create table #cat3482(
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat3482

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(3482) ;
--select * from #cat3482

if OBJECT_ID(N'tempdb..#cat3483', N'U') IS NOT NULL drop table #cat3483; 
create table #cat3483(
        locationObjectId int not null, locationCategoryObjectId int not null, locationCategoryName varchar(100) not null, primary key(locationObjectId, locationCategoryObjectId)
    );
insert 
    into
        #cat3483

select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(3483) ;
--select * from #cat3483


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_McDExtract]') AND type in (N'U'))
DROP TABLE [dbo].[_McDExtract]

select Surveyresponseobjectid,

--modetype,
--ani,

-- expr_0 as 'Date of Survey',
convert(varchar(11),expr_0,101)as 'Date of Survey',
--expr_1 as 'Date of Visit',
convert(varchar(11),expr_1,101)as 'Date of Visit',
cast(replace(expr_2,',','|') as varchar) as 'Restaurant',
--expr_4 as 'Time of Visit',
substring(convert(varchar(23),expr_4,114),1,5) as 'Time of Visit',
cast(expr_5 as varchar) as 'Amount Spent',
--cast(expr_6 as varchar) as 'Ordered Breakfast Menu',
'Ordered Breakfast Menu'=case expr_6 when 1 then 1 when 0 then 0 else Null end,
cast(expr_7 as varchar) as 'Menu Type (Web)',
cast(expr_8 as varchar) as 'How Dined',
cast(expr_9 as varchar) as 'Overall Sat',
cast(expr_10 as varchar) as 'Taste',
cast(expr_11 as varchar) as 'Temp',
cast(expr_12 as varchar) as 'Appear',
cast(expr_13 as varchar) as 'Speed',
cast(expr_14 as varchar) as 'Friendly',
cast(expr_15 as varchar) as 'Atten tive',
cast(expr_16 as varchar) as 'Accur Order',
cast(expr_17 as varchar) as 'Recd Cond',
cast(expr_18 as varchar) as 'Ext Clean',
cast(expr_19 as varchar) as 'Int Clean',
cast(expr_20 as varchar) as 'Rest room',
cast(expr_21 as varchar) as 'Satisfaction Reason',
--expr_22 as 'Comments',
--replace(dbo.udf_returnCommentsFromBC(expr_22),',','') as 'comments',
'comments' =
case modetype
when 2 then
replace(replace(replace(replace(replace(cast(dbo.udf_returnCommentsFromBC2(expr_22)as varchar(max)),'|',''),char(9),''),char(10),''),char(13),''),',','|') 
end,
cast(expr_23 as varchar) as 'Visited with Child Under 9',
cast(expr_24 as varchar) as 'Gender',
cast(expr_25 as varchar) as 'Receive Surveys, Promotions Email',
cast(expr_26 as varchar) as 'QSR Visited Most Recently',
cast(expr_27 as varchar) as 'How Compared to Previous Visit',
cast(expr_28 as varchar) as 'Recommend THIS McDonalds',
cast(expr_29 as varchar) as 'Visit THIS McDonalds More / Less',
cast(replace(expr_30,',','|') as varchar) as 'How Often Eat or Buy from McDonalds',
cast(replace(expr_31,',','|') as varchar) as 'How Often Eat or Buy from QSRs',
cast(expr_32 as varchar) as 'QSR Visit Most Often',
cast(expr_33 as varchar) as 'Favorite QSR',
isnull(cast(expr_34 as varchar),'') as 'AMCBS - Set - Ordered Specialty Coffee',
cast(expr_35 as varchar) as 'AMCBS03 - Cappuccino – Vanilla ',
cast(expr_36 as varchar) as 'AMCBS04 - Cappuccino – Caramel ',
cast(expr_37 as varchar) as 'AMCBS05 - Cappuccino – Plain',
cast(expr_38 as varchar) as 'AMCBS07 -  Latte – Vanilla ',
cast(expr_39 as varchar) as 'AMCBS08 - Latte – Caramel ',
cast(expr_40 as varchar) as 'AMCBS09 - Latte – Plain ',
cast(expr_41 as varchar) as 'AMCBS11 - Iced Latte – Vanilla ',
cast(expr_42 as varchar) as 'AMCBS12 - Iced Latte – Caramel ',
cast(expr_43 as varchar) as 'AMCBS12 - Iced Latte – Plain ',
cast(expr_44 as varchar) as 'AMDAB02 - The sandwich looked messy  ',
cast(expr_45 as varchar) as 'AMDAB03 - The bun was greasy  ',
cast(expr_46 as varchar) as 'AMDAB04 - The bun was crushed   ',
cast(expr_47 as varchar) as 'AMDAB05 - The condiments were leaking out of the s',
cast(expr_48 as varchar) as 'AMDAB06 - Other   ',
cast(expr_49 as varchar) as 'AMDAC02 - The cup wasn’t filled enough  ',
cast(expr_50 as varchar) as 'AMDAC03 - The cup was overfilled  ',
cast(expr_51 as varchar) as 'AMDAC04 - The lid wasn’t on properly  ',
cast(expr_52 as varchar) as 'AMDAC05 - It didn’t look good  ',
cast(expr_53 as varchar) as 'AMDAC06 - Other  ',
cast(expr_54 as varchar) as 'AMDAE02 - It didn’t have enough topping ',
cast(expr_55 as varchar) as 'AMDAE03 - It had too much topping ',
cast(expr_56 as varchar) as 'AMDAE04 - It was messy ',
cast(expr_57 as varchar) as 'AMDAE05 - It was runny / melted ',
cast(expr_58 as varchar) as 'AMDAE06 - Other ',
cast(expr_59 as varchar) as 'AMDAF02 - Box/bag wasn’t filled all the way ',
cast(expr_60 as varchar) as 'AMDAF03 - Too many small pieces ',
cast(expr_61 as varchar) as 'AMDAF04 - Didn’t look good ',
cast(expr_62 as varchar) as 'AMDAF05 - Other  ',
cast(expr_63 as varchar) as 'AMDAM0 - It was too flaky ',
cast(expr_64 as varchar) as 'AMDAM02 - It was burnt  ',
cast(expr_65 as varchar) as 'AMDAM03 - It was broken  ',
cast(expr_66 as varchar) as 'AMDAM04 - The filling was leaking out  ',
cast(expr_67 as varchar) as 'AMDAM05 - It had too much topping ',
cast(expr_68 as varchar) as 'AMDAM06 - Other ',
cast(expr_69 as varchar) as 'AMDAN02 - The cup wasn’t filled enough  ',
cast(expr_70 as varchar) as 'AMDAN03 - The cup was overfilled  ',
cast(expr_71 as varchar) as 'AMDAN04 - The lid wasn’t on properly  ',
cast(expr_72 as varchar) as 'AMDAN05 - It didn’t look good  ',
cast(expr_73 as varchar) as 'AMDAN06 - Other  ',
cast(expr_74 as varchar) as 'AMDAS02 - The lettuce was wilted ',
cast(expr_75 as varchar) as 'AMDAS03 - One or more ingredients had an off color',
cast(expr_76 as varchar) as 'AMDAS04 - It had a messy appearance ',
cast(expr_77 as varchar) as 'AMDAS05 - The lid was not on properly ',
cast(expr_78 as varchar) as 'AMDAS06 - The salad container wasn’t filled enough',
cast(expr_79 as varchar) as 'AMDAS07 - Other ',
cast(expr_80 as varchar) as 'AMDAU02 - It looked burnt ',
cast(expr_81 as varchar) as 'AMDAU03 - It was broken ',
cast(expr_82 as varchar) as 'AMDAU04 - The paper stuck to the muffin ',
cast(expr_83 as varchar) as 'AMDAU05 - Other ',
cast(expr_84 as varchar) as 'AMDCE03 - Drive Thru area wasn’t clean ',
cast(expr_85 as varchar) as 'AMDCE04 - Parking lot hadn’t been cleared of trash',
cast(expr_86 as varchar) as 'AMDCE05 - Other   ',
cast(expr_87 as varchar) as 'AMDCE06 - Nothing was wrong',
cast(expr_88 as varchar) as 'AMDCE2 - Trash cans were overflowing ',
cast(expr_89 as varchar) as 'AMDCI02 - Tables and/or floors were dirty ',
cast(expr_90 as varchar) as 'AMDCI03 - Trash cans were overflowing ',
cast(expr_91 as varchar) as 'AMDCI04 - Play place was dirty ',
cast(expr_92 as varchar) as 'AMDCI05 - Drink station was dirty ',
cast(expr_93 as varchar) as 'AMDCI06 - Kitchen area was dirty ',
cast(expr_94 as varchar) as 'AMDCI07 - Other  ',
cast(expr_95 as varchar) as 'AMDCI08 - Nothing was wrong',
cast(expr_96 as varchar) as 'AMDCR02 - Toilets were dirty  ',
cast(expr_97 as varchar) as 'AMDCR03 - Sink area was dirty ',
cast(expr_98 as varchar) as 'AMDCR04 - Soap or hand dryer wasn’t working or ava',
cast(expr_99 as varchar) as 'AMDCR05 - Trash cans were overflowing  ',
cast(expr_100 as varchar) as 'AMDCR06 - Unpleasant Odor ',
cast(expr_101 as varchar) as 'AMDCR07 - Other  ',
cast(expr_102 as varchar) as 'AMDCR08 - Nothing was wrong',
cast(expr_103 as varchar) as 'AMDF02 - Employee was rude or unprofessional ',
cast(expr_104 as varchar) as 'AMDF03 - I wasn’t greeted politely  ',
cast(expr_105 as varchar) as 'AMDF04 - I wasn’t thanked for my order   ',
cast(expr_106 as varchar) as 'AMDF05 - I felt rushed  ',
cast(expr_107 as varchar) as 'AMDF06 - Other ',
cast(expr_108 as varchar) as 'AMDF07 - Nothing was wrong',
cast(expr_109 as varchar) as 'AMDN02 - Missing or incorrect condiments  ',
cast(expr_110 as varchar) as 'AMDN03 - Missing salad dressing  ',
cast(expr_111 as varchar) as 'AMDN04 - Missing napkins  ',
cast(expr_112 as varchar) as 'AMDN05 - Missing straw   ',
cast(expr_113 as varchar) as 'AMDN06 - Missing utensils  ',
cast(expr_114 as varchar) as 'AMDN07 - Missing Happy Meal toy   ',
cast(expr_115 as varchar) as 'AMDN08 - Received the wrong change   ',
cast(expr_116 as varchar) as 'AMDN09 - Other ',
cast(expr_117 as varchar) as 'AMDN10 - Missing or incorrect condiments  ',
cast(expr_118 as varchar) as 'AMDN11 - Missing salad dressing  ',
cast(expr_119 as varchar) as 'AMDN12 - Missing or unavailable napkins  ',
cast(expr_120 as varchar) as 'AMDN13 - Missing or unavailable straw   ',
cast(expr_121 as varchar) as 'AMDN14 - Missing or unavailable Utensils  ',
cast(expr_122 as varchar) as 'AMDN15 - Missing Happy Meal toy   ',
cast(expr_123 as varchar) as 'AMDN16 - Received the wrong change   ',
cast(expr_124 as varchar) as 'AMDN17 - Other ',
cast(expr_125 as varchar) as 'AMDPA - Nothing was wrong',
cast(expr_126 as varchar) as 'AMDPAB02 - Double Cheeseburger ',
cast(expr_127 as varchar) as 'AMDPAB03 - Big Mac / Double Big Mac   ',
cast(expr_128 as varchar) as 'AMDPAB04 - Hamburger / Cheeseburger   ',
cast(expr_129 as varchar) as 'AMDPAB05 - Quarter Pounder with Cheese / Double Qu',
cast(expr_130 as varchar) as 'AMDPAB06 - McDouble / Bacon Cheeseburger   ',
cast(expr_131 as varchar) as 'AMDPAB07 - Angus Burger   ',
cast(expr_132 as varchar) as 'AMDPAB08 - Mac Snack Wrap   ',
cast(expr_133 as varchar) as 'AMDPAB09 - Other   ',
cast(expr_134 as varchar) as 'AMDPAC02 - Jr. Chicken Sandwich ',
cast(expr_135 as varchar) as 'AMDPAC03 - McChicken ',
cast(expr_136 as varchar) as 'AMDPAC04 - McNuggets ',
cast(expr_137 as varchar) as 'AMDPAC05 - Chicken Snack Wrap ',
cast(expr_138 as varchar) as 'AMDPAC06 - Filet-o-Fish ',
cast(expr_139 as varchar) as 'AMDPAC07 - Chicken Classic Sandwich ',
cast(expr_140 as varchar) as 'AMDPAC08 - Southwest Chicken Sandwich ',
cast(expr_141 as varchar) as 'AMDPAC09 - Chicken Fajita ',
cast(expr_142 as varchar) as 'AMDPAC10 - Other ',
cast(expr_143 as varchar) as 'AMDPAD02 - Muffin ',
cast(expr_144 as varchar) as 'AMDPAD03 - Cone/Sundae ',
cast(expr_145 as varchar) as 'AMDPAD04 - Pie ',
cast(expr_146 as varchar) as 'AMDPAD05 - Cinnamon Melts',
cast(expr_147 as varchar) as 'AMDPAD06 - McFlurry ',
cast(expr_148 as varchar) as 'AMDPAD07 - Fruit & Yogurt Parfait ',
cast(expr_149 as varchar) as 'AMDPAD08 - Apple Slices ',
cast(expr_150 as varchar) as 'AMDPAD09 - Other ',
cast(expr_151 as varchar) as 'AMDPAF02 - Regular or Decaf coffee  ',
cast(expr_152 as varchar) as 'AMDPAF04 - Latte  ',
cast(expr_153 as varchar) as 'AMDPAF05A - Hot Tea ',
cast(expr_154 as varchar) as 'AMDPAF06 - Mocha  ',
cast(expr_155 as varchar) as 'AMDPAF08 - Cappuccino  ',
cast(expr_156 as varchar) as 'AMDPAF09 - Espresso ',
cast(expr_157 as varchar) as 'AMDPAF10 - Other  ',
cast(expr_158 as varchar) as 'AMDPAH02 - Hamburger / Cheeseburger ',
cast(expr_159 as varchar) as 'AMDPAH03 - McNuggets ',
cast(expr_160 as varchar) as 'AMDPAH04 - Other Main Item',
cast(expr_161 as varchar) as 'AMDPAH05 - French Fries ',
cast(expr_162 as varchar) as 'AMDPAH05 - French Fries HM',
cast(expr_163 as varchar) as 'AMDPAH06 - Apple Slices ',
cast(expr_164 as varchar) as 'AMDPAH07 - Other Side Item',
cast(expr_165 as varchar) as 'AMDPAI01 - French Fries',
cast(expr_166 as varchar) as 'AMDPAMB0 - Coffee(s) ',
cast(expr_167 as varchar) as 'AMDPAMB02 - Hash Browns',
cast(expr_168 as varchar) as 'AMDPAMB03 - Egg McMuffin(s)  ',
cast(expr_169 as varchar) as 'AMDPAMB04 - Sausage McMuffin(s) ',
cast(expr_170 as varchar) as 'AMDPAMB05 - Bagel Sandwich(s) ',
cast(expr_171 as varchar) as 'AMDPAMB06 - Breakfast Burrito(s) ',
cast(expr_172 as varchar) as 'AMDPAMB07 - McGriddle Sandwich(s) ',
cast(expr_173 as varchar) as 'AMDPAMB08 - Breakfast Platter(s) ',
cast(expr_174 as varchar) as 'AMDPAMB10 - Other drink(s) ',
cast(expr_175 as varchar) as 'AMDPAMB11 - Other  ',
cast(expr_176 as varchar) as 'AMDPAN02 - Fountain Soft Drink ',
cast(expr_177 as varchar) as 'AMDPAN03 - Iced Coffee  ',
cast(expr_178 as varchar) as 'AMDPAN03 - Juice ',
cast(expr_179 as varchar) as 'AMDPAN04 - Milk ',
cast(expr_180 as varchar) as 'AMDPAN05 - Iced Latte  ',
cast(expr_181 as varchar) as 'AMDPAN05 - Iced Tea ',
cast(expr_182 as varchar) as 'AMDPAN06 - Shake ',
cast(expr_183 as varchar) as 'AMDPAN07 - Bottled Water ',
cast(expr_184 as varchar) as 'AMDPAN07 - Iced Mocha  ',
cast(expr_185 as varchar) as 'AMDPAN08 - Other ',
cast(expr_186 as varchar) as 'AMDPAS02 - Spicy Thai Salad ',
cast(expr_187 as varchar) as 'AMDPAS03 - Mediterranean Salad ',
cast(expr_188 as varchar) as 'AMDPAS04 - Mighty Ceasar Salad ',
cast(expr_189 as varchar) as 'AMDPAS05 - Garden Fresh Salad ',
cast(expr_190 as varchar) as 'AMDPAS06 - Side Salad  ',
cast(expr_191 as varchar) as 'AMDPAS07 - Other ',
cast(expr_192 as varchar) as 'AMDPAZ01 - Other Item',
cast(expr_193 as varchar) as 'AMDPT - Nothing was wrong',
cast(expr_194 as varchar) as 'AMDPTB02 - Double Cheeseburger ',
cast(expr_195 as varchar) as 'AMDPTB03 - Big Mac / Double Big Mac   ',
cast(expr_196 as varchar) as 'AMDPTB04 - Hamburger / Cheeseburger   ',
cast(expr_197 as varchar) as 'AMDPTB05 - Quarter Pounder with Cheese / Double Qu',
cast(expr_198 as varchar) as 'AMDPTB06 - McDouble / Bacon Cheeseburger   ',
cast(expr_199 as varchar) as 'AMDPTB07 - Angus Burger   ',
cast(expr_200 as varchar) as 'AMDPTB08 - Mac Snack Wrap   ',
cast(expr_201 as varchar) as 'AMDPTB09 - Other   ',
cast(expr_202 as varchar) as 'AMDPTC02 - Jr. Chicken Sandwich ',
cast(expr_203 as varchar) as 'AMDPTC03 - McChicken ',
cast(expr_204 as varchar) as 'AMDPTC04 - McNuggets ',
cast(expr_205 as varchar) as 'AMDPTC05 - Chicken Snack Wrap ',
cast(expr_206 as varchar) as 'AMDPTC06 - Filet-o-Fish ',
cast(expr_207 as varchar) as 'AMDPTC07 - Chicken Classic Sandwich ',
cast(expr_208 as varchar) as 'AMDPTC08 - Southwest Chicken Sandwich ',
cast(expr_209 as varchar) as 'AMDPTC09 - Chicken Fajita ',
cast(expr_210 as varchar) as 'AMDPTC10 - Other ',
cast(expr_211 as varchar) as 'AMDPTD02 - Muffin ',
cast(expr_212 as varchar) as 'AMDPTD03 - Cone/Sundae ',
cast(expr_213 as varchar) as 'AMDPTD04 - Pie ',
cast(expr_214 as varchar) as 'AMDPTD05 - Cinnamon Melts',
cast(expr_215 as varchar) as 'AMDPTD06 - McFlurry ',
cast(expr_216 as varchar) as 'AMDPTD07 - Fruit & Yogurt Parfait ',
cast(expr_217 as varchar) as 'AMDPTD08 - Apple Slices ',
cast(expr_218 as varchar) as 'AMDPTD09 - Other ',
cast(expr_219 as varchar) as 'AMDPTF02 - Regular or Decaf coffee  ',
cast(expr_220 as varchar) as 'AMDPTF04 - Latte  ',
cast(expr_221 as varchar) as 'AMDPTF05A - Hot Tea ',
cast(expr_222 as varchar) as 'AMDPTF06 - Mocha  ',
cast(expr_223 as varchar) as 'AMDPTF08 - Cappuccino  ',
cast(expr_224 as varchar) as 'AMDPTF09 - Espresso ',
cast(expr_225 as varchar) as 'AMDPTF10 - Other  ',
cast(expr_226 as varchar) as 'AMDPTH02 - Hamburger / Cheeseburger ',
cast(expr_227 as varchar) as 'AMDPTH03 - McNuggets ',
cast(expr_228 as varchar) as 'AMDPTH04 - Other Main Item',
cast(expr_229 as varchar) as 'AMDPTH05 - French Fries ',
cast(expr_230 as varchar) as 'AMDPTH05 - French Fries HM',
cast(expr_231 as varchar) as 'AMDPTH06 - Apple Slices ',
cast(expr_232 as varchar) as 'AMDPTH07 - Other Side Item',
cast(expr_233 as varchar) as 'AMDPTI01 - French Fries',
cast(expr_234 as varchar) as 'AMDPTMB0 - Coffee(s) ',
cast(expr_235 as varchar) as 'AMDPTMB02 - Hash Browns',
cast(expr_236 as varchar) as 'AMDPTMB03 - Egg McMuffin(s)  ',
cast(expr_237 as varchar) as 'AMDPTMB04 - Sausage McMuffin(s) ',
cast(expr_238 as varchar) as 'AMDPTMB05 - Bagel Sandwich(s) ',
cast(expr_239 as varchar) as 'AMDPTMB06 - Breakfast Burrito(s) ',
cast(expr_240 as varchar) as 'AMDPTMB07 - McGriddle Sandwich(s) ',
cast(expr_241 as varchar) as 'AMDPTMB08 - Breakfast Platter(s) ',
cast(expr_242 as varchar) as 'AMDPTMB10 - Other drink(s) ',
cast(expr_243 as varchar) as 'AMDPTMB11 - Other  ',
cast(expr_244 as varchar) as 'AMDPTN02 - Fountain Soft Drink ',
cast(expr_245 as varchar) as 'AMDPTN03 - Iced Coffee  ',
cast(expr_246 as varchar) as 'AMDPTN03 - Juice ',
cast(expr_247 as varchar) as 'AMDPTN04 - Milk ',
cast(expr_248 as varchar) as 'AMDPTN05 - Iced Latte  ',
cast(expr_249 as varchar) as 'AMDPTN05 - Iced Tea ',
cast(expr_250 as varchar) as 'AMDPTN06 - Shake ',
cast(expr_251 as varchar) as 'AMDPTN07 - Bottled Water ',
cast(expr_252 as varchar) as 'AMDPTN07 - Iced Mocha  ',
cast(expr_253 as varchar) as 'AMDPTN08 - Other ',
cast(expr_254 as varchar) as 'AMDPTS02 - Spicy Thai Salad ',
cast(expr_255 as varchar) as 'AMDPTS03 - Mediterranean Salad ',
cast(expr_256 as varchar) as 'AMDPTS04 - Mighty Ceasar Salad ',
cast(expr_257 as varchar) as 'AMDPTS05 - Garden Fresh Salad ',
cast(expr_258 as varchar) as 'AMDPTS06 - Side Salad  ',
cast(expr_259 as varchar) as 'AMDPTS07 - Other ',
cast(expr_260 as varchar) as 'AMDPTZ01 - Other Item',
cast(expr_261 as varchar) as 'AMDPU - Nothing was wrong',
cast(expr_262 as varchar) as 'AMDPUB02 - Double Cheeseburger ',
cast(expr_263 as varchar) as 'AMDPUB03 - Big Mac / Double Big Mac   ',
cast(expr_264 as varchar) as 'AMDPUB04 - Hamburger / Cheeseburger   ',
cast(expr_265 as varchar) as 'AMDPUB05 - Quarter Pounder with Cheese / Double Qu',
cast(expr_266 as varchar) as 'AMDPUB06 - McDouble / Bacon Cheeseburger   ',
cast(expr_267 as varchar) as 'AMDPUB07 - Angus Burger   ',
cast(expr_268 as varchar) as 'AMDPUB08 - Mac Snack Wrap   ',
cast(expr_269 as varchar) as 'AMDPUB09 - Other   ',
cast(expr_270 as varchar) as 'AMDPUC02 - Jr. Chicken Sandwich ',
cast(expr_271 as varchar) as 'AMDPUC03 - McChicken ',
cast(expr_272 as varchar) as 'AMDPUC04 - McNuggets ',
cast(expr_273 as varchar) as 'AMDPUC05 - Chicken Snack Wrap ',
cast(expr_274 as varchar) as 'AMDPUC06 - Filet-o-Fish ',
cast(expr_275 as varchar) as 'AMDPUC07 - Chicken Classic Sandwich ',
cast(expr_276 as varchar) as 'AMDPUC08 - Southwest Chicken Sandwich ',
cast(expr_277 as varchar) as 'AMDPUC09 - Chicken Fajita ',
cast(expr_278 as varchar) as 'AMDPUC10 - Other ',
cast(expr_279 as varchar) as 'AMDPUD02 - Muffin ',
cast(expr_280 as varchar) as 'AMDPUD03 - Cone/Sundae ',
cast(expr_281 as varchar) as 'AMDPUD04 - Pie ',
cast(expr_282 as varchar) as 'AMDPUD05 - Cinnamon Melts',
cast(expr_283 as varchar) as 'AMDPUD06 - McFlurry ',
cast(expr_284 as varchar) as 'AMDPUD07 - Fruit & Yogurt Parfait ',
cast(expr_285 as varchar) as 'AMDPUD08 - Apple Slices ',
cast(expr_286 as varchar) as 'AMDPUD09 - Other ',
cast(expr_287 as varchar) as 'AMDPUF02 - Regular or Decaf coffee  ',
cast(expr_288 as varchar) as 'AMDPUF04 - Latte  ',
cast(expr_289 as varchar) as 'AMDPUF05A - Hot Tea  ',
cast(expr_290 as varchar) as 'AMDPUF06 - Mocha  ',
cast(expr_291 as varchar) as 'AMDPUF08 - Cappuccino  ',
cast(expr_292 as varchar) as 'AMDPUF09 - Espresso ',
cast(expr_293 as varchar) as 'AMDPUF10 - Other  ',
cast(expr_294 as varchar) as 'AMDPUH02 - Hamburger / Cheeseburger ',
cast(expr_295 as varchar) as 'AMDPUH03 - McNuggets ',
cast(expr_296 as varchar) as 'AMDPUH04 - Other Main Item',
cast(expr_297 as varchar) as 'AMDPUH05 - French Fries ',
cast(expr_298 as varchar) as 'AMDPUH05 - French Fries HM',
cast(expr_299 as varchar) as 'AMDPUH06 - Apple Slices ',
cast(expr_300 as varchar) as 'AMDPUH07 - Other Side Item',
cast(expr_301 as varchar) as 'AMDPUI01 - French Fries',
cast(expr_302 as varchar) as 'AMDPUMB0 - Coffee(s) ',
cast(expr_303 as varchar) as 'AMDPUMB02 - Hash Browns',
cast(expr_304 as varchar) as 'AMDPUMB03 - Egg McMuffin(s)  ',
cast(expr_305 as varchar) as 'AMDPUMB04 - Sausage McMuffin(s) ',
cast(expr_306 as varchar) as 'AMDPUMB05 - Bagel Sandwich(s) ',
cast(expr_307 as varchar) as 'AMDPUMB06 - Breakfast Burrito(s) ',
cast(expr_308 as varchar) as 'AMDPUMB07 - McGriddle Sandwich(s) ',
cast(expr_309 as varchar) as 'AMDPUMB08 - Breakfast Platter(s) ',
cast(expr_310 as varchar) as 'AMDPUMB10 - Other drink(s) ',
cast(expr_311 as varchar) as 'AMDPUMB11 - Other  ',
cast(expr_312 as varchar) as 'AMDPUN02 - Fountain Soft Drink ',
cast(expr_313 as varchar) as 'AMDPUN03 - Iced Coffee  ',
cast(expr_314 as varchar) as 'AMDPUN03 - Juice ',
cast(expr_315 as varchar) as 'AMDPUN04 - Milk ',
cast(expr_316 as varchar) as 'AMDPUN05 - Iced Latte  ',
cast(expr_317 as varchar) as 'AMDPUN05 - Iced Tea ',
cast(expr_318 as varchar) as 'AMDPUN06 - Shake ',
cast(expr_319 as varchar) as 'AMDPUN07 - Bottled Water ',
cast(expr_320 as varchar) as 'AMDPUN07 - Iced Mocha  ',
cast(expr_321 as varchar) as 'AMDPUN08 - Other ',
cast(expr_322 as varchar) as 'AMDPUS02 - Spicy Thai Salad ',
cast(expr_323 as varchar) as 'AMDPUS03 - Mediterranean Salad ',
cast(expr_324 as varchar) as 'AMDPUS04 - Mighty Ceasar Salad ',
cast(expr_325 as varchar) as 'AMDPUS05 - Garden Fresh Salad ',
cast(expr_326 as varchar) as 'AMDPUS06 - Side Salad  ',
cast(expr_327 as varchar) as 'AMDPUS07 - Other ',
cast(expr_328 as varchar) as 'AMDPUZ01 - Other Item',
cast(expr_329 as varchar) as 'AMDRC02 - Item was prepared incorrectly  ',
cast(expr_330 as varchar) as 'AMDRC03  - Item was missing  ',
cast(expr_331 as varchar) as 'AMDRC04 - Received one or more wrong items  ',
cast(expr_332 as varchar) as 'AMDRC05 - Other  ',
cast(expr_333 as varchar) as 'AMDRIB02 - Double Cheeseburger ',
cast(expr_334 as varchar) as 'AMDRIB03 - Big Mac / Double Big Mac   ',
cast(expr_335 as varchar) as 'AMDRIB04 - Hamburger / Cheeseburger   ',
cast(expr_336 as varchar) as 'AMDRIB05 - Quarter Pounder with Cheese / Double Qu',
cast(expr_337 as varchar) as 'AMDRIB06 - McDouble / Bacon Cheeseburger   ',
cast(expr_338 as varchar) as 'AMDRIB07 - Angus Burger   ',
cast(expr_339 as varchar) as 'AMDRIB08 - Mac Snack Wrap   ',
cast(expr_340 as varchar) as 'AMDRIB09 - Other   ',
cast(expr_341 as varchar) as 'AMDRIC02 - Jr. Chicken Sandwich ',
cast(expr_342 as varchar) as 'AMDRIC03 - McChicken ',
cast(expr_343 as varchar) as 'AMDRIC04 - McNuggets ',
cast(expr_344 as varchar) as 'AMDRIC05 - Chicken Snack Wrap ',
cast(expr_345 as varchar) as 'AMDRIC06 - Filet-o-Fish ',
cast(expr_346 as varchar) as 'AMDRIC07 - Chicken Classic Sandwich ',
cast(expr_347 as varchar) as 'AMDRIC08 - Southwest Chicken Sandwich ',
cast(expr_348 as varchar) as 'AMDRIC09 - Chicken Fajita ',
cast(expr_349 as varchar) as 'AMDRIC10 - Other ',
cast(expr_350 as varchar) as 'AMDRID02 - Muffin ',
cast(expr_351 as varchar) as 'AMDRID03 - Cone/Sundae ',
cast(expr_352 as varchar) as 'AMDRID04 - Pie ',
cast(expr_353 as varchar) as 'AMDRID05 - Cinnamon Melts',
cast(expr_354 as varchar) as 'AMDRID06 - McFlurry ',
cast(expr_355 as varchar) as 'AMDRID07 - Fruit & Yogurt Parfait ',
cast(expr_356 as varchar) as 'AMDRID08 - Apple Slices ',
cast(expr_357 as varchar) as 'AMDRID09 - Other ',
cast(expr_358 as varchar) as 'AMDRIF02 - Regular or Decaf coffee  ',
cast(expr_359 as varchar) as 'AMDRIF04 - Latte  ',
cast(expr_360 as varchar) as 'AMDRIF05A - Hot Tea ',
cast(expr_361 as varchar) as 'AMDRIF06 - Mocha  ',
cast(expr_362 as varchar) as 'AMDRIF08 - Cappuccino  ',
cast(expr_363 as varchar) as 'AMDRIF09 - Espresso ',
cast(expr_364 as varchar) as 'AMDRIF10 - Other  ',
cast(expr_365 as varchar) as 'AMDRIH02 - Hamburger / Cheeseburger ',
cast(expr_366 as varchar) as 'AMDRIH03 - McNuggets ',
cast(expr_367 as varchar) as 'AMDRIH04 - Other Main Item',
cast(expr_368 as varchar) as 'AMDRIH05 - French Fries ',
cast(expr_369 as varchar) as 'AMDRIH05 - French Fries HM',
cast(expr_370 as varchar) as 'AMDRIH06 - Apple Slices ',
cast(expr_371 as varchar) as 'AMDRIH07 - Other Side Item',
cast(expr_372 as varchar) as 'AMDRII01 - French Fries ',
cast(expr_373 as varchar) as 'AMDRIMB0 - Coffee(s) ',
cast(expr_374 as varchar) as 'AMDRIMB02 - Hash Browns',
cast(expr_375 as varchar) as 'AMDRIMB03 - Egg McMuffin(s)  ',
cast(expr_376 as varchar) as 'AMDRIMB04 - Sausage McMuffin(s) ',
cast(expr_377 as varchar) as 'AMDRIMB05 - Bagel Sandwich(s) ',
cast(expr_378 as varchar) as 'AMDRIMB06 - Breakfast Burrito(s) ',
cast(expr_379 as varchar) as 'AMDRIMB07 - McGriddle Sandwich(s) ',
cast(expr_380 as varchar) as 'AMDRIMB08 - Breakfast Platter(s) ',
cast(expr_381 as varchar) as 'AMDRIMB10 - Other drink(s) ',
cast(expr_382 as varchar) as 'AMDRIMB11 - Other  ',
cast(expr_383 as varchar) as 'AMDRIN02 - Fountain Soft Drink ',
cast(expr_384 as varchar) as 'AMDRIN03 - Iced Coffee  ',
cast(expr_385 as varchar) as 'AMDRIN03 - Juice ',
cast(expr_386 as varchar) as 'AMDRIN04 - Milk ',
cast(expr_387 as varchar) as 'AMDRIN05 - Iced Latte  ',
cast(expr_388 as varchar) as 'AMDRIN05 - Iced Tea ',
cast(expr_389 as varchar) as 'AMDRIN06 - Shake ',
cast(expr_390 as varchar) as 'AMDRIN07 - Bottled Water ',
cast(expr_391 as varchar) as 'AMDRIN07 - Iced Mocha  ',
cast(expr_392 as varchar) as 'AMDRIN08 - Other ',
cast(expr_393 as varchar) as 'AMDRIS02 - Spicy Thai Salad ',
cast(expr_394 as varchar) as 'AMDRIS03 - Mediterranean Salad ',
cast(expr_395 as varchar) as 'AMDRIS04 - Mighty Ceasar Salad ',
cast(expr_396 as varchar) as 'AMDRIS05 - Garden Fresh Salad ',
cast(expr_397 as varchar) as 'AMDRIS06 - Side Salad  ',
cast(expr_398 as varchar) as 'AMDRIS07 - Other ',
cast(expr_399 as varchar) as 'AMDRIZ01 - Other Item',
cast(expr_400 as varchar) as 'AMDRMB02 - Double Cheeseburger ',
cast(expr_401 as varchar) as 'AMDRMB03 - Big Mac / Double Big Mac   ',
cast(expr_402 as varchar) as 'AMDRMB04 - Hamburger / Cheeseburger   ',
cast(expr_403 as varchar) as 'AMDRMB05 - Quarter Pounder with Cheese / Double Qu',
cast(expr_404 as varchar) as 'AMDRMB06 - McDouble / Bacon Cheeseburger   ',
cast(expr_405 as varchar) as 'AMDRMB07 - Angus Burger   ',
cast(expr_406 as varchar) as 'AMDRMB08 - Mac Snack Wrap   ',
cast(expr_407 as varchar) as 'AMDRMB09 - Other   ',
cast(expr_408 as varchar) as 'AMDRMC02 - Jr. Chicken Sandwich ',
cast(expr_409 as varchar) as 'AMDRMC03 - McChicken ',
cast(expr_410 as varchar) as 'AMDRMC04 - McNuggets ',
cast(expr_411 as varchar) as 'AMDRMC05 - Chicken Snack Wrap ',
cast(expr_412 as varchar) as 'AMDRMC06 - Filet-o-Fish ',
cast(expr_413 as varchar) as 'AMDRMC07 - Chicken Classic Sandwich ',
cast(expr_414 as varchar) as 'AMDRMC08 - Southwest Chicken Sandwich ',
cast(expr_415 as varchar) as 'AMDRMC09 - Chicken Fajita ',
cast(expr_416 as varchar) as 'AMDRMC10 - Other ',
cast(expr_417 as varchar) as 'AMDRMD02 - Muffin ',
cast(expr_418 as varchar) as 'AMDRMD03 - Cone/Sundae ',
cast(expr_419 as varchar) as 'AMDRMD04 - Pie ',
cast(expr_420 as varchar) as 'AMDRMD05 - Cinnamon Melts',
cast(expr_421 as varchar) as 'AMDRMD06 - McFlurry ',
cast(expr_422 as varchar) as 'AMDRMD07 - Fruit & Yogurt Parfait ',
cast(expr_423 as varchar) as 'AMDRMD08 - Apple Slices ',
cast(expr_424 as varchar) as 'AMDRMD09 - Other ',
cast(expr_425 as varchar) as 'AMDRMF02 - Regular or Decaf coffee  ',
cast(expr_426 as varchar) as 'AMDRMF04 - Latte  ',
cast(expr_427 as varchar) as 'AMDRMF05A - Hot Tea ',
cast(expr_428 as varchar) as 'AMDRMF06 - Mocha  ',
cast(expr_429 as varchar) as 'AMDRMF08 - Cappuccino  ',
cast(expr_430 as varchar) as 'AMDRMF09 - Espresso ',
cast(expr_431 as varchar) as 'AMDRMF10 - Other  ',
cast(expr_432 as varchar) as 'AMDRMH02 - Hamburger / Cheeseburger ',
cast(expr_433 as varchar) as 'AMDRMH03 - McNuggets ',
cast(expr_434 as varchar) as 'AMDRMH04 - Other Main Item',
cast(expr_435 as varchar) as 'AMDRMH05 - French Fries ',
cast(expr_436 as varchar) as 'AMDRMH05 - French Fries HM',
cast(expr_437 as varchar) as 'AMDRMH06 - Apple Slices ',
cast(expr_438 as varchar) as 'AMDRMH07 - Other Side Item',
cast(expr_439 as varchar) as 'AMDRMI01 - French Fries',
cast(expr_440 as varchar) as 'AMDRMMB0 - Coffee(s) ',
cast(expr_441 as varchar) as 'AMDRMMB02 - Hash Browns',
cast(expr_442 as varchar) as 'AMDRMMB03 - Egg McMuffin(s)  ',
cast(expr_443 as varchar) as 'AMDRMMB04 - Sausage McMuffin(s) ',
cast(expr_444 as varchar) as 'AMDRMMB05 - Bagel Sandwich(s) ',
cast(expr_445 as varchar) as 'AMDRMMB06 - Breakfast Burrito(s) ',
cast(expr_446 as varchar) as 'AMDRMMB07 - McGriddle Sandwich(s) ',
cast(expr_447 as varchar) as 'AMDRMMB08 - Breakfast Platter(s) ',
cast(expr_448 as varchar) as 'AMDRMMB10 - Other drink(s) ',
cast(expr_449 as varchar) as 'AMDRMMB11 - Other  ',
cast(expr_450 as varchar) as 'AMDRMN02 - Fountain Soft Drink ',
cast(expr_451 as varchar) as 'AMDRMN03 - Iced Coffee  ',
cast(expr_452 as varchar) as 'AMDRMN03 - Juice ',
cast(expr_453 as varchar) as 'AMDRMN04 - Milk ',
cast(expr_454 as varchar) as 'AMDRMN05 - Iced Latte  ',
cast(expr_455 as varchar) as 'AMDRMN05 - Iced Tea ',
cast(expr_456 as varchar) as 'AMDRMN06 - Shake ',
cast(expr_457 as varchar) as 'AMDRMN07 - Bottled Water ',
cast(expr_458 as varchar) as 'AMDRMN07 - Iced Mocha  ',
cast(expr_459 as varchar) as 'AMDRMN08 - Other ',
cast(expr_460 as varchar) as 'AMDRMS02 - Spicy Thai Salad ',
cast(expr_461 as varchar) as 'AMDRMS03 - Mediterranean Salad ',
cast(expr_462 as varchar) as 'AMDRMS04 - Mighty Ceasar Salad ',
cast(expr_463 as varchar) as 'AMDRMS05 - Garden Fresh Salad ',
cast(expr_464 as varchar) as 'AMDRMS06 - Side Salad  ',
cast(expr_465 as varchar) as 'AMDRMS07 - Other ',
cast(expr_466 as varchar) as 'AMDRMZ01 - Other Item',
cast(expr_467 as varchar) as 'AMDS02 - The line was too long ',
cast(expr_468 as varchar) as 'AMDS03 - The line wasn’t moving fast enough  ',
cast(expr_469 as varchar) as 'AMDS04 - I waited too long for my food or drink ',
cast(expr_470 as varchar) as 'AMDS05 - The restaurant seemed understaffed ',
cast(expr_471 as varchar) as 'AMDS06  - Other   ',
cast(expr_472 as varchar) as 'AMDS07 - Nothing was wrong',
cast(expr_473 as varchar) as 'AMDTA02 - The apples were mushy ',
cast(expr_474 as varchar) as 'AMDTA03 - The apples were old ',
cast(expr_475 as varchar) as 'AMDTA04 - Other ',
cast(expr_476 as varchar) as 'AMDTB02 - The sandwich was greasy ',
cast(expr_477 as varchar) as 'AMDTB03 - The meat was dry  ',
cast(expr_478 as varchar) as 'AMDTB04 - The meat wasn’t cooked enough  ',
cast(expr_479 as varchar) as 'AMDTB05 - The bun was hard or dry  ',
cast(expr_480 as varchar) as 'AMDTB06 - The bun was soggy ',
cast(expr_481 as varchar) as 'AMDTB07 - The produce wasn’t fresh  ',
cast(expr_482 as varchar) as 'AMDTB08 - Other  ',
cast(expr_483 as varchar) as 'AMDTC02 - It wasn’t sweet enough ',
cast(expr_484 as varchar) as 'AMDTC03 - It was too Sweet   ',
cast(expr_485 as varchar) as 'AMDTC04 - It was too Bitter ',
cast(expr_486 as varchar) as 'AMDTC05 - It was too strong ',
cast(expr_487 as varchar) as 'AMDTC06 - It was too weak ',
cast(expr_488 as varchar) as 'AMDTC07 - It wasn’t creamy enough ',
cast(expr_489 as varchar) as 'AMDTC08 - Other  ',
cast(expr_490 as varchar) as 'AMDTC09 - Too much ice',
cast(expr_491 as varchar) as 'AMDTC10 - Not enough ice',
cast(expr_492 as varchar) as 'AMDTE02 - The cone was stale ',
cast(expr_493 as varchar) as 'AMDTE03 - The ice cream wasn’t creamy ',
cast(expr_494 as varchar) as 'AMDTE04 - The topping didn’t taste good ',
cast(expr_495 as varchar) as 'AMDTE05 - The ice cream didn’t taste good ',
cast(expr_496 as varchar) as 'AMDTE06 - The toppings were old or stale ',
cast(expr_497 as varchar) as 'AMDTE07 - Other ',
cast(expr_498 as varchar) as 'AMDTF02 - They were too salty  ',
cast(expr_499 as varchar) as 'AMDTF03 - They weren’t salty enough  ',
cast(expr_500 as varchar) as 'AMDTF04 - They were soggy  ',
cast(expr_501 as varchar) as 'AMDTF05 - They were old or stale ',
cast(expr_502 as varchar) as 'AMDTF06 - They were burnt or hard ',
cast(expr_503 as varchar) as 'AMDTF07 - Other  ',
cast(expr_504 as varchar) as 'AMDTH02 - They were greasy ',
cast(expr_505 as varchar) as 'AMDTH03 - They were soggy  ',
cast(expr_506 as varchar) as 'AMDTH04 - They were old or stale ',
cast(expr_507 as varchar) as 'AMDTH05 - They were burnt or hard ',
cast(expr_508 as varchar) as 'AMDTH06 - Other  ',
cast(expr_509 as varchar) as 'AMDTK02 - It was too sweet ',
cast(expr_510 as varchar) as 'AMDTK03 - It was too creamy ',
cast(expr_511 as varchar) as 'AMDTK04 - It was too bitter ',
cast(expr_512 as varchar) as 'AMDTK05 - It wasn’t thick enough ',
cast(expr_513 as varchar) as 'AMDTK06 - Other ',
cast(expr_514 as varchar) as 'AMDTM02 - It was burnt ',
cast(expr_515 as varchar) as 'AMDTM03 - It was hard or stale ',
cast(expr_516 as varchar) as 'AMDTM04 - It was undercooked  ',
cast(expr_517 as varchar) as 'AMDTM05 - Other ',
cast(expr_518 as varchar) as 'AMDTN02 - It wasn’t sweet enough ',
cast(expr_519 as varchar) as 'AMDTN03 - It was too Sweet   ',
cast(expr_520 as varchar) as 'AMDTN04 - It was too Bitter ',
cast(expr_521 as varchar) as 'AMDTN05 - It was too strong ',
cast(expr_522 as varchar) as 'AMDTN06 - It was too weak ',
cast(expr_523 as varchar) as 'AMDTN07 - It wasn’t creamy enough ',
cast(expr_524 as varchar) as 'AMDTN08 - Other  ',
cast(expr_525 as varchar) as 'AMDTN09 - Too much ice',
cast(expr_526 as varchar) as 'AMDTN10 - Not enough ice',
cast(expr_527 as varchar) as 'AMDTS02 - The lettuce was soggy  or wilted ',
cast(expr_528 as varchar) as 'AMDTS03 - The chicken was burnt or dry ',
cast(expr_529 as varchar) as 'AMDTS04 - The chicken was soggy ',
cast(expr_530 as varchar) as 'AMDTS05 - Other ',
cast(expr_531 as varchar) as 'AMDTY02 - It had soggy granola ',
cast(expr_532 as varchar) as 'AMDTY03 - It had stale granola ',
cast(expr_533 as varchar) as 'AMDTY04 - It was too creamy ',
cast(expr_534 as varchar) as 'AMDTY05 - It was too sweet ',
cast(expr_535 as varchar) as 'AMDTY06 - Other ',
cast(expr_536 as varchar) as 'AMDUF02 - It was too warm ',
cast(expr_537 as varchar) as 'AMDUF03 - It was too cold ',
cast(expr_538 as varchar) as 'AMDUF04 - The fruit was frozen ',
cast(expr_539 as varchar) as 'AMDUF05 - Other ',
cast(expr_540 as varchar) as 'AMDUN02 - It was too cold',
cast(expr_541 as varchar) as 'AMDUN03 - It wasn’t cold enough   ',
cast(expr_542 as varchar) as 'AMDUN05 - Other ',
cast(expr_543 as varchar) as 'AMDUP02 - It was too hot  ',
cast(expr_544 as varchar) as 'AMDUP03 - It wasn’t hot enough   ',
cast(expr_545 as varchar) as 'AMDUP04 - It was cold ',
cast(expr_546 as varchar) as 'AMDUP05 - Other ',
cast(expr_547 as varchar) as 'AMDUS02 - The produce was hot / warm ',
cast(expr_548 as varchar) as 'AMDUS03 - The chicken was cold ',
cast(expr_549 as varchar) as 'AMDUS04 - The chicken was too hot ',
cast(expr_550 as varchar) as 'AMDUS05 - Other ',
cast(expr_551 as varchar) as 'AMDV02 - Employee didn’t give me their full attent',
cast(expr_552 as varchar) as 'AMDV03 - Employee didn’t listen to me  ',
cast(expr_553 as varchar) as 'AMDV04 - Employee didn’t look at me  ',
cast(expr_554 as varchar) as 'AMDV05)   - The employee wasn’t ready when I was r',
cast(expr_555 as varchar) as 'AMDV06 - Employee didn’t promptly resolve an issue',
cast(expr_556 as varchar) as 'AMDV07 - Nothing was wrong',
cast(expr_557 as varchar) as 'AMDV07 - Other ',
cast(expr_558 as varchar) as 'AME05 - End Survey Button, No Optional Questions',
cast(expr_559 as varchar) as 'AME05 - End Survey, Enter Sweepstakes',
cast(expr_560 as varchar) as 'AME08 - Acknowledge Read & Agreed Sweeps',
cast(expr_561 as varchar) as 'AMI02B - IsWeekend (Sat. - Sun.)',
cast(expr_562 as varchar) as 'AMPB02 - Double Cheeseburger ',
cast(expr_563 as varchar) as 'AMPB03 - Big Mac / Double Big Mac   ',
cast(expr_564 as varchar) as 'AMPB04 - Hamburger / Cheeseburger   ',
cast(expr_565 as varchar) as 'AMPB05 - Quarter Pounder with Cheese / Double Quar',
cast(expr_566 as varchar) as 'AMPB06 - McDouble / Bacon Cheeseburger   ',
cast(expr_567 as varchar) as 'AMPB07 - Angus Burger   ',
cast(expr_568 as varchar) as 'AMPB08 - Mac Snack Wrap   ',
cast(expr_569 as varchar) as 'AMPB09 - Other   ',
cast(expr_570 as varchar) as 'AMPC02 - Jr. Chicken Sandwich ',
cast(expr_571 as varchar) as 'AMPC03 - McChicken ',
cast(expr_572 as varchar) as 'AMPC04 - McNuggets ',
cast(expr_573 as varchar) as 'AMPC05 - Chicken Snack Wrap ',
cast(expr_574 as varchar) as 'AMPC06 - Filet-o-Fish ',
cast(expr_575 as varchar) as 'AMPC07 - Chicken Classic Sandwich ',
cast(expr_576 as varchar) as 'AMPC08 - Southwest Chicken Sandwich ',
cast(expr_577 as varchar) as 'AMPC09 - Chicken Fajita ',
cast(expr_578 as varchar) as 'AMPC10 - Other ',
cast(expr_579 as varchar) as 'AMPD02 - Muffin ',
cast(expr_580 as varchar) as 'AMPD03 - Cone/Sundae ',
cast(expr_581 as varchar) as 'AMPD04 - Pie ',
cast(expr_582 as varchar) as 'AMPD05 - Cinnamon Melts',
cast(expr_583 as varchar) as 'AMPD06 - McFlurry ',
cast(expr_584 as varchar) as 'AMPD07 - Fruit & Yogurt Parfait ',
cast(expr_585 as varchar) as 'AMPD08 - Apple Slices ',
cast(expr_586 as varchar) as 'AMPD09 - Other ',
cast(expr_587 as varchar) as 'AMPF02 - Regular or Decaf coffee  ',
cast(expr_588 as varchar) as 'AMPF04 - Latte  ',
cast(expr_589 as varchar) as 'AMPF05A - Hot Tea ',
cast(expr_590 as varchar) as 'AMPF06 - Mocha  ',
cast(expr_591 as varchar) as 'AMPF08 - Cappuccino  ',
cast(expr_592 as varchar) as 'AMPF09 - Espresso ',
cast(expr_593 as varchar) as 'AMPF10 - Other  ',
cast(expr_594 as varchar) as 'AMPH02 - Hamburger / Cheeseburger ',
cast(expr_595 as varchar) as 'AMPH03 - McNuggets ',
cast(expr_596 as varchar) as 'AMPH04 - Other Main Item',
cast(expr_597 as varchar) as 'AMPH05 - French Fries ',
cast(expr_598 as varchar) as 'AMPH06 - Apple Slices ',
cast(expr_599 as varchar) as 'AMPH07 - Other Side Item',
cast(expr_600 as varchar) as 'AMPMB02 - Hash Browns',
cast(expr_601 as varchar) as 'AMPMB03 - Egg McMuffin(s)  ',
cast(expr_602 as varchar) as 'AMPMB04 - Sausage McMuffin(s) ',
cast(expr_603 as varchar) as 'AMPMB05 - Bagel Sandwich(es) ',
cast(expr_604 as varchar) as 'AMPMB06 - Breakfast Burrito(s) ',
cast(expr_605 as varchar) as 'AMPMB07 - McGriddle Sandwich(es) ',
cast(expr_606 as varchar) as 'AMPMB08 - Breakfast Platter(s) ',
cast(expr_607 as varchar) as 'AMPMB09 - Coffee(s) ',
cast(expr_608 as varchar) as 'AMPMB10 - Other drink(s) ',
cast(expr_609 as varchar) as 'AMPMB11 - Other  ',
cast(expr_610 as varchar) as 'AMPMR02 - Happy Meal(s) ',
cast(expr_611 as varchar) as 'AMPMR03 - Burger Sandwich(es) ',
cast(expr_612 as varchar) as 'AMPMR04 - Chicken or Fish Sandwich(es) ',
cast(expr_613 as varchar) as 'AMPMR05 - French Fries ',
cast(expr_614 as varchar) as 'AMPMR06 - Salad(s) ',
cast(expr_615 as varchar) as 'AMPMR07 - Dessert/Snack(s) ',
cast(expr_616 as varchar) as 'AMPMR08 - (B10) Cold Drink(s) ',
cast(expr_617 as varchar) as 'AMPMR09 - (B09) - Hot Drink(s) ',
cast(expr_618 as varchar) as 'AMPMR10 - Other ',
cast(expr_619 as varchar) as 'AMPN02 - Fountain Soft Drink ',
cast(expr_620 as varchar) as 'AMPN03 - Iced Coffee  ',
cast(expr_621 as varchar) as 'AMPN03 - Juice ',
cast(expr_622 as varchar) as 'AMPN04 - Milk ',
cast(expr_623 as varchar) as 'AMPN05 - Iced Latte  ',
cast(expr_624 as varchar) as 'AMPN05 - Iced Tea ',
cast(expr_625 as varchar) as 'AMPN06 - Shake ',
cast(expr_626 as varchar) as 'AMPN07 - Bottled Water ',
cast(expr_627 as varchar) as 'AMPN07 - Iced Mocha  ',
cast(expr_628 as varchar) as 'AMPN08 - Other ',
cast(expr_629 as varchar) as 'AMPS02 - Spicy Thai Salad ',
cast(expr_630 as varchar) as 'AMPS03 - Mediterranean Salad ',
cast(expr_631 as varchar) as 'AMPS04 - Mighty Ceasar Salad ',
cast(expr_632 as varchar) as 'AMPS05 - Garden Fresh Salad ',
cast(expr_633 as varchar) as 'AMPS06 - Side Salad  ',
cast(expr_634 as varchar) as 'AMPS07 - Other ',
modetype,
playplace,
Dining,
Restrooms,
DriveThru,
McOpCoFranchise,
replace(Operator,',','| '),
replace(OpsConsultant,',','|'),
replace(McOpCoAreaSupervisor,',','|'),
replace(FieldServiceManager,',','|'),
replace(McOpCoOpsManager,',','|'),
replace(DirectorOfOperations,',','|'),
replace(McOpCoDirectorOfOperations,',','|'),
replace(RegionalQSCVP,',','|'),
replace(McOpCoQSCVP,',','|'),
--RegionFranchise,
replace(Division,',','|'),
replace(RegionAll,',','|'),
cast(expr_670 as varchar) as 'AMC12 - Value for the Money',
cast(expr_671 as varchar) as 'AMCBS - Specialty Beverage Drank (CA English)',
cast(expr_672 as varchar) as 'AMCBS14 - CBS Overall Sat',
cast(expr_673 as varchar) as 'AMCBS15 - CBS - Overall Quality',
cast(expr_674 as varchar) as 'AMCBS16 - CBS - Prep d to my Liking',
cast(expr_675 as varchar) as 'AMCBS17 - CBS - Overall Value',
cast(expr_676 as varchar) as 'AMCBS18 - If Item Not Available',
cast(expr_677 as varchar) as 'AMCBS19 - How Likely Purchase Again 4 Weeks',
cast(expr_678 as varchar) as 'AMCBS20 - Likely Recommend Item',
cast(expr_679 as varchar) as 'AMCBS21 - If Not Available Where Go?',
cast(expr_680 as varchar) as 'AMCBS22 - Likely Purchase ANY McCafé Beverage',
cast(expr_681 as varchar) as 'AMCBS23 - How Often Purchase ANY McCafé bev',
cast(expr_682 as varchar) as 'AMCBS24 - Because of McCafé, Visit McDonalds More',
cast(expr_683 as varchar) as 'AMCBS26 - How Often Drink Specialty Coffee?',
cast(expr_684 as varchar) as 'AMCBS27 - Typically Purchase Specialty Coffee',
cast(expr_685 as varchar) as 'AMCBS28 - How Likely Purchase From McDonalds Fut',
'OtherTextBox' =
case modetype
when 2 then
replace(replace(replace(replace(cast(dbo.udf_returnCommentsFromBC2(expr_686)as varchar(max)),',',''),char(9),''),char(10),''),char(13),'') 
end,
cast(expr_687 as varchar) as 'AMS01 - Current Age',
cast(expr_688 as varchar) as 'AMS01B - Age of Survey Taker (Phone)',
cast(expr_689 as varchar) as 'AMC13 - Receive What Ordered)',
cast(expr_690 as varchar) as 'AMC14 - Condiments, Napkins, etc.',
cast( expr_27226 as varchar) as 'AMDRPTSD01 - It wasnt sweet enough --- Fountain S',
cast( expr_27227 as varchar) as 'AMDRPTSD02 - It was too sweet --- Fountain Soft Dr',
cast( expr_27228 as varchar) as 'AMDRPTSD03 - It was too bitter --- Fountain Soft D',
cast( expr_27229 as varchar) as 'AMDRPTSD04 - It was too strong --- Fountain Soft D',
cast( expr_27230 as varchar) as 'AMDRPTSD05 - It was too weak --- Fountain Soft Dri',
cast( expr_27231 as varchar) as 'AMDRPTSD06 - Too much ice --- Fountain Soft Drink',
cast( expr_27232 as varchar) as 'AMDRPTSD07 - Not enough ice --- Fountain Soft Drin',
cast( expr_27233 as varchar) as 'AMDRPTSD08 - Other --- Fountain Soft Drink',
cast( expr_27234 as varchar) as 'AMDRPTIC01 - It wasnt sweet enough --- Iced Coffe',
cast( expr_27235 as varchar) as 'AMDRPTIC02 - It was too sweet --- Iced Coffee',
cast( expr_27236 as varchar) as 'AMDRPTIC03 - It was too bitter --- Iced Coffee',
cast( expr_27237 as varchar) as 'AMDRPTIC04 - It was too strong --- Iced Coffee',
cast( expr_27238 as varchar) as 'AMDRPTIC05 - It was too weak --- Iced Coffee',
cast( expr_27239 as varchar) as 'AMDRPTIC06 - It wasnt creamy enough --- Iced Coff',
cast( expr_27240 as varchar) as 'AMDRPTIC07 - Too much ice --- Iced Coffee',
cast( expr_27241 as varchar) as 'AMDRPTIC08 - Not enough ice --- Iced Coffee',
cast( expr_27242 as varchar) as 'AMDRPTIC09 - Other --- Iced Coffee',
cast( expr_27243 as varchar) as 'AMDRPTIL01 - It wasnt sweet enough --- Iced Latte',
cast( expr_27244 as varchar) as 'AMDRPTIL02 - It was too sweet --- Iced Latte',
cast( expr_27245 as varchar) as 'AMDRPTIL03 - It was too bitter --- Iced Latte',
cast( expr_27246 as varchar) as 'AMDRPTIL04 - It was too strong --- Iced Latte',
cast( expr_27247 as varchar) as 'AMDRPTIL05 - It was too weak --- Iced Latte',
cast( expr_27248 as varchar) as 'AMDRPTIL06 - It wasnt creamy enough --- Iced Latt',
cast( expr_27249 as varchar) as 'AMDRPTIL07 - Too much ice --- Iced Latte',
cast( expr_27250 as varchar) as 'AMDRPTIL08 - Not enough ice --- Iced Latte',
cast( expr_27251 as varchar) as 'AMDRPTIL09 - Other --- Iced Latte',
cast( expr_27252 as varchar) as 'AMDRPTIM01 - It wasnt sweet enough --- Iced Mocha',
cast( expr_27253 as varchar) as 'AMDRPTIM02 - It was too sweet --- Iced Mocha',
cast( expr_27254 as varchar) as 'AMDRPTIM03 - It was too bitter --- Iced Mocha',
cast( expr_27255 as varchar) as 'AMDRPTIM04 - It was too strong --- Iced Mocha',
cast( expr_27256 as varchar) as 'AMDRPTIM05 - It was too weak --- Iced Mocha',
cast( expr_27257 as varchar) as 'AMDRPTIM06 - It wasnt creamy enough --- Iced Moch',
cast( expr_27258 as varchar) as 'AMDRPTIM07 - Too much ice --- Iced Mocha',
cast( expr_27259 as varchar) as 'AMDRPTIM08 - Not enough ice --- Iced Mocha',
cast( expr_27260 as varchar) as 'AMDRPTIM09 - Other --- Iced Mocha',
cast( expr_27261 as varchar) as 'AMDRPTIT01 - It wasnt sweet enough --- Iced Tea',
cast( expr_27262 as varchar) as 'AMDRPTIT02 - It was too sweet --- Iced Tea',
cast( expr_27263 as varchar) as 'AMDRPTIT03 - It was too bitter --- Iced Tea',
cast( expr_27264 as varchar) as 'AMDRPTIT04 - It was too strong --- Iced Tea',
cast( expr_27265 as varchar) as 'AMDRPTIT05 - It was too weak --- Iced Tea',
cast( expr_27266 as varchar) as 'AMDRPTIT06 - Too much ice --- Iced Tea',
cast( expr_27267 as varchar) as 'AMDRPTIT07 - Not enough ice --- Iced Tea',
cast( expr_27268 as varchar) as 'AMDRPTIT08 - Other --- Iced Tea',
cast( expr_27269 as varchar) as 'AMDRPTJC01 - It wasnt sweet enough --- Juice',
cast( expr_27270 as varchar) as 'AMDRPTJC02 - It was too sweet --- Juice',
cast( expr_27271 as varchar) as 'AMDRPTJC03 - It was too strong --- Juice',
cast( expr_27272 as varchar) as 'AMDRPTJC04 - It was too weak --- Juice',
cast( expr_27273 as varchar) as 'AMDRPTJC05 - Other --- Juice',
cast( expr_27274 as varchar) as 'AMDRPTTM01 - It was too sweet --- Triple Thick Mil',
cast( expr_27275 as varchar) as 'AMDRPTTM02 - It was too creamy --- Triple Thick Mi',
cast( expr_27276 as varchar) as 'AMDRPTTM03 - It wasnt thick enough --- Triple Thi',
cast( expr_27277 as varchar) as 'AMDRPTTM04 - It was icy --- Triple Thick Milkshake',
cast( expr_27278 as varchar) as 'AMDRPTTM05 - Other --- Triple Thick Milkshake®',
cast( expr_27279 as varchar) as 'AMDRPTAP01 - The apples were mushy --- Apples Slic',
cast( expr_27280 as varchar) as 'AMDRPTAP02 - The apples were old or spoiled --- Ap',
cast( expr_27281 as varchar) as 'AMDRPTAP03 - Other --- Apples Slices',
cast( expr_27282 as varchar) as 'AMDRPTAH01 - The apples were mushy --- Happy Meal®',
cast( expr_27283 as varchar) as 'AMDRPTAH02 - The apples were old or spoiled --- Ha',
cast( expr_27284 as varchar) as 'AMDRPTAH03 - Other --- Happy Meal® Apple Slices',
cast( expr_27285 as varchar) as 'AMDRPTCM01 - It was burnt --- Cinnamon Melts®',
cast( expr_27286 as varchar) as 'AMDRPTCM02 - It was hard or stale --- Cinnamon Mel',
cast( expr_27287 as varchar) as 'AMDRPTCM03 - It was undercooked --- Cinnamon Melts',
cast( expr_27288 as varchar) as 'AMDRPTCM04 - It was too sweet --- Cinnamon Melts®',
cast( expr_27289 as varchar) as 'AMDRPTCM05 - Other --- Cinnamon Melts®',
cast( expr_27290 as varchar) as 'AMDRPTCS01 - The cone was stale --- Cone / Sundae',
cast( expr_27291 as varchar) as 'AMDRPTCS02 - The ice cream wasnt creamy --- Cone ',
cast( expr_27292 as varchar) as 'AMDRPTCS03 - The topping didnt taste good --- Con',
cast( expr_27293 as varchar) as 'AMDRPTCS04 - The ice cream didnt taste good --- C',
cast( expr_27294 as varchar) as 'AMDRPTCS05 - The toppings were old or stale --- Co',
cast( expr_27295 as varchar) as 'AMDRPTCS06 - Other --- Cone / Sundae',
cast( expr_27296 as varchar) as 'AMDRPTFY01 - It had soggy granola --- Fruit & Yogu',
cast( expr_27297 as varchar) as 'AMDRPTFY02 - It had stale granola --- Fruit & Yogu',
cast( expr_27298 as varchar) as 'AMDRPTFY03 - It was too creamy --- Fruit & Yogurt ',
cast( expr_27299 as varchar) as 'AMDRPTFY04 - It was too sweet --- Fruit & Yogurt P',
cast( expr_27300 as varchar) as 'AMDRPTFY05 - Other --- Fruit & Yogurt Parfait',
cast( expr_27301 as varchar) as 'AMDRPTMF01 - It was too sweet --- McFlurry® desser',
cast( expr_27302 as varchar) as 'AMDRPTMF02 - It wasnt creamy --- McFlurry® desser',
cast( expr_27303 as varchar) as 'AMDRPTMF03 - It was too creamy --- McFlurry® desse',
cast( expr_27304 as varchar) as 'AMDRPTMF04 - It was too thick --- McFlurry® desser',
cast( expr_27305 as varchar) as 'AMDRPTMF05 - It wasnt thick enough --- McFlurry® ',
cast( expr_27306 as varchar) as 'AMDRPTMF06 - It was icy --- McFlurry® dessert',
cast( expr_27307 as varchar) as 'AMDRPTMF07 - Other --- McFlurry® dessert',
cast( expr_27308 as varchar) as 'AMDRPTMN01 - It was burnt --- Muffin',
cast( expr_27309 as varchar) as 'AMDRPTMN02 - It was hard or stale --- Muffin',
cast( expr_27310 as varchar) as 'AMDRPTMN03 - It was undercooked --- Muffin',
cast( expr_27311 as varchar) as 'AMDRPTMN04 - Other --- Muffin',
cast( expr_27312 as varchar) as 'AMDRPTPI01 - It was burnt --- Pie',
cast( expr_27313 as varchar) as 'AMDRPTPI02 - It was hard or stale --- Pie',
cast( expr_27314 as varchar) as 'AMDRPTPI03 - It was undercooked --- Pie',
cast( expr_27315 as varchar) as 'AMDRPTPI04 - Other --- Pie',
cast( expr_27316 as varchar) as 'AMDRPTFF01 - They were too salty --- French Fries',
cast( expr_27317 as varchar) as 'AMDRPTFF02 -  They weren’t salty enough  --- Frenc',
cast( expr_27318 as varchar) as 'AMDRPTFF03 - They were soggy --- French Fries',
cast( expr_27319 as varchar) as 'AMDRPTFF04 - They were old or stale --- French Fri',
cast( expr_27320 as varchar) as 'AMDRPTFF05 - They were burnt or hard --- French Fr',
cast( expr_27321 as varchar) as 'AMDRPTFF06 - Other --- French Fries',
cast( expr_27322 as varchar) as 'AMDRPTHF01 - They were too salty --- Happy Meal® F',
cast( expr_27323 as varchar) as 'AMDRPTHF02 -  They weren’t salty enough  --- Happy',
cast( expr_27324 as varchar) as 'AMDRPTHF03 - They were soggy --- Happy Meal® Frenc',
cast( expr_27325 as varchar) as 'AMDRPTHF04 - They were old or stale --- Happy Meal',
cast( expr_27326 as varchar) as 'AMDRPTHF05 - They were burnt or hard --- Happy Mea',
cast( expr_27327 as varchar) as 'AMDRPTHF06 - Other --- Happy Meal® French Fries',
cast( expr_27328 as varchar) as 'AMDRPTCP01 - It wasnt sweet enough --- Cappuccino',
cast( expr_27329 as varchar) as 'AMDRPTCP02 - It was too sweet --- Cappuccino',
cast( expr_27330 as varchar) as 'AMDRPTCP03 - It was too bitter --- Cappuccino',
cast( expr_27331 as varchar) as 'AMDRPTCP04 - It was too strong --- Cappuccino',
cast( expr_27332 as varchar) as 'AMDRPTCP05 - It was too weak --- Cappuccino',
cast( expr_27333 as varchar) as 'AMDRPTCP06 - It wasnt creamy enough --- Cappuccin',
cast( expr_27334 as varchar) as 'AMDRPTCP07 - Other --- Cappuccino',
cast( expr_27335 as varchar) as 'AMDRPTES01 - It was too bitter --- Espresso',
cast( expr_27336 as varchar) as 'AMDRPTES02 - It was too strong --- Espresso',
cast( expr_27337 as varchar) as 'AMDRPTES03 - It was too weak --- Espresso',
cast( expr_27338 as varchar) as 'AMDRPTES04 - It wasnt creamy enough --- Espresso',
cast( expr_27339 as varchar) as 'AMDRPTES05 - Other --- Espresso',
cast( expr_27340 as varchar) as 'AMDRPTLT01 - It wasnt sweet enough --- Latte',
cast( expr_27341 as varchar) as 'AMDRPTLT02 - It was too sweet --- Latte',
cast( expr_27342 as varchar) as 'AMDRPTLT03 - It was too bitter --- Latte',
cast( expr_27343 as varchar) as 'AMDRPTLT04 - It was too strong --- Latte',
cast( expr_27344 as varchar) as 'AMDRPTLT05 - It was too weak --- Latte',
cast( expr_27345 as varchar) as 'AMDRPTLT06 - It wasnt creamy enough --- Latte',
cast( expr_27346 as varchar) as 'AMDRPTLT07 - Other --- Latte',
cast( expr_27347 as varchar) as 'AMDRPTMA01 - It wasnt sweet enough --- Mocha',
cast( expr_27348 as varchar) as 'AMDRPTMA02 - It was too sweet --- Mocha',
cast( expr_27349 as varchar) as 'AMDRPTMA03 - It was too bitter --- Mocha',
cast( expr_27350 as varchar) as 'AMDRPTMA04 - It was too strong --- Mocha',
cast( expr_27351 as varchar) as 'AMDRPTMA05 - It was too weak --- Mocha',
cast( expr_27352 as varchar) as 'AMDRPTMA06 - It wasnt creamy enough --- Mocha',
cast( expr_27353 as varchar) as 'AMDRPTMA07 - Other --- Mocha',
cast( expr_27354 as varchar) as 'AMDRPTRC01 - It was too bitter --- Regular or Deca',
cast( expr_27355 as varchar) as 'AMDRPTRC02 - It was too strong --- Regular or Deca',
cast( expr_27356 as varchar) as 'AMDRPTRC03 - It was too weak --- Regular or Decaf ',
cast( expr_27357 as varchar) as 'AMDRPTRC04 - It wasnt sweet enough  --- Regular o',
cast( expr_27358 as varchar) as 'AMDRPTRC05 - It was too sweet  --- Regular or Deca',
cast( expr_27359 as varchar) as 'AMDRPTRC06 - It wasnt creamy enough  --- Regular ',
cast( expr_27360 as varchar) as 'AMDRPTRC07 - Other --- Regular or Decaf Coffee',
cast( expr_27361 as varchar) as 'AMDRPTTH01 - It was too bitter --- Hot Tea',
cast( expr_27362 as varchar) as 'AMDRPTTH02 - It was too strong --- Hot Tea',
cast( expr_27363 as varchar) as 'AMDRPTTH03 - It was too weak --- Hot Tea',
cast( expr_27364 as varchar) as 'AMDRPTTH04 - Other --- Hot Tea',
cast( expr_27365 as varchar) as 'AMDRPTGS01 - The lettuce was soggy or wilted --- G',
cast( expr_27366 as varchar) as 'AMDRPTGS02 - Produce wasnt fresh --- Garden Fresh',
cast( expr_27367 as varchar) as 'AMDRPTGS03 - The chicken was burnt or dry --- Gard',
cast( expr_27368 as varchar) as 'AMDRPTGS04 - The chicken was soggy --- Garden Fres',
cast( expr_27369 as varchar) as 'AMDRPTGS05 - Tomatoes were not juicy --- Garden Fr',
cast( expr_27370 as varchar) as 'AMDRPTGS06 - Other --- Garden Fresh Salad',
cast( expr_27371 as varchar) as 'AMDRPTMS01 - The lettuce was soggy or wilted --- M',
cast( expr_27372 as varchar) as 'AMDRPTMS02 - Produce wasnt fresh --- Mediterranea',
cast( expr_27373 as varchar) as 'AMDRPTMS03 - The chicken was burnt or dry --- Medi',
cast( expr_27374 as varchar) as 'AMDRPTMS04 - The chicken was soggy --- Mediterrane',
cast( expr_27375 as varchar) as 'AMDRPTMS05 - Tomatoes were not juicy --- Mediterra',
cast( expr_27376 as varchar) as 'AMDRPTMS06 - Other --- Mediterranean Salad',
cast( expr_27377 as varchar) as 'AMDRPTMC01 - The lettuce was soggy or wilted --- M',
cast( expr_27378 as varchar) as 'AMDRPTMC02 - Produce wasnt fresh --- Mighty Caesa',
cast( expr_27379 as varchar) as 'AMDRPTMC03 - The chicken was burnt or dry --- Migh',
cast( expr_27380 as varchar) as 'AMDRPTMC04 - The chicken was soggy --- Mighty Caes',
cast( expr_27381 as varchar) as 'AMDRPTMC05 - Tomatoes were not juicy --- Mighty Ca',
cast( expr_27382 as varchar) as 'AMDRPTMC06 - Other --- Mighty Caesar Salad',
cast( expr_27383 as varchar) as 'AMDRPTSS01 - The lettuce was soggy or wilted --- S',
cast( expr_27384 as varchar) as 'AMDRPTSS02 - Produce wasnt fresh --- Side Salad',
cast( expr_27385 as varchar) as 'AMDRPTSS03 - The chicken was burnt or dry --- Side',
cast( expr_27386 as varchar) as 'AMDRPTSS04 - The chicken was soggy --- Side Salad',
cast( expr_27387 as varchar) as 'AMDRPTSS05 - Tomatoes were not juicy --- Side Sala',
cast( expr_27388 as varchar) as 'AMDRPTSS06 - Other --- Side Salad',
cast( expr_27389 as varchar) as 'AMDRPTST01 - The lettuce was soggy or wilted --- S',
cast( expr_27390 as varchar) as 'AMDRPTST02 - Produce wasnt fresh --- Spicy Thai S',
cast( expr_27391 as varchar) as 'AMDRPTST03 - The chicken was burnt or dry --- Spic',
cast( expr_27392 as varchar) as 'AMDRPTST04 - The chicken was soggy --- Spicy Thai ',
cast( expr_27393 as varchar) as 'AMDRPTST05 - Tomatoes were not juicy --- Spicy Tha',
cast( expr_27394 as varchar) as 'AMDRPTST06 - Other --- Spicy Thai Salad',
cast( expr_27395 as varchar) as 'AMDRPTHB01 - They were greasy --- Hash Browns',
cast( expr_27396 as varchar) as 'AMDRPTHB02 - They were soggy --- Hash Browns',
cast( expr_27397 as varchar) as 'AMDRPTHB03 - They were old or stale --- Hash Brown',
cast( expr_27398 as varchar) as 'AMDRPTHB04 - They were burnt or hard --- Hash Brow',
cast( expr_27399 as varchar) as 'AMDRPTHB05 - Other --- Hash Browns',
cast( expr_27400 as varchar) as 'AMDRPTAB01 - The sandwich was greasy --- Angus Bur',
cast( expr_27401 as varchar) as 'AMDRPTAB02 - The meat was dry --- Angus Burger',
cast( expr_27402 as varchar) as 'AMDRPTAB03 - The meat wasnt cooked enough --- Ang',
cast( expr_27403 as varchar) as 'AMDRPTAB04 - The bun was hard, dry or cracked --- ',
cast( expr_27404 as varchar) as 'AMDRPTAB05 - The bun was soggy --- Angus Burger',
cast( expr_27405 as varchar) as 'AMDRPTAB06 - The produce wasnt fresh --- Angus Bu',
cast( expr_27406 as varchar) as 'AMDRPTAB07 - Cheese wasnt melted enough --- Angus',
cast( expr_27407 as varchar) as 'AMDRPTAB08 - Cheese was too melted  --- Angus Burg',
cast( expr_27408 as varchar) as 'AMDRPTAB09 - Other --- Angus Burger',
cast( expr_27409 as varchar) as 'AMDRPTBS01 - The sandwich was greasy --- Bagel san',
cast( expr_27410 as varchar) as 'AMDRPTBS02 - The meat was dry --- Bagel sandwich(e',
cast( expr_27411 as varchar) as 'AMDRPTBS03 - The meat wasnt cooked enough --- Bag',
cast( expr_27412 as varchar) as 'AMDRPTBS04 - The bagel was hard or dry --- Bagel s',
cast( expr_27413 as varchar) as 'AMDRPTBS05 - The bagel was soggy --- Bagel sandwic',
cast( expr_27414 as varchar) as 'AMDRPTBS06 - Other --- Bagel sandwich(es)',
cast( expr_27415 as varchar) as 'AMDRPTBM01 - The sandwich was greasy --- Big Mac® ',
cast( expr_27416 as varchar) as 'AMDRPTBM02 - The meat was dry --- Big Mac® sandwic',
cast( expr_27417 as varchar) as 'AMDRPTBM03 - The meat wasnt cooked enough --- Big',
cast( expr_27418 as varchar) as 'AMDRPTBM04 - The bun was hard, dry or cracked --- ',
cast( expr_27419 as varchar) as 'AMDRPTBM05 - The bun was soggy --- Big Mac® sandwi',
cast( expr_27420 as varchar) as 'AMDRPTBM06 - The produce wasnt fresh --- Big Mac®',
cast( expr_27421 as varchar) as 'AMDRPTBM07 - Cheese wasnt melted enough --- Big M',
cast( expr_27422 as varchar) as 'AMDRPTBM08 - Cheese was too melted  --- Big Mac® s',
cast( expr_27423 as varchar) as 'AMDRPTBM09 - Other --- Big Mac® sandwich  / Double',
cast( expr_27424 as varchar) as 'AMDRPTBB01 - The burrito was greasy --- Breakfast ',
cast( expr_27425 as varchar) as 'AMDRPTBB02 - The egg was dry --- Breakfast Burrito',
cast( expr_27426 as varchar) as 'AMDRPTBB03 - The egg wasnt cooked enough --- Brea',
cast( expr_27427 as varchar) as 'AMDRPTBB04 - The wrap was hard or dry --- Breakfas',
cast( expr_27428 as varchar) as 'AMDRPTBB05 - The wrap was soggy --- Breakfast Burr',
cast( expr_27429 as varchar) as 'AMDRPTBB06 - Other --- Breakfast Burrito',
cast( expr_27430 as varchar) as 'AMDRPTBP01 - The meat was dry --- Breakfast Platte',
cast( expr_27431 as varchar) as 'AMDRPTBP02 - The meat wasnt cooked enough --- Bre',
cast( expr_27432 as varchar) as 'AMDRPTBP03 - The eggs were undercooked --- Breakfa',
cast( expr_27433 as varchar) as 'AMDRPTBP04 - The eggs were overcooked --- Breakfas',
cast( expr_27434 as varchar) as 'AMDRPTBP05 - The pancakes were hard or dry --- Bre',
cast( expr_27435 as varchar) as 'AMDRPTBP06 - The pancakes were soggy --- Breakfast',
cast( expr_27436 as varchar) as 'AMDRPTBP07 - Other --- Breakfast Platter',
cast( expr_27437 as varchar) as 'AMDRPTCC01 - The sandwich was greasy --- Chicken C',
cast( expr_27438 as varchar) as 'AMDRPTCC02 - The chicken was dry --- Chicken Class',
cast( expr_27439 as varchar) as 'AMDRPTCC03 - The chicken wasnt cooked enough --- ',
cast( expr_27440 as varchar) as 'AMDRPTCC04 - The bun was hard, dry and cracked ---',
cast( expr_27441 as varchar) as 'AMDRPTCC05 - The bun was soggy --- Chicken Classic',
cast( expr_27442 as varchar) as 'AMDRPTCC06 - The produce wasnt fresh --- Chicken ',
cast( expr_27443 as varchar) as 'AMDRPTCC07 - Other --- Chicken Classic sandwich',
cast( expr_27444 as varchar) as 'AMDRPTCF01 - The wrap was greasy --- Chicken Fajit',
cast( expr_27445 as varchar) as 'AMDRPTCF02 - The chicken was dry --- Chicken Fajit',
cast( expr_27446 as varchar) as 'AMDRPTCF03 - The chicken wasnt cooked enough --- ',
cast( expr_27447 as varchar) as 'AMDRPTCF04 - The wrap was hard, dry or cracked ---',
cast( expr_27448 as varchar) as 'AMDRPTCF05 - The wrap was soggy --- Chicken Fajita',
cast( expr_27449 as varchar) as 'AMDRPTCF06 - The produce wasnt fresh --- Chicken ',
cast( expr_27450 as varchar) as 'AMDRPTCF07 - Other --- Chicken Fajita',
cast( expr_27451 as varchar) as 'AMDRPTCW01 - The wrap was greasy --- Chicken Snack',
cast( expr_27452 as varchar) as 'AMDRPTCW02 - The chicken was dry --- Chicken Snack',
cast( expr_27453 as varchar) as 'AMDRPTCW03 - The chicken wasnt cooked enough --- ',
cast( expr_27454 as varchar) as 'AMDRPTCW04 - The wrap was hard, dry or cracked ---',
cast( expr_27455 as varchar) as 'AMDRPTCW05 - The wrap was soggy --- Chicken Snack ',
cast( expr_27456 as varchar) as 'AMDRPTCW06 - The produce wasnt fresh --- Chicken ',
cast( expr_27457 as varchar) as 'AMDRPTCW07 - Other --- Chicken Snack Wrap®',
cast( expr_27458 as varchar) as 'AMDRPTDC01 - The sandwich was greasy --- Double Ch',
cast( expr_27459 as varchar) as 'AMDRPTDC02 - The meat was dry --- Double Cheesebur',
cast( expr_27460 as varchar) as 'AMDRPTDC03 - The meat wasnt cooked enough --- Dou',
cast( expr_27461 as varchar) as 'AMDRPTDC04 - The bun was hard, dry or cracked --- ',
cast( expr_27462 as varchar) as 'AMDRPTDC05 - The bun was soggy --- Double Cheesebu',
cast( expr_27463 as varchar) as 'AMDRPTDC06 - Cheese wasnt melted enough --- Doubl',
cast( expr_27464 as varchar) as 'AMDRPTDC07 - Cheese was too melted  --- Double Che',
cast( expr_27465 as varchar) as 'AMDRPTDC08 - Other --- Double Cheeseburger',
cast( expr_27466 as varchar) as 'AMDRPTEM01 - The sandwich was greasy --- Egg McMuf',
cast( expr_27467 as varchar) as 'AMDRPTEM02 - The egg was dry --- Egg McMuffin® san',
cast( expr_27468 as varchar) as 'AMDRPTEM03 - The Canadian bacon was dry --- Egg Mc',
cast( expr_27469 as varchar) as 'AMDRPTEM04 - The egg wasnt cooked enough --- Egg ',
cast( expr_27470 as varchar) as 'AMDRPTEM05 - The english muffin was hard, dry or b',
cast( expr_27471 as varchar) as 'AMDRPTEM06 - The english muffin was soggy or under',
cast( expr_27472 as varchar) as 'AMDRPTEM07 - Other --- Egg McMuffin® sandwich(es)',
cast( expr_27473 as varchar) as 'AMDRPTOF01 - The sandwich was greasy --- Filet-o-F',
cast( expr_27474 as varchar) as 'AMDRPTOF02 - The fish was dry --- Filet-o-Fish® sa',
cast( expr_27475 as varchar) as 'AMDRPTOF03 - The fish wasnt cooked enough --- Fil',
cast( expr_27476 as varchar) as 'AMDRPTOF04 - The bun was hard, dry or cracked --- ',
cast( expr_27477 as varchar) as 'AMDRPTOF05 - The bun was soggy --- Filet-o-Fish® s',
cast( expr_27478 as varchar) as 'AMDRPTOF06 - There was too much tartar sauce --- F',
cast( expr_27479 as varchar) as 'AMDRPTOF07 - Other --- Filet-o-Fish® sandwich',
cast( expr_27480 as varchar) as 'AMDRPTHC01 - The sandwich was greasy --- Hamburger',
cast( expr_27481 as varchar) as 'AMDRPTHC02 - The meat was dry --- Hamburger / Chee',
cast( expr_27482 as varchar) as 'AMDRPTHC03 - The meat wasnt cooked enough --- Ham',
cast( expr_27483 as varchar) as 'AMDRPTHC04 - The bun was hard, dry or cracked --- ',
cast( expr_27484 as varchar) as 'AMDRPTHC05 - The bun was soggy --- Hamburger / Che',
cast( expr_27485 as varchar) as 'AMDRPTHC06 - Cheese wasnt melted enough --- Hambu',
cast( expr_27486 as varchar) as 'AMDRPTHC07 - Cheese was too melted  --- Hamburger ',
cast( expr_27487 as varchar) as 'AMDRPTHC08 - Other --- Hamburger / Cheeseburger',
cast( expr_27488 as varchar) as 'AMDRPTHH01 - The sandwich was greasy --- Happy Mea',
cast( expr_27489 as varchar) as 'AMDRPTHH02 - The meat was dry --- Happy Meal® Hamb',
cast( expr_27490 as varchar) as 'AMDRPTHH03 - The meat wasnt cooked enough --- Hap',
cast( expr_27491 as varchar) as 'AMDRPTHH04 - The bun was hard, dry or cracked --- ',
cast( expr_27492 as varchar) as 'AMDRPTHH05 - The bun was soggy --- Happy Meal® Ham',
cast( expr_27493 as varchar) as 'AMDRPTHH06 - Cheese wasnt melted enough --- Happy',
cast( expr_27494 as varchar) as 'AMDRPTHH07 - Cheese was too melted  --- Happy Meal',
cast( expr_27495 as varchar) as 'AMDRPTHH08 - Other --- Happy Meal® Hamburger / Che',
cast( expr_27496 as varchar) as 'AMDRPTJS01 - The sandwich was greasy --- Jr. Chick',
cast( expr_27497 as varchar) as 'AMDRPTJS02 - The chicken was dry --- Jr. Chicken s',
cast( expr_27498 as varchar) as 'AMDRPTJS03 - The chicken wasnt cooked enough --- ',
cast( expr_27499 as varchar) as 'AMDRPTJS04 - The bun was hard or dry --- Jr. Chick',
cast( expr_27500 as varchar) as 'AMDRPTJS05 - The bun was soggy --- Jr. Chicken san',
cast( expr_27501 as varchar) as 'AMDRPTJS06 - The produce wasnt fresh --- Jr. Chic',
cast( expr_27502 as varchar) as 'AMDRPTJS07 - Other --- Jr. Chicken sandwich',
cast( expr_27503 as varchar) as 'AMDRPTMW01 - The wrap was greasy --- Mac Snack Wra',
cast( expr_27504 as varchar) as 'AMDRPTMW02 - The meat was dry --- Mac Snack Wrap™',
cast( expr_27505 as varchar) as 'AMDRPTMW03 - The meat wasnt cooked enough --- Mac',
cast( expr_27506 as varchar) as 'AMDRPTMW04 - The wrap was hard, dry or cracked  --',
cast( expr_27507 as varchar) as 'AMDRPTMW05 - The wrap was soggy --- Mac Snack Wrap',
cast( expr_27508 as varchar) as 'AMDRPTMW06 - The produce wasnt fresh --- Mac Snac',
cast( expr_27509 as varchar) as 'AMDRPTMW07 - Other --- Mac Snack Wrap™',
cast( expr_27510 as varchar) as 'AMDRPTCH01 - The sandwich was greasy --- McChicken',
cast( expr_27511 as varchar) as 'AMDRPTCH02 - The chicken was dry --- McChicken® sa',
cast( expr_27512 as varchar) as 'AMDRPTCH03 - The chicken wasnt cooked enough --- ',
cast( expr_27513 as varchar) as 'AMDRPTCH04 - The bun was hard or dry --- McChicken',
cast( expr_27514 as varchar) as 'AMDRPTCH05 - The bun was soggy --- McChicken® sand',
cast( expr_27515 as varchar) as 'AMDRPTCH06 - The produce wasnt fresh --- McChicke',
cast( expr_27516 as varchar) as 'AMDRPTCH07 - Other --- McChicken® sandwich',
cast( expr_27517 as varchar) as 'AMDRPTMD01 - The sandwich was greasy --- McDouble™',
cast( expr_27518 as varchar) as 'AMDRPTMD02 - The meat or bacon was dry --- McDoubl',
cast( expr_27519 as varchar) as 'AMDRPTMD03 - The meat or bacon wasnt cooked enoug',
cast( expr_27520 as varchar) as 'AMDRPTMD04 - The bun was hard, dry or cracked --- ',
cast( expr_27521 as varchar) as 'AMDRPTMD05 - The bun was soggy --- McDouble™ sandw',
cast( expr_27522 as varchar) as 'AMDRPTMD06 - Cheese wasnt melted enough --- McDou',
cast( expr_27523 as varchar) as 'AMDRPTMD07 - Cheese was too melted  --- McDouble™ ',
cast( expr_27524 as varchar) as 'AMDRPTMD08 - Other --- McDouble™ sandwich / Bacon ',
cast( expr_27525 as varchar) as 'AMDRPTMG01 - The sandwich was greasy --- McGriddle',
cast( expr_27526 as varchar) as 'AMDRPTMG02 - The meat was dry --- McGriddles® sand',
cast( expr_27527 as varchar) as 'AMDRPTMG03 - The meat wasnt cooked enough --- McG',
cast( expr_27528 as varchar) as 'AMDRPTMG04 - The McGriddle cake was hard or dry --',
cast( expr_27529 as varchar) as 'AMDRPTMG05 - The McGriddle cake was soggy --- McGr',
cast( expr_27530 as varchar) as 'AMDRPTMG06 - Too sweet  --- McGriddles® sandwich(e',
cast( expr_27531 as varchar) as 'AMDRPTMG07 - Not sweet enough --- McGriddles® sand',
cast( expr_27532 as varchar) as 'AMDRPTMG08 - Other --- McGriddles® sandwich(es)',
cast( expr_27533 as varchar) as 'AMDRPTNG01 - The Chicken McNuggets® were dry --- M',
cast( expr_27534 as varchar) as 'AMDRPTNG02 - The Chicken McNuggets® werent cooked',
cast( expr_27535 as varchar) as 'AMDRPTNG03 - The breading was overcooked --- McNug',
cast( expr_27536 as varchar) as 'AMDRPTNG04 - The breading was undercooked --- McNu',
cast( expr_27537 as varchar) as 'AMDRPTNG05 - Other --- Chicken McNuggets®',
cast( expr_27538 as varchar) as 'AMDRPTHN01 - The Chicken McNuggets® were dry',
cast( expr_27539 as varchar) as 'AMDRPTHN02 - The The Chicken McNuggets® werent co',
cast( expr_27540 as varchar) as 'AMDRPTHN03 - The breading was overcooked --- Happy',
cast( expr_27541 as varchar) as 'AMDRPTHN04 - The breading was undercooked --- Happ',
cast( expr_27542 as varchar) as 'AMDRPTHN05 - Other --- Happy Meal® McNuggets®',
cast( expr_27543 as varchar) as 'AMDRPTQP01 - The sandwich was greasy --- Quarter P',
cast( expr_27544 as varchar) as 'AMDRPTQP02 - The meat was dry --- Quarter Pounder ',
cast( expr_27545 as varchar) as 'AMDRPTQP03 - The meat wasnt cooked enough --- Qua',
cast( expr_27546 as varchar) as 'AMDRPTQP04 - The bun was hard, dry or cracked --- ',
cast( expr_27547 as varchar) as 'AMDRPTQP05 - The bun was soggy --- Quarter Pounder',
cast( expr_27548 as varchar) as 'AMDRPTQP06 - Cheese wasnt melted enough --- Quart',
cast( expr_27549 as varchar) as 'AMDRPTQP07 - Cheese was too melted  --- Quarter Po',
cast( expr_27550 as varchar) as 'AMDRPTQP08 - Other --- Quarter Pounder with Cheese',
cast( expr_27551 as varchar) as 'AMDRPTSM01 - The sandwich was greasy --- Sausage M',
cast( expr_27552 as varchar) as 'AMDRPTSM02 - The egg was dry --- Sausage McMuffin®',
cast( expr_27553 as varchar) as 'AMDRPTSM03 - The sausage was dry --- Sausage McMuf',
cast( expr_27554 as varchar) as 'AMDRPTSM04 - The sausage was too greasy --- Sausag',
cast( expr_27555 as varchar) as 'AMDRPTSM05 - The egg wasnt cooked enough --- Saus',
cast( expr_27556 as varchar) as 'AMDRPTSM06 - The english muffin was hard, dry or b',
cast( expr_27557 as varchar) as 'AMDRPTSM07 - The english muffin was soggy or under',
cast( expr_27558 as varchar) as 'AMDRPTSM08 - Other --- Sausage McMuffin® sandwich(',
cast( expr_27559 as varchar) as 'AMDRPTSW01 - The sandwich was greasy --- Southwest',
cast( expr_27560 as varchar) as 'AMDRPTSW02 - The chicken was dry --- Southwest Chi',
cast( expr_27561 as varchar) as 'AMDRPTSW03 - The chicken wasnt cooked enough --- ',
cast( expr_27562 as varchar) as 'AMDRPTSW04 - The bun was hard, dry or cracked --- ',
cast( expr_27563 as varchar) as 'AMDRPTSW05 - The bun was soggy --- Southwest Chick',
cast( expr_27564 as varchar) as 'AMDRPTSW06 - The produce wasnt fresh --- Southwes',
cast( expr_27565 as varchar) as 'AMDRPTSW07 - Other --- Southwest Chicken sandwich',
cast( expr_27566 as varchar) as 'AMDRPABW01 - The bottle was damaged --- Bottled Wa',
cast( expr_27567 as varchar) as 'AMDRPABW02 - The bottle was dirty --- Bottled Wate',
cast( expr_27568 as varchar) as 'AMDRPABW03 - Other --- Bottled Water',
cast( expr_27569 as varchar) as 'AMDRPASD01 - The cup wasnt filled enough --- Foun',
cast( expr_27570 as varchar) as 'AMDRPASD02 - The cup was overfilled --- Fountain S',
cast( expr_27571 as varchar) as 'AMDRPASD03 - The lid wasnt on properly --- Founta',
cast( expr_27572 as varchar) as 'AMDRPASD04 - Unappealing appearance --- Fountain S',
cast( expr_27573 as varchar) as 'AMDRPASD05 - Other --- Fountain Soft Drink',
cast( expr_27574 as varchar) as 'AMDRPAIC01 - The cup wasnt filled enough --- Iced',
cast( expr_27575 as varchar) as 'AMDRPAIC02 - The cup was overfilled --- Iced Coffe',
cast( expr_27576 as varchar) as 'AMDRPAIC03 - The lid wasnt on properly --- Iced C',
cast( expr_27577 as varchar) as 'AMDRPAIC04 - Unappealing appearance --- Iced Coffe',
cast( expr_27578 as varchar) as 'AMDRPAIC05 - Other --- Iced Coffee',
cast( expr_27579 as varchar) as 'AMDRPAIL01 - The cup wasnt filled enough --- Iced',
cast( expr_27580 as varchar) as 'AMDRPAIL02 - The cup was overfilled --- Iced Latte',
cast( expr_27581 as varchar) as 'AMDRPAIL03 - The lid wasnt on properly --- Iced L',
cast( expr_27582 as varchar) as 'AMDRPAIL04 - Unappealing appearance --- Iced Latte',
cast( expr_27583 as varchar) as 'AMDRPAIL05 - Other --- Iced Latte',
cast( expr_27584 as varchar) as 'AMDRPAIM01 - The cup wasnt filled enough --- Iced',
cast( expr_27585 as varchar) as 'AMDRPAIM02 - The cup was overfilled --- Iced Mocha',
cast( expr_27586 as varchar) as 'AMDRPAIM03 - The lid wasnt on properly --- Iced M',
cast( expr_27587 as varchar) as 'AMDRPAIM04 - Unappealing appearance --- Iced Mocha',
cast( expr_27588 as varchar) as 'AMDRPAIM05 - Other --- Iced Mocha',
cast( expr_27589 as varchar) as 'AMDRPAIT01 - The cup wasnt filled enough --- Iced',
cast( expr_27590 as varchar) as 'AMDRPAIT02 - The cup was overfilled --- Iced Tea',
cast( expr_27591 as varchar) as 'AMDRPAIT03 - The lid wasnt on properly --- Iced T',
cast( expr_27592 as varchar) as 'AMDRPAIT04 - Unappealing appearance --- Iced Tea',
cast( expr_27593 as varchar) as 'AMDRPAIT05 - Other --- Iced Tea',
cast( expr_27594 as varchar) as 'AMDRPAJC01 - The carton or cup was damaged --- Jui',
cast( expr_27595 as varchar) as 'AMDRPAJC02 - The carton or cup was dirty --- Juice',
cast( expr_27596 as varchar) as 'AMDRPAJC03 - Other --- Juice',
cast( expr_27597 as varchar) as 'AMDRPAMK01 - The carton was damaged --- Milk',
cast( expr_27598 as varchar) as 'AMDRPAMK02 - The carton was dirty --- Milk',
cast( expr_27599 as varchar) as 'AMDRPAMK03 - Other --- Milk',
cast( expr_27600 as varchar) as 'AMDRPATM01 - The cup wasnt filled enough --- Trip',
cast( expr_27601 as varchar) as 'AMDRPATM02 - The cup was overfilled --- Triple Thi',
cast( expr_27602 as varchar) as 'AMDRPATM03 - The lid wasnt on properly --- Triple',
cast( expr_27603 as varchar) as 'AMDRPATM04 - The cup was messy or leaking --- Trip',
cast( expr_27604 as varchar) as 'AMDRPATM05 - Other --- Triple Thick Milkshake®',
cast( expr_27605 as varchar) as 'AMDRPACM01 - It was burnt --- Cinnamon Melts®',
cast( expr_27606 as varchar) as 'AMDRPACM02 - It was too flaky (DELETE) --- Cinna',
cast( expr_27607 as varchar) as 'AMDRPACM03 - The filling was leaking out --- Cinna',
cast( expr_27608 as varchar) as 'AMDRPACM04 - It had too much topping --- Cinnamon ',
cast( expr_27609 as varchar) as 'AMDRPACM05 - Other --- Cinnamon Melts®',
cast( expr_27610 as varchar) as 'AMDRPACS01 - It didnt have enough topping --- Con',
cast( expr_27611 as varchar) as 'AMDRPACS02 - It had too much topping --- Cone / Su',
cast( expr_27612 as varchar) as 'AMDRPACS03 - It was messy --- Cone / Sundae',
cast( expr_27613 as varchar) as 'AMDRPACS04 - It was runny / melted --- Cone / Sund',
cast( expr_27614 as varchar) as 'AMDRPACS05 - Other --- Cone / Sundae',
cast( expr_27615 as varchar) as 'AMDRPAFY01 - The cup wasnt filled enough --- Frui',
cast( expr_27616 as varchar) as 'AMDRPAFY02 - The cup was overfilled --- Fruit & Yo',
cast( expr_27617 as varchar) as 'AMDRPAFY03 - The lid wasnt on properly --- Fruit ',
cast( expr_27618 as varchar) as 'AMDRPAFY04 - Unappealing appearance --- Fruit & Yo',
cast( expr_27619 as varchar) as 'AMDRPAFY05 - Other --- Fruit & Yogurt Parfait',
cast( expr_27620 as varchar) as 'AMDRPAMF01 - It didnt have enough topping --- McF',
cast( expr_27621 as varchar) as 'AMDRPAMF02 - It had too much topping --- McFlurry®',
cast( expr_27622 as varchar) as 'AMDRPAMF03 - The cup was messy or leaking --- McFl',
cast( expr_27623 as varchar) as 'AMDRPAMF04 - It was runny / melted --- McFlurry® d',
cast( expr_27624 as varchar) as 'AMDRPAMF05 - Other --- McFlurry® dessert',
cast( expr_27625 as varchar) as 'AMDRPAMN01 - It looked burnt --- Muffin',
cast( expr_27626 as varchar) as 'AMDRPAMN02 - It was broken --- Muffin',
cast( expr_27627 as varchar) as 'AMDRPAMN03 - The paper stuck to the muffin --- Muf',
cast( expr_27628 as varchar) as 'AMDRPAMN04 - Other --- Muffin',
cast( expr_27629 as varchar) as 'AMDRPAPI01 - It was burnt --- Pie',
cast( expr_27630 as varchar) as 'AMDRPAPI02 - It was broken --- Pie',
cast( expr_27631 as varchar) as 'AMDRPAPI03 - It was too flaky --- Pie',
cast( expr_27632 as varchar) as 'AMDRPAPI04 - The filling was leaking out --- Pie',
cast( expr_27633 as varchar) as 'AMDRPAPI05 - Other --- Pie',
cast( expr_27634 as varchar) as 'AMDRPAFF01 - Box/bag wasnt filled all the way ---',
cast( expr_27635 as varchar) as 'AMDRPAFF02 - Too many small pieces --- French Frie',
cast( expr_27636 as varchar) as 'AMDRPAFF03 - They looked burnt --- French Fries',
cast( expr_27637 as varchar) as 'AMDRPAFF04 - Other --- French Fries',
cast( expr_27638 as varchar) as 'AMDRPAHF01 - Box/bag wasnt filled all the way ---',
cast( expr_27639 as varchar) as 'AMDRPAHF02 - Too many small pieces --- Happy Meal®',
cast( expr_27640 as varchar) as 'AMDRPAHF03 - They looked burnt --- Happy Meal® Fre',
cast( expr_27641 as varchar) as 'AMDRPAHF04 - Other --- Happy Meal® French Fries',
cast( expr_27642 as varchar) as 'AMDRPACP01 - The cup wasnt filled enough --- Capp',
cast( expr_27643 as varchar) as 'AMDRPACP02 - The cup was overfilled --- Cappuccino',
cast( expr_27644 as varchar) as 'AMDRPACP03 - The lid wasnt on properly --- Cappuc',
cast( expr_27645 as varchar) as 'AMDRPACP04 - Unappealing appearance --- Cappuccino',
cast( expr_27646 as varchar) as 'AMDRPACP05 - Other --- Cappuccino',
cast( expr_27647 as varchar) as 'AMDRPAES01 - The cup wasnt filled enough --- Espr',
cast( expr_27648 as varchar) as 'AMDRPAES02 - The cup was overfilled --- Espresso',
cast( expr_27649 as varchar) as 'AMDRPAES03 - The lid wasnt on properly --- Espres',
cast( expr_27650 as varchar) as 'AMDRPAES04 - Unappealing appearance --- Espresso',
cast( expr_27651 as varchar) as 'AMDRPAES05 - Other --- Espresso',
cast( expr_27652 as varchar) as 'AMDRPALT01 - The cup wasnt filled enough --- Latt',
cast( expr_27653 as varchar) as 'AMDRPALT02 - The cup was overfilled --- Latte',
cast( expr_27654 as varchar) as 'AMDRPALT03 - The lid wasnt on properly --- Latte',
cast( expr_27655 as varchar) as 'AMDRPALT04 - Unappealing appearance --- Latte',
cast( expr_27656 as varchar) as 'AMDRPALT05 - Other --- Latte',
cast( expr_27657 as varchar) as 'AMDRPAMA01 - The cup wasnt filled enough --- Moch',
cast( expr_27658 as varchar) as 'AMDRPAMA02 - The cup was overfilled --- Mocha',
cast( expr_27659 as varchar) as 'AMDRPAMA03 - The lid wasnt on properly --- Mocha',
cast( expr_27660 as varchar) as 'AMDRPAMA04 - Unappealing appearance --- Mocha',
cast( expr_27661 as varchar) as 'AMDRPAMA05 - Other --- Mocha',
cast( expr_27662 as varchar) as 'AMDRPARC01 - The cup wasnt filled enough --- Regu',
cast( expr_27663 as varchar) as 'AMDRPARC02 - The cup was overfilled --- Regular or',
cast( expr_27664 as varchar) as 'AMDRPARC03 - The lid wasnt on properly --- Regula',
cast( expr_27665 as varchar) as 'AMDRPARC04 - It didnt look good --- Regular or De',
cast( expr_27666 as varchar) as 'AMDRPARC05 - Other --- Regular or Decaf Coffee',
cast( expr_27667 as varchar) as 'AMDRPATH01 - The cup wasnt filled enough --- Tea',
cast( expr_27668 as varchar) as 'AMDRPATH02 - The cup was overfilled --- Hot Tea',
cast( expr_27669 as varchar) as 'AMDRPATH03 - The lid wasnt on properly --- Hot Te',
cast( expr_27670 as varchar) as 'AMDRPATH04 - Unappealing appearance --- Hot Tea',
cast( expr_27671 as varchar) as 'AMDRPATH05 - Other --- Hot Tea',
cast( expr_27672 as varchar) as 'AMDRPAGS01 - The lettuce was wilted --- Garden Fre',
cast( expr_27673 as varchar) as 'AMDRPAGS02 - One or more ingredients had an off co',
cast( expr_27674 as varchar) as 'AMDRPAGS03 - It had a messy appearance --- Garden ',
cast( expr_27675 as varchar) as 'AMDRPAGS04 - The chicken wasnt cut through --- Ga',
cast( expr_27676 as varchar) as 'AMDRPAGS05 - The lid was not on properly --- Garde',
cast( expr_27677 as varchar) as 'AMDRPAGS06 - The salad container wasnt filled eno',
cast( expr_27678 as varchar) as 'AMDRPAGS07 - Other --- Garden Fresh Salad',
cast( expr_27679 as varchar) as 'AMDRPAMS01 - The lettuce was wilted --- Mediterran',
cast( expr_27680 as varchar) as 'AMDRPAMS02 - One or more ingredients had an off co',
cast( expr_27681 as varchar) as 'AMDRPAMS03 - It had a messy appearance --- Mediter',
cast( expr_27682 as varchar) as 'AMDRPAMS04 - The chicken wasnt cut through --- Me',
cast( expr_27683 as varchar) as 'AMDRPAMS05 - The lid was not on properly --- Medit',
cast( expr_27684 as varchar) as 'AMDRPAMS06 - The salad container wasnt filled eno',
cast( expr_27685 as varchar) as 'AMDRPAMS07 - Other --- Mediterranean Salad',
cast( expr_27686 as varchar) as 'AMDRPAMC01 - The lettuce was wilted --- Mighty Cae',
cast( expr_27687 as varchar) as 'AMDRPAMC02 - One or more ingredients had an off co',
cast( expr_27688 as varchar) as 'AMDRPAMC03 - It had a messy appearance --- Mighty ',
cast( expr_27689 as varchar) as 'AMDRPAMC04 - The chicken wasnt cut through --- Mi',
cast( expr_27690 as varchar) as 'AMDRPAMC05 - The lid was not on properly --- Might',
cast( expr_27691 as varchar) as 'AMDRPAMC06 - The salad container wasnt filled eno',
cast( expr_27692 as varchar) as 'AMDRPAMC07 - Other --- Mighty Caesar Salad',
cast( expr_27693 as varchar) as 'AMDRPASS01 - The lettuce was wilted --- Side Salad',
cast( expr_27694 as varchar) as 'AMDRPASS02 - One or more ingredients had an off co',
cast( expr_27695 as varchar) as 'AMDRPASS03 - It had a messy appearance --- Side Sa',
cast( expr_27696 as varchar) as 'AMDRPASS04 - The lid was not on properly --- Side ',
cast( expr_27697 as varchar) as 'AMDRPASS05 - The salad container wasnt filled eno',
cast( expr_27698 as varchar) as 'AMDRPASS06 - Other --- Side Salad',
cast( expr_27699 as varchar) as 'AMDRPAST01 - The lettuce was wilted --- Spicy Thai',
cast( expr_27700 as varchar) as 'AMDRPAST02 - One or more ingredients had an off co',
cast( expr_27701 as varchar) as 'AMDRPAST03 - It had a messy appearance --- Spicy T',
cast( expr_27702 as varchar) as 'AMDRPAST04 - The chicken wasnt cut through --- Sp',
cast( expr_27703 as varchar) as 'AMDRPAST05 - The lid was not on properly --- Spicy',
cast( expr_27704 as varchar) as 'AMDRPAST06 - The salad container wasnt filled eno',
cast( expr_27705 as varchar) as 'AMDRPAST07 - Other --- Spicy Thai Salad',
cast( expr_27706 as varchar) as 'AMDRPAAB01 - The sandwich looked messy --- Angus B',
cast( expr_27707 as varchar) as 'AMDRPAAB02 - The bun was greasy --- Angus Burger',
cast( expr_27708 as varchar) as 'AMDRPAAB03 - The bun was crushed --- Angus Burger',
cast( expr_27709 as varchar) as 'AMDRPAAB04 - The condiments were leaking out of th',
cast( expr_27710 as varchar) as 'AMDRPAAB05 - The sandwich wrap was not on properly',
cast( expr_27711 as varchar) as 'AMDRPAAB06 - Cheese wasnt melted enough --- Angus',
cast( expr_27712 as varchar) as 'AMDRPAAB07 - Cheese was too melted  --- Angus Burg',
cast( expr_27713 as varchar) as 'AMDRPAAB08 - Other --- Angus Burger',
cast( expr_27714 as varchar) as 'AMDRPABS01 - The sandwich looked messy --- Bagel s',
cast( expr_27715 as varchar) as 'AMDRPABS02 - The bagel was greasy --- Bagel sandwi',
cast( expr_27716 as varchar) as 'AMDRPABS03 - The bagel was crushed --- Bagel sandw',
cast( expr_27717 as varchar) as 'AMDRPABS04 - The condiments were leaking out of th',
cast( expr_27718 as varchar) as 'AMDRPABS05 - Other --- Bagel sandwich(es)',
cast( expr_27719 as varchar) as 'AMDRPABM01 - The sandwich looked messy --- Big Mac',
cast( expr_27720 as varchar) as 'AMDRPABM02 - The bun was greasy --- Big Mac® sandw',
cast( expr_27721 as varchar) as 'AMDRPABM03 - The bun was crushed --- Big Mac® sand',
cast( expr_27722 as varchar) as 'AMDRPABM04 - The condiments were leaking out of th',
cast( expr_27723 as varchar) as 'AMDRPABM05 - Too much lettuce --- Big Mac® sandwic',
cast( expr_27724 as varchar) as 'AMDRPABM06 - Cheese wasnt melted enough --- Big M',
cast( expr_27725 as varchar) as 'AMDRPABM07 - Cheese was too melted  --- Big Mac® s',
cast( expr_27726 as varchar) as 'AMDRPABM08 - Other --- Big Mac® sandwich  / Double',
cast( expr_27727 as varchar) as 'AMDRPABB01 - The burrito looked messy --- Breakfas',
cast( expr_27728 as varchar) as 'AMDRPABB02 - The wrap was crushed --- Breakfast Bu',
cast( expr_27729 as varchar) as 'AMDRPABB03 - The condiments were leaking out of th',
cast( expr_27730 as varchar) as 'AMDRPABB04 - Other --- Breakfast Burrito',
cast( expr_27731 as varchar) as 'AMDRPABP01 - The food on the platter looked messy ',
cast( expr_27732 as varchar) as 'AMDRPABP02 - The food was on top of each other  --',
cast( expr_27733 as varchar) as 'AMDRPABP03 - Other --- Breakfast Platter',
cast( expr_27734 as varchar) as 'AMDRPACC01 - The sandwich looked messy --- Chicken',
cast( expr_27735 as varchar) as 'AMDRPACC02 - The bun was greasy --- Chicken Classi',
cast( expr_27736 as varchar) as 'AMDRPACC03 - The bun was crushed --- Chicken Class',
cast( expr_27737 as varchar) as 'AMDRPACC04 - The condiments were leaking out of th',
cast( expr_27738 as varchar) as 'AMDRPACC05 - Other --- Chicken Classic sandwich',
cast( expr_27739 as varchar) as 'AMDRPACF01 - The wrap looked messy --- Chicken Faj',
cast( expr_27740 as varchar) as 'AMDRPACF02 - The wrap was crushed --- Chicken Faji',
cast( expr_27741 as varchar) as 'AMDRPACF03 - The condiments were leaking out of th',
cast( expr_27742 as varchar) as 'AMDRPACF04 - Other --- Chicken Fajita',
cast( expr_27743 as varchar) as 'AMDRPACW01 - The wrap looked messy --- Chicken Sna',
cast( expr_27744 as varchar) as 'AMDRPACW02 - The wrap was crushed --- Chicken Snac',
cast( expr_27745 as varchar) as 'AMDRPACW03 - The condiments were leaking out of th',
cast( expr_27746 as varchar) as 'AMDRPACW04 - Other --- Chicken Snack Wrap®',
cast( expr_27747 as varchar) as 'AMDRPADC01 - The sandwich looked messy --- Double ',
cast( expr_27748 as varchar) as 'AMDRPADC02 - The bun was greasy --- Double Cheeseb',
cast( expr_27749 as varchar) as 'AMDRPADC03 - The bun was crushed --- Double Cheese',
cast( expr_27750 as varchar) as 'AMDRPADC04 - The condiments were leaking out of th',
cast( expr_27751 as varchar) as 'AMDRPADC05 - Cheese wasnt melted enough --- Doubl',
cast( expr_27752 as varchar) as 'AMDRPADC06 - Cheese was too melted  --- Double Che',
cast( expr_27753 as varchar) as 'AMDRPADC07 - Other --- Double Cheeseburger',
cast( expr_27754 as varchar) as 'AMDRPAEM01 - The sandwich looked messy --- Egg McM',
cast( expr_27755 as varchar) as 'AMDRPAEM02 - The english muffin was greasy --- Egg',
cast( expr_27756 as varchar) as 'AMDRPAEM03 - The english muffin was crushed --- Eg',
cast( expr_27757 as varchar) as 'AMDRPAEM04 - Other --- Egg McMuffin® sandwich(es)',
cast( expr_27758 as varchar) as 'AMDRPAOF01 - The sandwich looked messy --- Filet-o',
cast( expr_27759 as varchar) as 'AMDRPAOF02 - The bun was greasy --- Filet-o-Fish® ',
cast( expr_27760 as varchar) as 'AMDRPAOF03 - The bun was crushed --- Filet-o-Fish®',
cast( expr_27761 as varchar) as 'AMDRPAOF04 - The tartar sauce was leaking out of ',
cast( expr_27762 as varchar) as 'AMDRPAOF05 - Other --- Filet-o-Fish® sandwich',
cast( expr_27763 as varchar) as 'AMDRPAHC01 - The sandwich looked messy --- Hamburg',
cast( expr_27764 as varchar) as 'AMDRPAHC02 - The bun was greasy --- Hamburger / Ch',
cast( expr_27765 as varchar) as 'AMDRPAHC03 - The bun was crushed --- Hamburger / C',
cast( expr_27766 as varchar) as 'AMDRPAHC04 - The condiments were leaking out of th',
cast( expr_27767 as varchar) as 'AMDRPAHC05 - Cheese wasnt melted enough --- Hambu',
cast( expr_27768 as varchar) as 'AMDRPAHC06 - Cheese was too melted  --- Hamburger ',
cast( expr_27769 as varchar) as 'AMDRPAHC07 - Other --- Hamburger / Cheeseburger',
cast( expr_27770 as varchar) as 'AMDRPAHH01 - The sandwich looked messy --- Happy M',
cast( expr_27771 as varchar) as 'AMDRPAHH02 - The bun was greasy --- Happy Meal® Ha',
cast( expr_27772 as varchar) as 'AMDRPAHH03 - The bun was crushed --- Happy Meal® H',
cast( expr_27773 as varchar) as 'AMDRPAHH04 - The condiments were leaking out of th',
cast( expr_27774 as varchar) as 'AMDRPAHH05 - Cheese wasnt melted enough --- Happy',
cast( expr_27775 as varchar) as 'AMDRPAHH06 - Cheese was too melted  --- Happy Meal',
cast( expr_27776 as varchar) as 'AMDRPAHH07 - Other --- Happy Meal® Hamburger / Che',
cast( expr_27777 as varchar) as 'AMDRPAJS01 - The sandwich looked messy --- Jr. Chi',
cast( expr_27778 as varchar) as 'AMDRPAJS02 - The bun was greasy --- Jr. Chicken sa',
cast( expr_27779 as varchar) as 'AMDRPAJS03 - The bun was crushed --- Jr. Chicken s',
cast( expr_27780 as varchar) as 'AMDRPAJS04 - The condiments were leaking out of th',
cast( expr_27781 as varchar) as 'AMDRPAJS05 - Other --- Jr. Chicken sandwich',
cast( expr_27782 as varchar) as 'AMDRPAMW01 - The wrap looked messy --- Mac Snack W',
cast( expr_27783 as varchar) as 'AMDRPAMW02 - The wrap was crushed --- Mac Snack Wr',
cast( expr_27784 as varchar) as 'AMDRPAMW03 - The condiments were leaking out of th',
cast( expr_27785 as varchar) as 'AMDRPAMW04 - Too much lettuce --- Mac Snack Wrap™',
cast( expr_27786 as varchar) as 'AMDRPAMW05 - Other --- Mac Snack Wrap™',
cast( expr_27787 as varchar) as 'AMDRPACH01 - The sandwich looked messy --- McChick',
cast( expr_27788 as varchar) as 'AMDRPACH02 - The bun was greasy --- McChicken® san',
cast( expr_27789 as varchar) as 'AMDRPACH03 - The bun was crushed --- McChicken® sa',
cast( expr_27790 as varchar) as 'AMDRPACH04 - The condiments were leaking out of th',
cast( expr_27791 as varchar) as 'AMDRPACH05 - Other --- McChicken® sandwich',
cast( expr_27792 as varchar) as 'AMDRPAMD01 - The sandwich looked messy --- McDoubl',
cast( expr_27793 as varchar) as 'AMDRPAMD02 - The bun was greasy --- McDouble™ sand',
cast( expr_27794 as varchar) as 'AMDRPAMD03 - The bun was crushed --- McDouble™ san',
cast( expr_27795 as varchar) as 'AMDRPAMD04 - The bacon or condiments were leaking ',
cast( expr_27796 as varchar) as 'AMDRPAMD05 - Cheese wasnt melted enough --- McDou',
cast( expr_27797 as varchar) as 'AMDRPAMD06 - Cheese was too melted  --- McDouble™ ',
cast( expr_27798 as varchar) as 'AMDRPAMD07 - Other --- McDouble™ sandwich / Bacon ',
cast( expr_27799 as varchar) as 'AMDRPAMG01 - The sandwich looked messy --- McGridd',
cast( expr_27800 as varchar) as 'AMDRPAMG02 - The McGriddle cake was greasy --- McG',
cast( expr_27801 as varchar) as 'AMDRPAMG03 - The McGriddle cake was crushed --- Mc',
cast( expr_27802 as varchar) as 'AMDRPAMG04 - The condiments were leaking out of th',
cast( expr_27803 as varchar) as 'AMDRPAMG05 - Other --- McGriddles® sandwich(es)',
cast( expr_27804 as varchar) as 'AMDRPAQP01 - The sandwich looked messy --- Quarter',
cast( expr_27805 as varchar) as 'AMDRPAQP02 - The bun was greasy --- Quarter Pounde',
cast( expr_27806 as varchar) as 'AMDRPAQP03 - The bun was crushed --- Quarter Pound',
cast( expr_27807 as varchar) as 'AMDRPAQP04 - The condiments were leaking out of th',
cast( expr_27808 as varchar) as 'AMDRPAQP05 - Cheese wasnt melted enough --- Quart',
cast( expr_27809 as varchar) as 'AMDRPAQP06 - Cheese was too melted  --- Quarter Po',
cast( expr_27810 as varchar) as 'AMDRPAQP07 - Other --- Quarter Pounder with Cheese',
cast( expr_27811 as varchar) as 'AMDRPASM01 - The sandwich looked messy --- Sausage',
cast( expr_27812 as varchar) as 'AMDRPASM02 - The english muffin was greasy --- Sau',
cast( expr_27813 as varchar) as 'AMDRPASM03 - The english muffin was crushed --- Sa',
cast( expr_27814 as varchar) as 'AMDRPASM04 - Other --- Sausage McMuffin® sandwich(',
cast( expr_27815 as varchar) as 'AMDRPASW01 - The sandwich looked messy --- Southwe',
cast( expr_27816 as varchar) as 'AMDRPASW02 - The bun was greasy --- Southwest Chic',
cast( expr_27817 as varchar) as 'AMDRPASW03 - The bun was crushed --- Southwest Chi',
cast( expr_27818 as varchar) as 'AMDRPASW04 - The condiments were leaking out of th',
cast( expr_27819 as varchar) as 'AMDRPASW05 - Other --- Southwest Chicken sandwich',
cast( expr_27820 as varchar) as 'AMDRPUTH01 - It was too hot --- Hot Tea',
cast( expr_27821 as varchar) as 'AMDRPUTH02 - It wasnt hot enough --- Hot Tea',
cast( expr_27822 as varchar) as 'AMDRPUTH03 - It was cold --- Hot Tea',
cast( expr_27823 as varchar) as 'AMDRPUTH04 - Other --- Hot Tea',
cast( expr_27824 as varchar) as 'AMDRPURC01 - It was too hot --- Regular or Decaf C',
cast( expr_27825 as varchar) as 'AMDRPURC02 - It wasnt hot enough --- Regular or D',
cast( expr_27826 as varchar) as 'AMDRPURC03 - It was cold --- Regular or Decaf Coff',
cast( expr_27827 as varchar) as 'AMDRPURC04 - Other --- Regular or Decaf Coffee',
cast( expr_27828 as varchar) as 'AMDRPUMA01 - It was too hot --- Mocha',
cast( expr_27829 as varchar) as 'AMDRPUMA02 - It wasnt hot enough --- Mocha',
cast( expr_27830 as varchar) as 'AMDRPUMA03 - It was cold --- Mocha',
cast( expr_27831 as varchar) as 'AMDRPUMA04 - Other --- Mocha',
cast( expr_27832 as varchar) as 'AMDRPULT01 - It was too hot --- Latte',
cast( expr_27833 as varchar) as 'AMDRPULT02 - It wasnt hot enough --- Latte',
cast( expr_27834 as varchar) as 'AMDRPULT03 - It was cold --- Latte',
cast( expr_27835 as varchar) as 'AMDRPULT04 - Other --- Latte',
cast( expr_27836 as varchar) as 'AMDRPUES01 - It was too hot --- Espresso',
cast( expr_27837 as varchar) as 'AMDRPUES02 - It wasnt hot enough --- Espresso',
cast( expr_27838 as varchar) as 'AMDRPUES03 - It was cold --- Espresso',
cast( expr_27839 as varchar) as 'AMDRPUES04 - Other --- Espresso',
cast( expr_27840 as varchar) as 'AMDRPUCP01 - It was too hot --- Cappuccino',
cast( expr_27841 as varchar) as 'AMDRPUCP02 - It wasnt hot enough --- Cappuccino',
cast( expr_27842 as varchar) as 'AMDRPUCP03 - It was cold --- Cappuccino',
cast( expr_27843 as varchar) as 'AMDRPUCP04 - Other --- Cappuccino',
cast( expr_27876 as varchar) as 'AM Revisit Top Box',
cast( expr_27877 as varchar) as 'AM Revisit Top 2 Box',
cast( expr_27888 as varchar) as 'Likely to Revisit (Top Box)',
cast( expr_27928 as varchar) as 'AMDRPATH03A - The cup was leaking --- Ho',
cast( expr_27929 as varchar) as 'AMDRPAES03A - The cup was leaking --- Es',
cast( expr_27930 as varchar) as 'AMDRPACP03A - The cup was leaking --- Ca',
cast( expr_27931 as varchar) as 'AMDRPAMA03A - The cup was leaking --- Mo',
cast( expr_27932 as varchar) as 'AMDRPALT03A - The cup was leaking --- La',
cast( expr_27933 as varchar) as 'AMDRPARC03A - The cup was leaking --- Re',
cast( expr_27934 as varchar) as 'AMDRPAIM03A - The cup was leaking --- Ic',
cast( expr_27935 as varchar) as 'AMDRPAIL03A - The cup was leaking --- Ic',
cast( expr_27936 as varchar) as 'AMDRPAIC03A - The cup was leaking --- Ic',
cast( expr_27937 as varchar) as 'AMDRPABW02A - The bottle was leaking --- Bo',
cast( expr_27938 as varchar) as 'AMDRPAMK02A - The carton was leaking --- Mi',
cast( expr_27939 as varchar) as 'AMDRPAJC02A - The carton or cup was leaking',
cast( expr_27940 as varchar) as 'AMDRPAIT03A - The cup was messy or leaking --- Ic',
cast( expr_27941 as varchar) as 'AMDRPASD03A - The cup was messy or leaking --- Fo',
cast( expr_27942 as varchar) as 'AMDRPTBS02A - The egg was dry --- Bagel sa',
cast( expr_27943 as varchar) as 'AMDRPTBS03A - The egg wasnt cooked enough',
cast( expr_27944 as varchar) as 'AMDRPTMG02A - The egg was dry --- McGriddl',
cast( expr_27945 as varchar) as 'AMDRPTMG03A - The egg wasnt cooked enough',
cast( expr_27946 as varchar) as 'AMDRPAHB01 - Hash Browns were greasy --- Hash Bro',
cast( expr_27947 as varchar) as 'AMDRPAHB02 - Hash Browns were burnt --- H',
cast( expr_27948 as varchar) as 'AMDRPAHB03 - Other --- Hash Browns',
cast( expr_27951 as varchar) as 'AMDRPTMK03 - It was icy --- Milk',
cast( expr_27952 as varchar) as 'AMDRPTMK01 - It was too warm --- Milk',
cast( expr_27953 as varchar) as 'AMDRPTMK02 - It was spoiled --- Milk',
cast( expr_27954 as varchar) as 'AMDRPTMK04 - Other --- Milk',
cast( expr_27955 as varchar) as 'AMDRPANG01 - Packaging was greasy --- McNuggets® ',
cast( expr_27956 as varchar) as 'AMDRPANG02 - Packaging was messy --- McNuggets® ',
cast( expr_27957 as varchar) as 'AMDRPANG03 - Chicken McNuggets® were burnt',
cast( expr_27958 as varchar) as 'AMDRPANG04 - Other --- McNuggets®',
cast( expr_27959 as varchar) as 'AMDRPAHN01 - Packaging was greasy --- Happy Meal® ',
cast( expr_27960 as varchar) as 'AMDRPAHN02 - Packaging was messy --- Happy Meal® M',
cast( expr_27961 as varchar) as 'AMDRPAHN03 - Happy Meal® Chicken McNuggets® were b',
cast( expr_27962 as varchar) as 'AMDRPAHC04 - Other --- Happy Meal® McNuggets®',
cast( expr_27988 as varchar) as 'AMO04B – Why Favorite QSR',
cast( expr_27989 as varchar) as 'AMDRPAFY02A - The cup was messy or leaking --- Fr',
cast( expr_27990 as varchar) as 'AMDRPATM04A - Unappealing appearance --- Tr',
cast( expr_27992 as varchar) as 'AMDRPABW02B - Unappealing appearance --- B',
cast( expr_27993 as varchar) as 'AMDRPAMK02B - Unappealing appearance --- M',
cast( expr_27994 as varchar) as 'AMDRPAJC02B - Unappealing appearance',
cast( expr_27995 as varchar) as 'AMDRPTOF06A - Not enough tartar sauce ',
cast( expr_27996 as varchar) as 'AMDRPTFY04B - Fruit was old or spoiled --- Fruit &',
cast( expr_27997 as varchar) as 'AMDRPTFY04A - Fruit was frozen --- Frui',
locationnumber,
cast( expr_26569 as varchar) as 'State',
[state] as restaurantinstate,
replace([RGN-NAM],',','|') as 'RGN-NAM',
replace([DIST-NAM],',','|') as 'DIST-NAM',
replace([REST-TYP],',','|') as 'REST-TYP',
replace([MKT-NAM],',','|') as 'MKT-NAM',
replace([MMKT-LDESC],',','|') as 'MMKT-LDESC',
replace([TV-MKT-LDESC],',','|') as 'TV-MKT-LDESC',
cast( expr_33131 as varchar) as 'AMPNI02 - Ordered McMini Sandwich(es)',
cast( expr_33115 as varchar) as 'AMDPUNI02 - Temp. Issue',
cast( expr_33116 as varchar) as 'AMDRINI02 - Prepped Incor',
cast( expr_33117 as varchar) as 'AMDRMNI02 - Missing',
cast( expr_33113 as varchar) as 'AMDPANI02 - Appear Issue',
cast( expr_33118 as varchar) as 'AMDRPANI01 - The sandwich looked messy',
cast( expr_33119 as varchar) as 'AMDRPANI02 - The bun was greasy',
cast( expr_33120 as varchar) as 'AMDRPANI03 - The bun was crushed',
cast( expr_33122 as varchar) as 'AMDRPANI05 - Other',
cast( expr_33114 as varchar) as 'AMDPTNI02 - Taste Issue',
cast( expr_33125 as varchar) as 'AMDRPTNI01 - The sandwich was greasy',
cast( expr_33126 as varchar) as 'AMDRPTNI02 - The chicken was dry',
cast( expr_33128 as varchar) as 'AMDRPTNI04 - The bun was hard or dry',
cast( expr_33129 as varchar) as 'AMDRPTNI05 - The bun was soggy',
cast( expr_33130 as varchar) as 'AMDRPTNI07 - Taste Other',
cast( expr_33121 as varchar) as 'AMDRPANI04 - The condiments were leaking ',
cast( expr_33127 as varchar) as 'AMDRPTNI03 - The chicken wasnt cooked eno',

cast( expr_37229 as varchar) as 'AMDPANIP02 - McMini™ Pesto ',
cast( expr_37226 as varchar) as 'AMDPANIST02 - McMini™ Spicy Thai ',
cast( expr_37230 as varchar) as 'AMDPANIZM02 - McMini™ Zesty Mango ',
cast( expr_37232 as varchar) as 'AMDPTNIP02 - McMini™ Pesto ',
cast( expr_37231 as varchar) as 'AMDPTNIST02 - McMini™ Spicy Thai ',
cast( expr_37233 as varchar) as 'AMDPTNIZM02 - McMini™ Zesty Mango ',
cast( expr_37235 as varchar) as 'AMDPUNIP02 - McMini™ Pesto ',
cast( expr_37234 as varchar) as 'AMDPUNIST02 - McMini™ Spicy Thai ',
cast( expr_37236 as varchar) as 'AMDPUNIZM02 - McMini™ Zesty Mango ',
cast( expr_37238 as varchar) as 'AMDRINIP02 - McMini™ Pesto ',
cast( expr_37237 as varchar) as 'AMDRINIST02 - McMini™ Spicy Thai ',
cast( expr_37239 as varchar) as 'AMDRINIZM02 - McMini™ Zesty Mango ',
cast( expr_37241 as varchar) as 'AMDRMNIP02 - McMini™ Pesto ',
cast( expr_37240 as varchar) as 'AMDRMNIST02 - McMini™ Spicy Thai ',
cast( expr_37242 as varchar) as 'AMDRMNIZM02 - McMini™ Zesty Mango ',
cast( expr_37277 as varchar) as 'AMPNIP02 - McMini™ Pesto ',
cast( expr_37276 as varchar) as 'AMPNIST02 - McMini™ Spicy Thai ',
cast( expr_37278 as varchar) as 'AMPNIZM02 - McMini™ Zesty Mango ',
cast( expr_37244 as varchar) as 'AMDRPANIP01 - The sandwich looked messy',
cast( expr_37247 as varchar) as 'AMDRPANIP02 - The bun was greasy',
cast( expr_37250 as varchar) as 'AMDRPANIP03 - The bun was crushed',
cast( expr_37253 as varchar) as 'AMDRPANIP04 - The condiments were leaking',
cast( expr_37256 as varchar) as 'AMDRPANIP05 - Other',
cast( expr_37259 as varchar) as 'AMDRPTNIP01 - The sandwich was greasy',
cast( expr_37262 as varchar) as 'AMDRPTNIP02 - The chicken was dry',
cast( expr_37265 as varchar) as 'AMDRPTNIP03 - The chicken wasnt cooked',
cast( expr_37268 as varchar) as 'AMDRPTNIP04 - The bun was hard or dry',
cast( expr_37271 as varchar) as 'AMDRPTNIP05 - The bun was soggy',
cast( expr_37274 as varchar) as 'AMDRPTNIP07 - Other',
cast( expr_37243 as varchar) as 'AMDRPANIST01 - The sandwich looked messy',
cast( expr_37246 as varchar) as 'AMDRPANIST02 - The bun was greasy',
cast( expr_37249 as varchar) as 'AMDRPANIST03 - The bun was crushed',
cast( expr_37252 as varchar) as 'AMDRPANIST04 - The condiments were leaking',
cast( expr_37255 as varchar) as 'AMDRPANIST05 - Other Spicy Thai',
cast( expr_37258 as varchar) as 'AMDRPTNIST01 - The sandwich was greasy',
cast( expr_37261 as varchar) as 'AMDRPTNIST02 - The chicken was dry',
cast( expr_37264 as varchar) as 'AMDRPTNIST03 - The chicken wasnt cooked eno',
cast( expr_37267 as varchar) as 'AMDRPTNIST04 - The bun was hard or dry',
cast( expr_37270 as varchar) as 'AMDRPTNIST05 - The bun was soggy',
cast( expr_37273 as varchar) as 'AMDRPTNIST07 - Other Spicy Thai ',
cast( expr_37245 as varchar) as 'AMDRPANIZM01 - The sandwich looked messy ',
cast( expr_37248 as varchar) as 'AMDRPANIZM02 - The bun was greasy',
cast( expr_37251 as varchar) as 'AMDRPANIZM03 - The bun was crushed',
cast( expr_37254 as varchar) as 'AMDRPANIZM04 - The condiments were leaki',
cast( expr_37257 as varchar) as 'AMDRPANIZM05 - Other Zesty Mango ',
cast( expr_37260 as varchar) as 'AMDRPTNIZM01 - The sandwich was greasy',
cast( expr_37263 as varchar) as 'AMDRPTNIZM02 - The chicken was dry',
cast( expr_37266 as varchar) as 'AMDRPTNIZM03 - The chicken wasnt cooked',
cast( expr_37269 as varchar) as 'AMDRPTNIZM04 - The bun was hard or dry',
cast( expr_37272 as varchar) as 'AMDRPTNIZM05 - The bun was soggy',
cast( expr_37275 as varchar) as 'AMDRPTNIZM07 - Other Zesty Mango ',
cast( expr_39540 as varchar) as 'AMPM01 McCafé',

cast( expr_43647 as varchar) as 'AMDPAMB15 - Bacon N Egg Biscuit ',
cast( expr_43648 as varchar) as 'AMDPAMB16 - Sausage N Egg Biscuit ',
cast( expr_43649 as varchar) as 'AMDPAMB17 - Sausage Biscuit ',
cast( expr_43805 as varchar) as 'AMDPAMB18 - Buttermilk Biscuit ',
cast( expr_43615 as varchar) as 'AMDPTMB15 Bacon N Egg Biscuit ',
cast( expr_43616 as varchar) as 'AMDPTMB16 Sausage N Egg Biscuit ',
cast( expr_43617 as varchar) as 'AMDPTMB17 Sausage Biscuit ',
cast( expr_43800 as varchar) as 'AMDPTMB18 Buttermilk Biscuit ',
cast( expr_43759 as varchar) as 'AMDPUMB15 - Bacon N Egg Biscuit ',
cast( expr_43760 as varchar) as 'AMDPUMB16 - Sausage N Egg Biscuit ',
cast( expr_43761 as varchar) as 'AMDPUMB17 - Sausage Biscuit ',
cast( expr_43810 as varchar) as 'AMDPUMB18 Buttermilk Biscuit ',
cast( expr_43968 as varchar) as 'AMDRIMB15 - Bacon N Egg Biscuit ',
cast( expr_43969 as varchar) as 'AMDRIMB16 - Sausage N Egg Biscuit ',
cast( expr_43970 as varchar) as 'AMDRIMB17 - Sausage Biscuit ',
cast( expr_43971 as varchar) as 'AMDRIMB18 - Buttermilk Biscuit ',
cast( expr_43972 as varchar) as 'AMDRMMB15 - Bacon N Egg Biscuit ',
cast( expr_43973 as varchar) as 'AMDRMMB16 - Sausage N Egg Biscuit ',
cast( expr_43974 as varchar) as 'AMDRMMB17 - Sausage Biscuit ',
cast( expr_43975 as varchar) as 'AMDRMMB18 - Buttermilk Biscuit ',
cast( expr_43807 as varchar) as 'AMDRPABMB01 - The biscuit was greasy - Buttermilk ',
cast( expr_43808 as varchar) as 'AMDRPABMB02 - The biscuit was crushed - Buttermilk ',
cast( expr_43809 as varchar) as 'AMDRPABMB03 - Other - Buttermilk Biscuit ',
cast( expr_43651 as varchar) as 'AMDRPABNEB02 - The Biscuit was greasy - Bacon N e ',
cast( expr_43652 as varchar) as 'AMDRPABNEB03 - The biscuit was crushed - Bacon N ',
cast( expr_43653 as varchar) as 'AMDRPABNEB04 - Other - Bacon N Egg Biscuit ',
cast( expr_43656 as varchar) as 'AMDRPASB02 - The Biscuit was greasy - Sausage N ',
cast( expr_43657 as varchar) as 'AMDRPASB03 - The biscuit was crushed - Sausage N ',
cast( expr_43658 as varchar) as 'AMDRPASB04 - Other - Sausage N Egg Biscuit ',
cast( expr_43660 as varchar) as 'AMDRPASBB02 - The biscuit was greasy - Sausage Bis ',
cast( expr_43661 as varchar) as 'AMDRPASBB03 - The biscuit was crushed - Sausage ',
cast( expr_43662 as varchar) as 'AMDRPASBB04 - Other - Sausage Biscuit ',
cast( expr_43801 as varchar) as 'AMDRPTBMB01 - The biscuit was hard, dry or burnt ',
cast( expr_43802 as varchar) as 'AMDRPTBMB02 - The biscuit was soggy or underbaked ',
cast( expr_43803 as varchar) as 'AMDRPTBMB03 - Other --- Buttermilk Biscuit ',
cast( expr_43622 as varchar) as 'AMDRPTBNEB05 - The biscuit was hard, dry or burnt ',
cast( expr_43631 as varchar) as 'AMDRPTBNEB06 - The biscuit was soggy or underbaked ',
cast( expr_43632 as varchar) as 'AMDRPTBNEB07 - Other --- Bacon N Egg Biscuit ',
cast( expr_43637 as varchar) as 'AMDRPTSB05 - The biscuit was hard, dry or burnt ',
cast( expr_43638 as varchar) as 'AMDRPTSB06 - The biscuit was soggy or underbaked ',
cast( expr_43639 as varchar) as 'AMDRPTSB07 - Other --- Sausage N Egg Biscuit ',
cast( expr_43641 as varchar) as 'AMDRPTSBB02 - The egg was dry - Sausage Biscuit ',
cast( expr_43644 as varchar) as 'AMDRPTSBB05 - The biscuit was hard, dry or burnt ',
cast( expr_43645 as varchar) as 'AMDRPTSBB06 - The biscuit was soggy or underbaked ',
cast( expr_43646 as varchar) as 'AMDRPTSBB07 - Other --- Sausage Biscuit ',
cast( expr_43584 as varchar) as 'AMPMB15 Bacon N Egg Biscuit ',
cast( expr_43585 as varchar) as 'AMPMB16 Sausage N Egg Biscuit ',
cast( expr_43587 as varchar) as 'AMPMB17 Sausage Biscuit ',
cast( expr_43799 as varchar) as 'AMPMB18 Buttermilk Biscuit ',
--04/02/2011
cast( expr_43618 as varchar) as 'Bacon N Egg Biscuit Taste - The sandwich was greasy',
cast( expr_43619 as varchar) as 'Bacon N Egg Biscuit Taste - The egg was dry',
cast( expr_43620 as varchar) as 'Bacon N Egg Biscuit Taste - The bacon was dry',
cast( expr_43621 as varchar) as 'Bacon N Egg Biscuit Taste - The egg wasnt cooked enough',
cast( expr_43633 as varchar) as 'Sausage N Egg Biscuit Taste - The sandwich was greasy',
cast( expr_43634 as varchar) as 'Sausage N Egg Biscuit Taste - The egg was dry',
cast( expr_43635 as varchar) as 'Sausage N Egg Biscuit Taste - The sausage was dry',
cast( expr_43636 as varchar) as 'Sausage N Egg Biscuit Taste - The egg wasnt cooked enough',
cast( expr_43640 as varchar) as 'Sausage Biscuit Taste - The sandwich was greasy',
cast( expr_43642 as varchar) as 'Sausage Biscuit Taste - The sausage was dry',
cast( expr_43650 as varchar) as 'Bacon N Egg Biscuit Appear - The sandwich looked messy',
cast( expr_43655 as varchar) as 'Sausage N Egg Biscuit Appear - The sandwich looked messy',
cast( expr_43659 as varchar) as 'Sausage Biscuit Appear - The sandwich looked messy',
--050211
cast ( expr_45760 as varchar) as 'AMPB12 - Angus Mushroom & Swiss ',
cast ( expr_45739 as varchar) as 'AMDPAB12 - Angus Mushroom & Swiss   ',
cast ( expr_45740 as varchar) as 'AMDPTB12 - Angus Mushroom & Swiss ',
cast ( expr_45741 as varchar) as 'AMDPUB12 - Angus Mushroom & Swiss ',
cast ( expr_45742 as varchar) as 'AMDRIB12 - Angus Mushroom & Swiss ',
cast ( expr_45743 as varchar) as 'AMDRMB12 - Angus Mushroom & Swiss ',
cast ( expr_45744 as varchar) as 'AMDRPAAM01 - The sandwich looked messy --- Angus B ',
cast ( expr_45745 as varchar) as 'AMDRPAAM02 - The bun was greasy --- Angus Mushroom ',
cast ( expr_45746 as varchar) as 'AMDRPAAM03 - The bun was crushed --- Angus Mushroo ',
cast ( expr_45747 as varchar) as 'AMDRPAAM04 - The condiments were leaking out of th ',
cast ( expr_45748 as varchar) as 'AMDRPAAM05 - Cheese wasnt melted enough --- Angus ',
cast ( expr_45749 as varchar) as 'AMDRPAAM06 - Other --- Angus Mushroom & Swiss ',
cast ( expr_45761 as varchar) as 'AMDRPAAM - Other Issue, What? ',
cast ( expr_45750 as varchar) as 'AMDRPTAM01 - The sandwich was greasy --- Angus Mus ',
cast ( expr_45751 as varchar) as 'AMDRPTAM02 - The meat was dry --- Angus Mushroom & ',
cast ( expr_45752 as varchar) as 'AMDRPTAM03 - The meat wasnt cooked enough --- Ang ',
cast ( expr_45753 as varchar) as 'AMDRPTAM04 - The bun was hard, dry or cracked --- ',
cast ( expr_45754 as varchar) as 'AMDRPTAM05 - The bun was soggy --- Angus Mushroom ',
cast ( expr_45755 as varchar) as 'AMDRPTAM06 - Mushrooms were undercooked --- Angus ',
cast ( expr_45756 as varchar) as 'AMDRPTAM07 - Cheese wasnt melted enough --- Angus ',
cast ( expr_45757 as varchar) as 'AMDRPTAM08 - Mushrooms were overcooked --- Angus ',
cast ( expr_45758 as varchar) as 'AMDRPTAM09 - Other --- Angus Mushroom & Swiss ',
cast ( expr_45759 as varchar) as 'AMDRPTAM - Other Issue, What? ',
cast ( expr_46408 as varchar) as 'AMPS11 - Southwest Salad ',
cast ( expr_46375 as varchar) as 'AMDPAS11 - Southwest Salad   ',
cast ( expr_46376 as varchar) as 'AMDPTS11 - Southwest Salad ',
cast ( expr_46377 as varchar) as 'AMDPUS11 - Southwest Salad ',
cast ( expr_46378 as varchar) as 'AMDRIS11 - Southwest Salad ',
cast ( expr_46380 as varchar) as 'AMDRMS11 - Southwest Salad ',
cast ( expr_46389 as varchar) as 'AMDRPTSWS01 - The lettuce was soggy or wilted --- ',
cast ( expr_46391 as varchar) as 'AMDRPTSWS02 - Produce wasnt fresh --- Southwest ',
cast ( expr_46399 as varchar) as 'AMDRPTSWS03 - The chicken was burnt or dry --- ',
cast ( expr_46400 as varchar) as 'AMDRPTSWS04 - The chicken was soggy --- Southwest ',
cast ( expr_46401 as varchar) as 'AMDRPTSWS05 - Tomatoes were not juicy --- Southwes ',
cast ( expr_46402 as varchar) as 'AMDRPTSWS06 - Other --- Southwest Salad ',
cast ( expr_46403 as varchar) as 'AMDRPTSWS - Other Issue, What? ',
cast ( expr_46382 as varchar) as 'AMDRPASWS01 - The lettuce was wilted --- Southwest ',
cast ( expr_46381 as varchar) as 'AMDRPASWS02 - One or more ingredients had an off ',
cast ( expr_46383 as varchar) as 'AMDRPASWS03 - It had a messy appearance --- Southw ',
cast ( expr_46384 as varchar) as 'AMDRPASWS04 - The chicken wasnt cut through --- ',
cast ( expr_46385 as varchar) as 'AMDRPASWS05 - The lid was not on properly --- ',
cast ( expr_46386 as varchar) as 'AMDRPASWS06 - The salad container wasnt filled en ',
cast ( expr_46387 as varchar) as 'AMDRPASWS07 - Other --- Southwest Salad ',
cast ( expr_46388 as varchar) as 'AMDRPASWS - Other Issue, What? ',

cast ( expr_46793 as varchar) as 'AMPS12 - Tuscan Salad',
cast ( expr_46789 as varchar) as 'AMDPAS12 - Tuscan Salad',
cast ( expr_46790 as varchar) as 'AMDPTS12 - Tuscan Salad',
cast ( expr_46791 as varchar) as 'AMDPUS12 - Tuscan Salad',
cast ( expr_46792 as varchar) as 'AMDRIS12 - Tuscan Salad',
cast ( expr_46954 as varchar) as 'AMDRMS12 - Tuscan Salad',
cast ( expr_46794 as varchar) as 'AMDRPATS01 - The lettuce was wilted --- Tuscan Sal',
cast ( expr_46795 as varchar) as 'AMDRPATS02 - Produce wasnt fresh - Tuscan Salad',
cast ( expr_46796 as varchar) as 'AMDRPATS03 -- The Chicken was burnt or dry -- Tusc',
cast ( expr_46797 as varchar) as 'AMDRPATS04 -- The chicken was soggy -- Tuscan Sala',
cast ( expr_46798 as varchar) as 'AMDRPATS05 -- Tomatoes were not juicy - Tuscan Sal',
cast ( expr_46799 as varchar) as 'AMDRPATS06 -- Container wasnt filled all the way',
cast ( expr_46800 as varchar) as 'AMDRPATS07 -- The salad was messy - Tuscan Salad',
cast ( expr_46801 as varchar) as 'AMDRPATS08 -- Other -- Tuscan Salad',
cast ( expr_46803 as varchar) as 'AMDRPTTS01 - The lettuce was soggy or wilted -- Tu',
cast ( expr_46804 as varchar) as 'AMDRPTTS02 - The produce wasnt fresh -- Tuscan Sa',
cast ( expr_46807 as varchar) as 'AMDRPTTS03 -- The chicken was burnt or dry -- Tusc',
cast ( expr_46808 as varchar) as 'AMDRPTTS04 -- The chicken was soggy -- Tuscan Sala',
cast ( expr_46811 as varchar) as 'AMDRPTTS05 -- Tomatoes were not juicy -- Tuscan Sa',
cast ( expr_46812 as varchar) as 'AMDRPTTS06 -- Too much/not enough sauce on the chi',
cast ( expr_46814 as varchar) as 'AMDRPTTS07-- Other -- Tuscan Salad',
cast ( expr_46817 as varchar) as 'AMDRPASWS08 -- Produce wasnt fresh -- Southwest S',
cast ( expr_46999 as varchar) as 'AMDRPASWS09 -- The chicken was burnt or dry -- Sou',
cast ( expr_47000 as varchar) as 'AMDRPASWS10 -- The chicken was soggy -- Southwest',

cast ( expr_48874 as varchar) as 'AMDRPABLT - Other Issue, What? ',
cast ( expr_48497 as varchar) as 'AMDRPABLT01 - The sandwich looked messy - BLT Chic ',
cast ( expr_48498 as varchar) as 'AMDRPABLT02 - The bun was greasy -- BLT Chicken Su ',
cast ( expr_48499 as varchar) as 'AMDRPABLT03 - The bun was crushed -- BLT Chicken S ',
cast ( expr_48500 as varchar) as 'AMDRPABLT04 - The condiments were leaking out of s ',
cast ( expr_48501 as varchar) as 'AMDRPABLT05 - The sandwich was not served in a pap ',
cast ( expr_48502 as varchar) as 'AMDRPABLT06 - Other - Chicken Supreme BLT',
cast ( expr_48889 as varchar) as 'AMDRPATT - Other Issue, What? -- Tangy Thai Chicke ',
cast ( expr_48539 as varchar) as 'AMDRPATT01 - The sandwich looked messy - Tangy Tha ',
cast ( expr_48540 as varchar) as 'AMDRPATT02 - The bun was greasy - Tangy Thai Chick ',
cast ( expr_48541 as varchar) as 'AMDRPATT03 - The bun was crushed - Tangy Thai Chic ',
cast ( expr_48542 as varchar) as 'AMDRPATT04 - The condiments were leaking out of th ',
cast ( expr_48543 as varchar) as 'AMDRPATT05 - The sandwich was not served in a pape ',
cast ( expr_48544 as varchar) as 'AMDRPATT06 - Other - Chicken Supreme Tangy Thai ',
cast ( expr_48890 as varchar) as 'AMDRPAMSS - Other Issue, What? -- Mushroom Swiss C ',
cast ( expr_48588 as varchar) as 'AMDRPAMSS01 - The sandwich looked messy - Mushroom ',
cast ( expr_48589 as varchar) as 'AMDRPAMSS02 - The bun was greasy - Mushroom Swiss ',
cast ( expr_48590 as varchar) as 'AMDRPAMSS03 - The bun was crushed - Mushroom Swiss ',
cast ( expr_48591 as varchar) as 'AMDRPAMSS04 - The condiments were leaking out of t ',
cast ( expr_48592 as varchar) as 'AMDRPAMSS05 - The sandwich was not served in a pap ',
cast ( expr_48605 as varchar) as 'AMDRPAMSS06 - Cheese wasnt melted enough - Mushro ',
cast ( expr_48607 as varchar) as 'AMDRPAMSS07 - Cheese was too melted - Mushroom Swi ',
cast ( expr_48608 as varchar) as 'AMDRPAMSS08 - Other - Chicken Supreme Mushroom Swi ',
cast ( expr_48891 as varchar) as 'AMDRPTMSS - Other Issue, What? -- Mushroom Swiss C ',
cast ( expr_48561 as varchar) as 'AMDRPTMSS01 - The sandwich was greasy - Mushroom S ',
cast ( expr_48563 as varchar) as 'AMDRPTMSS02 - The chicken was dry - Mushroom Swiss ',
cast ( expr_48565 as varchar) as 'AMDRPTMSS03 - The chicken wasnt cooked enough - M ',
cast ( expr_48566 as varchar) as 'AMDRPTMSS04 - The bun was hard or dry - Mushroom S ',
cast ( expr_48568 as varchar) as 'AMDRPTMSS05 - The bun was soggy - Mushroom Swiss C ',
cast ( expr_48582 as varchar) as 'AMDRPTMSS06 - The produce wasnt fresh - Mushroom ',
cast ( expr_48583 as varchar) as 'AMDRPTMSS07 - Mushroom were undercooked - Mushroom ',
cast ( expr_48584 as varchar) as 'AMDRPTMSS08 - Mushrooms were overcooked - Mushroom ',
cast ( expr_48585 as varchar) as 'AMDRPTMSS09 - Cheese wasnt melted enough - Mushro ',
cast ( expr_48586 as varchar) as 'AMDRPTMSS10 - Cheese was too melted - Mushroom Swi ',
cast ( expr_48587 as varchar) as 'AMDRPTMSS11 - Other - Chicken Supreme Mushroom Swi ',
cast ( expr_48885 as varchar) as 'AMDRPTTT - Other Issue, What? ',
cast ( expr_48518 as varchar) as 'AMDRPTTT01 - The sandwich was greasy - Tangy Thai ',
cast ( expr_48521 as varchar) as 'AMDRPTTT02 - The chicken was dry -- Tangy Thai Chi ',
cast ( expr_48522 as varchar) as 'AMDRPTTT03 - The chicken wasnt cooked enough - Ta ',
cast ( expr_48523 as varchar) as 'AMDRPTTT04 - The bun was hard or dry -- Tangy Thai ',
cast ( expr_48524 as varchar) as 'AMDRPTTT05 - The bun was soggy -- Tangy Thai Chick ',
cast ( expr_48525 as varchar) as 'AMDRPTTT06 - The produce wasnt fresh -- Tangy Tha ',
cast ( expr_48526 as varchar) as 'AMDRPTTT07 - The red peppers were overcooked - Tan ',
cast ( expr_48527 as varchar) as 'AMDRPTTT08 - The red peppers were undercooked - Ta ',
cast ( expr_48528 as varchar) as 'AMDRPTTT09 - Other -- Chicken Supreme Tangy Thai ',
cast ( expr_48875 as varchar) as 'AMDRPTBLT - Other Issue, What? ',
cast ( expr_48477 as varchar) as 'AMDRPTBLT01 - The sandwich was greasy --- BLT Supr ',
cast ( expr_48481 as varchar) as 'AMDRPTBLT02 - The chicken was dry --- BLT Chicken ',
cast ( expr_48482 as varchar) as 'AMDRPTBLT03 - The chicken wasnt cooked enough - S ',
cast ( expr_48483 as varchar) as 'AMDRPTBLT04 - The bun was hard or dry - BLT Chicke ',
cast ( expr_48484 as varchar) as 'AMDRPTBLT05 - The bun was soggy -- BLT Chicken Sup ',
cast ( expr_48485 as varchar) as 'AMDRPTBLT06 - The produce wasnt fresh - BLT Chick ',
cast ( expr_48486 as varchar) as 'AMDRPTBLT07 - The bacon was dry -- BLT Chicken Sup ',
cast ( expr_48488 as varchar) as 'AMDRPTBLT08 - Other - Chicken Supreme BLT ',
cast ( expr_48503 as varchar) as 'AMDPAC11 - Chicken Supreme BLT ',
cast ( expr_48507 as varchar) as 'AMDPAC12 - Chicken Supreme Tangy Thai ',
cast ( expr_48512 as varchar) as 'AMDPAC13 - Chicken Supreme Mushroom Swiss ',
cast ( expr_48489 as varchar) as 'AMDPTC11 - Chicken Supreme BLT ',
cast ( expr_48508 as varchar) as 'AMDPTC12 - Chicken Supreme Tangy Thai ',
cast ( expr_48513 as varchar) as 'AMDPTC13 - Chicken Supreme Mushroom Swiss ',
cast ( expr_48504 as varchar) as 'AMDPUC11 - Chicken Supreme BLT ',
cast ( expr_48509 as varchar) as 'AMDPUC12 - Chicken Supreme Tangy Thai ',
cast ( expr_48514 as varchar) as 'AMDPUC13 - Chicken Supreme Mushroom Swiss ',
cast ( expr_48505 as varchar) as 'AMDRIC11 - Chicken Supreme BLT ',
cast ( expr_48510 as varchar) as 'AMDRIC12 - Chicken Supreme Tangy Thai ',
cast ( expr_48515 as varchar) as 'AMDRIC13 - Chicken Supreme Mushroom Swiss ',
cast ( expr_48506 as varchar) as 'AMDRMC11 - Chicken Supreme BLT ',
cast ( expr_48511 as varchar) as 'AMDRMC12 - Chicken Supreme Tangy Thai ',
cast ( expr_48517 as varchar) as 'AMDRMC13 - Chicken Supreme Mushroom Swiss ',
cast ( expr_48661 as varchar) as 'AMPC11 Chicken Supreme BLT sandwich ',
cast ( expr_48665 as varchar) as 'AMPC12 Chicken Supreme Tangy Thai Sandwich ',
cast ( expr_48666 as varchar) as 'AMPC13 Chicken Supreme Mushroom Swiss sandwich ',
cast ( expr_49827 as varchar) as 'AMDRPTOAT - Other Issue, What? -- Oatmeal ',
cast ( expr_49809 as varchar) as 'AMDRPTOAT01 - It was not sweet enough -- Oatmeal ',
cast ( expr_49810 as varchar) as 'AMDRPTOAT02 - It was too sweet -- Oatmeal ',
cast ( expr_49811 as varchar) as 'AMDRPTOAT03 - Too little cranberries/raisins ',
cast ( expr_49812 as varchar) as 'AMDRPTOAT04 - Too much cranberries/raisins -- Oatm ',
cast ( expr_49813 as varchar) as 'AMDRPTOAT05 - The oatmeal was not fully mixed -- O ',
cast ( expr_49821 as varchar) as 'AMDRPTOAT06 - The oatmeal texture was too thick -- ',
cast ( expr_49823 as varchar) as 'AMDRPTOAT07 - The oatmeal texture was too thin -- ',
cast ( expr_49824 as varchar) as 'AMDRPTOAT08 - Apple pieces were not fresh -- Oatme ',
cast ( expr_49825 as varchar) as 'AMDRPTOAT09 - Apple pieces were mushy -- Oatmeal ',
cast ( expr_49826 as varchar) as 'AMDRPTOAT10 - Other -- Oatmeal ',
cast ( expr_49804 as varchar) as 'AMDRPAOAT - Other Issue, What? -- Oatmeal ',
cast ( expr_49783 as varchar) as 'AMDRPAOAT01 - The oatmeal texture was too thick - ',
cast ( expr_49784 as varchar) as 'AMDRPAOAT02 - The oatmeal texture was too thin ',
cast ( expr_49785 as varchar) as 'AMDRPAOAT03 - The oatmeal was not fully mixed - Oa ',
cast ( expr_49786 as varchar) as 'AMDRPAOAT04 - Unappealing Appearance - Oatmeal ',
cast ( expr_49795 as varchar) as 'AMDRPAOAT05 - The bowl wasnt filled enough - Oatm ',
cast ( expr_49797 as varchar) as 'AMDRPAOAT06 - The bowl was overfilled -- Oatmeal ',
cast ( expr_49798 as varchar) as 'AMDRPAOAT07 - The lid wasnt on properly -- Oatmea ',
cast ( expr_49799 as varchar) as 'AMDRPAOAT08 - The bowl was messy or leaking ',
cast ( expr_49801 as varchar) as 'AMDRPAOAT09 - Apple pieces were old and spoiled -- ',
cast ( expr_49802 as varchar) as 'AMDRPAOAT10 -- Other -- Oatmeal ',
cast ( expr_49778 as varchar) as 'AMDPAMB19 - Oatmeal ',
cast ( expr_49779 as varchar) as 'AMDPTMB19 Oatmeal ',
cast ( expr_49780 as varchar) as 'AMDPUMB19 - Oatmeal ',
cast ( expr_49781 as varchar) as 'AMDRIMB19 - Oatmeal ',
cast ( expr_49782 as varchar) as 'AMDRMMB19 - Oatmeal ',
cast ( expr_49975 as varchar) as 'AMPMB19 Oatmeal ',
cast ( expr_49960 as varchar) as 'AMDRPUOAT01 - The Oatmeal was too warm',
cast ( expr_49961 as varchar) as 'AMDRPUOAT02 - The Oatmeal was too cool',
isnull(cast ( expr_49957 as varchar),'') as 'AML04N - Return to this McDonalds',

cast ( expr_51339 as varchar) as 'Ordered - Big Xtra Sandwich',
cast ( expr_51340 as varchar) as 'Appear. Issue - Big Xtra Sandwich',
cast ( expr_51341 as varchar) as 'Taste Issue - Big Xtra Sandwich',
cast ( expr_51342 as varchar) as 'Temp. Issue - Big Xtra Sandwich',
cast ( expr_51344 as varchar) as 'Prepd Incorr - Big Xtra Sandwich',
cast ( expr_51345 as varchar) as 'Missing - Big Xtra Sandwich',
cast ( expr_51024 as varchar) as 'Big Xtra Sandwich Appear - The sandwich looked messy',
cast ( expr_51025 as varchar) as 'Big Xtra Sandwich Appear - The bun was greasy',
cast ( expr_51026 as varchar) as 'Big Xtra Sandwich Appear - The bun was crushed',
cast ( expr_51027 as varchar) as 'Big Xtra Sandwich Appear - The condiments were leaking out of the sandwich',
cast ( expr_51028 as varchar) as 'Big Xtra Sandwich Appear - Too much lettuce',
cast ( expr_51029 as varchar) as 'Big Xtra Sandwich Appear - Cheese wasnt melted enough',
cast ( expr_51030 as varchar) as 'Big Xtra Sandwich Appear - Cheese was too melted',
cast ( expr_51031 as varchar) as 'Big Xtra Sandwich Appear - Other',
cast ( expr_51347 as varchar) as 'Other Big Xtra Sandwich Appear Issue',
cast ( expr_51015 as varchar) as 'Big Xtra Sandwich Taste - The sandwich was greasy',
cast ( expr_51016 as varchar) as 'Big Xtra Sandwich Taste - The meat was dry',
cast ( expr_51017 as varchar) as 'Big Xtra Sandwich Taste - The meat wasnt cooked enough',
cast ( expr_51018 as varchar) as 'Big Xtra Sandwich Taste - The bun was hard or dry',
cast ( expr_51019 as varchar) as 'Big Xtra Sandwich Taste - The bun was soggy',
cast ( expr_51020 as varchar) as 'Big Xtra Sandwich Taste - The produce wasnt fresh',
cast ( expr_51021 as varchar) as 'Big Xtra Sandwich Taste - Cheese wasnt melted enough',
cast ( expr_51022 as varchar) as 'Big Xtra Sandwich Taste - Cheese was too melted',
cast ( expr_51023 as varchar) as 'Big Xtra Sandwich Taste - Other',
cast ( expr_51348 as varchar) as 'Other Big Xtra Sandwich Taste Issue',

cast ( expr_53503 as varchar) as 'AMDPAF12 - Hot Chocolate',
cast ( expr_53504 as varchar) as 'AMDPTF12 - Hot Chocolate',
cast ( expr_53505 as varchar) as 'AMDPUF12 - Hot Chocolate',
cast ( expr_53506 as varchar) as 'AMDRIF12 - Hot Chocolate',
cast ( expr_53507 as varchar) as 'AMDRMF12 - Hot Chocolate',
cast ( expr_53518 as varchar) as 'AMDRPAHCH01 - The cup wasnt filled enough',
cast ( expr_53519 as varchar) as 'AMDRPAHCH02 - The cup was overfilled - Hot Chocola',
cast ( expr_53521 as varchar) as 'AMDRPAHCH03 - The lid wasnt on properly - Hot Cho',
cast ( expr_53522 as varchar) as 'AMDRPAHCH04 - The cup was leaking - Hot Chocolate',
cast ( expr_53523 as varchar) as 'AMDRPAHCH05 - Unappealing appearance - Hot Chocola',
cast ( expr_53524 as varchar) as 'AMDRPAHCH06 - Other -- Hot Chocolate',
cast ( expr_53508 as varchar) as 'AMDRPTHCH01 - It wasnt sweet enough - Hot Chocola',
cast ( expr_53509 as varchar) as 'AMDRPTHCH02 - It was too sweet - Hot Chocolate',
cast ( expr_53511 as varchar) as 'AMDRPTHCH03 - It was too strong -- Hot Chocolate',
cast ( expr_53512 as varchar) as 'AMDRPTHCH04 - It was too weak -- Hot Chocolate',
cast ( expr_53513 as varchar) as 'AMDRPTHCH05 - It wasnt creamy enough -- Hot Choco',
cast ( expr_53514 as varchar) as 'AMDRPTHCH06 - It was too creamy -- Hot Chocolate',
cast ( expr_53515 as varchar) as 'AMDRPTHCH07 - It wasnt chocolaty enough -- Hot Ch',
cast ( expr_53516 as varchar) as 'AMDRPTHCH08 - It was too chocolaty - Hot Chocolate',
cast ( expr_53517 as varchar) as 'AMDRPTHCH09 - Other -- Hot Chocolate',
cast ( expr_53525 as varchar) as 'AMDRPUHCH01 - It was too hot -- Hot Chocolate',
cast ( expr_53526 as varchar) as 'AMDRPUHCH02 - It wasnt hot enough -- Hot Chocolat',
cast ( expr_53527 as varchar) as 'AMDRPUHCH03 - It was cold - Hot Chocolate',
cast ( expr_53528 as varchar) as 'AMDRPUHCH04 - Other -- Hot Chocolate',
cast ( expr_53532 as varchar) as 'AMPF12 - Hot Chocolate',

cast ( expr_52806 as varchar) as 'AMDPAF11 - Americano',
cast ( expr_52807 as varchar) as 'AMDPTF11 - Americano',
cast ( expr_52808 as varchar) as 'AMDPUF11 - Americano',
cast ( expr_52809 as varchar) as 'AMDRIF11 - Americano',
cast ( expr_52810 as varchar) as 'AMDRMF11 - Americano',
cast ( expr_52811 as varchar) as 'AMDRPAA01 - The cup wasnt filled enough - America',
cast ( expr_52812 as varchar) as 'AMDRPAA02 - The cup was overfilled -- Americano',
cast ( expr_52813 as varchar) as 'AMDRPAA03 - The lid wasnt on properly',
cast ( expr_52814 as varchar) as 'AMDRPAA03A - The cup was leaking -- Americano',
cast ( expr_52815 as varchar) as 'AMDRPAA04 - Unappealing appearance -- Americano',
cast ( expr_52816 as varchar) as 'AMDRPAA05 - Other -- Americano',
cast ( expr_52817 as varchar) as 'AMDRPTA01 - It was too bitter -- Americano',
cast ( expr_52818 as varchar) as 'AMDRPTA02 - It was too strong -- Americano',
cast ( expr_52819 as varchar) as 'AMDRPTA03 - It was too weak -- Americano',
cast ( expr_52820 as varchar) as 'AMDRPTA04 - It wasnt creamy enough -- Americano',
cast ( expr_52821 as varchar) as 'AMDRPTA05 - Other --- Americano',
cast ( expr_52822 as varchar) as 'AMDRPUA01 - It was too hot -- Americano',
cast ( expr_52823 as varchar) as 'AMDRPUA01 - It wasnt hot enough -- Americano',
cast ( expr_52824 as varchar) as 'AMDRPUA03 - It was cold -- Americano',
cast ( expr_52825 as varchar) as 'AMDRPUA04 - Other -- Americano',
cast ( expr_52834 as varchar) as 'AMPF11 - Americano',

cast ( expr_53529 as varchar) as 'Other Appear Issue Hot Chocolate',
cast ( expr_53559 as varchar) as 'Other Appear Issue Espresso',
cast ( expr_53546 as varchar) as 'Other Appear Issue Latte',
cast ( expr_53561 as varchar) as 'Other Appear Issue Iced Latte',
cast ( expr_53553 as varchar) as 'Other Appear Issue Mocha',
cast ( expr_53563 as varchar) as 'Other Appear Issue Iced Mocha',
cast ( expr_53556 as varchar) as 'Other Appear Issue Cappuccino',
cast ( expr_53596 as varchar) as 'Other Appear Issue Americano',
cast ( expr_53530 as varchar) as 'Other Taste Issue Hot Chocolate',
cast ( expr_53560 as varchar) as 'Other Taste Issue Espresso',
cast ( expr_53549 as varchar) as 'Other Taste Issue Latte',
cast ( expr_53562 as varchar) as 'Other Taste Issue Iced Latte',
cast ( expr_53552 as varchar) as 'Other Taste Issue Mocha',
cast ( expr_53564 as varchar) as 'Other Taste Issue Iced Mocha',
cast ( expr_53557 as varchar) as 'Other Taste Issue Cappuccino',
cast ( expr_53598 as varchar) as 'Other Taste Issue Americano',
cast ( expr_53531 as varchar) as 'Other Temp Issue Hot Chocolate',
cast ( expr_53558 as varchar) as 'Other Temp Issue Espresso',
cast ( expr_53545 as varchar) as 'Other Temp Issue Latte',
cast ( expr_53550 as varchar) as 'Other Temp Issue Mocha',
cast ( expr_53555 as varchar) as 'Other Temp Issue Cappuccino',
cast ( expr_53597 as varchar) as 'Other Temp Issue Americano',

cast ( expr_53593 as varchar) as 'Main reason',
cast ( expr_53594 as varchar) as 'Taken Survey',
cast ( expr_53595 as varchar) as 'Last time taken',

--02012012
cast (expr_54210 as varchar) as 'AMDPAF13 - Smoothie',
cast (expr_54212 as varchar) as 'AMDPTF13 - Smoothie',
cast (expr_54213 as varchar) as 'AMDPUF13 - Smoothie',
cast (expr_54214 as varchar) as 'AMDRIF13 - Smoothie',
cast (expr_54215 as varchar) as 'AMDRMF13 - Smoothie',
cast (expr_54216 as varchar) as 'AMDRPTSME01 - It was too sweet -- Smoothie',
cast (expr_54217 as varchar) as 'AMDRPTSME02 - It wasnt sweet enough -- Smoothie',
cast (expr_54218 as varchar) as 'AMDRPTSME03 - Too much yougurt -- Smoothie',
cast (expr_54219 as varchar) as 'AMDRPTSME04 - Not enough yogurt -- Smoothie',
cast (expr_54220 as varchar) as 'AMDRPTSME05 - It was too thick - Smoothie',
cast (expr_54221 as varchar) as 'AMDRPTSME06 - It wasnt thick enough -- Smoothie',
cast (expr_54222 as varchar) as 'AMDRPTSME07 - Too much fruit -- Smoothie',
cast (expr_54223 as varchar) as 'AMDRPTSME08 - Not enough fruit -- Smoothie',
cast (expr_54224 as varchar) as 'AMDRPTSME09 - It was too icy -- Smoothie',
cast (expr_54225 as varchar) as 'AMDRPTSME10 - Other -- Smoothie',
cast (expr_54226 as varchar) as 'AMDRPTSME - Other Issue, What? -- Smoothie',
cast (expr_54227 as varchar) as 'AMDRPASME01 - The cup wasnt filled enough -- Smoo',
cast (expr_54228 as varchar) as 'AMDRPASME02 - The cup is overfilled -- Smoothie',
cast (expr_54229 as varchar) as 'AMDRPASME03 - The lid wasnt on properly -- Smooth',
cast (expr_54230 as varchar) as 'AMDRPASME04 - The cup was messy or leaking -- Smoo',
cast (expr_54231 as varchar) as 'AMDRPASME05 - Unappealing appearance -- Smoothie',
cast (expr_54232 as varchar) as 'AMDRPASME06 - Other -- Smoothie',
cast (expr_54233 as varchar) as 'AMDRPASME - Other Issue, What? -- Smoothie',
cast (expr_54234 as varchar) as 'AMDRPUSME01 - It was too cold -- Smoothie',
cast (expr_54235 as varchar) as 'AMDRPUSME02 - It wasnt cold enough -- Smoothie',
cast (expr_54236 as varchar) as 'AMDRPUSME03 - Other -- Smoothie',
cast (expr_54237 as varchar) as 'AMDPRUSME - Other Issue, What? -- Smoothie',
cast (expr_54238 as varchar) as 'AMPF13 - Smoothie',

--added 030212
cast (expr_55315 as varchar) as 'AMPC14 McBistro Chicken BLT ',

cast (expr_55110 as varchar) as 'AMDPAC14 - McBistro Chicken BLT ',
cast (expr_55115 as varchar) as 'AMDPTC14 - McBistro Chicken BLT ',
cast (expr_55137 as varchar) as 'AMDPUC14 - McBistro Chicken BLT ',
cast (expr_55140 as varchar) as 'AMDRIC14 - McBistro Chicken BLT ',
cast (expr_55144 as varchar) as 'AMDRMC14 - McBistro Chicken BLT ',

cast (expr_55185 as varchar) as 'AMDRPTMBC - Other Issue, What? -- McBistro Chicken ',
cast (expr_55166 as varchar) as 'AMDRPTMBC01 - The sandwich was greasy - McBistro C ',
cast (expr_55167 as varchar) as 'AMDRPTMBC02 - The chicken was dry - McBistro Chick ',
cast (expr_55168 as varchar) as 'AMDRPTMBC03 - The chicken wasnt cooked enough - M ',
cast (expr_55176 as varchar) as 'AMDRPTMBC04 - The bun was hard or dry - McBistro C ',
cast (expr_55177 as varchar) as 'AMDRPTMBC05 - The bun was soggy - McBistro Chicken ',
cast (expr_55178 as varchar) as 'AMDRPTMBC06 - The produce wasnt fresh ',
cast (expr_55179 as varchar) as 'AMDRPTMBC07 - The bacon was dry - McBistro Chicken ',
cast (expr_55180 as varchar) as 'AMDRPTMBC08 - Other - McBistro Chicken BLT ',


cast (expr_55153 as varchar) as 'AMDRPAMBC - Other Issue, What? -- McBistro Chicken ',
cast (expr_55147 as varchar) as 'AMDRPAMBC01 - The sandwich looked messy - McBistro ',
cast (expr_55148 as varchar) as 'AMDRPAMBC02 - The bun was greasy - McBistro Chicke ',
cast (expr_55149 as varchar) as 'AMDRPAMBC03 - The bun was crushed - McBistro Chick ',
cast (expr_55150 as varchar) as 'AMDRPAMBC04 - The condiments were leaking out of t ',
cast (expr_55151 as varchar) as 'AMDRPAMBC05 - The sandwich was not served in paper ',
cast (expr_55152 as varchar) as 'AMDRPAMBC06 - Other - McBistro Chicken BLT ',

cast (expr_55317 as varchar) as 'AMPC16 McBistro Swiss Mushroom Melt Chicken ',

cast (expr_55112 as varchar) as 'AMDPAC16 - McBistro Swiss Mushroom Melt Chicken ',
cast (expr_55136 as varchar) as 'AMDPTC16 - McBistro Swiss Mushroom Melt Chicken ',
cast (expr_55139 as varchar) as 'AMDPUC16 - McBistro Swiss Mushroom Melt Chicken ',
cast (expr_55143 as varchar) as 'AMDRIC16 - McBistro Swiss Mushroom Melt Chicken ',
cast (expr_55146 as varchar) as 'AMDRMC16 - McBistro Swiss Mushroom Melt Chicken ',

cast (expr_55301 as varchar) as 'AMDRPTMSM - Other Issue, What? -- McBistro Swiss M ',
cast (expr_55287 as varchar) as 'AMDRPTMSM01 - The sandwich was greasy -- McBistro ',
cast (expr_55288 as varchar) as 'AMDRPTMSM02 - The chicken was dry - McBistro Swiss ',
cast (expr_55289 as varchar) as 'AMDRPTMSM03 - The chicken wasnt cooked enough - M ',
cast (expr_55291 as varchar) as 'AMDRPTMSM04 - The bun was hard or dry - McBistro C ',
cast (expr_55292 as varchar) as 'AMDRPTMSM05 - The bun was soggy - McBistro Swiss ',
cast (expr_55294 as varchar) as 'AMDRPTMSM06 - The produce wasnt fresh - McBistro ',
cast (expr_55295 as varchar) as 'AMDRPTMSM07 - Mushrooms were undercooked -- McBist ',
cast (expr_55296 as varchar) as 'AMDRPTMSM08 - Mushrooms were overcooked - McBistro ',
cast (expr_55297 as varchar) as 'AMDRPTMSM09 - Cheese wasnt melted enough - McBist ',
cast (expr_55298 as varchar) as 'AMDRPTMSM10 - Cheese was too melted - McBistro Swi ',
cast (expr_55299 as varchar) as 'AMDRPTMSM11 - Other - McBistro Swiss Mushroom Chic ',


cast (expr_55313 as varchar) as 'AMDRPAMSM - Other Issue, What? - McBistro Swiss Mu ',
cast (expr_55304 as varchar) as 'AMDRPAMSM01 - The sandwich looked messy - McBistro ',
cast (expr_55305 as varchar) as 'AMDRPAMSM02 - The bun was greasy - McBistro Swiss ',
cast (expr_55306 as varchar) as 'AMDRPAMSM03 - The bun was crushed - McBistro Swiss ',
cast (expr_55307 as varchar) as 'AMDRPAMSM04 - The condiments were leaking out of t ',
cast (expr_55309 as varchar) as 'AMDRPAMSM05 - The sandwich was not served in paper ',
cast (expr_55310 as varchar) as 'AMDRPAMSM06 - Cheese wasnt melted enough ',
cast (expr_55311 as varchar) as 'AMDRPAMSM07 - Cheese was too melted - McBistro Swi ',
cast (expr_55312 as varchar) as 'AMDRPAMSM08 - Other - McBistro Swiss Mushroom ',

cast (expr_55316 as varchar) as 'AMPC15 McBistro Southwest Chicken ',

cast (expr_55111 as varchar) as 'AMDPAC15 - McBistro Southwest Chicken ',
cast (expr_55135 as varchar) as 'AMDPTC15 - McBistro Southwest Chicken ',
cast (expr_55138 as varchar) as 'AMDPUC15 - McBistro Southwest Chicken ',
cast (expr_55142 as varchar) as 'AMDRIC15 - McBistro Southwest Chicken ',
cast (expr_55145 as varchar) as 'AMDRMC15 - McBistro Southwest Chicken ',

cast (expr_55276 as varchar) as 'AMDRPAMSC - Other Issue, What? -- McBistro Southwe ',
cast (expr_55202 as varchar) as 'AMDRPAMSC01 - The sandwich looked messy -- McBistr ',
cast (expr_55203 as varchar) as 'AMDRPAMSC02 - The bun was greasy -- McBistro South ',
cast (expr_55204 as varchar) as 'AMDRPAMSC03 - The bun was crushed - McBistro South ',
cast (expr_55205 as varchar) as 'AMDRPAMSC04 - The condiments were leaking out of t ',
cast (expr_55206 as varchar) as 'AMDRPAMSC05 - The sandwich was not served in paper ',
cast (expr_55207 as varchar) as 'AMDRPAMSC06 - Other - McBistro Southwest Chicken ',

cast (expr_55286 as varchar) as 'AMDRPTMSC - Other Issue, What? -- McBistro Southw ',
cast (expr_55277 as varchar) as 'AMDRPTMSC01 - The sandwich was greasy - McBistro S ',
cast (expr_55278 as varchar) as 'AMDRPTMSC02 - The chicken was dry -- McBistro Sout ',
cast (expr_55279 as varchar) as 'AMDRPTMSC03 - The chicken wasnt cooked enough - M ',
cast (expr_55280 as varchar) as 'AMDRPTMSC04 - The bun was hard or dry -- McBistro ',
cast (expr_55281 as varchar) as 'AMDRPTMSC05 - The bun was soggy - McBistro Southwe ',
cast (expr_55282 as varchar) as 'AMDRPTMSC06 - The produce wasnt fresh - McBistro ',
cast (expr_55283 as varchar) as 'AMDRPTMSC07 - Cheese wasnt melted enough - McBist ',
cast (expr_55284 as varchar) as 'AMDRPTMSC08 - Cheese was too melted -- McBistro So ',
cast (expr_55285 as varchar) as 'AMDRPTMSC09 - Other -- McBistro Southwest Chicken ',

--added 040212
cast (expr_56890 as varchar) as 'AMDRPCW - Crispy or Grilled Chicken - Chicken Snac',
cast (expr_56887 as varchar) as 'AMDRPMBC - Crispy or Grilled - McBistro Chicken BL',
cast (expr_56891 as varchar) as 'AMDRPMC - Crispy or Grilled Chicken - Caesar Salad',
cast (expr_56889 as varchar) as 'AMDRPMSC - Crispy or Grilled - McBistro Southwest',
cast (expr_56888 as varchar) as 'AMDRPMSM - Crispy or Grilled - McBistro Swiss Mush',
cast (expr_56892 as varchar) as 'AMDRPST - Crispy or Grilled Chicken - Spicy Thai S',
cast (expr_56893 as varchar) as 'AMDRPTS - Crispy or Grilled Chicken - Tuscan Salad',

cast (expr_56894 as varchar) as 'AMDRPTMSM12 - The sandwich was not flavorful',
cast (expr_56895 as varchar) as 'AMDRPTMSC10 - The sandwich was not flavorful ',
cast (expr_56896 as varchar) as 'AMDRPTMBC09 - The sandwich was not flavorful  ',

--added 050212
cast (expr_58138 as varchar) as 'AMDPAS13 - Cashew Teriyaki Salad ',
cast (expr_58139 as varchar) as 'AMDPTS13 - Cashew Teriyaki Salad ',
cast (expr_58140 as varchar) as 'AMDPUS13 - Cashew Teriyaki Salad ',
cast (expr_58141 as varchar) as 'AMDRIS13 - Cashew Teriyaki Salad ',
cast (expr_58142 as varchar) as 'AMDRMS13 - Cashew Teriyaki Salad ',
cast (expr_58137 as varchar) as 'AMPS13 - Cashew Teriyaki Salad ',

cast (expr_58217 as varchar) as 'AMDRPACT - Other Issue, What? -- Cashew Teriyaki ',
cast (expr_58143 as varchar) as 'AMDRPACT01 - The lettuce was wilted - Cashew Teriy ',
cast (expr_58144 as varchar) as 'AMDRPACT02 - It had a messy appearance - Cashew Te ',
cast (expr_58145 as varchar) as 'AMDRPACT03 - The salad container wasnt filled eno ',
cast (expr_58146 as varchar) as 'AMDRPACT04 - Produce wasnt fresh - Cashew Teriyak ',
cast (expr_58147 as varchar) as 'AMDRPACT05 - The chicken was burnt or dry - Cashew ',
cast (expr_58206 as varchar) as 'AMDRPACT06 - The chicken was soggy - Cashew Teriya ',
cast (expr_58207 as varchar) as 'AMDRPACT07 - Other - Cashew Teriyaki Salad ',

cast (expr_58219 as varchar) as 'AMDRPTCT - Other Issue, What? - Cashew Teriyaki ',
cast (expr_58210 as varchar) as 'AMDRPTCT01 - The lettuce was soggy or wilted - Cas ',
cast (expr_58211 as varchar) as 'AMDRPTCT02 - Produce wasnt fresh - Cashew Teriyak ',
cast (expr_58213 as varchar) as 'AMDRPTCT03 - The chicken was burnt or dry - Cashew ',
cast (expr_58214 as varchar) as 'AMDRPTCT04 - The chicken was soggy - Cashew Teriya ',
cast (expr_58215 as varchar) as 'AMDRPTCT05 - Other - Cashew Teriyaki Salad ',

cast (expr_58126 as varchar) as 'AMDRMH08 - Happy Meal® Yogurt ',
cast (expr_58926 as varchar) as 'AMDRMH08 - Happy Meal® Yogurt - Chicken McNuggets ',
cast (expr_58927 as varchar) as 'AMDRMH08 - Happy Meal® Yogurt - Other Main Item ',

--added 060112
cast (expr_58875 as varchar) as 'AMDPAMB20 - Regular Bagel ',
cast (expr_58876 as varchar) as 'AMDPAMB21 - Multigrain Bagel ',
cast (expr_58877 as varchar) as 'AMDPAMB22 - Regular BLT Bagel ',
cast (expr_58880 as varchar) as 'AMDPAMB23 - Multigrain BLT Bagel ',
cast (expr_58881 as varchar) as 'AMDPAMB24 - Regular Bacon N Egg Bagel ',
cast (expr_58882 as varchar) as 'AMDPAMB25 - Multigrain Bacon N Egg Bagel ',
cast (expr_58883 as varchar) as 'AMDPAMB26 - Regular Egg LT Bagel ',
cast (expr_58884 as varchar) as 'AMDPAMB27 - Multigrain Egg LT Bagel ',

cast (expr_58885 as varchar) as 'AMDPTMB20 - Regular Bagel ',
cast (expr_58886 as varchar) as 'AMDPTMB21 Multigrain Bagel ',
cast (expr_58887 as varchar) as 'AMDPTMB22 Regular BLT Bagel ',
cast (expr_58888 as varchar) as 'AMDPTMB23 Multigrain BLT Bagel ',
cast (expr_58889 as varchar) as 'AMDPTMB24 Regular Bacon N Egg Bagel ',
cast (expr_58890 as varchar) as 'AMDPTMB25 Multigrain Bacon N Egg Bagel ',
cast (expr_58891 as varchar) as 'AMDPTMB26 Regular Egg LT Bagel ',
cast (expr_58892 as varchar) as 'AMDPTMB27 Multigrain Egg LT Bagel ',

cast (expr_58893 as varchar) as 'AMDPUMB20 Regular Bagel ',
cast (expr_58894 as varchar) as 'AMDPUMB21 Multigrain Bagel ',
cast (expr_58895 as varchar) as 'AMDPUMB22 Regular BLT Bagel ',
cast (expr_58896 as varchar) as 'AMDPUMB23 Multigrain BLT Bagel ',
cast (expr_58897 as varchar) as 'AMDPUMB24 Regular Bacon N Egg Bagel ',
cast (expr_58899 as varchar) as 'AMDPUMB26 Regular Egg LT Bagel ',
cast (expr_58900 as varchar) as 'AMDPUMB27 Multigrain Egg LT Bagel ',

cast (expr_58901 as varchar) as 'AMDRIMB20 Regular Bagel ',
cast (expr_59054 as varchar) as 'AMDRIMB21 Multigrain Bagel ',
cast (expr_59055 as varchar) as 'AMDRIMB22 Regular BLT Bagel ',
cast (expr_59059 as varchar) as 'AMDRIMB23 Multigrain Bagel BLT ',
cast (expr_59064 as varchar) as 'AMDRIMB24 Regular Bacon N Egg Bagel ',
cast (expr_59065 as varchar) as 'AMDRIMB25 Multigrain Bacon N Egg Bagel ',
cast (expr_59066 as varchar) as 'AMDRIMB26 Regular Egg LT Bagel ',
cast (expr_59068 as varchar) as 'AMDRIMB27 Multigrain Egg LT Bagel ',

cast (expr_59281 as varchar) as 'AMDRMMB20 - Regular Bagel ',
cast (expr_59285 as varchar) as 'AMDRMMB21 - Multigrain Bagel ',
cast (expr_59306 as varchar) as 'AMDRMMB22 - Regular BLT Bagel ',
cast (expr_59307 as varchar) as 'AMDRMMB23 - Multigrain BLT Bagel ',
cast (expr_59309 as varchar) as 'AMDRMMB24 - Regular Bacon N Egg Bagel ',
cast (expr_59311 as varchar) as 'AMDRMMB25 - Multigrain Bacon N Egg Bagel ',
cast (expr_59312 as varchar) as 'AMDRMMB26 - Regular Egg LT Bagel ',
cast (expr_59313 as varchar) as 'AMDRMMB27 - Multigrain Egg LT Bagel ',


cast (expr_58749 as varchar) as 'AMDRPAMBB01 - The sandwich looked messy - M-BLT Ba',
cast (expr_58750 as varchar) as 'AMDRPAMBB02 - The bagel was greasy - M-BLT Bagel ',
cast (expr_58751 as varchar) as 'AMDRPAMBB03 - The bagel was crushed - M-BLT Bagel ',
cast (expr_58752 as varchar) as 'AMDRPAMBB04 - The bagel was over-toasted - M-BLT B ',
cast (expr_58753 as varchar) as 'AMDRPAMBB05 - The bagel was under-toasted - M-BLT ',
cast (expr_58754 as varchar) as 'AMDRPAMBB06 - The condiments were leaking out of t',
cast (expr_58755 as varchar) as 'AMDRPAMBB07 - Other - M-BLT Bagel ',
cast (expr_59323 as varchar) as 'AMDRPAMBB - Other Issue, What? -- Multigrain BLT B',

cast (expr_58788 as varchar) as 'AMDRPAMBE01 - The sandwich looked messy - M-Bacon',
cast (expr_58790 as varchar) as 'AMDRPAMBE02 - The bagel was greasy - M-Bacon N Eg ',
cast (expr_58792 as varchar) as 'AMDRPAMBE03 - The bagel was crushed - M-Bacon N E ',
cast (expr_58796 as varchar) as 'AMDRPAMBE04 - The bagel was over-toasted - M-Bacon ',
cast (expr_58798 as varchar) as 'AMDRPAMBE05 - The bagel was under-toasted - M-Bage ',
cast (expr_58799 as varchar) as 'AMDRPAMBE06 - The condiments were leaking out of t',
cast (expr_58800 as varchar) as 'AMDRPAMBE07 - Other - M-Bacon N Egg Bagel ',
cast (expr_59330 as varchar) as 'AMDRPAMBE - Other Issue, What? -- Multigrain Bacon',

cast (expr_58841 as varchar) as 'AMDRPAMEB01 - The sandwich looked messy - M-Egg LT',
cast (expr_58842 as varchar) as 'AMDRPAMEB02 - The bagel was greasy - M-Egg LT Bage ',
cast (expr_58843 as varchar) as 'AMDRPAMEB03 - The bagel was crushed - M-Egg LT Bag ',
cast (expr_58844 as varchar) as 'AMDRPAMEB04 - The bagel was over-toasted - M-Egg L ',
cast (expr_58848 as varchar) as 'AMDRPAMEB05 - The bagel was under-toasted - M-Egg ',
cast (expr_58849 as varchar) as 'AMDRPAMEB06 - The condiments were leaking out of t',
cast (expr_58850 as varchar) as 'AMDRPAMEB07 - Other - M-Egg LT Bagel ',
cast (expr_59332 as varchar) as 'AMDRPAMEB - Other Issue, What? - MG Egg LT Bagel A ',

cast (expr_58728 as varchar) as 'AMDRPAMGB01 - The bagel was greasy - Multigrain Ba ',
cast (expr_58729 as varchar) as 'AMDRPAMGB02 - The bagel was crushed - Multigrain B ',
cast (expr_58730 as varchar) as 'AMDRPAMGB03 - The bagel was over-toasted - Multigr ',
cast (expr_58731 as varchar) as 'AMDRPAMGB04 - The bagel was under-toasted - Multig ',
cast (expr_58732 as varchar) as 'AMDRPAMGB05 - Other - Multigrain Bagel ',
cast (expr_59318 as varchar) as 'AMDRPAMGB - Other Issue, What? - Multigrain Bagel ',

cast (expr_58723 as varchar) as 'AMDRPARB01 - The bagel was greasy - Regular Bagel ',
cast (expr_58724 as varchar) as 'AMDRPARB02 - The bagel was crushed - Regular Bagel ',
cast (expr_58725 as varchar) as 'AMDRPARB03 - The bagel was over-toasted - Regular ',
cast (expr_58726 as varchar) as 'AMDRPARB04 - The bagel was under-toasted - Regular ',
cast (expr_58727 as varchar) as 'AMDRPARB05 - Other - Regular Bagel ',
cast (expr_59317 as varchar) as 'AMDRPARB - Other Issue, What? - Regular Bagel ',

cast (expr_58742 as varchar) as 'AMDRPARBB01 - The sandwich looked messy - R-BLT Ba',
cast (expr_58743 as varchar) as 'AMDRPARBB02 - The bagel was greasy - R-BLT Bagel ',
cast (expr_58744 as varchar) as 'AMDRPARBB03 - The bagel was crushed - R-BLT Bagel ',
cast (expr_58745 as varchar) as 'AMDRPARBB04 - The bagel was over-toasted - R-BLT B ',
cast (expr_58746 as varchar) as 'AMDRPARBB05 - The bagel was under-toasted - R-BLT ',
cast (expr_58747 as varchar) as 'AMDRPARBB06 - The condiments were leaking out of t',
cast (expr_58748 as varchar) as 'AMDRPARBB07 - Other - R-BLT Bagel ',
cast (expr_59322 as varchar) as 'AMDRPARBB - Other Issue, What? - Regular BLT Bagel',

cast (expr_58801 as varchar) as 'AMDRPARBE01 - The sandwich looked messy - R-Bacon',
cast (expr_58802 as varchar) as 'AMDRPARBE02 - The bagel was greasy - R-Bacon N Eg ',
cast (expr_58803 as varchar) as 'AMDRPARBE03 - The bagel was crushed - R-Bacon N E ',
cast (expr_58804 as varchar) as 'AMDRPARBE04 - The bagel was over-toasted - R-Bacon ',
cast (expr_58805 as varchar) as 'AMDRPARBE05 - The bagel was under-toasted - R-Baco ',
cast (expr_58806 as varchar) as 'AMDRPARBE06 - The condiments were leaking out of t',
cast (expr_58807 as varchar) as 'AMDRPARBE07 - Other - R-Bacon N Egg Bagel ',
cast (expr_59326 as varchar) as 'AMDRPARBE - Other Issue, What? Regular Bacon N Egg',

cast (expr_58852 as varchar) as 'AMDRPAREB01 - The sandwich looked messy - R-Egg LT',
cast (expr_58853 as varchar) as 'AMDRPAREB02 - The bagel was greasy - R-Egg LT ',
cast (expr_58854 as varchar) as 'AMDRPAREB03 - The bagel was crushed - R-Egg LT Bag ',
cast (expr_58856 as varchar) as 'AMDRPAREB04 - The bagel was over-toasted - R-Egg L ',
cast (expr_58858 as varchar) as 'AMDRPAREB05 - The bagel was under-toasted - R-Egg ',
cast (expr_58859 as varchar) as 'AMDRPAREB06 - The condiments were leaking out of t',
cast (expr_58861 as varchar) as 'AMDRPAREB07 - Other - R-Egg LT Bagel ',
cast (expr_59331 as varchar) as 'AMDRPAREB - Other Issue, What? - Regular Egg LT Ba',


cast (expr_58756 as varchar) as 'AMDRPTMBB01 - The sandwich was greasy - M-BLT Bage',
cast (expr_58758 as varchar) as 'AMDRPTMBB02 - The bagel was hard or dry - M-BLT Ba ',
cast (expr_58759 as varchar) as 'AMDRPTMBB03 - The bagel was soggy - M-BLT Bagel ',
cast (expr_58760 as varchar) as 'AMDRPTMBB04 - The produce wasnt fresh - M-BLT Bag',
cast (expr_58761 as varchar) as 'AMDRPTMBB05 - The bacon was dry - M-BLT Bagel ',
cast (expr_58762 as varchar) as 'AMDRPTMBB06 - Other - M-BLT Bagel ',
cast (expr_59361 as varchar) as 'AMDRPTMBB - Other Issue, What? - MG BLT Bagel Tast ',


cast (expr_58773 as varchar) as 'AMDRPTMBE01 - The sandwich was greasy - M-Bacon N',
cast (expr_58774 as varchar) as 'AMDRPTMBE02 - The egg was dry - M-Bacon N Egg Bag',
cast (expr_58775 as varchar) as 'AMDRPTMBE03 - The egg wasnt cooked enough - M-Bac',
cast (expr_58776 as varchar) as 'AMDRPTMBE04 - The bagel was hard or dry - M-Bacon ',
cast (expr_58777 as varchar) as 'AMDRPTMBE05 - The bagel was soggy - M-Bacon N Egg ',
cast (expr_58778 as varchar) as 'AMDRPTMBE06 - The bacon was dry - M-Bacon N Egg B',
cast (expr_58779 as varchar) as 'AMDRPTMBE07 - The cheese wasnt melted enough - M-',
cast (expr_58780 as varchar) as 'AMDRPTMBE08 - Other - M-Bacon N Egg Bagel ',
cast (expr_59368 as varchar) as 'AMDRPTMBE - Other Issue, What? - Multigran Bacon N',

cast (expr_58817 as varchar) as 'AMDRPTMEB01 - The sandwich was greasy - R-Egg LT B',
cast (expr_58818 as varchar) as 'AMDRPTMEB02 - The egg was dry - M-Egg LT Bagel ',
cast (expr_58812 as varchar) as 'AMDRPTMEB04 - The bagel was hard or dry - R-Egg LT ',
cast (expr_58820 as varchar) as 'AMDRPTMEB05 - The bagel was soggy - M-Egg LT Bagel ',
cast (expr_58821 as varchar) as 'AMDRPTMEB06 - The produce wasnt fresh - M-Egg LT',
cast (expr_58822 as varchar) as 'AMDRPTMEB07 - The cheese wasnt melted enough - M-',
cast (expr_58823 as varchar) as 'AMDRPTMEB08 - Other - M-Egg LT Bagel ',
cast (expr_59370 as varchar) as 'AMDRPTMEB - Other Issue, What? - MG Egg LT Bagel ',

cast (expr_58733 as varchar) as 'AMDRPTMGB01 - The bagel was hard or dry - Multigra ',
cast (expr_58734 as varchar) as 'AMDRPTMGB02 - The bagel was soggy - Multigrain Bag ',
cast (expr_58735 as varchar) as 'AMDRPTMGB03 - Other - Multigrain Bagel ',
cast (expr_59357 as varchar) as 'AMDRPTMGB - Other Issue, What? - Multigrain Bagel ',

cast (expr_58720 as varchar) as 'AMDRPTRB01 - The bagel was hard or dry - Regular B ',
cast (expr_58721 as varchar) as 'AMDRPTRB02 - The bagel was soggy - Regular Bagel ',
cast (expr_58722 as varchar) as 'AMDRPTRB03 - Other - Regular Bagel ',
cast (expr_59343 as varchar) as 'AMDRPTRB - Other Issue, What? - Regular Bagel Tast ',

cast (expr_58736 as varchar) as 'AMDRPTRBB01 - The sandwich was greasy - R-BLT Bage',
cast (expr_58737 as varchar) as 'AMDRPTRBB02 - The bagel was hard or dry - R-BLT Ba ',
cast (expr_58738 as varchar) as 'AMDRPTRBB03 - The bagel was soggy - R-BLT Bagel ',
cast (expr_58739 as varchar) as 'AMDRPTRBB04 - The produce wasnt fresh - R-BLT Bag',
cast (expr_58740 as varchar) as 'AMDRPTRBB05 - The bacon was dry - R-BLT Bagel ',
cast (expr_58741 as varchar) as 'AMDRPTRBB06 - Other - R-BLT Bagel ',
cast (expr_59359 as varchar) as 'AMDRPTRBB - Other Issue, What? - Regular BLT Bagel ',

cast (expr_58765 as varchar) as 'AMDRPTRBE01 - The sandwich was greasy - R-Bacon N',
cast (expr_58766 as varchar) as 'AMDRPTRBE02 - The egg was dry - R-Bacon N Egg Bag',
cast (expr_58767 as varchar) as 'AMDRPTRBE03 - The egg wasnt cooked enough - R-Bac',
cast (expr_58768 as varchar) as 'AMDRPTRBE04 - The Bagel was hard or dry - R-Bacon ',
cast (expr_58769 as varchar) as 'AMDRPTRBE05 - The bagel was soggy - R-Bacon N Egg ',
cast (expr_58770 as varchar) as 'AMDRPTRBE06 - The bacon was dry - R-Bacon N Egg B',
cast (expr_58771 as varchar) as 'AMDRPTRBE07 - The cheese wasnt melted enough - R-',
cast (expr_58772 as varchar) as 'AMDRPTRBE08 - Other - R-Bacon N Egg Bagel ',
cast (expr_59364 as varchar) as 'AMDRPTRBE - Other Issue, What? - Regular Bacon N',


cast (expr_58808 as varchar) as 'AMDRPTREB01 - The sandwich was greasy - R Egg LT B',
cast (expr_58809 as varchar) as 'AMDRPTREB02 - The egg was dry - R- Egg LT Bagel ',
cast (expr_58810 as varchar) as 'AMDRPTREB03 - The egg wasnt cooked enough - R-Egg',
cast (expr_58811 as varchar) as 'AMDRPTREB04 - The bagel was hard or dry - R-Egg LT ',
cast (expr_58813 as varchar) as 'AMDRPTREB05 - The bagel was soggy - R-Egg LT Bagel ',
cast (expr_58814 as varchar) as 'AMDRPTREB06 - The produce wasnt fresh - R-Egg LT',
cast (expr_58815 as varchar) as 'AMDRPTREB07 - The cheese wasnt melted enough - R',
cast (expr_58816 as varchar) as 'AMDRPTREB08 - Other - R-Egg LT Bagel ',
cast (expr_59369 as varchar) as 'AMDRPTREB - Other Issue, What? - Regular Egg LT Ba',


cast (expr_58864 as varchar) as 'AMPMB20 - Regular Bagel ',
cast (expr_58865 as varchar) as 'AMPMB21 - Multigrain Bagel ',
cast (expr_58869 as varchar) as 'AMPMB22 - Regular BLT Bagel ',
cast (expr_58870 as varchar) as 'AMPMB23 - Multigrain BLT Bagel ',
cast (expr_58871 as varchar) as 'AMPMB24 - Regular Bacon N Egg Bagel ',
cast (expr_58872 as varchar) as 'AMPMB25 - Multigrain Bacon N Egg Bagel ',
cast (expr_58873 as varchar) as 'AMPMB26 - Regular Egg LT Bagel ',
cast (expr_58874 as varchar) as 'AMPMB27 - Multigrain Egg LT Bagel ',
--added06/08/12
cast (expr_58898 as varchar) as 'AMDPUMB25 Multigrain Bacon N Egg Bacon',
cast (expr_58819 as varchar) as 'AMDRPTMEB03 - The egg wasnt cooked enough - M-Egg',

cast (expr_58413 as varchar) as 'AMPB14 - Angus Smokey BBQ Bacon',
cast (expr_58416 as varchar) as 'AMDPAB13 - Angus Smokey BBQ Bacon',
cast (expr_58417 as varchar) as 'AMDPTB13 - Angus Smokey BBQ Bacon',
cast (expr_58418 as varchar) as 'AMDPUB13 - Angus Smokey BBQ Bacon',
cast (expr_58420 as varchar) as 'AMDRIB13 - Angus Smokey BBQ Bacon',
cast (expr_58421 as varchar) as 'AMDRMB13 - Angus Smokey BBQ Bacon',

cast (expr_58444 as varchar) as 'AMDRPAAS - Other Issue, What? -- Angus Smokey BBQ',
cast (expr_58436 as varchar) as 'AMDRPAAS01 - The sandwich looked messy - Angus Smo',
cast (expr_58437 as varchar) as 'AMDRPAAS02 - The bun was greasy - Angus Smokey BBQ',
cast (expr_58438 as varchar) as 'AMDRPAAS03 - The bun was crushed - Angus Smokey BB',
cast (expr_58439 as varchar) as 'AMDRPAAS04 - The condiments were leaking out of th',
cast (expr_58441 as varchar) as 'AMDRPAAS05 - The sandwich was not served in paper',
cast (expr_58442 as varchar) as 'AMDRPAAS06 - Cheese wasnt melted enough -- Angus',
cast (expr_58443 as varchar) as 'AMDRPAAS07 - Other - Angus Smokey BBQ Bacon',

cast (expr_58433 as varchar) as 'AMDRPTAS - Other Issue, What? -- Angus Smokey BBQ',
cast (expr_58422 as varchar) as 'AMDRPTAS01 - The Sandwich was greasy - Angus Smoke',
cast (expr_58424 as varchar) as 'AMDRPTAS02 - The meat was dry - Angus Smokey BBQ B',
cast (expr_58425 as varchar) as 'AMDRPTAS03 - The meat wasnt cooked enough - Angus',
cast (expr_58426 as varchar) as 'AMDRPTAS04 - The bun was hard or dry - Angus Smoke',
cast (expr_58427 as varchar) as 'AMDRPTAS05 - The bun was soggy - Angus Smokey BBQ',
cast (expr_58428 as varchar) as 'AMDRPTAS06 - The produce wasnt fresh - Angus Smok',
cast (expr_58429 as varchar) as 'AMDRPTAS07 - Cheese wasnt melted enough - Angus S',
cast (expr_58430 as varchar) as 'AMDRPTAS08 - The bacon was dry - Angus Smokey BBQ',
cast (expr_58431 as varchar) as 'AMDRPTAS09 - Other -- Angus Smokey BBQ Bacon',
--1/12/2012
cast (expr_68895 as varchar) as 'AMDPAC17 - McBites',
cast (expr_68849 as varchar) as 'AMDPTC17 - McBites',
cast (expr_68924 as varchar) as 'AMDPUC17 - McBites',
cast (expr_68618 as varchar) as 'AMDRAMcB - Other Issue, What? - McBites',
cast (expr_68614 as varchar) as 'AMDRAMcB01 - Packaging was greasy --- McBites®',
cast (expr_68615 as varchar) as 'AMDRAMcB02 - Packaging was messy --- McBites®',
cast (expr_68616 as varchar) as 'AMDRAMcB03 - Chicken McBites® were burnt',
cast (expr_68617 as varchar) as 'AMDRAMcB04 - Other --- McBites®',
cast (expr_68925 as varchar) as 'AMDRIC17 - McBites',
cast (expr_68926 as varchar) as 'AMDRMC17 - McBites',
cast (expr_68647 as varchar) as 'AMDRTMcB - Other Issue, What? - McBites',
cast (expr_68626 as varchar) as 'AMDRTMcB01 - The Chicken McBites® were dry',
cast (expr_68629 as varchar) as 'AMDRTMcB02 - The Chicken McBites® werent co',
cast (expr_68631 as varchar) as 'AMDRTMcB03 - McBites breading was overcooked Happy',
cast (expr_68632 as varchar) as 'AMDRTMcB04 - McBites breading was undercooked Hap',
cast (expr_68635 as varchar) as 'AMDRTMcB05 - Other --- McBites®',
cast (expr_68927 as varchar) as 'AMPC17 - McBites',

--6/4/13
cast (expr_94682 as varchar) as 'AMPC18 Chic/Bac McWrap',
cast (expr_94938 as varchar) as 'AMDPTC18 Chic/Bac McWrap',
cast (expr_94939 as varchar) as 'AMDPAC18 Chic/Bac McWrap',
cast (expr_94995 as varchar) as 'AMDPUC18 Chic/Bac McWrap',
cast (expr_94930 as varchar) as 'AMDRIC18 Chic/Bac McWrap',
cast (expr_94933 as varchar) as 'AMDRMC18 Chic/Bac McWrap',

cast (expr_94698 as varchar) as 'AMPC19 Fiesta McWrap',
cast (expr_94940 as varchar) as 'AMDPAC19 Fiesta McWrap',
cast (expr_94937 as varchar) as 'AMDPTC19 Fiesta McWrap',
cast (expr_94998 as varchar) as 'AMDPUC19 Fiesta McWrap',
cast (expr_94931 as varchar) as 'AMDRIC19 Fiesta McWrap',
cast (expr_94934 as varchar) as 'AMDRMC19 Fiesta McWrap',

cast (expr_94710 as varchar) as 'AMPC20 Sweet Chili Cucumber McWrap®',
cast (expr_94941 as varchar) as 'AMDPAC20 Sweet Chili Cucumber McWrap®',
cast (expr_94936 as varchar) as 'AMDPTC20 Sweet Chili Cucumber McWrap®',
cast (expr_94999 as varchar) as 'AMDPUC20 Sweet Chili Cucumber McWrap®',
cast (expr_94932 as varchar) as 'AMDRIC20 Sweet Chili Cucumber McWrap®',
cast (expr_94935 as varchar) as 'AMDRMC20 Sweet Chili Cucumber McWrap®',

cast (expr_94683 as varchar) as 'AMDRPCB - Crispy or Grilled - Chic/Bac McWrap',
cast (expr_94699 as varchar) as 'AMDRPF - Crispy or Grilled - Fiesta McWrap',
cast (expr_94712 as varchar) as 'AMDRPSC - Crispy or Grilled -Sweet Chili Cucumber',

cast (expr_94685 as varchar) as 'AMDRTCB01 The Wrap was Greasy - Chic/Bac McWrap',
cast (expr_94688 as varchar) as 'AMDRTCB02 - The Wrap was hard/dry -Chic/Bac McWrap',
cast (expr_94689 as varchar) as 'AMDRTCB03 - The Wrap was soggy - Chic/Bac McWrap',
cast (expr_94690 as varchar) as 'AMDRTCB04- The chicken was dry - Chic/Bac McWrap',
cast (expr_94691 as varchar) as 'AMDRTCB05 - The chicken wasnt cooked enough - Chi',
cast (expr_94692 as varchar) as 'AMDRTCB06 - The lettuce was soggy/wilted -Chic/Ba',
cast (expr_94693 as varchar) as 'AMDRTCB07 -Tomatoes were not juicy - Chic/Bac McWr',
cast (expr_94694 as varchar) as 'AMDRTCB08 - The bacon was dry - Chic/Bac McWrap',
cast (expr_94695 as varchar) as 'AMDRTCB09 - The bacon was chewy - Chic/Bac McWrap',
cast (expr_94696 as varchar) as 'AMDRTCB10 - Too much/Not enough sauce Chic/Bac Mc',
cast (expr_94697 as varchar) as 'AMDRTCB11 - Other Issue, What? --Chic/Bac McWrap',
cast (expr_95506 as varchar) as 'AMDRTCB12 - Chic/Bac Other',

cast (expr_94735 as varchar) as 'AMDRACB01 - The Wrap looked messy - Chic/Bac McWra',
cast (expr_94736 as varchar) as 'AMDRACB02 - The Wrap was crushed - Chic/Bac McWrap',
cast (expr_94738 as varchar) as 'AMDRACB03 - The condiments were leaking/spillin -',
cast (expr_94737 as varchar) as 'AMDRACB04 - The tortilla was torn - Chic/Bac McWra',
cast (expr_94739 as varchar) as 'AMDRACB05 - Other Issue, What? --Chic/Bac McWrap',
cast (expr_95507 as varchar) as 'AMDRACB06 - Chic/Bac Other',

cast (expr_94700 as varchar) as 'AMDRTF01 The Wrap was Greasy - Fiesta McWrap',
cast (expr_94701 as varchar) as 'AMDRTF02 - The Wrap was hard/dry - Fiesta McWrap',
cast (expr_94702 as varchar) as 'AMDRTF03 - The Wrap was soggy - Fiesta McWrap',
cast (expr_94703 as varchar) as 'AMDRTF04 - The chicken was dry - Fiesta',
cast (expr_94704 as varchar) as 'AMDRTF05 - The chicken wasnt cooked enough - Fi',
cast (expr_94705 as varchar) as 'AMDRTF06 - The lettuce was soggy/wilted - Fiesta',
cast (expr_94706 as varchar) as 'AMDRTF07 -Tomatoes were not juicy - Fie',
cast (expr_94707 as varchar) as 'AMDRTF08 - Tortilla strips were soggy - Fiesta Mc',
cast (expr_94708 as varchar) as 'AMDRTF09 - Too much/Not enough sauce - Fiesta McW',
cast (expr_94709 as varchar) as 'AMDRTF10 - Other Issue, What? --Fiesta McWrap',
cast (expr_95508 as varchar) as 'AMDRTF11 - Fiesta Other',

cast (expr_94741 as varchar) as 'AMDRAF01 - The Wrap looked messy - Fiesta McWrap',
cast (expr_94743 as varchar) as 'AMDRAF02 - The Wrap was crushed - Fiesta McWrap',
cast (expr_94745 as varchar) as 'AMDRAF03 - The condiments were leaking/spilling o',
cast (expr_94747 as varchar) as 'AMDRAF04 - The tortilla was torn - Fiesta McWrap',
cast (expr_94749 as varchar) as 'AMDRAF05 - Other Issue, What? --Fiesta McWrap',
cast (expr_95509 as varchar) as 'AMDRAF06 - Other Fiesta',

cast (expr_94713 as varchar) as 'AMDRTSC01 The Wrap was Greasy - Sweet Wrap',
cast (expr_94715 as varchar) as 'AMDRTSC02 - The Wrap was hard/dry - Sweet Chili Cu',
cast (expr_94716 as varchar) as 'AMDRTSC03 - The Wrap was soggy - Sweet Chili Cucum',
cast (expr_94717 as varchar) as 'AMDRTSC04 - The chicken was dry - Sweet Chili Cucu',
cast (expr_94718 as varchar) as 'AMDRTSC05 - The chicken wasnt cooked',
cast (expr_94719 as varchar) as 'AMDRTSC06 - The lettuce was soggy/wilted - Sweet C',
cast (expr_94720 as varchar) as 'AMDRTSC07 -Tomatoes were not juicy - Sweet Chili C',
cast (expr_94721 as varchar) as 'AMDRTSC08 - Cucumbers were not fresh - Sweet Chi',
cast (expr_94722 as varchar) as 'AMDRTSC09 - Too much/Not enough sauce - Sweet Chil',
cast (expr_94714 as varchar) as 'AMDRTSC10 - Other Issue, What? --Sweet Chili Cucu',
cast (expr_95510 as varchar) as 'AMDRTSC11 - Sweet Chili Other',

cast (expr_94742 as varchar) as 'AMDRASC01 - The Wrap looked messy - Sweet Chili Cu',
cast (expr_94744 as varchar) as 'AMDRASC02 - The Wrap was crushed - Sweet Chili Cuc',
cast (expr_94746 as varchar) as 'AMDRASC03 - The condiments were leaking/spilling o',
cast (expr_94748 as varchar) as 'AMDRASC04 - The tortilla was torn - Sweet Chili Cu',
cast (expr_94750 as varchar) as 'AMDRASC05 - Other Issue, What? --Sweet Chili Cucum',
cast (expr_95511 as varchar) as 'AMDRASC06 - Sweet Chili Other',

cast (expr_95519 as varchar) as 'AMPN08 Coffee Iced Frappe',
cast (expr_95634 as varchar) as 'AMDPAN08 Coffee Iced Appear',
cast (expr_95655 as varchar) as 'AMDPTN08 Coffee Iced taste',
cast (expr_95638 as varchar) as 'AMDPUN08 Coffee Iced temp',
cast (expr_95625 as varchar) as 'AMDRIN08 Coffee Iced incorrect',
cast (expr_95629 as varchar) as 'AMDRMN08 Coffee Iced missing',

cast (expr_95520 as varchar) as 'AMPN09 Vanilla Chai Tea Iced Frappe',
cast (expr_95635 as varchar) as 'AMDPAN09 Vanilla Chai Appear',
cast (expr_95658 as varchar) as 'AMDPTN09 Vanilla Chai taste',
cast (expr_95642 as varchar) as 'AMDPUN09 Vanilla Chai temp',
cast (expr_95626 as varchar) as 'AMDRIN09 Vanilla Chai incorrect',
cast (expr_95630 as varchar) as 'AMDRMN09 Vanilla Chai missing',

cast (expr_95521 as varchar) as 'AMDRPTCIF01 Coffee Iced too sweet',
cast (expr_95523 as varchar) as 'AMDRPTCIF02 Coffee Iced not sweet enough',
cast (expr_95524 as varchar) as 'AMDRPTCIF03 Coffee Iced too strong',
cast (expr_95525 as varchar) as 'AMDRPTCIF04 Coffee Iced too weak',
cast (expr_95526 as varchar) as 'AMDRPTCIF05 Coffee Iced too thick',
cast (expr_95527 as varchar) as 'AMDRPTCIF06 Coffee Iced not thick enough',
cast (expr_95528 as varchar) as 'AMDRPTCIF07 Coffee Iced too creamy',
cast (expr_95529 as varchar) as 'AMDRPTCIF08 Coffee Iced not creamy',
cast (expr_95530 as varchar) as 'AMDRPTCIF09 Coffee Iced Icy',
cast (expr_95545 as varchar) as 'AMDRPTCIF10 Coffee Iced not icy',
cast (expr_95546 as varchar) as 'AMDRPTCIF11 Other',
cast (expr_95547 as varchar) as 'AMDRPTCIF11a Other Issue, What? -- Coffee Iced',

cast (expr_95548 as varchar) as 'AMDRPACIF01 Coffee Iced not filled',
cast (expr_95549 as varchar) as 'AMDRPACIF02 Coffee Iced too full',
cast (expr_95556 as varchar) as 'AMDRPACIF03 Coffee Iced lid not on',
cast (expr_95558 as varchar) as 'AMDRPACIF04 Coffee Iced cup messy',
cast (expr_95559 as varchar) as 'AMDRPACIF05 Coffee Iced unppeal appear',
cast (expr_95560 as varchar) as 'AMDRPACIF06 Coffee Iced Other',
cast (expr_95562 as varchar) as 'AMDRPACIF06a Other Issue, What? -- Coffee Iced',

cast (expr_95561 as varchar) as 'AMDRPUCIF01 Coffee Iced melted',
cast (expr_95563 as varchar) as 'AMDRPUCIF02 Coffee Iced Other',
cast (expr_95564 as varchar) as 'AMDRPUCIF02a Other Issue, What? -- Coffee Iced',

cast (expr_95585 as varchar) as 'AMDRPTVC01 Vanilla Chai too sweet',
cast (expr_95586 as varchar) as 'AMDRPTVC02 Vanilla Chai not sweet',
cast (expr_95587 as varchar) as 'AMDRPTVC03 Vanilla Chai too strong',
cast (expr_95588 as varchar) as 'AMDRPTVC04 Vanilla Chai too weak',
cast (expr_95589 as varchar) as 'AMDRPTVC05 Vanilla Chai too thick',
cast (expr_95590 as varchar) as 'AMDRPTVC06 Vanilla Chai not thick',
cast (expr_95591 as varchar) as 'AMDRPTVC07 Vanilla Chai too creamy',
cast (expr_95592 as varchar) as 'AMDRPTVC08 Vanilla Chai not creamy',
cast (expr_95593 as varchar) as 'AMDRPTVC09 Vanilla Chai icy',
cast (expr_95594 as varchar) as 'AMDRPTVC10 Vanilla Chai not icy',
cast (expr_95595 as varchar) as 'AMDRPTVC11 Vanilla Chai Other Taste',
cast (expr_95596 as varchar) as 'AMDRPTVC11a Other Issue, What? -- Vanilla Chai',

cast (expr_95597 as varchar) as 'AMDRPAVC01 Vanilla Chai not full',
cast (expr_95598 as varchar) as 'AMDRPAVC02 Vanilla Chai overfilled',
cast (expr_95599 as varchar) as 'AMDRPAVC03 Vanilla Chai lid not on',
cast (expr_95600 as varchar) as 'AMDRPAVC04 Vanilla Chai cup messy',
cast (expr_95601 as varchar) as 'AMDRPAVC05 Vanilla Chai unappeal appear',
cast (expr_95602 as varchar) as 'AMDRPAVC06 Vanilla Chai Other',
cast (expr_95603 as varchar) as 'AMDRPAVC06a Other Issue, What? -- Vanilla Chai',

cast (expr_95604 as varchar) as 'AMDRPUVC01 Vanilla Chai melted',
cast (expr_95606 as varchar) as 'AMDRPUVC02 Vanilla Chai Other',
cast (expr_95607 as varchar) as 'AMDRPUVC02a Other Issue, What? -- Vanilla Chai',

cast (expr_94627 as varchar) as 'CANMC Employee Location',
cast (expr_94628 as varchar) as 'CANMC Employee',

--added 9/1/13

cast (expr_98629 as varchar) as 'AMDPAC21 Santa Fe Signature McWrap®',
cast (expr_98627 as varchar) as 'AMDPTC21 Santa Fe Signature McWrap®',
cast (expr_98643 as varchar) as 'AMDPUSF21 Santa Fe McWrap',
cast (expr_98554 as varchar) as 'AMDRASF01 The wrap looked messy Santa Fe',
cast (expr_98556 as varchar) as 'AMDRASF02 The wrap was crushed Santa Fe',
cast (expr_98557 as varchar) as 'AMDRASF03 Condiments leaking/spilling Santa Fe',
cast (expr_98558 as varchar) as 'AMDRASF04 The tortilla was torn Santa Fe',
cast (expr_98560 as varchar) as 'AMDRASF05 Other Santa Fe',
cast (expr_98605 as varchar) as 'AMDRASF06 If Other Santa Fe',
cast (expr_98622 as varchar) as 'AMDRIC21 Santa Fe Signature McWrap®',
cast (expr_98626 as varchar) as 'AMDRMC21 Santa Fe Signature McWrap®',
cast (expr_98230 as varchar) as 'AMDRTSF01 Greasy wrap - Santa Fe Wrap',
cast (expr_98235 as varchar) as 'AMDRTSF02 Wrap was hard Santa Fe',
cast (expr_98238 as varchar) as 'AMDRTSF03 Wrap was soggy Santa Fe',
cast (expr_98241 as varchar) as 'AMDRTSF04 Lettuce was soggy Santa Fe',
cast (expr_98242 as varchar) as 'AMDRTSF05 Too much/Not enough lettuce Santa Fe',
cast (expr_98245 as varchar) as 'AMDRTSF06 Tomatoes were not juicy Santa Fe',
cast (expr_98247 as varchar) as 'AMDRTSF07 Tortilla strips were soggy Santa Fe',
cast (expr_98248 as varchar) as 'AMDRTSF08 Corn & Black Bean Santa Fe',
cast (expr_98249 as varchar) as 'AMDRTSF09 Enough sauce Santa Fe',
cast (expr_98250 as varchar) as 'AMDRTSF10 Other Santa Fe',
cast (expr_98552 as varchar) as 'AMDRTSF11 If other Santa Fe',
cast (expr_98221 as varchar) as 'AMPC21 Santa Fe Signature McWrap',
cast (expr_98630 as varchar) as 'AMDPAC22 Mediterranean Signature McWrap®',
cast (expr_98628 as varchar) as 'AMDPTC22 Mediterranean Signature McWrap®',
cast (expr_98711 as varchar) as 'AMDPUMS22 Mediterranean Signature McWrap®',
cast (expr_98591 as varchar) as 'AMDRAMS01 The wrap looked messy Mediterranean Sign',
cast (expr_98592 as varchar) as 'AMDRAMS02 The wrap was crushed Mediterranean Sign',
cast (expr_98595 as varchar) as 'AMDRAMS03 The condiment leaking Mediterranean Sign',
cast (expr_98597 as varchar) as 'AMDRAMS04 The tortilla was torn Mediterranean Sign',
cast (expr_98598 as varchar) as 'AMDRAMS05 Other Mediterranean Sign',
cast (expr_98601 as varchar) as 'AMDRAMS06 If other Mediterranean Sign',
cast (expr_98624 as varchar) as 'AMDRIC22 Mediterranean Signature McWrap®',
cast (expr_98625 as varchar) as 'AMDRMC22 Mediterranean Signature McWrap®',
cast (expr_98564 as varchar) as 'AMDRTMS01 The wrap was greasy Mediterranean Sign',
cast (expr_98565 as varchar) as 'AMDRTMS02 The wrap was hard Mediterranean Sign',
cast (expr_98566 as varchar) as 'AMDRTMS03 The wrap was soggy Mediterranean Sign',
cast (expr_98567 as varchar) as 'AMDRTMS04 The Lettuce was soggy Mediterranean Sign',
cast (expr_98569 as varchar) as 'AMDRTMS05 Too much/not lettuce Mediterranean Sign',
cast (expr_98570 as varchar) as 'AMDRTMS06 Tomatoes not juicy Mediterranean Sign',
cast (expr_98571 as varchar) as 'AMDRTMS07 Cucumbers not fresh Mediterranean Sign',
cast (expr_98572 as varchar) as 'AMDRTMS08 Too much/not feta Mediterranean Sign',
cast (expr_98573 as varchar) as 'AMDRTMS09 Too much/not hummus Mediterranean Sign',
cast (expr_98586 as varchar) as 'AMDRTMS10 Too much/not sauce Mediterranean Sign',
cast (expr_98588 as varchar) as 'AMDRTMS11 Other Mediterranean Sign',
cast (expr_98590 as varchar) as 'AMDRTMS12 If other Mediterranean Sign',
cast (expr_98223 as varchar) as 'AMPC22 Mediterranean Signature McWrap',
cast (expr_94759 as varchar) as 'AMPMR01 Wrap(s) '


--into _McDExtract

from ( 
select
                SurveyResponse.objectId as surveyResponseObjectId ,
				locationnumber,
				[state],
				modetype,
				ani,
--                (case expr_28 
--                    when 69434 then N'Definitely Will Not' 
--                    when 69435 then N'Probably Will Not' 
--                    when 69438 then N'Definitely Will' 
--                    when 69437 then N'Probably Will' 
--                    when 69436 then N'Might or Might Not' 
--                end) as expr_28 ,
                (case expr_28 
                    when 69434 then N'1' 
                    when 69435 then N'2' 
                    when 69438 then N'5' 
                    when 69437 then N'4' 
                    when 69436 then N'3' 
                end) as expr_28 ,
                expr_333 as expr_333 ,
                expr_86 as expr_86 ,
                expr_219 as expr_219 ,
                expr_128 as expr_128 ,
                expr_464 as expr_464 ,
                expr_70 as expr_70 ,
                expr_469 as expr_469 ,
                expr_349 as expr_349 ,
                expr_561 as expr_561 ,
                expr_304 as expr_304 ,
                (case expr_13 
                    when 69350 then N'1' 
                    when 69349 then N'2' 
                    when 69348 then N'3' 
                    when 69347 then N'4' 
                    when 69346 then N'5' 
                end) as expr_13 ,
                expr_272 as expr_272 ,
                (case expr_27 
                    when 69431 then N'Better' 
                    when 69433 then N'Worse' 
                    when 69432 then N'Same' 
                end) as expr_27 ,
                expr_67 as expr_67 ,
                expr_448 as expr_448 ,
                expr_431 as expr_431 ,
                expr_152 as expr_152 ,
                expr_229 as expr_229 ,
                expr_410 as expr_410 ,
                expr_111 as expr_111 ,
                expr_537 as expr_537 ,
                expr_102 as expr_102 ,
                expr_77 as expr_77 ,
                expr_528 as expr_528 ,
                expr_368 as expr_368 ,
                expr_568 as expr_568 ,
                expr_263 as expr_263 ,
                expr_322 as expr_322 ,
                expr_167 as expr_167 ,
                expr_129 as expr_129 ,
                expr_415 as expr_415 ,
                expr_45 as expr_45 ,
                expr_261 as expr_261 ,
                expr_453 as expr_453 ,
                expr_282 as expr_282 ,
                expr_353 as expr_353 ,
                expr_150 as expr_150 ,
                expr_244 as expr_244 ,
                expr_123 as expr_123 ,
                expr_71 as expr_71 ,
                expr_227 as expr_227 ,
                expr_375 as expr_375 ,
                expr_565 as expr_565 ,
                expr_82 as expr_82 ,
                expr_295 as expr_295 ,
                expr_451 as expr_451 ,
                expr_422 as expr_422 ,
                expr_122 as expr_122 ,
                expr_209 as expr_209 ,
                expr_265 as expr_265 ,
                expr_101 as expr_101 ,
                expr_143 as expr_143 ,
                expr_408 as expr_408 ,
                expr_370 as expr_370 ,
                expr_171 as expr_171 ,
                expr_53 as expr_53 ,
                expr_93 as expr_93 ,
                expr_430 as expr_430 ,
                expr_176 as expr_176 ,
                (case expr_9 
                    when 69327 then N'4' 
                    when 69326 then N'5' 
                    when 69330 then N'1' 
                    when 69329 then N'2' 
                    when 69328 then N'3' 
                end) as expr_9 ,
                expr_5 as expr_5 ,
                expr_580 as expr_580 ,
                expr_522 as expr_522 ,
                expr_191 as expr_191 ,
                expr_365 as expr_365 ,
                expr_535 as expr_535 ,
                expr_393 as expr_393 ,
                expr_195 as expr_195 ,
                expr_239 as expr_239 ,
                expr_401 as expr_401 ,
                expr_75 as expr_75 ,
                expr_88 as expr_88 ,
                expr_604 as expr_604 ,
                expr_399 as expr_399 ,
                expr_509 as expr_509 ,
                expr_208 as expr_208 ,
                expr_481 as expr_481 ,
                expr_328 as expr_328 ,
                (case expr_20 
                    when 69736 then N'N/A' 
                    when 69378 then N'3' 
                    when 69379 then N'2' 
                    when 69376 then N'5' 
                    when 69380 then N'1' 
                    when 69377 then N'4' 
                end) as expr_20 ,
                expr_554 as expr_554 ,
                expr_135 as expr_135 ,
                expr_267 as expr_267 ,
                expr_197 as expr_197 ,
                expr_539 as expr_539 ,
                expr_78 as expr_78 ,
                expr_576 as expr_576 ,
                expr_22 as expr_22 ,
                expr_296 as expr_296 ,
                expr_482 as expr_482 ,
                expr_444 as expr_444 ,
                expr_390 as expr_390 ,
                expr_85 as expr_85 ,
                expr_139 as expr_139 ,
                expr_489 as expr_489 ,
                expr_273 as expr_273 ,
                expr_186 as expr_186 ,
                expr_174 as expr_174 ,
                expr_170 as expr_170 ,
                expr_42 as expr_42 ,
                expr_305 as expr_305 ,
                expr_326 as expr_326 ,
                expr_588 as expr_588 ,
                expr_199 as expr_199 ,
                expr_309 as expr_309 ,
                expr_41 as expr_41 ,
                expr_142 as expr_142 ,
                expr_407 as expr_407 ,
                expr_280 as expr_280 ,
                expr_64 as expr_64 ,
                expr_531 as expr_531 ,
                expr_97 as expr_97 ,
                expr_44 as expr_44 ,
                expr_423 as expr_423 ,
                expr_364 as expr_364 ,
                expr_358 as expr_358 ,
                expr_181 as expr_181 ,
                expr_392 as expr_392 ,
                expr_613 as expr_613 ,
                expr_189 as expr_189 ,
                expr_421 as expr_421 ,
                expr_213 as expr_213 ,
                expr_46 as expr_46 ,
                expr_424 as expr_424 ,
                expr_94 as expr_94 ,
                expr_629 as expr_629 ,
                expr_567 as expr_567 ,
                expr_564 as expr_564 ,
                expr_210 as expr_210 ,
                expr_69 as expr_69 ,
                expr_502 as expr_502 ,
                expr_562 as expr_562 ,
                expr_630 as expr_630 ,
                (case expr_33 
                    when 69402 then N'Dairy Queen' 
                    when 69399 then N'KFC' 
                    when 69403 then N'Mr. Sub' 
                    when 69400 then N'Subway' 
                    when 69401 then N'Quiznos' 
                    when 69396 then N'Burger King' 
                    when 69393 then N'McDonald’s' 
                    when 69398 then N'A&W' 
                    when 69395 then N'Harvey’s' 
                    when 69394 then N'Tim Hortons ' 
                    when 69397 then N'Wendy''s' 
                end) as expr_33 ,
                expr_597 as expr_597 ,
                expr_446 as expr_446 ,
                expr_602 as expr_602 ,
                expr_404 as expr_404 ,
                expr_287 as expr_287 ,
                expr_605 as expr_605 ,
                expr_270 as expr_270 ,
                expr_224 as expr_224 ,
                expr_493 as expr_493 ,
                expr_495 as expr_495 ,
                (case expr_18 
                    when 69370 then N'1' 
                    when 69368 then N'3' 
                    when 69367 then N'4' 
                    when 69366 then N'5' 
                    when 69369 then N'2' 
                end) as expr_18 ,
                expr_388 as expr_388 ,
                expr_620 as expr_620 ,
                expr_470 as expr_470 ,
                expr_623 as expr_623 ,
                expr_394 as expr_394 ,
                expr_182 as expr_182 ,
                expr_503 as expr_503 ,
                expr_84 as expr_84 ,
                expr_417 as expr_417 ,
                expr_339 as expr_339 ,
                expr_190 as expr_190 ,
                expr_307 as expr_307 ,
                expr_92 as expr_92 ,
                expr_455 as expr_455 ,
                expr_99 as expr_99 ,
                expr_382 as expr_382 ,
                expr_592 as expr_592 ,
                expr_230 as expr_230 ,
                expr_545 as expr_545 ,
                expr_379 as expr_379 ,
                expr_173 as expr_173 ,
                expr_395 as expr_395 ,
                expr_632 as expr_632 ,
                expr_218 as expr_218 ,
                expr_540 as expr_540 ,
                expr_346 as expr_346 ,
                expr_590 as expr_590 ,
                expr_238 as expr_238 ,
                expr_579 as expr_579 ,
                expr_74 as expr_74 ,
                expr_68 as expr_68 ,
                expr_137 as expr_137 ,
                expr_39 as expr_39 ,
                expr_194 as expr_194 ,
                expr_278 as expr_278 ,
                expr_505 as expr_505 ,
                expr_55 as expr_55 ,
                expr_98 as expr_98 ,
                expr_344 as expr_344 ,
                expr_569 as expr_569 ,
                expr_183 as expr_183 ,
                expr_610 as expr_610 ,
                expr_168 as expr_168 ,
                expr_436 as expr_436 ,
                expr_285 as expr_285 ,
                expr_468 as expr_468 ,
                expr_234 as expr_234 ,
                expr_310 as expr_310 ,
                expr_626 as expr_626 ,
                expr_411 as expr_411 ,
                expr_487 as expr_487 ,
                expr_225 as expr_225 ,
                expr_585 as expr_585 ,
                expr_609 as expr_609 ,
                expr_518 as expr_518 ,
                expr_276 as expr_276 ,
                expr_271 as expr_271 ,
                expr_345 as expr_345 ,
                expr_354 as expr_354 ,
                expr_511 as expr_511 ,
                expr_236 as expr_236 ,
                expr_593 as expr_593 ,
                expr_169 as expr_169 ,
                expr_49 as expr_49 ,
                expr_616 as expr_616 ,
                expr_543 as expr_543 ,
                expr_452 as expr_452 ,
                expr_151 as expr_151 ,
                expr_268 as expr_268 ,
                expr_628 as expr_628 ,
                expr_298 as expr_298 ,
                expr_429 as expr_429 ,
                expr_255 as expr_255 ,
                expr_611 as expr_611 ,
                expr_262 as expr_262 ,
                expr_157 as expr_157 ,
                expr_391 as expr_391 ,
                expr_58 as expr_58 ,
                SurveyResponse.beginDate as expr_0 ,
                expr_294 as expr_294 ,
                expr_301 as expr_301 ,
                expr_155 as expr_155 ,
                expr_612 as expr_612 ,
                expr_384 as expr_384 ,
                expr_547 as expr_547 ,
                expr_257 as expr_257 ,
                expr_356 as expr_356 ,
                expr_457 as expr_457 ,
                expr_57 as expr_57 ,
                expr_140 as expr_140 ,
                expr_439 as expr_439 ,
                expr_447 as expr_447 ,
                expr_366 as expr_366 ,
                expr_66 as expr_66 ,
                expr_515 as expr_515 ,
                expr_458 as expr_458 ,
                expr_144 as expr_144 ,
                expr_485 as expr_485 ,
                expr_293 as expr_293 ,
                expr_513 as expr_513 ,
                expr_374 as expr_374 ,
                expr_501 as expr_501 ,
                expr_62 as expr_62 ,
                expr_363 as expr_363 ,
                expr_517 as expr_517 ,
                expr_571 as expr_571 ,
                expr_465 as expr_465 ,
                expr_634 as expr_634 ,
                expr_440 as expr_440 ,
                expr_40 as expr_40 ,
                expr_59 as expr_59 ,
                expr_248 as expr_248 ,
                expr_172 as expr_172 ,
                expr_343 as expr_343 ,
                expr_541 as expr_541 ,
                expr_462 as expr_462 ,
                expr_297 as expr_297 ,
                expr_337 as expr_337 ,
                expr_284 as expr_284 ,
                expr_371 as expr_371 ,
                expr_477 as expr_477 ,
                (case expr_8 
                    when 69323 then N'In the Drive Thru' 
                    when 69322 then N'Ordered in the restaurant and carried out' 
                    when 69321 then N'In the Restaurant' 
                end) as expr_8 ,
                expr_342 as expr_342 ,
                expr_578 as expr_578 ,
                expr_549 as expr_549 ,
                expr_427 as expr_427 ,
                expr_405 as expr_405 ,
                expr_214 as expr_214 ,
                expr_603 as expr_603 ,
                expr_250 as expr_250 ,
                expr_527 as expr_527 ,
                expr_550 as expr_550 ,
                expr_60 as expr_60 ,
                expr_438 as expr_438 ,
                expr_300 as expr_300 ,
                expr_456 as expr_456 ,
                expr_204 as expr_204 ,
                expr_156 as expr_156 ,
                expr_90 as expr_90 ,
                expr_373 as expr_373 ,
                expr_133 as expr_133 ,
                expr_435 as expr_435 ,
                expr_138 as expr_138 ,
                expr_302 as expr_302 ,
                expr_258 as expr_258 ,
                expr_575 as expr_575 ,
                expr_437 as expr_437 ,
                expr_506 as expr_506 ,
                expr_245 as expr_245 ,
                expr_633 as expr_633 ,
                expr_341 as expr_341 ,
                expr_177 as expr_177 ,
                expr_136 as expr_136 ,
                expr_521 as expr_521 ,
                expr_461 as expr_461 ,
                (case expr_31 
                    when 69462 then N'Once every 2-3 weeks' 
                    when 69464 then N'Less often than once a month' 
                    when 69461 then N'Once a week' 
                    when 69463 then N'Once a month, every four weeks' 
                    when 69465 then N'Never' 
                    when 69460 then N'More than once a week' 
                end) as expr_31 ,
                expr_107 as expr_107 ,
                (case expr_32 
                    when 69413 then N'Dairy Queen' 
                    when 69411 then N'Subway' 
                    when 69410 then N'KFC' 
                    when 69414 then N'Mr. Sub' 
                    when 69409 then N'A&W' 
                    when 69406 then N'Harvey’s' 
                    when 69405 then N'Tim Hortons ' 
                    when 69408 then N'Wendy''s' 
                    when 69412 then N'Quiznos' 
                    when 69407 then N'Burger King' 
                    when 69404 then N'McDonald’s' 
                end) as expr_32 ,
                expr_327 as expr_327 ,
                expr_599 as expr_599 ,
                expr_467 as expr_467 ,
                SurveyResponse.dateOfService as expr_1 ,
                expr_222 as expr_222 ,
                expr_402 as expr_402 ,
                expr_617 as expr_617 ,
                expr_538 as expr_538 ,
                expr_253 as expr_253 ,
                expr_490 as expr_490 ,
                expr_582 as expr_582 ,
                expr_108 as expr_108 ,
                expr_114 as expr_114 ,
                expr_323 as expr_323 ,
                expr_125 as expr_125 ,
                expr_474 as expr_474 ,
                expr_166 as expr_166 ,
                expr_299 as expr_299 ,
                expr_529 as expr_529 ,
                expr_414 as expr_414 ,
                expr_198 as expr_198 ,
                expr_291 as expr_291 ,
                expr_96 as expr_96 ,
                expr_130 as expr_130 ,
                expr_314 as expr_314 ,
                expr_61 as expr_61 ,
                expr_319 as expr_319 ,
                expr_536 as expr_536 ,
                expr_43 as expr_43 ,
                expr_279 as expr_279 ,
                expr_34 as expr_34 ,
                expr_292 as expr_292 ,
                expr_563 as expr_563 ,
                expr_281 as expr_281 ,
                expr_266 as expr_266 ,
                expr_376 as expr_376 ,
                expr_491 as expr_491 ,
                expr_416 as expr_416 ,
                expr_231 as expr_231 ,
                expr_324 as expr_324 ,
                expr_499 as expr_499 ,
                expr_362 as expr_362 ,
                expr_153 as expr_153 ,
                expr_196 as expr_196 ,
                expr_158 as expr_158 ,
                expr_397 as expr_397 ,
                expr_247 as expr_247 ,
                expr_614 as expr_614 ,
                expr_496 as expr_496 ,
                expr_235 as expr_235 ,
                expr_131 as expr_131 ,
                (case expr_15 
                    when 69341 then N'5' 
                    when 69342 then N'4' 
                    when 69345 then N'1' 
                    when 69344 then N'2' 
                    when 69343 then N'3' 
                end) as expr_15 ,
                expr_317 as expr_317 ,
                expr_572 as expr_572 ,
                (case expr_10 
                    when 69353 then N'3' 
                    when 69352 then N'4' 
                    when 69351 then N'5' 
                    when 69355 then N'1' 
                    when 69354 then N'2' 
                end) as expr_10 ,
                expr_475 as expr_475 ,
                expr_432 as expr_432 ,
                expr_357 as expr_357 ,
                expr_220 as expr_220 ,
                expr_625 as expr_625 ,
                expr_583 as expr_583 ,
                expr_463 as expr_463 ,
                expr_184 as expr_184 ,
                (case expr_11 
                    when 69362 then N'4' 
                    when 69364 then N'2' 
                    when 69363 then N'3' 
                    when 69361 then N'5' 
                    when 69365 then N'1' 
                end) as expr_11 ,
                expr_533 as expr_533 ,
                expr_466 as expr_466 ,
                expr_601 as expr_601 ,
                expr_504 as expr_504 ,
                expr_409 as expr_409 ,
                expr_52 as expr_52 ,
                expr_289 as expr_289 ,
                expr_523 as expr_523 ,
                expr_215 as expr_215 ,
                expr_252 as expr_252 ,
                expr_507 as expr_507 ,
                expr_483 as expr_483 ,
                expr_480 as expr_480 ,
                expr_584 as expr_584 ,
                expr_329 as expr_329 ,
                expr_38 as expr_38 ,
                expr_159 as expr_159 ,
                expr_202 as expr_202 ,
                expr_288 as expr_288 ,
                (case expr_23 
                    when 69448 then N'0' 
                    when 69447 then N'1' 
                end) as expr_23 ,
                expr_598 as expr_598 ,
                expr_134 as expr_134 ,
                Location.name as expr_2 ,
                expr_124 as expr_124 ,
                expr_450 as expr_450 ,
                expr_433 as expr_433 ,
                expr_320 as expr_320 ,
                expr_118 as expr_118 ,
                (case expr_16 
                    when 69382 then N'0' 
                    when 69381 then N'1' 
                end) as expr_16 ,
                expr_350 as expr_350 ,
                expr_175 as expr_175 ,
                expr_488 as expr_488 ,
                expr_573 as expr_573 ,
                expr_385 as expr_385 ,
                expr_216 as expr_216 ,
                expr_619 as expr_619 ,
                expr_622 as expr_622 ,
                expr_530 as expr_530 ,
                expr_525 as expr_525 ,
                expr_109 as expr_109 ,
                expr_315 as expr_315 ,
                expr_512 as expr_512 ,
                expr_308 as expr_308 ,
                (case expr_30 
                    when 69458 then N'Less often than once a month' 
                    when 69454 then N'More than once a week' 
                    when 69459 then N'Never' 
                    when 69457 then N'Once a month, every four weeks' 
                    when 69456 then N'Once every 2-3 weeks' 
                    when 69455 then N'Once a week' 
                end) as expr_30 ,
                expr_442 as expr_442 ,
                expr_73 as expr_73 ,
                expr_201 as expr_201 ,
                expr_508 as expr_508 ,
                (case expr_6 
                    when 69325 then N'0' 
                    when 69324 then N'1' 
                end) as expr_6 ,
                expr_283 as expr_283 ,
                expr_83 as expr_83 ,
                expr_627 as expr_627 ,
                expr_243 as expr_243 ,
                expr_330 as expr_330 ,
                expr_406 as expr_406 ,
                expr_141 as expr_141 ,
                expr_631 as expr_631 ,
                expr_570 as expr_570 ,
                expr_398 as expr_398 ,
                expr_180 as expr_180 ,
                expr_552 as expr_552 ,
                expr_472 as expr_472 ,
                expr_223 as expr_223 ,
                expr_212 as expr_212 ,
                expr_200 as expr_200 ,
                expr_303 as expr_303 ,
                expr_478 as expr_478 ,
                expr_192 as expr_192 ,
                expr_558 as expr_558 ,
                expr_116 as expr_116 ,
                expr_581 as expr_581 ,
                expr_381 as expr_381 ,
                expr_148 as expr_148 ,
                expr_113 as expr_113 ,
                expr_594 as expr_594 ,
                expr_577 as expr_577 ,
                expr_206 as expr_206 ,
                expr_275 as expr_275 ,
                expr_95 as expr_95 ,
                expr_516 as expr_516 ,
                expr_449 as expr_449 ,
                expr_132 as expr_132 ,
                expr_160 as expr_160 ,
                expr_551 as expr_551 ,
                expr_557 as expr_557 ,
                expr_321 as expr_321 ,
                expr_534 as expr_534 ,
                expr_79 as expr_79 ,
                expr_316 as expr_316 ,
                expr_476 as expr_476 ,
                expr_532 as expr_532 ,
                expr_497 as expr_497 ,
                expr_76 as expr_76 ,
                expr_165 as expr_165 ,
                expr_203 as expr_203 ,
                expr_105 as expr_105 ,
                expr_217 as expr_217 ,
                expr_119 as expr_119 ,
                expr_106 as expr_106 ,
                expr_228 as expr_228 ,
                expr_403 as expr_403 ,
                expr_519 as expr_519 ,
                expr_454 as expr_454 ,
                expr_188 as expr_188 ,
                expr_146 as expr_146 ,
                Location.objectId as entityId_3 ,
                expr_232 as expr_232 ,
                expr_359 as expr_359 ,
                expr_87 as expr_87 ,
                expr_336 as expr_336 ,
                expr_112 as expr_112 ,
                expr_246 as expr_246 ,
                expr_418 as expr_418 ,
                expr_37 as expr_37 ,
                expr_63 as expr_63 ,
                expr_286 as expr_286 ,
                expr_161 as expr_161 ,
                expr_526 as expr_526 ,
                expr_544 as expr_544 ,
                expr_332 as expr_332 ,
                expr_559 as expr_559 ,
                expr_89 as expr_89 ,
                expr_621 as expr_621 ,
                expr_445 as expr_445 ,
                expr_555 as expr_555 ,
                expr_396 as expr_396 ,
                expr_56 as expr_56 ,
                expr_237 as expr_237 ,
                expr_104 as expr_104 ,
                expr_443 as expr_443 ,
                expr_185 as expr_185 ,
                (case expr_14 
                    when 69340 then N'1' 
                    when 69337 then N'4' 
                    when 69339 then N'2' 
                    when 69336 then N'5' 
                    when 69338 then N'3' 
                end) as expr_14 ,
                expr_277 as expr_277 ,
                expr_348 as expr_348 ,
                expr_548 as expr_548 ,
                expr_514 as expr_514 ,
                expr_510 as expr_510 ,
                expr_179 as expr_179 ,
                expr_50 as expr_50 ,
                expr_306 as expr_306 ,
                expr_36 as expr_36 ,
                expr_249 as expr_249 ,
                expr_331 as expr_331 ,
                expr_35 as expr_35 ,
                expr_606 as expr_606 ,
                expr_163 as expr_163 ,
                expr_80 as expr_80 ,
                expr_110 as expr_110 ,
                expr_193 as expr_193 ,
                expr_334 as expr_334 ,
                expr_473 as expr_473 ,
                expr_256 as expr_256 ,
                expr_419 as expr_419 ,
                expr_147 as expr_147 ,
                expr_608 as expr_608 ,
                expr_117 as expr_117 ,
                expr_254 as expr_254 ,
                expr_591 as expr_591 ,
                (case expr_25 
                    when 69452 then N'1' 
                    when 69453 then N'0' 
                end) as expr_25 ,
                expr_100 as expr_100 ,
                expr_607 as expr_607 ,
                expr_380 as expr_380 ,
                expr_312 as expr_312 ,
                expr_347 as expr_347 ,
                expr_154 as expr_154 ,
                expr_290 as expr_290 ,
                expr_221 as expr_221 ,
                expr_615 as expr_615 ,
                expr_560 as expr_560 ,
                expr_149 as expr_149 ,
                expr_383 as expr_383 ,
                expr_360 as expr_360 ,
                expr_226 as expr_226 ,
                expr_618 as expr_618 ,
                expr_121 as expr_121 ,
                expr_624 as expr_624 ,
                expr_542 as expr_542 ,
                expr_460 as expr_460 ,
                expr_260 as expr_260 ,
                expr_595 as expr_595 ,
                expr_520 as expr_520 ,
                expr_361 as expr_361 ,
                expr_500 as expr_500 ,
                expr_441 as expr_441 ,
                expr_115 as expr_115 ,
                expr_600 as expr_600 ,
                expr_459 as expr_459 ,
                expr_126 as expr_126 ,
                expr_120 as expr_120 ,
                (case expr_12 
                    when 69359 then N'2' 
                    when 69360 then N'1' 
                    when 69358 then N'3' 
                    when 69356 then N'5' 
                    when 69357 then N'4' 
                end) as expr_12 ,
                expr_355 as expr_355 ,
                expr_471 as expr_471 ,
                expr_524 as expr_524 ,
                expr_127 as expr_127 ,
                expr_313 as expr_313 ,
                expr_369 as expr_369 ,
                expr_81 as expr_81 ,
                expr_494 as expr_494 ,
                expr_412 as expr_412 ,
                expr_498 as expr_498 ,
                expr_207 as expr_207 ,
                expr_48 as expr_48 ,
                expr_205 as expr_205 ,
                expr_311 as expr_311 ,
                expr_389 as expr_389 ,
                expr_187 as expr_187 ,
                expr_372 as expr_372 ,
                (case expr_29 
                    when 69440 then N'Somewhat more often' 
                    when 69443 then N'A lot less often' 
                    when 69441 then N'About as often as I do now ' 
                    when 69439 then N'A lot more often' 
                    when 69444 then N'Does not apply' 
                    when 69442 then N'Somewhat less often' 
                end) as expr_29 ,
                expr_211 as expr_211 ,
                expr_589 as expr_589 ,
                (case expr_24 
                    when 69451 then N'Prefer not to Answer' 
                    when 69449 then N'1' 
                    when 69450 then N'0' 
                end) as expr_24 ,
                expr_387 as expr_387 ,
                expr_318 as expr_318 ,
                (case expr_7 
                    when 69468 then N'Breakfast menu' 
                    when 69469 then N'Regular menu' 
                end) as expr_7 ,
                expr_72 as expr_72 ,
                expr_434 as expr_434 ,
                expr_556 as expr_556 ,
                expr_65 as expr_65 ,
                expr_352 as expr_352 ,
                expr_425 as expr_425 ,
                expr_377 as expr_377 ,
                expr_492 as expr_492 ,
                expr_242 as expr_242 ,
                expr_103 as expr_103 ,
                expr_233 as expr_233 ,
                expr_4 as expr_4 ,
                expr_178 as expr_178 ,
                expr_486 as expr_486 ,
                expr_240 as expr_240 ,
                expr_351 as expr_351 ,
                expr_335 as expr_335 ,
                expr_553 as expr_553 ,
                expr_546 as expr_546 ,
                expr_264 as expr_264 ,
                expr_164 as expr_164 ,
                expr_259 as expr_259 ,
                expr_251 as expr_251 ,
                expr_566 as expr_566 ,
                (case expr_19 
                    when 69371 then N'5' 
                    when 69372 then N'4' 
                    when 69374 then N'2' 
                    when 69375 then N'1' 
                    when 69373 then N'3' 
                end) as expr_19 ,
                expr_274 as expr_274 ,
                expr_269 as expr_269 ,
                expr_574 as expr_574 ,
                expr_484 as expr_484 ,
                expr_479 as expr_479 ,
                expr_586 as expr_586 ,
                expr_378 as expr_378 ,
                expr_420 as expr_420 ,
                expr_367 as expr_367 ,
                expr_413 as expr_413 ,
                expr_54 as expr_54 ,
                expr_145 as expr_145 ,
                (case expr_26 
                    when 69417 then N'Harvey’s' 
                    when 69929 then N'Other' 
                    when 69420 then N'A&W' 
                    when 69421 then N'KFC' 
                    when 69423 then N'Quiznos' 
                    when 69426 then N'This McDonald''s' 
                    when 69416 then N'Tim Hortons ' 
                    when 69418 then N'Burger King' 
                    when 69419 then N'Wendy''s' 
                    when 69422 then N'Subway' 
                    when 69425 then N'Mr. Sub' 
                    when 69415 then N'Another McDonald’s' 
                    when 69424 then N'Dairy Queen' 
                end) as expr_26 ,
                expr_91 as expr_91 ,
                expr_426 as expr_426 ,
                expr_325 as expr_325 ,
                expr_51 as expr_51 ,
                expr_400 as expr_400 ,
                expr_587 as expr_587 ,
                expr_162 as expr_162 ,
                expr_386 as expr_386 ,
                expr_338 as expr_338 ,
                expr_340 as expr_340 ,
                expr_428 as expr_428 ,
                (case expr_21 
                    when 69931 then N'Other' 
                    when 69486 then N'Getting in and out quickly' 
                    when 69488 then N'The food and/or drink' 
                    when 69930 then N'Amenities of the restaurant' 
                    when 69489 then N'Getting your order right' 
                    when 69490 then N'A clean restaurant' 
                    when 69487 then N'The crew and manager' 
                end) as expr_21 ,
                (case expr_17 
                    when 69384 then N'0' 
                    when 69383 then N'1' 
                end) as expr_17 ,
                expr_596 as expr_596 ,
                expr_47 as expr_47 ,
                expr_241 as expr_241,
				cat997.locationCategoryName as playplace,
				cat995.locationCategoryName as dining,
				cat996.locationCategoryName as restrooms,
				cat998.locationCategoryName as drivethru, 
				cat1032.locationCategoryName as McOpCoFranchise, 
				cat1014.locationCategoryName as Operator, 
				cat1008.locationCategoryName as OpsConsultant, 
				cat1013.locationCategoryName as McOpCoAreaSUpervisor,
				cat1007.locationCategoryName as FieldServiceManager,
				cat1012.locationCategoryName as McOpCoOpsManager,
				cat1006.locationCategoryName as DirectorOfOperations,
				cat1011.locationCategoryName as McOpCoDirectorOfOperations,
				cat1005.locationCategoryName as RegionalQSCVP,
				cat1010.locationCategoryName as McOpCoQSCVP,
--				cat887.locationCategoryName as RegionFranchise,
				cat886.locationCategoryName as Division,
				cat1002.locationCategoryName as RegionAll,
                (case expr_670 
                    when 69331 then N'5' 
                    when 69332 then N'4' 
                    when 69333 then N'3' 
                    when 69334 then N'2' 
                    when 69335 then N'1' 
                end) as expr_670, 
                (case expr_671 
                     when 70774 then N' Latte'
					 when 70775 then N' Mocha'
					 when 70776 then N' Cappuccino'
					 when 70777 then N' Espresso'
					 when 70778 then N' Iced Latte'
					 when 70779 then N' Iced Mocha'
					 when 70865 then N' Hot Chocolate'
                end) as expr_671,
                (case expr_672 
                      when 70573 then N' 5'
					 when 70574 then N' 4'
					 when 70575 then N' 3'
					 when 70576 then N' 2'
					 when 70577 then N' 1'
                end) as expr_672,
                (case expr_673 
					 when 70578 then N' 1'
					 when 70579 then N' 2'
					 when 70580 then N' 3'
					 when 70581 then N' 4'
					 when 70582 then N' 5'
                end) as expr_673, 
                (case expr_674 
					 when 70611 then N' 5'
					 when 70612 then N' 4'
					 when 70613 then N' 3'
					 when 70614 then N' 2'
					 when 70615 then N' 1'
                end) as expr_674, 
                (case expr_675 
					 when 70606 then N' 5'
					 when 70607 then N' 4'
					 when 70608 then N' 3'
					 when 70609 then N' 2'
					 when 70610 then N' 1'
                end) as expr_675,
                (case expr_676
					 when 70616 then N' Come anyway and order something else'
					 when 70617 then N' Go to another restaurant/café'
					 when 70618 then N' Not order/skip meal'
					 when 70619 then N' Don’t know'
                end) as expr_676,
                (case expr_677
					 when 70620 then N' 5'
					 when 70621 then N' 4'
					 when 70622 then N' 3'
					 when 70623 then N' 2'
					 when 70624 then N' 1'
                end) as expr_677,
                (case expr_678
					 when 70625 then N' 5'
					 when 70626 then N' 4'
					 when 70627 then N' 3'
					 when 70628 then N' 2'
					 when 70629 then N' 1'
                end) as expr_678,
                (case expr_679
					 when 70630 then N' Tim Hortons'
					 when 70631 then N' Starbucks'
					 when 70632 then N' Second Cup'
					 when 70633 then N' Wendy’s'
					 when 70634 then N' Other'
                end) as expr_679,
                (case expr_680
					 when 70635 then N' 5'
					 when 70636 then N' 4'
					 when 70637 then N' 3'
					 when 70638 then N' 2'
					 when 70639 then N' 1'
                end) as expr_680,
                (case expr_681
					 when 70640 then N' More than once a week'
					 when 70641 then N' Once a week'
					 when 70642 then N' Once every 2-3 weeks'
					 when 70643 then N' Once a month'
					 when 70644 then N' Less than once a month'
					 when 70645 then N' Never'
                end) as expr_681 ,
                (case expr_682
					 when 70646 then N' A lot more often'
					 when 70647 then N' Somewhat more often'
					 when 70648 then N' About as often as you do now'
					 when 70649 then N' Somewhat less often'
					 when 70650 then N' A lot less often'
					 when 70651 then N' Does not apply'
                end) as expr_682,
                (case expr_683
					 when 70652 then N' Every day'
					 when 70653 then N' A few times a week'
					 when 70654 then N' About once a week'
					 when 70655 then N' About 2-3 times a week'
					 when 70656 then N' Not very often'
					 when 70657 then N' Never'
                end) as expr_683  ,
                (case expr_684
					 when 70658 then N' McDonald’s'
					 when 70659 then N' Tim Hortons'
					 when 70660 then N' Starbucks'
					 when 70661 then N' Second Cup'
					 when 70662 then N' Wendy’s'
					 when 70663 then N' Other'
                end) as expr_684,
                (case expr_685
					 when 70664 then N' 5'
					 when 70665 then N' 4'
					 when 70666 then N' 3'
					 when 70667 then N' 2'
					 when 70668 then N' 1'
                end) as expr_685,
				expr_686 as expr_686,
                (case expr_687
					 when 69310 then N' Under 15 years old'
					 when 69311 then N' 15 to 17'
					 when 69312 then N' 18 to 24'
					 when 69313 then N' 25 to 34'
					 when 69314 then N' 35 to 44'
					 when 69315 then N' 45 to 54 '
					 when 69316 then N' 55 and Older'
                end) as expr_687,
				expr_688 as expr_688,
                (case expr_689
                    when 69382 then N'0' 
                    when 69381 then N'1'
				end) as expr_689,
	                (case expr_690
                    when 69384 then N'0' 
                    when 69383 then N'1'
				end) as expr_690,
				expr_27226 as expr_27226,
				expr_27227 as expr_27227,
				expr_27228 as expr_27228,
				expr_27229 as expr_27229,
				expr_27230 as expr_27230,
				expr_27231 as expr_27231,
				expr_27232 as expr_27232,
				expr_27233 as expr_27233,
				expr_27234 as expr_27234,
				expr_27235 as expr_27235,
				expr_27236 as expr_27236,
				expr_27237 as expr_27237,
				expr_27238 as expr_27238,
				expr_27239 as expr_27239,
				expr_27240 as expr_27240,
				expr_27241 as expr_27241,
				expr_27242 as expr_27242,
				expr_27243 as expr_27243,
				expr_27244 as expr_27244,
				expr_27245 as expr_27245,
				expr_27246 as expr_27246,
				expr_27247 as expr_27247,
				expr_27248 as expr_27248,
				expr_27249 as expr_27249,
				expr_27250 as expr_27250,
				expr_27251 as expr_27251,
				expr_27252 as expr_27252,
				expr_27253 as expr_27253,
				expr_27254 as expr_27254,
				expr_27255 as expr_27255,
				expr_27256 as expr_27256,
				expr_27257 as expr_27257,
				expr_27258 as expr_27258,
				expr_27259 as expr_27259,
				expr_27260 as expr_27260,
				expr_27261 as expr_27261,
				expr_27262 as expr_27262,
				expr_27263 as expr_27263,
				expr_27264 as expr_27264,
				expr_27265 as expr_27265,
				expr_27266 as expr_27266,
				expr_27267 as expr_27267,
				expr_27268 as expr_27268,
				expr_27269 as expr_27269,
				expr_27270 as expr_27270,
				expr_27271 as expr_27271,
				expr_27272 as expr_27272,
				expr_27273 as expr_27273,
				expr_27274 as expr_27274,
				expr_27275 as expr_27275,
				expr_27276 as expr_27276,
				expr_27277 as expr_27277,
				expr_27278 as expr_27278,
				expr_27279 as expr_27279,
				expr_27280 as expr_27280,
				expr_27281 as expr_27281,
				expr_27282 as expr_27282,
				expr_27283 as expr_27283,
				expr_27284 as expr_27284,
				expr_27285 as expr_27285,
				expr_27286 as expr_27286,
				expr_27287 as expr_27287,
				expr_27288 as expr_27288,
				expr_27289 as expr_27289,
				expr_27290 as expr_27290,
				expr_27291 as expr_27291,
				expr_27292 as expr_27292,
				expr_27293 as expr_27293,
				expr_27294 as expr_27294,
				expr_27295 as expr_27295,
				expr_27296 as expr_27296,
				expr_27297 as expr_27297,
				expr_27298 as expr_27298,
				expr_27299 as expr_27299,
				expr_27300 as expr_27300,
				expr_27301 as expr_27301,
				expr_27302 as expr_27302,
				expr_27303 as expr_27303,
				expr_27304 as expr_27304,
				expr_27305 as expr_27305,
				expr_27306 as expr_27306,
				expr_27307 as expr_27307,
				expr_27308 as expr_27308,
				expr_27309 as expr_27309,
				expr_27310 as expr_27310,
				expr_27311 as expr_27311,
				expr_27312 as expr_27312,
				expr_27313 as expr_27313,
				expr_27314 as expr_27314,
				expr_27315 as expr_27315,
				expr_27316 as expr_27316,
				expr_27317 as expr_27317,
				expr_27318 as expr_27318,
				expr_27319 as expr_27319,
				expr_27320 as expr_27320,
				expr_27321 as expr_27321,
				expr_27322 as expr_27322,
				expr_27323 as expr_27323,
				expr_27324 as expr_27324,
				expr_27325 as expr_27325,
				expr_27326 as expr_27326,
				expr_27327 as expr_27327,
				expr_27328 as expr_27328,
				expr_27329 as expr_27329,
				expr_27330 as expr_27330,
				expr_27331 as expr_27331,
				expr_27332 as expr_27332,
				expr_27333 as expr_27333,
				expr_27334 as expr_27334,
				expr_27335 as expr_27335,
				expr_27336 as expr_27336,
				expr_27337 as expr_27337,
				expr_27338 as expr_27338,
				expr_27339 as expr_27339,
				expr_27340 as expr_27340,
				expr_27341 as expr_27341,
				expr_27342 as expr_27342,
				expr_27343 as expr_27343,
				expr_27344 as expr_27344,
				expr_27345 as expr_27345,
				expr_27346 as expr_27346,
				expr_27347 as expr_27347,
				expr_27348 as expr_27348,
				expr_27349 as expr_27349,
				expr_27350 as expr_27350,
				expr_27351 as expr_27351,
				expr_27352 as expr_27352,
				expr_27353 as expr_27353,
				expr_27354 as expr_27354,
				expr_27355 as expr_27355,
				expr_27356 as expr_27356,
				expr_27357 as expr_27357,
				expr_27358 as expr_27358,
				expr_27359 as expr_27359,
				expr_27360 as expr_27360,
				expr_27361 as expr_27361,
				expr_27362 as expr_27362,
				expr_27363 as expr_27363,
				expr_27364 as expr_27364,
				expr_27365 as expr_27365,
				expr_27366 as expr_27366,
				expr_27367 as expr_27367,
				expr_27368 as expr_27368,
				expr_27369 as expr_27369,
				expr_27370 as expr_27370,
				expr_27371 as expr_27371,
				expr_27372 as expr_27372,
				expr_27373 as expr_27373,
				expr_27374 as expr_27374,
				expr_27375 as expr_27375,
				expr_27376 as expr_27376,
				expr_27377 as expr_27377,
				expr_27378 as expr_27378,
				expr_27379 as expr_27379,
				expr_27380 as expr_27380,
				expr_27381 as expr_27381,
				expr_27382 as expr_27382,
				expr_27383 as expr_27383,
				expr_27384 as expr_27384,
				expr_27385 as expr_27385,
				expr_27386 as expr_27386,
				expr_27387 as expr_27387,
				expr_27388 as expr_27388,
				expr_27389 as expr_27389,
				expr_27390 as expr_27390,
				expr_27391 as expr_27391,
				expr_27392 as expr_27392,
				expr_27393 as expr_27393,
				expr_27394 as expr_27394,
				expr_27395 as expr_27395,
				expr_27396 as expr_27396,
				expr_27397 as expr_27397,
				expr_27398 as expr_27398,
				expr_27399 as expr_27399,
				expr_27400 as expr_27400,
				expr_27401 as expr_27401,
				expr_27402 as expr_27402,
				expr_27403 as expr_27403,
				expr_27404 as expr_27404,
				expr_27405 as expr_27405,
				expr_27406 as expr_27406,
				expr_27407 as expr_27407,
				expr_27408 as expr_27408,
				expr_27409 as expr_27409,
				expr_27410 as expr_27410,
				expr_27411 as expr_27411,
				expr_27412 as expr_27412,
				expr_27413 as expr_27413,
				expr_27414 as expr_27414,
				expr_27415 as expr_27415,
				expr_27416 as expr_27416,
				expr_27417 as expr_27417,
				expr_27418 as expr_27418,
				expr_27419 as expr_27419,
				expr_27420 as expr_27420,
				expr_27421 as expr_27421,
				expr_27422 as expr_27422,
				expr_27423 as expr_27423,
				expr_27424 as expr_27424,
				expr_27425 as expr_27425,
				expr_27426 as expr_27426,
				expr_27427 as expr_27427,
				expr_27428 as expr_27428,
				expr_27429 as expr_27429,
				expr_27430 as expr_27430,
				expr_27431 as expr_27431,
				expr_27432 as expr_27432,
				expr_27433 as expr_27433,
				expr_27434 as expr_27434,
				expr_27435 as expr_27435,
				expr_27436 as expr_27436,
				expr_27437 as expr_27437,
				expr_27438 as expr_27438,
				expr_27439 as expr_27439,
				expr_27440 as expr_27440,
				expr_27441 as expr_27441,
				expr_27442 as expr_27442,
				expr_27443 as expr_27443,
				expr_27444 as expr_27444,
				expr_27445 as expr_27445,
				expr_27446 as expr_27446,
				expr_27447 as expr_27447,
				expr_27448 as expr_27448,
				expr_27449 as expr_27449,
				expr_27450 as expr_27450,
				expr_27451 as expr_27451,
				expr_27452 as expr_27452,
				expr_27453 as expr_27453,
				expr_27454 as expr_27454,
				expr_27455 as expr_27455,
				expr_27456 as expr_27456,
				expr_27457 as expr_27457,
				expr_27458 as expr_27458,
				expr_27459 as expr_27459,
				expr_27460 as expr_27460,
				expr_27461 as expr_27461,
				expr_27462 as expr_27462,
				expr_27463 as expr_27463,
				expr_27464 as expr_27464,
				expr_27465 as expr_27465,
				expr_27466 as expr_27466,
				expr_27467 as expr_27467,
				expr_27468 as expr_27468,
				expr_27469 as expr_27469,
				expr_27470 as expr_27470,
				expr_27471 as expr_27471,
				expr_27472 as expr_27472,
				expr_27473 as expr_27473,
				expr_27474 as expr_27474,
				expr_27475 as expr_27475,
				expr_27476 as expr_27476,
				expr_27477 as expr_27477,
				expr_27478 as expr_27478,
				expr_27479 as expr_27479,
				expr_27480 as expr_27480,
				expr_27481 as expr_27481,
				expr_27482 as expr_27482,
				expr_27483 as expr_27483,
				expr_27484 as expr_27484,
				expr_27485 as expr_27485,
				expr_27486 as expr_27486,
				expr_27487 as expr_27487,
				expr_27488 as expr_27488,
				expr_27489 as expr_27489,
				expr_27490 as expr_27490,
				expr_27491 as expr_27491,
				expr_27492 as expr_27492,
				expr_27493 as expr_27493,
				expr_27494 as expr_27494,
				expr_27495 as expr_27495,
				expr_27496 as expr_27496,
				expr_27497 as expr_27497,
				expr_27498 as expr_27498,
				expr_27499 as expr_27499,
				expr_27500 as expr_27500,
				expr_27501 as expr_27501,
				expr_27502 as expr_27502,
				expr_27503 as expr_27503,
				expr_27504 as expr_27504,
				expr_27505 as expr_27505,
				expr_27506 as expr_27506,
				expr_27507 as expr_27507,
				expr_27508 as expr_27508,
				expr_27509 as expr_27509,
				expr_27510 as expr_27510,
				expr_27511 as expr_27511,
				expr_27512 as expr_27512,
				expr_27513 as expr_27513,
				expr_27514 as expr_27514,
				expr_27515 as expr_27515,
				expr_27516 as expr_27516,
				expr_27517 as expr_27517,
				expr_27518 as expr_27518,
				expr_27519 as expr_27519,
				expr_27520 as expr_27520,
				expr_27521 as expr_27521,
				expr_27522 as expr_27522,
				expr_27523 as expr_27523,
				expr_27524 as expr_27524,
				expr_27525 as expr_27525,
				expr_27526 as expr_27526,
				expr_27527 as expr_27527,
				expr_27528 as expr_27528,
				expr_27529 as expr_27529,
				expr_27530 as expr_27530,
				expr_27531 as expr_27531,
				expr_27532 as expr_27532,
				expr_27533 as expr_27533,
				expr_27534 as expr_27534,
				expr_27535 as expr_27535,
				expr_27536 as expr_27536,
				expr_27537 as expr_27537,
				expr_27538 as expr_27538,
				expr_27539 as expr_27539,
				expr_27540 as expr_27540,
				expr_27541 as expr_27541,
				expr_27542 as expr_27542,
				expr_27543 as expr_27543,
				expr_27544 as expr_27544,
				expr_27545 as expr_27545,
				expr_27546 as expr_27546,
				expr_27547 as expr_27547,
				expr_27548 as expr_27548,
				expr_27549 as expr_27549,
				expr_27550 as expr_27550,
				expr_27551 as expr_27551,
				expr_27552 as expr_27552,
				expr_27553 as expr_27553,
				expr_27554 as expr_27554,
				expr_27555 as expr_27555,
				expr_27556 as expr_27556,
				expr_27557 as expr_27557,
				expr_27558 as expr_27558,
				expr_27559 as expr_27559,
				expr_27560 as expr_27560,
				expr_27561 as expr_27561,
				expr_27562 as expr_27562,
				expr_27563 as expr_27563,
				expr_27564 as expr_27564,
				expr_27565 as expr_27565,
				expr_27566 as expr_27566,
				expr_27567 as expr_27567,
				expr_27568 as expr_27568,
				expr_27569 as expr_27569,
				expr_27570 as expr_27570,
				expr_27571 as expr_27571,
				expr_27572 as expr_27572,
				expr_27573 as expr_27573,
				expr_27574 as expr_27574,
				expr_27575 as expr_27575,
				expr_27576 as expr_27576,
				expr_27577 as expr_27577,
				expr_27578 as expr_27578,
				expr_27579 as expr_27579,
				expr_27580 as expr_27580,
				expr_27581 as expr_27581,
				expr_27582 as expr_27582,
				expr_27583 as expr_27583,
				expr_27584 as expr_27584,
				expr_27585 as expr_27585,
				expr_27586 as expr_27586,
				expr_27587 as expr_27587,
				expr_27588 as expr_27588,
				expr_27589 as expr_27589,
				expr_27590 as expr_27590,
				expr_27591 as expr_27591,
				expr_27592 as expr_27592,
				expr_27593 as expr_27593,
				expr_27594 as expr_27594,
				expr_27595 as expr_27595,
				expr_27596 as expr_27596,
				expr_27597 as expr_27597,
				expr_27598 as expr_27598,
				expr_27599 as expr_27599,
				expr_27600 as expr_27600,
				expr_27601 as expr_27601,
				expr_27602 as expr_27602,
				expr_27603 as expr_27603,
				expr_27604 as expr_27604,
				expr_27605 as expr_27605,
				expr_27606 as expr_27606,
				expr_27607 as expr_27607,
				expr_27608 as expr_27608,
				expr_27609 as expr_27609,
				expr_27610 as expr_27610,
				expr_27611 as expr_27611,
				expr_27612 as expr_27612,
				expr_27613 as expr_27613,
				expr_27614 as expr_27614,
				expr_27615 as expr_27615,
				expr_27616 as expr_27616,
				expr_27617 as expr_27617,
				expr_27618 as expr_27618,
				expr_27619 as expr_27619,
				expr_27620 as expr_27620,
				expr_27621 as expr_27621,
				expr_27622 as expr_27622,
				expr_27623 as expr_27623,
				expr_27624 as expr_27624,
				expr_27625 as expr_27625,
				expr_27626 as expr_27626,
				expr_27627 as expr_27627,
				expr_27628 as expr_27628,
				expr_27629 as expr_27629,
				expr_27630 as expr_27630,
				expr_27631 as expr_27631,
				expr_27632 as expr_27632,
				expr_27633 as expr_27633,
				expr_27634 as expr_27634,
				expr_27635 as expr_27635,
				expr_27636 as expr_27636,
				expr_27637 as expr_27637,
				expr_27638 as expr_27638,
				expr_27639 as expr_27639,
				expr_27640 as expr_27640,
				expr_27641 as expr_27641,
				expr_27642 as expr_27642,
				expr_27643 as expr_27643,
				expr_27644 as expr_27644,
				expr_27645 as expr_27645,
				expr_27646 as expr_27646,
				expr_27647 as expr_27647,
				expr_27648 as expr_27648,
				expr_27649 as expr_27649,
				expr_27650 as expr_27650,
				expr_27651 as expr_27651,
				expr_27652 as expr_27652,
				expr_27653 as expr_27653,
				expr_27654 as expr_27654,
				expr_27655 as expr_27655,
				expr_27656 as expr_27656,
				expr_27657 as expr_27657,
				expr_27658 as expr_27658,
				expr_27659 as expr_27659,
				expr_27660 as expr_27660,
				expr_27661 as expr_27661,
				expr_27662 as expr_27662,
				expr_27663 as expr_27663,
				expr_27664 as expr_27664,
				expr_27665 as expr_27665,
				expr_27666 as expr_27666,
				expr_27667 as expr_27667,
				expr_27668 as expr_27668,
				expr_27669 as expr_27669,
				expr_27670 as expr_27670,
				expr_27671 as expr_27671,
				expr_27672 as expr_27672,
				expr_27673 as expr_27673,
				expr_27674 as expr_27674,
				expr_27675 as expr_27675,
				expr_27676 as expr_27676,
				expr_27677 as expr_27677,
				expr_27678 as expr_27678,
				expr_27679 as expr_27679,
				expr_27680 as expr_27680,
				expr_27681 as expr_27681,
				expr_27682 as expr_27682,
				expr_27683 as expr_27683,
				expr_27684 as expr_27684,
				expr_27685 as expr_27685,
				expr_27686 as expr_27686,
				expr_27687 as expr_27687,
				expr_27688 as expr_27688,
				expr_27689 as expr_27689,
				expr_27690 as expr_27690,
				expr_27691 as expr_27691,
				expr_27692 as expr_27692,
				expr_27693 as expr_27693,
				expr_27694 as expr_27694,
				expr_27695 as expr_27695,
				expr_27696 as expr_27696,
				expr_27697 as expr_27697,
				expr_27698 as expr_27698,
				expr_27699 as expr_27699,
				expr_27700 as expr_27700,
				expr_27701 as expr_27701,
				expr_27702 as expr_27702,
				expr_27703 as expr_27703,
				expr_27704 as expr_27704,
				expr_27705 as expr_27705,
				expr_27706 as expr_27706,
				expr_27707 as expr_27707,
				expr_27708 as expr_27708,
				expr_27709 as expr_27709,
				expr_27710 as expr_27710,
				expr_27711 as expr_27711,
				expr_27712 as expr_27712,
				expr_27713 as expr_27713,
				expr_27714 as expr_27714,
				expr_27715 as expr_27715,
				expr_27716 as expr_27716,
				expr_27717 as expr_27717,
				expr_27718 as expr_27718,
				expr_27719 as expr_27719,
				expr_27720 as expr_27720,
				expr_27721 as expr_27721,
				expr_27722 as expr_27722,
				expr_27723 as expr_27723,
				expr_27724 as expr_27724,
				expr_27725 as expr_27725,
				expr_27726 as expr_27726,
				expr_27727 as expr_27727,
				expr_27728 as expr_27728,
				expr_27729 as expr_27729,
				expr_27730 as expr_27730,
				expr_27731 as expr_27731,
				expr_27732 as expr_27732,
				expr_27733 as expr_27733,
				expr_27734 as expr_27734,
				expr_27735 as expr_27735,
				expr_27736 as expr_27736,
				expr_27737 as expr_27737,
				expr_27738 as expr_27738,
				expr_27739 as expr_27739,
				expr_27740 as expr_27740,
				expr_27741 as expr_27741,
				expr_27742 as expr_27742,
				expr_27743 as expr_27743,
				expr_27744 as expr_27744,
				expr_27745 as expr_27745,
				expr_27746 as expr_27746,
				expr_27747 as expr_27747,
				expr_27748 as expr_27748,
				expr_27749 as expr_27749,
				expr_27750 as expr_27750,
				expr_27751 as expr_27751,
				expr_27752 as expr_27752,
				expr_27753 as expr_27753,
				expr_27754 as expr_27754,
				expr_27755 as expr_27755,
				expr_27756 as expr_27756,
				expr_27757 as expr_27757,
				expr_27758 as expr_27758,
				expr_27759 as expr_27759,
				expr_27760 as expr_27760,
				expr_27761 as expr_27761,
				expr_27762 as expr_27762,
				expr_27763 as expr_27763,
				expr_27764 as expr_27764,
				expr_27765 as expr_27765,
				expr_27766 as expr_27766,
				expr_27767 as expr_27767,
				expr_27768 as expr_27768,
				expr_27769 as expr_27769,
				expr_27770 as expr_27770,
				expr_27771 as expr_27771,
				expr_27772 as expr_27772,
				expr_27773 as expr_27773,
				expr_27774 as expr_27774,
				expr_27775 as expr_27775,
				expr_27776 as expr_27776,
				expr_27777 as expr_27777,
				expr_27778 as expr_27778,
				expr_27779 as expr_27779,
				expr_27780 as expr_27780,
				expr_27781 as expr_27781,
				expr_27782 as expr_27782,
				expr_27783 as expr_27783,
				expr_27784 as expr_27784,
				expr_27785 as expr_27785,
				expr_27786 as expr_27786,
				expr_27787 as expr_27787,
				expr_27788 as expr_27788,
				expr_27789 as expr_27789,
				expr_27790 as expr_27790,
				expr_27791 as expr_27791,
				expr_27792 as expr_27792,
				expr_27793 as expr_27793,
				expr_27794 as expr_27794,
				expr_27795 as expr_27795,
				expr_27796 as expr_27796,
				expr_27797 as expr_27797,
				expr_27798 as expr_27798,
				expr_27799 as expr_27799,
				expr_27800 as expr_27800,
				expr_27801 as expr_27801,
				expr_27802 as expr_27802,
				expr_27803 as expr_27803,
				expr_27804 as expr_27804,
				expr_27805 as expr_27805,
				expr_27806 as expr_27806,
				expr_27807 as expr_27807,
				expr_27808 as expr_27808,
				expr_27809 as expr_27809,
				expr_27810 as expr_27810,
				expr_27811 as expr_27811,
				expr_27812 as expr_27812,
				expr_27813 as expr_27813,
				expr_27814 as expr_27814,
				expr_27815 as expr_27815,
				expr_27816 as expr_27816,
				expr_27817 as expr_27817,
				expr_27818 as expr_27818,
				expr_27819 as expr_27819,
				expr_27820 as expr_27820,
				expr_27821 as expr_27821,
				expr_27822 as expr_27822,
				expr_27823 as expr_27823,
				expr_27824 as expr_27824,
				expr_27825 as expr_27825,
				expr_27826 as expr_27826,
				expr_27827 as expr_27827,
				expr_27828 as expr_27828,
				expr_27829 as expr_27829,
				expr_27830 as expr_27830,
				expr_27831 as expr_27831,
				expr_27832 as expr_27832,
				expr_27833 as expr_27833,
				expr_27834 as expr_27834,
				expr_27835 as expr_27835,
				expr_27836 as expr_27836,
				expr_27837 as expr_27837,
				expr_27838 as expr_27838,
				expr_27839 as expr_27839,
				expr_27840 as expr_27840,
				expr_27841 as expr_27841,
				expr_27842 as expr_27842,
				expr_27843 as expr_27843,
				expr_27876 as expr_27876,
				expr_27877 as expr_27877,
				expr_27888 as expr_27888,
				expr_27928 as expr_27928,
				expr_27929 as expr_27929,
				expr_27930 as expr_27930,
				expr_27931 as expr_27931,
				expr_27932 as expr_27932,
				expr_27933 as expr_27933,
				expr_27934 as expr_27934,
				expr_27935 as expr_27935,
				expr_27936 as expr_27936,
				expr_27937 as expr_27937,
				expr_27938 as expr_27938,
				expr_27939 as expr_27939,
				expr_27940 as expr_27940,
				expr_27941 as expr_27941,
				expr_27942 as expr_27942,
				expr_27943 as expr_27943,
				expr_27944 as expr_27944,
				expr_27945 as expr_27945,
				expr_27946 as expr_27946,
				expr_27947 as expr_27947,
				expr_27948 as expr_27948,
				expr_27951 as expr_27951,
				expr_27952 as expr_27952,
				expr_27953 as expr_27953,
				expr_27954 as expr_27954,
				expr_27955 as expr_27955,
				expr_27956 as expr_27956,
				expr_27957 as expr_27957,
				expr_27958 as expr_27958,
				expr_27959 as expr_27959,
				expr_27960 as expr_27960,
				expr_27961 as expr_27961,
				expr_27962 as expr_27962,
--				expr_27988 as expr_27988,
				expr_27989 as expr_27989,
				expr_27990 as expr_27990,
				expr_27992 as expr_27992,
				expr_27993 as expr_27993,
				expr_27994 as expr_27994,
				expr_27995 as expr_27995,
				expr_27996 as expr_27996,
				expr_27997 as expr_27997,
                (case expr_26569 
					when 69861 then N'Alabama - AL'
					when 69862 then N'Alaska - AK'
					when 69863 then N'Arizona - AZ'
					when 69864 then N'Arkansas - AR'
					when 69865 then N'California - CA'
					when 69866 then N'Colorado - CO'
					when 69867 then N'Conneticut - CT'
					when 69868 then N'Delaware - DE'
					when 69869 then N'District of Columbia - DC'
					when 69870 then N'Florida - FL'
					when 69871 then N'Georgia - GA'
					when 69872 then N'Hawaii - HI'
					when 69873 then N'Idaho - ID'
					when 69874 then N'Illinois - IL'
					when 69875 then N'Indiana - IN'
					when 69876 then N'Iowa - IA'
					when 69877 then N'Kansas - KS'
					when 69878 then N'Kentucky - KY'
					when 69879 then N'Louisiana - LA'
					when 69880 then N'Maine - ME'
					when 69881 then N'Maryland - MD'
					when 69882 then N'Massachusetts - MA'
					when 69883 then N'Michigan - MI'
					when 69884 then N'Minnesota - MN'
					when 69885 then N'Mississippi - MS'
					when 69886 then N'Missouri - MO'
					when 69887 then N'Montana - MT'
					when 69888 then N'Nebraska - NE'
					when 69889 then N'Nevada - NV'
					when 69890 then N'New Hampshire - NH'
					when 69891 then N'New Jersey - NJ'
					when 69892 then N'New Mexico - NM'
					when 69893 then N'New York - NY'
					when 69894 then N'North Carolina - NC'
					when 69895 then N'North Dakota - ND'
					when 69896 then N'Ohio - OH'
					when 69897 then N'Oklahoma - OK'
					when 69898 then N'Oregon - OR'
					when 69899 then N'Pennsylvania - PA'
					when 69900 then N'Puerto Rico - PR'
					when 69901 then N'Rhode Island - RI'
					when 69902 then N'South Carolina - SC'
					when 69903 then N'South Dakota - SD'
					when 69904 then N'Tennesee - TN'
					when 69905 then N'Texas - TX'
					when 69906 then N'Utah - UT'
					when 69907 then N'Vermont - VT'
					when 69908 then N'Virginia - VA'
					when 69909 then N'Washington - WA'
					when 69910 then N'West Virginia - WV'
					when 69911 then N'Wisconsin - WI'
					when 69912 then N'Wyoming - WY'
					when 69913 then N'Alberta - AB'
					when 69914 then N'British Columbia - BC'
					when 69915 then N'Manitoba - MB'
					when 69916 then N'New Brunswick - NB'
					when 69917 then N'Newfoundland/Labrador - NL'
					when 69918 then N'Northwest Territories - NT'
					when 69919 then N'Nova Scotia - NS'
					when 69920 then N'Nunavut - NU'
					when 69921 then N'Ontario - ON'
					when 69922 then N'Prince Edward Island - PE'
					when 69923 then N'Quebec - QC'
					when 69924 then N'Saskatchewan - SK'
					when 69925 then N'Yukon - YT'
                end) as expr_26569,
                (case expr_27988
					when 71831 then N'Quick service '
					when 71840 then N'Cleanliness'
					when 71833 then N'Value for the money '
					when 71826 then N'Menu variety '
					when 71838 then N'Consistency '
					when 71837 then N'Childhood favorite '
					when 71827 then N'Healthy food options '
					when 71829 then N'Freshness of food '
					when 71825 then N'Unique product offering '
					when 71832 then N'Convenient locations '
					when 71839 then N'Company values '
					when 71834 then N'Customization of items/toppings '
					when 71828 then N'Quality of food '
					when 71830 then N'The people who serve me '
					when 71835 then N'My kids love it '
					when 71836 then N'Social gathering place '
                end) as expr_27988,
				cat3478.locationCategoryName as 'RGN-NAM',
				cat3479.locationCategoryName as 'DIST-NAM',
				cat3480.locationCategoryName as 'REST-TYP',
				cat3481.locationCategoryName as 'MKT-NAM',
				cat3482.locationCategoryName as 'MMKT-LDESC',
				cat3483.locationCategoryName as 'TV-MKT-LDESC',
				expr_33113 as expr_33113,
				expr_33114 as expr_33114,
				expr_33115 as expr_33115,
				expr_33116 as expr_33116,
				expr_33117 as expr_33117,
				expr_33118 as expr_33118,
				expr_33119 as expr_33119,
				expr_33120 as expr_33120,
				expr_33121 as expr_33121,
				expr_33122 as expr_33122,
				expr_33125 as expr_33125,
				expr_33126 as expr_33126,
				expr_33127 as expr_33127,
				expr_33128 as expr_33128,
				expr_33129 as expr_33129,
				expr_33130 as expr_33130,
				expr_33131 as expr_33131,
expr_37229 as expr_37229,
expr_37226 as expr_37226,
expr_37230 as expr_37230,
expr_37232 as expr_37232,
expr_37231 as expr_37231,
expr_37233 as expr_37233,
expr_37235 as expr_37235,
expr_37234 as expr_37234,
expr_37236 as expr_37236,
expr_37238 as expr_37238,
expr_37237 as expr_37237,
expr_37239 as expr_37239,
expr_37241 as expr_37241,
expr_37240 as expr_37240,
expr_37242 as expr_37242,
expr_37277 as expr_37277,
expr_37276 as expr_37276,
expr_37278 as expr_37278,
expr_37244 as expr_37244,
expr_37247 as expr_37247,
expr_37250 as expr_37250,
expr_37253 as expr_37253,
expr_37256 as expr_37256,
expr_37259 as expr_37259,
expr_37262 as expr_37262,
expr_37265 as expr_37265,
expr_37268 as expr_37268,
expr_37271 as expr_37271,
expr_37274 as expr_37274,
expr_37243 as expr_37243,
expr_37246 as expr_37246,
expr_37249 as expr_37249,
expr_37252 as expr_37252,
expr_37255 as expr_37255,
expr_37258 as expr_37258,
expr_37261 as expr_37261,
expr_37264 as expr_37264,
expr_37267 as expr_37267,
expr_37270 as expr_37270,
expr_37273 as expr_37273,
expr_37245 as expr_37245,
expr_37248 as expr_37248,
expr_37251 as expr_37251,
expr_37254 as expr_37254,
expr_37257 as expr_37257,
expr_37260 as expr_37260,
expr_37263 as expr_37263,
expr_37266 as expr_37266,
expr_37269 as expr_37269,
expr_37272 as expr_37272,
expr_37275 as expr_37275,
	                (case expr_39540 
                    when 99313 then N'McDonalds' 
                    when 99314 then N'McCafé'
				end) as expr_39540 ,
expr_43647 as expr_43647,
expr_43648 as expr_43648,
expr_43649 as expr_43649,
expr_43805 as expr_43805,
expr_43615 as expr_43615,
expr_43616 as expr_43616,
expr_43617 as expr_43617,
expr_43800 as expr_43800,
expr_43759 as expr_43759,
expr_43760 as expr_43760,
expr_43761 as expr_43761,
expr_43810 as expr_43810,
expr_43968 as expr_43968,
expr_43969 as expr_43969,
expr_43970 as expr_43970,
expr_43971 as expr_43971,
expr_43972 as expr_43972,
expr_43973 as expr_43973,
expr_43974 as expr_43974,
expr_43975 as expr_43975,
expr_43807 as expr_43807,
expr_43808 as expr_43808,
expr_43809 as expr_43809,
expr_43651 as expr_43651,
expr_43652 as expr_43652,
expr_43653 as expr_43653,
expr_43656 as expr_43656,
expr_43657 as expr_43657,
expr_43658 as expr_43658,
expr_43660 as expr_43660,
expr_43661 as expr_43661,
expr_43662 as expr_43662,
expr_43801 as expr_43801,
expr_43802 as expr_43802,
expr_43803 as expr_43803,
expr_43622 as expr_43622,
expr_43631 as expr_43631,
expr_43632 as expr_43632,
expr_43637 as expr_43637,
expr_43638 as expr_43638,
expr_43639 as expr_43639,
expr_43641 as expr_43641,
expr_43644 as expr_43644,
expr_43645 as expr_43645,
expr_43646 as expr_43646,
expr_43584 as expr_43584,
expr_43585 as expr_43585,
expr_43587 as expr_43587,
expr_43799 as expr_43799,

expr_43618 as expr_43618,
expr_43619 as expr_43619,
expr_43620 as expr_43620,
expr_43621 as expr_43621,
expr_43633 as expr_43633,
expr_43634 as expr_43634,
expr_43635 as expr_43635,
expr_43636 as expr_43636,
expr_43640 as expr_43640,
expr_43642 as expr_43642,
expr_43650 as expr_43650,
expr_43655 as expr_43655,
expr_43659 as expr_43659,

expr_45760 as expr_45760,
expr_45739 as expr_45739,
expr_45740 as expr_45740,
expr_45741 as expr_45741,
expr_45742 as expr_45742,
expr_45743 as expr_45743,
expr_45744 as expr_45744,
expr_45745 as expr_45745,
expr_45746 as expr_45746,
expr_45747 as expr_45747,
expr_45748 as expr_45748,
expr_45749 as expr_45749,
expr_45761 as expr_45761,
expr_45750 as expr_45750,
expr_45751 as expr_45751,
expr_45752 as expr_45752,
expr_45753 as expr_45753,
expr_45754 as expr_45754,
expr_45755 as expr_45755,
expr_45756 as expr_45756,
expr_45757 as expr_45757,
expr_45758 as expr_45758,
expr_45759 as expr_45759,

expr_46408 as expr_46408,
expr_46375 as expr_46375,
expr_46376 as expr_46376,
expr_46377 as expr_46377,
expr_46378 as expr_46378,
expr_46380 as expr_46380,
expr_46389 as expr_46389,
expr_46391 as expr_46391,
expr_46399 as expr_46399,
expr_46400 as expr_46400,
expr_46401 as expr_46401,
expr_46402 as expr_46402,
expr_46403 as expr_46403,
expr_46382 as expr_46382,
expr_46381 as expr_46381,
expr_46383 as expr_46383,
expr_46384 as expr_46384,
expr_46385 as expr_46385,
expr_46386 as expr_46386,
expr_46387 as expr_46387,
expr_46388 as expr_46388,

expr_46793 as expr_46793,
expr_46789 as expr_46789,
expr_46790 as expr_46790,
expr_46791 as expr_46791,
expr_46792 as expr_46792,
expr_46954 as expr_46954,
expr_46794 as expr_46794,
expr_46795 as expr_46795,
expr_46796 as expr_46796,
expr_46797 as expr_46797,
expr_46798 as expr_46798,
expr_46799 as expr_46799,
expr_46800 as expr_46800,
expr_46801 as expr_46801,
expr_46803 as expr_46803,
expr_46804 as expr_46804,
expr_46807 as expr_46807,
expr_46808 as expr_46808,
expr_46811 as expr_46811,
expr_46812 as expr_46812,
expr_46814 as expr_46814,
expr_46817 as expr_46817,
expr_46999 as expr_46999,
expr_47000 as expr_47000,

--added 8/29/11
expr_48874 as expr_48874,
expr_48497 as expr_48497,
expr_48498 as expr_48498,
expr_48499 as expr_48499,
expr_48500 as expr_48500,
expr_48501 as expr_48501,
expr_48502 as expr_48502,
expr_48889 as expr_48889,
expr_48539 as expr_48539,
expr_48540 as expr_48540,
expr_48541 as expr_48541,
expr_48542 as expr_48542,
expr_48543 as expr_48543,
expr_48544 as expr_48544,
expr_48890 as expr_48890,
expr_48588 as expr_48588,
expr_48589 as expr_48589,
expr_48590 as expr_48590,
expr_48591 as expr_48591,
expr_48592 as expr_48592,
expr_48605 as expr_48605,
expr_48607 as expr_48607,
expr_48608 as expr_48608,
expr_48891 as expr_48891,
expr_48561 as expr_48561,
expr_48563 as expr_48563,
expr_48565 as expr_48565,
expr_48566 as expr_48566,
expr_48568 as expr_48568,
expr_48582 as expr_48582,
expr_48583 as expr_48583,
expr_48584 as expr_48584,
expr_48585 as expr_48585,
expr_48586 as expr_48586,
expr_48587 as expr_48587,
expr_48885 as expr_48885,
expr_48518 as expr_48518,
expr_48521 as expr_48521,
expr_48522 as expr_48522,
expr_48523 as expr_48523,
expr_48524 as expr_48524,
expr_48525 as expr_48525,
expr_48526 as expr_48526,
expr_48527 as expr_48527,
expr_48528 as expr_48528,
expr_48875 as expr_48875,
expr_48477 as expr_48477,
expr_48481 as expr_48481,
expr_48482 as expr_48482,
expr_48483 as expr_48483,
expr_48484 as expr_48484,
expr_48485 as expr_48485,
expr_48486 as expr_48486,
expr_48488 as expr_48488,
expr_48503 as expr_48503,
expr_48507 as expr_48507,
expr_48512 as expr_48512,
expr_48489 as expr_48489,
expr_48508 as expr_48508,
expr_48513 as expr_48513,
expr_48504 as expr_48504,
expr_48509 as expr_48509,
expr_48514 as expr_48514,
expr_48505 as expr_48505,
expr_48510 as expr_48510,
expr_48515 as expr_48515,
expr_48506 as expr_48506,
expr_48511 as expr_48511,
expr_48517 as expr_48517,
expr_48661 as expr_48661,
expr_48665 as expr_48665,
expr_48666 as expr_48666,
expr_49827 as expr_49827,
expr_49809 as expr_49809,
expr_49810 as expr_49810,
expr_49811 as expr_49811,
expr_49812 as expr_49812,
expr_49813 as expr_49813,
expr_49821 as expr_49821,
expr_49823 as expr_49823,
expr_49824 as expr_49824,
expr_49825 as expr_49825,
expr_49826 as expr_49826,
expr_49804 as expr_49804,
expr_49783 as expr_49783,
expr_49784 as expr_49784,
expr_49785 as expr_49785,
expr_49786 as expr_49786,
expr_49795 as expr_49795,
expr_49797 as expr_49797,
expr_49798 as expr_49798,
expr_49799 as expr_49799,
expr_49801 as expr_49801,
expr_49802 as expr_49802,
expr_49778 as expr_49778,
expr_49779 as expr_49779,
expr_49780 as expr_49780,
expr_49781 as expr_49781,
expr_49782 as expr_49782,
expr_49975 as expr_49975,
expr_49960 as expr_49960,
expr_49961 as expr_49961,
	                (case expr_49957
                    when 126799 then N'Definitely Will' 
                    when 126800 then N'Probably Will'
                    when 126801 then N'Might or Might Not'
                    when 126802 then N'Probably Will Not'
                    when 126803 then N'Definitely Will Not'
				end) as expr_49957,
				
				expr_51339 as expr_51339,
expr_51340 as expr_51340,
expr_51341 as expr_51341,
expr_51342 as expr_51342,
expr_51344 as expr_51344,
expr_51345 as expr_51345,
expr_51024 as expr_51024,
expr_51025 as expr_51025,
expr_51026 as expr_51026,
expr_51027 as expr_51027,
expr_51028 as expr_51028,
expr_51029 as expr_51029,
expr_51030 as expr_51030,
expr_51031 as expr_51031,
expr_51347 as expr_51347,
expr_51015 as expr_51015,
expr_51016 as expr_51016,
expr_51017 as expr_51017,
expr_51018 as expr_51018,
expr_51019 as expr_51019,
expr_51020 as expr_51020,
expr_51021 as expr_51021,
expr_51022 as expr_51022,
expr_51023 as expr_51023,
expr_51348 as expr_51348,

expr_53503 as expr_53503,
expr_53504 as expr_53504,
expr_53505 as expr_53505,
expr_53506 as expr_53506,
expr_53507 as expr_53507,
expr_53518 as expr_53518,
expr_53519 as expr_53519,
expr_53521 as expr_53521,
expr_53522 as expr_53522,
expr_53523 as expr_53523,
expr_53524 as expr_53524,
expr_53508 as expr_53508,
expr_53509 as expr_53509,
expr_53511 as expr_53511,
expr_53512 as expr_53512,
expr_53513 as expr_53513,
expr_53514 as expr_53514,
expr_53515 as expr_53515,
expr_53516 as expr_53516,
expr_53517 as expr_53517,
expr_53525 as expr_53525,
expr_53526 as expr_53526,
expr_53527 as expr_53527,
expr_53528 as expr_53528,
expr_53532 as expr_53532,

expr_52806 as expr_52806,
expr_52807 as expr_52807,
expr_52808 as expr_52808,
expr_52809 as expr_52809,
expr_52810 as expr_52810,
expr_52811 as expr_52811,
expr_52812 as expr_52812,
expr_52813 as expr_52813,
expr_52814 as expr_52814,
expr_52815 as expr_52815,
expr_52816 as expr_52816,
expr_52817 as expr_52817,
expr_52818 as expr_52818,
expr_52819 as expr_52819,
expr_52820 as expr_52820,
expr_52821 as expr_52821,
expr_52822 as expr_52822,
expr_52823 as expr_52823,
expr_52824 as expr_52824,
expr_52825 as expr_52825,
expr_52834 as expr_52834,

expr_53529 as expr_53529,
expr_53559 as expr_53559,
expr_53546 as expr_53546,
expr_53561 as expr_53561,
expr_53553 as expr_53553,
expr_53563 as expr_53563,
expr_53556 as expr_53556,
expr_53596 as expr_53596,
expr_53530 as expr_53530,
expr_53560 as expr_53560,
expr_53549 as expr_53549,
expr_53562 as expr_53562,
expr_53552 as expr_53552,
expr_53564 as expr_53564,
expr_53557 as expr_53557,
expr_53598 as expr_53598,
expr_53531 as expr_53531,
expr_53558 as expr_53558,
expr_53545 as expr_53545,
expr_53550 as expr_53550,
expr_53555 as expr_53555,
expr_53597 as expr_53597,

	                (case expr_53593
                    when 137259 then N'To be entered into the sweepstakes' 
                    when 137260 then N'To provide feedback about my recent visit'
                    when 137261 then N'Other'
                    when 139089 then N'To receive a free Make it a Meal coupon'
				end) as expr_53593,
				
		            (case expr_53594
                    when 137262 then N'0'
                    when 137263 then N'1'
				end) as expr_53594,
				
				   (case expr_53595
                    when 137264 then N'Within the past month' 
                    when 137265 then N'Within the past 2-6 months'
                    when 137266 then N'More than 6 months ago'
				end) as expr_53595,
				
				expr_54210 as expr_54210,
expr_54212 as expr_54212,
expr_54213 as expr_54213,
expr_54214 as expr_54214,
expr_54215 as expr_54215,
expr_54216 as expr_54216,
expr_54217 as expr_54217,
expr_54218 as expr_54218,
expr_54219 as expr_54219,
expr_54220 as expr_54220,
expr_54221 as expr_54221,
expr_54222 as expr_54222,
expr_54223 as expr_54223,
expr_54224 as expr_54224,
expr_54225 as expr_54225,
expr_54226 as expr_54226,
expr_54227 as expr_54227,
expr_54228 as expr_54228,
expr_54229 as expr_54229,
expr_54230 as expr_54230,
expr_54231 as expr_54231,
expr_54232 as expr_54232,
expr_54233 as expr_54233,
expr_54234 as expr_54234,
expr_54235 as expr_54235,
expr_54236 as expr_54236,
expr_54237 as expr_54237,
expr_54238 as expr_54238,

--added 030212
expr_55315 as expr_55315,

expr_55110 as expr_55110,
expr_55115 as expr_55115,
expr_55137 as expr_55137,
expr_55140 as expr_55140,
expr_55144 as expr_55144,

expr_55185 as expr_55185,
expr_55166 as expr_55166,
expr_55167 as expr_55167,
expr_55168 as expr_55168,
expr_55176 as expr_55176,
expr_55177 as expr_55177,
expr_55178 as expr_55178,
expr_55179 as expr_55179,
expr_55180 as expr_55180,
expr_56896 as expr_56896,

expr_55153 as expr_55153,
expr_55147 as expr_55147,
expr_55148 as expr_55148,
expr_55149 as expr_55149,
expr_55150 as expr_55150,
expr_55151 as expr_55151,
expr_55152 as expr_55152,

expr_55317 as expr_55317,

expr_55112 as expr_55112,
expr_55136 as expr_55136,
expr_55139 as expr_55139,
expr_55143 as expr_55143,
expr_55146 as expr_55146,

expr_55301 as expr_55301,
expr_55287 as expr_55287,
expr_55288 as expr_55288,
expr_55289 as expr_55289,
expr_55291 as expr_55291,
expr_55292 as expr_55292,
expr_55294 as expr_55294,
expr_55295 as expr_55295,
expr_55296 as expr_55296,
expr_55297 as expr_55297,
expr_55298 as expr_55298,
expr_55299 as expr_55299,
expr_56894 as expr_56894,

expr_55313 as expr_55313,
expr_55304 as expr_55304,
expr_55305 as expr_55305,
expr_55306 as expr_55306,
expr_55307 as expr_55307,
expr_55309 as expr_55309,
expr_55310 as expr_55310,
expr_55311 as expr_55311,
expr_55312 as expr_55312,

expr_55316 as expr_55316,

expr_55111 as expr_55111,
expr_55135 as expr_55135,
expr_55138 as expr_55138,
expr_55142 as expr_55142,
expr_55145 as expr_55145,

expr_55276 as expr_55276,
expr_55202 as expr_55202,
expr_55203 as expr_55203,
expr_55204 as expr_55204,
expr_55205 as expr_55205,
expr_55206 as expr_55206,
expr_55207 as expr_55207,

expr_55286 as expr_55286,
expr_55277 as expr_55277,
expr_55278 as expr_55278,
expr_55279 as expr_55279,
expr_55280 as expr_55280,
expr_55281 as expr_55281,
expr_55282 as expr_55282,
expr_55283 as expr_55283,
expr_55284 as expr_55284,
expr_55285 as expr_55285,
expr_56895 as expr_56895,

--added 040212
--expr_56890 as expr_56890,
--145808	56890	Crispy Chicken
--145809	56890	Grilled Chicken
	                (case expr_56890
                    when 145808 then N'Crispy Chicken' 
                    when 145809 then N'Grilled Chicken'
				end) as expr_56890,

--expr_56887 as expr_56887,
--145802	56887	Crispy Chicken
--145803	56887	Grilled Chicken
	                (case expr_56887
                    when 145802 then N'Crispy Chicken' 
                    when 145803 then N'Grilled Chicken'
				end) as expr_56887,
--expr_56891 as expr_56891,
--145810	56891	Crispy Chicken
--145811	56891	Grilled Chicken
	                (case expr_56891
                    when 145810 then N'Crispy Chicken' 
                    when 145811 then N'Grilled Chicken'
				end) as expr_56891,
--expr_56889 as expr_56889,
--145806	56889	Crispy Chicken
--145807	56889	Grilled Chicken
	                (case expr_56889
                    when 145806 then N'Crispy Chicken' 
                    when 145807 then N'Grilled Chicken'
				end) as expr_56889,

--expr_56888 as expr_56888,
--145804	56888	Crispy Chicken
--145805	56888	Grilled Chicken
	                (case expr_56888
                    when 145804 then N'Crispy Chicken' 
                    when 145805 then N'Grilled Chicken'
				end) as expr_56888,
--expr_56892 as expr_56892,
--145812	56892	Crispy Chicken
--145813	56892	Grilled Chicken
	                (case expr_56892
                    when 145812 then N'Crispy Chicken' 
                    when 145813 then N'Grilled Chicken'
				end) as expr_56892,
--expr_56893 as expr_56893,
--145814	56893	Crispy Chicken
--145815	56893	Grilled Chicken
	                (case expr_56893
                    when 145814 then N'Crispy Chicken' 
                    when 145815 then N'Grilled Chicken'
				end) as expr_56893,

--added 5/2/2012
expr_58138 as expr_58138,
expr_58139 as expr_58139,
expr_58140 as expr_58140,
expr_58141 as expr_58141,
expr_58142 as expr_58142,
expr_58137 as expr_58137,

expr_58217 as expr_58217,
expr_58143 as expr_58143,
expr_58144 as expr_58144,
expr_58145 as expr_58145,
expr_58146 as expr_58146,
expr_58147 as expr_58147,
expr_58206 as expr_58206,
expr_58207 as expr_58207,

expr_58219 as expr_58219,
expr_58210 as expr_58210,
expr_58211 as expr_58211,
expr_58213 as expr_58213,
expr_58214 as expr_58214,
expr_58215 as expr_58215,

expr_58126 as expr_58126,
expr_58926 as expr_58926,
expr_58927 as expr_58927,

--added 060112
expr_58875 as expr_58875,
expr_58876 as expr_58876,
expr_58877 as expr_58877,
expr_58880 as expr_58880,
expr_58881 as expr_58881,
expr_58882 as expr_58882,
expr_58883 as expr_58883,
expr_58884 as expr_58884,

expr_58885 as expr_58885,
expr_58886 as expr_58886,
expr_58887 as expr_58887,
expr_58888 as expr_58888,
expr_58889 as expr_58889,
expr_58890 as expr_58890,
expr_58891 as expr_58891,
expr_58892 as expr_58892,

expr_58893 as expr_58893,
expr_58894 as expr_58894,
expr_58895 as expr_58895,
expr_58896 as expr_58896,
expr_58897 as expr_58897,
expr_58899 as expr_58899,
expr_58900 as expr_58900,

expr_58901 as expr_58901,
expr_59054 as expr_59054,
expr_59055 as expr_59055,
expr_59059 as expr_59059,
expr_59064 as expr_59064,
expr_59065 as expr_59065,
expr_59066 as expr_59066,
expr_59068 as expr_59068,

expr_59281 as expr_59281,
expr_59285 as expr_59285,
expr_59306 as expr_59306,
expr_59307 as expr_59307,
expr_59309 as expr_59309,
expr_59311 as expr_59311,
expr_59312 as expr_59312,
expr_59313 as expr_59313,


expr_58749 as expr_58749,
expr_58750 as expr_58750,
expr_58751 as expr_58751,
expr_58752 as expr_58752,
expr_58753 as expr_58753,
expr_58754 as expr_58754,
expr_58755 as expr_58755,
expr_59323 as expr_59323,

expr_58788 as expr_58788,
expr_58790 as expr_58790,
expr_58792 as expr_58792,
expr_58796 as expr_58796,
expr_58798 as expr_58798,
expr_58799 as expr_58799,
expr_58800 as expr_58800,
expr_59330 as expr_59330,

expr_58841 as expr_58841,
expr_58842 as expr_58842,
expr_58843 as expr_58843,
expr_58844 as expr_58844,
expr_58848 as expr_58848,
expr_58849 as expr_58849,
expr_58850 as expr_58850,
expr_59332 as expr_59332,

expr_58728 as expr_58728,
expr_58729 as expr_58729,
expr_58730 as expr_58730,
expr_58731 as expr_58731,
expr_58732 as expr_58732,
expr_59318 as expr_59318,

expr_58723 as expr_58723,
expr_58724 as expr_58724,
expr_58725 as expr_58725,
expr_58726 as expr_58726,
expr_58727 as expr_58727,
expr_59317 as expr_59317,

expr_58742 as expr_58742,
expr_58743 as expr_58743,
expr_58744 as expr_58744,
expr_58745 as expr_58745,
expr_58746 as expr_58746,
expr_58747 as expr_58747,
expr_58748 as expr_58748,
expr_59322 as expr_59322,

expr_58801 as expr_58801,
expr_58802 as expr_58802,
expr_58803 as expr_58803,
expr_58804 as expr_58804,
expr_58805 as expr_58805,
expr_58806 as expr_58806,
expr_58807 as expr_58807,
expr_59326 as expr_59326,

expr_58852 as expr_58852,
expr_58853 as expr_58853,
expr_58854 as expr_58854,
expr_58856 as expr_58856,
expr_58858 as expr_58858,
expr_58859 as expr_58859,
expr_58861 as expr_58861,
expr_59331 as expr_59331,


expr_58756 as expr_58756,
expr_58758 as expr_58758,
expr_58759 as expr_58759,
expr_58760 as expr_58760,
expr_58761 as expr_58761,
expr_58762 as expr_58762,
expr_59361 as expr_59361,


expr_58773 as expr_58773,
expr_58774 as expr_58774,
expr_58775 as expr_58775,
expr_58776 as expr_58776,
expr_58777 as expr_58777,
expr_58778 as expr_58778,
expr_58779 as expr_58779,
expr_58780 as expr_58780,
expr_59368 as expr_59368,

expr_58817 as expr_58817,
expr_58818 as expr_58818,
expr_58812 as expr_58812,
expr_58820 as expr_58820,
expr_58821 as expr_58821,
expr_58822 as expr_58822,
expr_58823 as expr_58823,
expr_59370 as expr_59370,

expr_58733 as expr_58733,
expr_58734 as expr_58734,
expr_58735 as expr_58735,
expr_59357 as expr_59357,

expr_58720 as expr_58720,
expr_58721 as expr_58721,
expr_58722 as expr_58722,
expr_59343 as expr_59343,

expr_58736 as expr_58736,
expr_58737 as expr_58737,
expr_58738 as expr_58738,
expr_58739 as expr_58739,
expr_58740 as expr_58740,
expr_58741 as expr_58741,
expr_59359 as expr_59359,

expr_58765 as expr_58765,
expr_58766 as expr_58766,
expr_58767 as expr_58767,
expr_58768 as expr_58768,
expr_58769 as expr_58769,
expr_58770 as expr_58770,
expr_58771 as expr_58771,
expr_58772 as expr_58772,
expr_59364 as expr_59364,


expr_58808 as expr_58808,
expr_58809 as expr_58809,
expr_58810 as expr_58810,
expr_58811 as expr_58811,
expr_58813 as expr_58813,
expr_58814 as expr_58814,
expr_58815 as expr_58815,
expr_58816 as expr_58816,
expr_59369 as expr_59369,


expr_58864 as expr_58864,
expr_58865 as expr_58865,
expr_58869 as expr_58869,
expr_58870 as expr_58870,
expr_58871 as expr_58871,
expr_58872 as expr_58872,
expr_58873 as expr_58873,
expr_58874 as expr_58874,

--added 6/8/2012
expr_58898 as expr_58898,
expr_58819 as expr_58819,

expr_58413 as expr_58413,
expr_58416 as expr_58416,
expr_58417 as expr_58417,
expr_58418 as expr_58418,
expr_58420 as expr_58420,
expr_58421 as expr_58421,

expr_58444 as expr_58444,
expr_58436 as expr_58436,
expr_58437 as expr_58437,
expr_58438 as expr_58438,
expr_58439 as expr_58439,
expr_58441 as expr_58441,
expr_58442 as expr_58442,
expr_58443 as expr_58443,

expr_58433 as expr_58433,
expr_58422 as expr_58422,
expr_58424 as expr_58424,
expr_58425 as expr_58425,
expr_58426 as expr_58426,
expr_58427 as expr_58427,
expr_58428 as expr_58428,
expr_58429 as expr_58429,
expr_58430 as expr_58430,
expr_58431 as expr_58431,
--11/02/2012
expr_68895 as expr_68895,
expr_68849 as expr_68849,
expr_68924 as expr_68924,
expr_68618 as expr_68618,
expr_68614 as expr_68614,
expr_68615 as expr_68615,
expr_68616 as expr_68616,
expr_68617 as expr_68617,
expr_68925 as expr_68925,
expr_68926 as expr_68926,
expr_68647 as expr_68647,
expr_68626 as expr_68626,
expr_68629 as expr_68629,
expr_68631 as expr_68631,
expr_68632 as expr_68632,
expr_68635 as expr_68635,
expr_68927 as expr_68927,

--added 6/3/13


--expr_95283 as expr_95283,
--expr_95298 as expr_95298,
--expr_95311 as expr_95311,
/*
select * from organization where name like '%McDonald%'
select * from datafield where objectid =95295

select * from datafield df left join datafieldoption dfo on df.objectid=dfo.datafieldobjectid where df.objectid=94628
*/

expr_94682 as expr_94682,
expr_94938 as expr_94938,
expr_94939 as expr_94939,
expr_94995 as expr_94995,
expr_94930 as expr_94930,
expr_94933 as expr_94933,

expr_94698 as expr_94698,
expr_94940 as expr_94940,
expr_94937 as expr_94937,
expr_94998 as expr_94998,
expr_94931 as expr_94931,
expr_94934 as expr_94934,

expr_94710 as expr_94710,
expr_94941 as expr_94941,
expr_94936 as expr_94936,
expr_94999 as expr_94999,
expr_94932 as expr_94932,
expr_94935 as expr_94935,

--expr_94683 as expr_94683,
	                (case expr_94683
                    when 187751 then N'Crispy Chicken' 
                    when 187752 then N'Grilled Chicken'
				end) as expr_94683,
--expr_94699 as expr_94699,
	                (case expr_94699
                    when 187761 then N'Crispy Chicken' 
                    when 187762 then N'Grilled Chicken'
				end) as expr_94699,

--expr_94712 as expr_94712,
	                (case expr_94712
                    when 187762 then N'Crispy Chicken' 
                    when 187764 then N'Grilled Chicken'
				end) as expr_94712,

expr_94685 as expr_94685,
expr_94688 as expr_94688,
expr_94689 as expr_94689,
expr_94690 as expr_94690,
expr_94691 as expr_94691,
expr_94692 as expr_94692,
expr_94693 as expr_94693,
expr_94694 as expr_94694,
expr_94695 as expr_94695,
expr_94696 as expr_94696,
expr_94697 as expr_94697,
expr_95506 as expr_95506,

expr_94735 as expr_94735,
expr_94736 as expr_94736,
expr_94738 as expr_94738,
expr_94737 as expr_94737,
expr_94739 as expr_94739,
expr_95507 as expr_95507,

expr_94700 as expr_94700,
expr_94701 as expr_94701,
expr_94702 as expr_94702,
expr_94703 as expr_94703,
expr_94704 as expr_94704,
expr_94705 as expr_94705,
expr_94706 as expr_94706,
expr_94707 as expr_94707,
expr_94708 as expr_94708,
expr_94709 as expr_94709,
expr_95508 as expr_95508,

expr_94741 as expr_94741,
expr_94743 as expr_94743,
expr_94745 as expr_94745,
expr_94747 as expr_94747,
expr_94749 as expr_94749,
expr_95509 as expr_95509,

expr_94713 as expr_94713,
expr_94715 as expr_94715,
expr_94716 as expr_94716,
expr_94717 as expr_94717,
expr_94718 as expr_94718,
expr_94719 as expr_94719,
expr_94720 as expr_94720,
expr_94721 as expr_94721,
expr_94722 as expr_94722,
expr_94714 as expr_94714,
expr_95510 as expr_95510,

expr_94742 as expr_94742,
expr_94744 as expr_94744,
expr_94746 as expr_94746,
expr_94748 as expr_94748,
expr_94750 as expr_94750,
expr_95511 as expr_95511,

expr_95519 as expr_95519,
expr_95634 as expr_95634,
expr_95655 as expr_95655,
expr_95638 as expr_95638,
expr_95625 as expr_95625,
expr_95629 as expr_95629,

expr_95520 as expr_95520,
expr_95635 as expr_95635,
expr_95658 as expr_95658,
expr_95642 as expr_95642,
expr_95626 as expr_95626,
expr_95630 as expr_95630,

expr_95521 as expr_95521,
expr_95523 as expr_95523,
expr_95524 as expr_95524,
expr_95525 as expr_95525,
expr_95526 as expr_95526,
expr_95527 as expr_95527,
expr_95528 as expr_95528,
expr_95529 as expr_95529,
expr_95530 as expr_95530,
expr_95545 as expr_95545,
expr_95546 as expr_95546,
expr_95547 as expr_95547,

expr_95548 as expr_95548,
expr_95549 as expr_95549,
expr_95556 as expr_95556,
expr_95558 as expr_95558,
expr_95559 as expr_95559,
expr_95560 as expr_95560,
expr_95562 as expr_95562,

expr_95561 as expr_95561,
expr_95563 as expr_95563,
expr_95564 as expr_95564,

expr_95585 as expr_95585,
expr_95586 as expr_95586,
expr_95587 as expr_95587,
expr_95588 as expr_95588,
expr_95589 as expr_95589,
expr_95590 as expr_95590,
expr_95591 as expr_95591,
expr_95592 as expr_95592,
expr_95593 as expr_95593,
expr_95594 as expr_95594,
expr_95595 as expr_95595,
expr_95596 as expr_95596,

expr_95597 as expr_95597,
expr_95598 as expr_95598,
expr_95599 as expr_95599,
expr_95600 as expr_95600,
expr_95601 as expr_95601,
expr_95602 as expr_95602,
expr_95603 as expr_95603,

expr_95604 as expr_95604,
expr_95606 as expr_95606,
expr_95607 as expr_95607,

expr_94627 as expr_94627,

	                (case expr_94628
                    when 187690 then N'Employee' 
                    when 187691 then N'Customer'
				end) as expr_94628,
				
expr_98629 as expr_98629,
expr_98627 as expr_98627,
expr_98643 as expr_98643,
expr_98554 as expr_98554,
expr_98556 as expr_98556,
expr_98557 as expr_98557,
expr_98558 as expr_98558,
expr_98560 as expr_98560,
expr_98605 as expr_98605,
expr_98622 as expr_98622,
expr_98626 as expr_98626,
expr_98230 as expr_98230,
expr_98235 as expr_98235,
expr_98238 as expr_98238,
expr_98241 as expr_98241,
expr_98242 as expr_98242,
expr_98245 as expr_98245,
expr_98247 as expr_98247,
expr_98248 as expr_98248,
expr_98249 as expr_98249,
expr_98250 as expr_98250,
expr_98552 as expr_98552,
expr_98221 as expr_98221,
expr_98630 as expr_98630,
expr_98628 as expr_98628,
expr_98711 as expr_98711,
expr_98591 as expr_98591,
expr_98592 as expr_98592,
expr_98595 as expr_98595,
expr_98597 as expr_98597,
expr_98598 as expr_98598,
expr_98601 as expr_98601,
expr_98624 as expr_98624,
expr_98625 as expr_98625,
expr_98564 as expr_98564,
expr_98565 as expr_98565,
expr_98566 as expr_98566,
expr_98567 as expr_98567,
expr_98569 as expr_98569,
expr_98570 as expr_98570,
expr_98571 as expr_98571,
expr_98572 as expr_98572,
expr_98573 as expr_98573,
expr_98586 as expr_98586,
expr_98588 as expr_98588,
expr_98590 as expr_98590,
expr_98223 as expr_98223,
expr_94759 as expr_94759


            
            from
                SurveyResponse 
            inner join
                Location 
                    on Location.objectId=SurveyResponse.locationObjectId 
			inner join
				address 
					on address.objectid=location.addressobjectid
            left outer join
                (
                    select
                        surveyResponseObjectId ,
                        max( case dataFieldObjectId 
                            when 25756 then dateValue 
                        end ) expr_4 ,
                        max( case dataFieldObjectId 
                            when 25757 then numericValue 
                        end ) expr_5 ,
                        max( case dataFieldObjectId 
                            when 25790 then dataFieldOptionObjectId 
                        end ) expr_6 ,
                        max( case dataFieldObjectId 
                            when 25852 then dataFieldOptionObjectId 
                        end ) expr_7 ,
                        max( case dataFieldObjectId 
                            when 25789 then dataFieldOptionObjectId 
                        end ) expr_8 ,
                        max( case dataFieldObjectId 
                            when 25791 then dataFieldOptionObjectId 
                        end ) expr_9 ,
                        max( case dataFieldObjectId 
                            when 25796 then dataFieldOptionObjectId 
                        end ) expr_10 ,
                        max( case dataFieldObjectId 
                            when 25798 then dataFieldOptionObjectId 
                        end ) expr_11 ,
                        max( case dataFieldObjectId 
                            when 25797 then dataFieldOptionObjectId 
                        end ) expr_12 ,
                        max( case dataFieldObjectId 
                            when 25795 then dataFieldOptionObjectId 
                        end ) expr_13 ,
                        max( case dataFieldObjectId 
                            when 25793 then dataFieldOptionObjectId 
                        end ) expr_14 ,
                        max( case dataFieldObjectId 
                            when 25794 then dataFieldOptionObjectId 
                        end ) expr_15 ,
                        max( case dataFieldObjectId 
                            when 25802 then dataFieldOptionObjectId 
                        end ) expr_16 ,
                        max( case dataFieldObjectId 
                            when 25803 then dataFieldOptionObjectId 
                        end ) expr_17 ,
                        max( case dataFieldObjectId 
                            when 25799 then dataFieldOptionObjectId 
                        end ) expr_18 ,
                        max( case dataFieldObjectId 
                            when 25800 then dataFieldOptionObjectId 
                        end ) expr_19 ,
                        max( case dataFieldObjectId 
                            when 25801 then dataFieldOptionObjectId 
                        end ) expr_20 ,
                        max( case dataFieldObjectId 
                            when 26402 then dataFieldOptionObjectId 
                        end ) expr_21 ,
                        max( case dataFieldObjectId 
                            when 25826 then c.ObjectId 
                        end ) expr_22 ,
                        max( case dataFieldObjectId 
                            when 25840 then dataFieldOptionObjectId 
                        end ) expr_23 ,
                        max( case dataFieldObjectId 
                            when 25841 then dataFieldOptionObjectId 
                        end ) expr_24 ,
                        max( case dataFieldObjectId 
                            when 25842 then dataFieldOptionObjectId 
                        end ) expr_25 ,
                        max( case dataFieldObjectId 
                            when 25809 then dataFieldOptionObjectId 
                        end ) expr_26 ,
                        max( case dataFieldObjectId 
                            when 25828 then dataFieldOptionObjectId 
                        end ) expr_27 ,
                        max( case dataFieldObjectId 
                            when 25829 then dataFieldOptionObjectId 
                        end ) expr_28 ,
                        max( case dataFieldObjectId 
                            when 25830 then dataFieldOptionObjectId 
                        end ) expr_29 ,
                        max( case dataFieldObjectId 
                            when 25848 then dataFieldOptionObjectId 
                        end ) expr_30 ,
                        max( case dataFieldObjectId 
                            when 25849 then dataFieldOptionObjectId 
                        end ) expr_31 ,
                        max( case dataFieldObjectId 
                            when 25808 then dataFieldOptionObjectId 
                        end ) expr_32 ,
                        max( case dataFieldObjectId 
                            when 25807 then dataFieldOptionObjectId 
                        end ) expr_33 ,
                        max( case dataFieldObjectId 
                            when 26982 then CAST(booleanValue AS TINYINT) 
                        end ) expr_34 ,
                        max( case dataFieldObjectId 
                            when 26949 then CAST(booleanValue AS TINYINT) 
                        end ) expr_35 ,
                        max( case dataFieldObjectId 
                            when 26950 then CAST(booleanValue AS TINYINT) 
                        end ) expr_36 ,
                        max( case dataFieldObjectId 
                            when 26951 then CAST(booleanValue AS TINYINT) 
                        end ) expr_37 ,
                        max( case dataFieldObjectId 
                            when 26952 then CAST(booleanValue AS TINYINT) 
                        end ) expr_38 ,
                        max( case dataFieldObjectId 
                            when 26953 then CAST(booleanValue AS TINYINT) 
                        end ) expr_39 ,
                        max( case dataFieldObjectId 
                            when 26954 then CAST(booleanValue AS TINYINT) 
                        end ) expr_40 ,
                        max( case dataFieldObjectId 
                            when 26955 then CAST(booleanValue AS TINYINT) 
                        end ) expr_41 ,
                        max( case dataFieldObjectId 
                            when 26956 then CAST(booleanValue AS TINYINT) 
                        end ) expr_42 ,
                        max( case dataFieldObjectId 
                            when 26957 then CAST(booleanValue AS TINYINT) 
                        end ) expr_43 ,
                        max( case dataFieldObjectId 
                            when 26319 then CAST(booleanValue AS TINYINT) 
                        end ) expr_44 ,
                        max( case dataFieldObjectId 
                            when 26320 then CAST(booleanValue AS TINYINT) 
                        end ) expr_45 ,
                        max( case dataFieldObjectId 
                            when 26321 then CAST(booleanValue AS TINYINT) 
                        end ) expr_46 ,
                        max( case dataFieldObjectId 
                            when 26322 then CAST(booleanValue AS TINYINT) 
                        end ) expr_47 ,
                        max( case dataFieldObjectId 
                            when 26323 then CAST(booleanValue AS TINYINT) 
                        end ) expr_48 ,
                        max( case dataFieldObjectId 
                            when 26328 then CAST(booleanValue AS TINYINT) 
                        end ) expr_49 ,
                        max( case dataFieldObjectId 
                            when 26329 then CAST(booleanValue AS TINYINT) 
                        end ) expr_50 ,
                        max( case dataFieldObjectId 
                            when 26330 then CAST(booleanValue AS TINYINT) 
                        end ) expr_51 ,
                        max( case dataFieldObjectId 
                            when 26331 then CAST(booleanValue AS TINYINT) 
                        end ) expr_52 ,
                        max( case dataFieldObjectId 
                            when 26332 then CAST(booleanValue AS TINYINT) 
                        end ) expr_53 ,
                        max( case dataFieldObjectId 
                            when 26345 then CAST(booleanValue AS TINYINT) 
                        end ) expr_54 ,
                        max( case dataFieldObjectId 
                            when 26346 then CAST(booleanValue AS TINYINT) 
                        end ) expr_55 ,
                        max( case dataFieldObjectId 
                            when 26347 then CAST(booleanValue AS TINYINT) 
                        end ) expr_56 ,
                        max( case dataFieldObjectId 
                            when 26348 then CAST(booleanValue AS TINYINT) 
                        end ) expr_57 ,
                        max( case dataFieldObjectId 
                            when 26349 then CAST(booleanValue AS TINYINT) 
                        end ) expr_58 ,
                        max( case dataFieldObjectId 
                            when 26324 then CAST(booleanValue AS TINYINT) 
                        end ) expr_59 ,
                        max( case dataFieldObjectId 
                            when 26325 then CAST(booleanValue AS TINYINT) 
                        end ) expr_60 ,
                        max( case dataFieldObjectId 
                            when 26326 then CAST(booleanValue AS TINYINT) 
                        end ) expr_61 ,
                        max( case dataFieldObjectId 
                            when 26327 then CAST(booleanValue AS TINYINT) 
                        end ) expr_62 ,
                        max( case dataFieldObjectId 
                            when 26341 then CAST(booleanValue AS TINYINT) 
                        end ) expr_63 ,
                        max( case dataFieldObjectId 
                            when 26339 then CAST(booleanValue AS TINYINT) 
                        end ) expr_64 ,
                        max( case dataFieldObjectId 
                            when 26340 then CAST(booleanValue AS TINYINT) 
                        end ) expr_65 ,
                        max( case dataFieldObjectId 
                            when 26342 then CAST(booleanValue AS TINYINT) 
                        end ) expr_66 ,
                        max( case dataFieldObjectId 
                            when 26343 then CAST(booleanValue AS TINYINT) 
                        end ) expr_67 ,
                        max( case dataFieldObjectId 
                            when 26344 then CAST(booleanValue AS TINYINT) 
                        end ) expr_68 ,
                        max( case dataFieldObjectId 
                            when 26596 then CAST(booleanValue AS TINYINT) 
                        end ) expr_69 ,
                        max( case dataFieldObjectId 
                            when 26597 then CAST(booleanValue AS TINYINT) 
                        end ) expr_70 ,
                        max( case dataFieldObjectId 
                            when 26598 then CAST(booleanValue AS TINYINT) 
                        end ) expr_71 ,
                        max( case dataFieldObjectId 
                            when 26599 then CAST(booleanValue AS TINYINT) 
                        end ) expr_72 ,
                        max( case dataFieldObjectId 
                            when 26600 then CAST(booleanValue AS TINYINT) 
                        end ) expr_73 ,
                        max( case dataFieldObjectId 
                            when 26333 then CAST(booleanValue AS TINYINT) 
                        end ) expr_74 ,
                        max( case dataFieldObjectId 
                            when 26334 then CAST(booleanValue AS TINYINT) 
                        end ) expr_75 ,
                        max( case dataFieldObjectId 
                            when 26335 then CAST(booleanValue AS TINYINT) 
                        end ) expr_76 ,
                        max( case dataFieldObjectId 
                            when 26336 then CAST(booleanValue AS TINYINT) 
                        end ) expr_77 ,
                        max( case dataFieldObjectId 
                            when 26337 then CAST(booleanValue AS TINYINT) 
                        end ) expr_78 ,
                        max( case dataFieldObjectId 
                            when 26338 then CAST(booleanValue AS TINYINT) 
                        end ) expr_79 ,
                        max( case dataFieldObjectId 
                            when 26350 then CAST(booleanValue AS TINYINT) 
                        end ) expr_80 ,
                        max( case dataFieldObjectId 
                            when 26351 then CAST(booleanValue AS TINYINT) 
                        end ) expr_81 ,
                        max( case dataFieldObjectId 
                            when 26352 then CAST(booleanValue AS TINYINT) 
                        end ) expr_82 ,
                        max( case dataFieldObjectId 
                            when 26353 then CAST(booleanValue AS TINYINT) 
                        end ) expr_83 ,
                        max( case dataFieldObjectId 
                            when 26383 then CAST(booleanValue AS TINYINT) 
                        end ) expr_84 ,
                        max( case dataFieldObjectId 
                            when 26384 then CAST(booleanValue AS TINYINT) 
                        end ) expr_85 ,
                        max( case dataFieldObjectId 
                            when 26385 then CAST(booleanValue AS TINYINT) 
                        end ) expr_86 ,
                        max( case dataFieldObjectId 
                            when 26615 then CAST(booleanValue AS TINYINT) 
                        end ) expr_87 ,
                        max( case dataFieldObjectId 
                            when 26382 then CAST(booleanValue AS TINYINT) 
                        end ) expr_88 ,
                        max( case dataFieldObjectId 
                            when 26386 then CAST(booleanValue AS TINYINT) 
                        end ) expr_89 ,
                        max( case dataFieldObjectId 
                            when 26387 then CAST(booleanValue AS TINYINT) 
                        end ) expr_90 ,
                        max( case dataFieldObjectId 
                            when 26388 then CAST(booleanValue AS TINYINT) 
                        end ) expr_91 ,
                        max( case dataFieldObjectId 
                            when 26389 then CAST(booleanValue AS TINYINT) 
                        end ) expr_92 ,
                        max( case dataFieldObjectId 
                            when 26390 then CAST(booleanValue AS TINYINT) 
                        end ) expr_93 ,
                        max( case dataFieldObjectId 
                            when 26391 then CAST(booleanValue AS TINYINT) 
                        end ) expr_94 ,
                        max( case dataFieldObjectId 
                            when 26614 then CAST(booleanValue AS TINYINT) 
                        end ) expr_95 ,
                        max( case dataFieldObjectId 
                            when 26392 then CAST(booleanValue AS TINYINT) 
                        end ) expr_96 ,
                        max( case dataFieldObjectId 
                            when 26393 then CAST(booleanValue AS TINYINT) 
                        end ) expr_97 ,
                        max( case dataFieldObjectId 
                            when 26394 then CAST(booleanValue AS TINYINT) 
                        end ) expr_98 ,
                        max( case dataFieldObjectId 
                            when 26395 then CAST(booleanValue AS TINYINT) 
                        end ) expr_99 ,
                        max( case dataFieldObjectId 
                            when 26396 then CAST(booleanValue AS TINYINT) 
                        end ) expr_100 ,
                        max( case dataFieldObjectId 
                            when 26397 then CAST(booleanValue AS TINYINT) 
                        end ) expr_101 ,
                        max( case dataFieldObjectId 
                            when 26613 then CAST(booleanValue AS TINYINT) 
                        end ) expr_102 ,
                        max( case dataFieldObjectId 
                            when 26366 then CAST(booleanValue AS TINYINT) 
                        end ) expr_103 ,
                        max( case dataFieldObjectId 
                            when 26367 then CAST(booleanValue AS TINYINT) 
                        end ) expr_104 ,
                        max( case dataFieldObjectId 
                            when 26368 then CAST(booleanValue AS TINYINT) 
                        end ) expr_105 ,
                        max( case dataFieldObjectId 
                            when 26369 then CAST(booleanValue AS TINYINT) 
                        end ) expr_106 ,
                        max( case dataFieldObjectId 
                            when 26370 then CAST(booleanValue AS TINYINT) 
                        end ) expr_107 ,
                        max( case dataFieldObjectId 
                            when 26618 then CAST(booleanValue AS TINYINT) 
                        end ) expr_108 ,
                        max( case dataFieldObjectId 
                            when 25936 then CAST(booleanValue AS TINYINT) 
                        end ) expr_109 ,
                        max( case dataFieldObjectId 
                            when 25937 then CAST(booleanValue AS TINYINT) 
                        end ) expr_110 ,
                        max( case dataFieldObjectId 
                            when 25938 then CAST(booleanValue AS TINYINT) 
                        end ) expr_111 ,
                        max( case dataFieldObjectId 
                            when 25939 then CAST(booleanValue AS TINYINT) 
                        end ) expr_112 ,
                        max( case dataFieldObjectId 
                            when 25940 then CAST(booleanValue AS TINYINT) 
                        end ) expr_113 ,
                        max( case dataFieldObjectId 
                            when 25941 then CAST(booleanValue AS TINYINT) 
                        end ) expr_114 ,
                        max( case dataFieldObjectId 
                            when 25942 then CAST(booleanValue AS TINYINT) 
                        end ) expr_115 ,
                        max( case dataFieldObjectId 
                            when 25943 then CAST(booleanValue AS TINYINT) 
                        end ) expr_116 ,
                        max( case dataFieldObjectId 
                            when 25944 then CAST(booleanValue AS TINYINT) 
                        end ) expr_117 ,
                        max( case dataFieldObjectId 
                            when 25945 then CAST(booleanValue AS TINYINT) 
                        end ) expr_118 ,
                        max( case dataFieldObjectId 
                            when 25946 then CAST(booleanValue AS TINYINT) 
                        end ) expr_119 ,
                        max( case dataFieldObjectId 
                            when 25947 then CAST(booleanValue AS TINYINT) 
                        end ) expr_120 ,
                        max( case dataFieldObjectId 
                            when 25948 then CAST(booleanValue AS TINYINT) 
                        end ) expr_121 ,
                        max( case dataFieldObjectId 
                            when 25949 then CAST(booleanValue AS TINYINT) 
                        end ) expr_122 ,
                        max( case dataFieldObjectId 
                            when 25950 then CAST(booleanValue AS TINYINT) 
                        end ) expr_123 ,
                        max( case dataFieldObjectId 
                            when 25951 then CAST(booleanValue AS TINYINT) 
                        end ) expr_124 ,
                        max( case dataFieldObjectId 
                            when 26620 then CAST(booleanValue AS TINYINT) 
                        end ) expr_125 ,
                        max( case dataFieldObjectId 
                            when 26157 then CAST(booleanValue AS TINYINT) 
                        end ) expr_126 ,
                        max( case dataFieldObjectId 
                            when 26158 then CAST(booleanValue AS TINYINT) 
                        end ) expr_127 ,
                        max( case dataFieldObjectId 
                            when 26159 then CAST(booleanValue AS TINYINT) 
                        end ) expr_128 ,
                        max( case dataFieldObjectId 
                            when 26160 then CAST(booleanValue AS TINYINT) 
                        end ) expr_129 ,
                        max( case dataFieldObjectId 
                            when 26161 then CAST(booleanValue AS TINYINT) 
                        end ) expr_130 ,
                        max( case dataFieldObjectId 
                            when 26162 then CAST(booleanValue AS TINYINT) 
                        end ) expr_131 ,
                        max( case dataFieldObjectId 
                            when 26163 then CAST(booleanValue AS TINYINT) 
                        end ) expr_132 ,
                        max( case dataFieldObjectId 
                            when 26164 then CAST(booleanValue AS TINYINT) 
                        end ) expr_133 ,
                        max( case dataFieldObjectId 
                            when 26165 then CAST(booleanValue AS TINYINT) 
                        end ) expr_134 ,
                        max( case dataFieldObjectId 
                            when 26166 then CAST(booleanValue AS TINYINT) 
                        end ) expr_135 ,
                        max( case dataFieldObjectId 
                            when 26167 then CAST(booleanValue AS TINYINT) 
                        end ) expr_136 ,
                        max( case dataFieldObjectId 
                            when 26168 then CAST(booleanValue AS TINYINT) 
                        end ) expr_137 ,
                        max( case dataFieldObjectId 
                            when 26169 then CAST(booleanValue AS TINYINT) 
                        end ) expr_138 ,
                        max( case dataFieldObjectId 
                            when 26170 then CAST(booleanValue AS TINYINT) 
                        end ) expr_139 ,
                        max( case dataFieldObjectId 
                            when 26171 then CAST(booleanValue AS TINYINT) 
                        end ) expr_140 ,
                        max( case dataFieldObjectId 
                            when 26172 then CAST(booleanValue AS TINYINT) 
                        end ) expr_141 ,
                        max( case dataFieldObjectId 
                            when 26173 then CAST(booleanValue AS TINYINT) 
                        end ) expr_142 ,
                        max( case dataFieldObjectId 
                            when 26180 then CAST(booleanValue AS TINYINT) 
                        end ) expr_143 ,
                        max( case dataFieldObjectId 
                            when 26181 then CAST(booleanValue AS TINYINT) 
                        end ) expr_144 ,
                        max( case dataFieldObjectId 
                            when 26182 then CAST(booleanValue AS TINYINT) 
                        end ) expr_145 ,
                        max( case dataFieldObjectId 
                            when 26183 then CAST(booleanValue AS TINYINT) 
                        end ) expr_146 ,
                        max( case dataFieldObjectId 
                            when 26184 then CAST(booleanValue AS TINYINT) 
                        end ) expr_147 ,
                        max( case dataFieldObjectId 
                            when 26185 then CAST(booleanValue AS TINYINT) 
                        end ) expr_148 ,
                        max( case dataFieldObjectId 
                            when 26186 then CAST(booleanValue AS TINYINT) 
                        end ) expr_149 ,
                        max( case dataFieldObjectId 
                            when 26187 then CAST(booleanValue AS TINYINT) 
                        end ) expr_150 ,
                        max( case dataFieldObjectId 
                            when 26195 then CAST(booleanValue AS TINYINT) 
                        end ) expr_151 ,
                        max( case dataFieldObjectId 
                            when 26197 then CAST(booleanValue AS TINYINT) 
                        end ) expr_152 ,
                        max( case dataFieldObjectId 
                            when 26586 then CAST(booleanValue AS TINYINT) 
                        end ) expr_153 ,
                        max( case dataFieldObjectId 
                            when 26199 then CAST(booleanValue AS TINYINT) 
                        end ) expr_154 ,
                        max( case dataFieldObjectId 
                            when 26201 then CAST(booleanValue AS TINYINT) 
                        end ) expr_155 ,
                        max( case dataFieldObjectId 
                            when 26202 then CAST(booleanValue AS TINYINT) 
                        end ) expr_156 ,
                        max( case dataFieldObjectId 
                            when 26203 then CAST(booleanValue AS TINYINT) 
                        end ) expr_157 ,
                        max( case dataFieldObjectId 
                            when 26151 then CAST(booleanValue AS TINYINT) 
                        end ) expr_158 ,
                        max( case dataFieldObjectId 
                            when 26152 then CAST(booleanValue AS TINYINT) 
                        end ) expr_159 ,
                        max( case dataFieldObjectId 
                            when 26153 then CAST(booleanValue AS TINYINT) 
                        end ) expr_160 ,
                        max( case dataFieldObjectId 
                            when 26154 then CAST(booleanValue AS TINYINT) 
                        end ) expr_161 ,
                        max( case dataFieldObjectId 
                            when 26489 then CAST(booleanValue AS TINYINT) 
                        end ) expr_162 ,
                        max( case dataFieldObjectId 
                            when 26155 then CAST(booleanValue AS TINYINT) 
                        end ) expr_163 ,
                        max( case dataFieldObjectId 
                            when 26156 then CAST(booleanValue AS TINYINT) 
                        end ) expr_164 ,
                        max( case dataFieldObjectId 
                            when 26484 then CAST(booleanValue AS TINYINT) 
                        end ) expr_165 ,
                        max( case dataFieldObjectId 
                            when 26148 then CAST(booleanValue AS TINYINT) 
                        end ) expr_166 ,
                        max( case dataFieldObjectId 
                            when 26141 then CAST(booleanValue AS TINYINT) 
                        end ) expr_167 ,
                        max( case dataFieldObjectId 
                            when 26142 then CAST(booleanValue AS TINYINT) 
                        end ) expr_168 ,
                        max( case dataFieldObjectId 
                            when 26143 then CAST(booleanValue AS TINYINT) 
                        end ) expr_169 ,
                        max( case dataFieldObjectId 
                            when 26144 then CAST(booleanValue AS TINYINT) 
                        end ) expr_170 ,
                        max( case dataFieldObjectId 
                            when 26145 then CAST(booleanValue AS TINYINT) 
                        end ) expr_171 ,
                        max( case dataFieldObjectId 
                            when 26146 then CAST(booleanValue AS TINYINT) 
                        end ) expr_172 ,
                        max( case dataFieldObjectId 
                            when 26147 then CAST(booleanValue AS TINYINT) 
                        end ) expr_173 ,
                        max( case dataFieldObjectId 
                            when 26149 then CAST(booleanValue AS TINYINT) 
                        end ) expr_174 ,
                        max( case dataFieldObjectId 
                            when 26150 then CAST(booleanValue AS TINYINT) 
                        end ) expr_175 ,
                        max( case dataFieldObjectId 
                            when 26188 then CAST(booleanValue AS TINYINT) 
                        end ) expr_176 ,
                        max( case dataFieldObjectId 
                            when 26196 then CAST(booleanValue AS TINYINT) 
                        end ) expr_177 ,
                        max( case dataFieldObjectId 
                            when 26189 then CAST(booleanValue AS TINYINT) 
                        end ) expr_178 ,
                        max( case dataFieldObjectId 
                            when 26190 then CAST(booleanValue AS TINYINT) 
                        end ) expr_179 ,
                        max( case dataFieldObjectId 
                            when 26198 then CAST(booleanValue AS TINYINT) 
                        end ) expr_180 ,
                        max( case dataFieldObjectId 
                            when 26191 then CAST(booleanValue AS TINYINT) 
                        end ) expr_181 ,
                        max( case dataFieldObjectId 
                            when 26192 then CAST(booleanValue AS TINYINT) 
                        end ) expr_182 ,
                        max( case dataFieldObjectId 
                            when 26193 then CAST(booleanValue AS TINYINT) 
                        end ) expr_183 ,
                        max( case dataFieldObjectId 
                            when 26200 then CAST(booleanValue AS TINYINT) 
                        end ) expr_184 ,
                        max( case dataFieldObjectId 
                            when 26194 then CAST(booleanValue AS TINYINT) 
                        end ) expr_185 ,
                        max( case dataFieldObjectId 
                            when 26174 then CAST(booleanValue AS TINYINT) 
                        end ) expr_186 ,
                        max( case dataFieldObjectId 
                            when 26175 then CAST(booleanValue AS TINYINT) 
                        end ) expr_187 ,
                        max( case dataFieldObjectId 
                            when 26176 then CAST(booleanValue AS TINYINT) 
                        end ) expr_188 ,
                        max( case dataFieldObjectId 
                            when 26177 then CAST(booleanValue AS TINYINT) 
                        end ) expr_189 ,
                        max( case dataFieldObjectId 
                            when 26178 then CAST(booleanValue AS TINYINT) 
                        end ) expr_190 ,
                        max( case dataFieldObjectId 
                            when 26179 then CAST(booleanValue AS TINYINT) 
                        end ) expr_191 ,
                        max( case dataFieldObjectId 
                            when 26733 then CAST(booleanValue AS TINYINT) 
                        end ) expr_192 ,
                        max( case dataFieldObjectId 
                            when 26619 then CAST(booleanValue AS TINYINT) 
                        end ) expr_193 ,
                        max( case dataFieldObjectId 
                            when 26094 then CAST(booleanValue AS TINYINT) 
                        end ) expr_194 ,
                        max( case dataFieldObjectId 
                            when 26095 then CAST(booleanValue AS TINYINT) 
                        end ) expr_195 ,
                        max( case dataFieldObjectId 
                            when 26096 then CAST(booleanValue AS TINYINT) 
                        end ) expr_196 ,
                        max( case dataFieldObjectId 
                            when 26097 then CAST(booleanValue AS TINYINT) 
                        end ) expr_197 ,
                        max( case dataFieldObjectId 
                            when 26098 then CAST(booleanValue AS TINYINT) 
                        end ) expr_198 ,
                        max( case dataFieldObjectId 
                            when 26099 then CAST(booleanValue AS TINYINT) 
                        end ) expr_199 ,
                        max( case dataFieldObjectId 
                            when 26100 then CAST(booleanValue AS TINYINT) 
                        end ) expr_200 ,
                        max( case dataFieldObjectId 
                            when 26101 then CAST(booleanValue AS TINYINT) 
                        end ) expr_201 ,
                        max( case dataFieldObjectId 
                            when 26102 then CAST(booleanValue AS TINYINT) 
                        end ) expr_202 ,
                        max( case dataFieldObjectId 
                            when 26103 then CAST(booleanValue AS TINYINT) 
                        end ) expr_203 ,
                        max( case dataFieldObjectId 
                            when 26104 then CAST(booleanValue AS TINYINT) 
                        end ) expr_204 ,
                        max( case dataFieldObjectId 
                            when 26105 then CAST(booleanValue AS TINYINT) 
                        end ) expr_205 ,
                        max( case dataFieldObjectId 
                            when 26106 then CAST(booleanValue AS TINYINT) 
                        end ) expr_206 ,
                        max( case dataFieldObjectId 
                            when 26107 then CAST(booleanValue AS TINYINT) 
                        end ) expr_207 ,
                        max( case dataFieldObjectId 
                            when 26108 then CAST(booleanValue AS TINYINT) 
                        end ) expr_208 ,
                        max( case dataFieldObjectId 
                            when 26109 then CAST(booleanValue AS TINYINT) 
                        end ) expr_209 ,
                        max( case dataFieldObjectId 
                            when 26110 then CAST(booleanValue AS TINYINT) 
                        end ) expr_210 ,
                        max( case dataFieldObjectId 
                            when 26117 then CAST(booleanValue AS TINYINT) 
                        end ) expr_211 ,
                        max( case dataFieldObjectId 
                            when 26118 then CAST(booleanValue AS TINYINT) 
                        end ) expr_212 ,
                        max( case dataFieldObjectId 
                            when 26119 then CAST(booleanValue AS TINYINT) 
                        end ) expr_213 ,
                        max( case dataFieldObjectId 
                            when 26120 then CAST(booleanValue AS TINYINT) 
                        end ) expr_214 ,
                        max( case dataFieldObjectId 
                            when 26121 then CAST(booleanValue AS TINYINT) 
                        end ) expr_215 ,
                        max( case dataFieldObjectId 
                            when 26122 then CAST(booleanValue AS TINYINT) 
                        end ) expr_216 ,
                        max( case dataFieldObjectId 
                            when 26123 then CAST(booleanValue AS TINYINT) 
                        end ) expr_217 ,
                        max( case dataFieldObjectId 
                            when 26124 then CAST(booleanValue AS TINYINT) 
                        end ) expr_218 ,
                        max( case dataFieldObjectId 
                            when 26132 then CAST(booleanValue AS TINYINT) 
                        end ) expr_219 ,
                        max( case dataFieldObjectId 
                            when 26134 then CAST(booleanValue AS TINYINT) 
                        end ) expr_220 ,
                        max( case dataFieldObjectId 
                            when 26587 then CAST(booleanValue AS TINYINT) 
                        end ) expr_221 ,
                        max( case dataFieldObjectId 
                            when 26136 then CAST(booleanValue AS TINYINT) 
                        end ) expr_222 ,
                        max( case dataFieldObjectId 
                            when 26138 then CAST(booleanValue AS TINYINT) 
                        end ) expr_223 ,
                        max( case dataFieldObjectId 
                            when 26139 then CAST(booleanValue AS TINYINT) 
                        end ) expr_224 ,
                        max( case dataFieldObjectId 
                            when 26140 then CAST(booleanValue AS TINYINT) 
                        end ) expr_225 ,
                        max( case dataFieldObjectId 
                            when 26088 then CAST(booleanValue AS TINYINT) 
                        end ) expr_226 ,
                        max( case dataFieldObjectId 
                            when 26089 then CAST(booleanValue AS TINYINT) 
                        end ) expr_227 ,
                        max( case dataFieldObjectId 
                            when 26090 then CAST(booleanValue AS TINYINT) 
                        end ) expr_228 ,
                        max( case dataFieldObjectId 
                            when 26091 then CAST(booleanValue AS TINYINT) 
                        end ) expr_229 ,
                        max( case dataFieldObjectId 
                            when 26488 then CAST(booleanValue AS TINYINT) 
                        end ) expr_230 ,
                        max( case dataFieldObjectId 
                            when 26092 then CAST(booleanValue AS TINYINT) 
                        end ) expr_231 ,
                        max( case dataFieldObjectId 
                            when 26093 then CAST(booleanValue AS TINYINT) 
                        end ) expr_232 ,
                        max( case dataFieldObjectId 
                            when 26483 then CAST(booleanValue AS TINYINT) 
                        end ) expr_233 ,
                        max( case dataFieldObjectId 
                            when 26085 then CAST(booleanValue AS TINYINT) 
                        end ) expr_234 ,
                        max( case dataFieldObjectId 
                            when 26078 then CAST(booleanValue AS TINYINT) 
                        end ) expr_235 ,
                        max( case dataFieldObjectId 
                            when 26079 then CAST(booleanValue AS TINYINT) 
                        end ) expr_236 ,
                        max( case dataFieldObjectId 
                            when 26080 then CAST(booleanValue AS TINYINT) 
                        end ) expr_237 ,
                        max( case dataFieldObjectId 
                            when 26081 then CAST(booleanValue AS TINYINT) 
                        end ) expr_238 ,
                        max( case dataFieldObjectId 
                            when 26082 then CAST(booleanValue AS TINYINT) 
                        end ) expr_239 ,
                        max( case dataFieldObjectId 
                            when 26083 then CAST(booleanValue AS TINYINT) 
                        end ) expr_240 ,
                        max( case dataFieldObjectId 
                            when 26084 then CAST(booleanValue AS TINYINT) 
                        end ) expr_241 ,
                        max( case dataFieldObjectId 
                            when 26086 then CAST(booleanValue AS TINYINT) 
                        end ) expr_242 ,
                        max( case dataFieldObjectId 
                            when 26087 then CAST(booleanValue AS TINYINT) 
                        end ) expr_243 ,
                        max( case dataFieldObjectId 
                            when 26125 then CAST(booleanValue AS TINYINT) 
                        end ) expr_244 ,
                        max( case dataFieldObjectId 
                            when 26133 then CAST(booleanValue AS TINYINT) 
                        end ) expr_245 ,
                        max( case dataFieldObjectId 
                            when 26126 then CAST(booleanValue AS TINYINT) 
                        end ) expr_246 ,
                        max( case dataFieldObjectId 
                            when 26127 then CAST(booleanValue AS TINYINT) 
                        end ) expr_247 ,
                        max( case dataFieldObjectId 
                            when 26135 then CAST(booleanValue AS TINYINT) 
                        end ) expr_248 ,
                        max( case dataFieldObjectId 
                            when 26128 then CAST(booleanValue AS TINYINT) 
                        end ) expr_249 ,
                        max( case dataFieldObjectId 
                            when 26129 then CAST(booleanValue AS TINYINT) 
                        end ) expr_250 ,
                        max( case dataFieldObjectId 
                            when 26130 then CAST(booleanValue AS TINYINT) 
                        end ) expr_251 ,
                        max( case dataFieldObjectId 
                            when 26137 then CAST(booleanValue AS TINYINT) 
                        end ) expr_252 ,
                        max( case dataFieldObjectId 
                            when 26131 then CAST(booleanValue AS TINYINT) 
                        end ) expr_253 ,
                        max( case dataFieldObjectId 
                            when 26111 then CAST(booleanValue AS TINYINT) 
                        end ) expr_254 ,
                        max( case dataFieldObjectId 
                            when 26112 then CAST(booleanValue AS TINYINT) 
                        end ) expr_255 ,
                        max( case dataFieldObjectId 
                            when 26113 then CAST(booleanValue AS TINYINT) 
                        end ) expr_256 ,
                        max( case dataFieldObjectId 
                            when 26114 then CAST(booleanValue AS TINYINT) 
                        end ) expr_257 ,
                        max( case dataFieldObjectId 
                            when 26115 then CAST(booleanValue AS TINYINT) 
                        end ) expr_258 ,
                        max( case dataFieldObjectId 
                            when 26116 then CAST(booleanValue AS TINYINT) 
                        end ) expr_259 ,
                        max( case dataFieldObjectId 
                            when 26734 then CAST(booleanValue AS TINYINT) 
                        end ) expr_260 ,
                        max( case dataFieldObjectId 
                            when 26621 then CAST(booleanValue AS TINYINT) 
                        end ) expr_261 ,
                        max( case dataFieldObjectId 
                            when 26220 then CAST(booleanValue AS TINYINT) 
                        end ) expr_262 ,
                        max( case dataFieldObjectId 
                            when 26221 then CAST(booleanValue AS TINYINT) 
                        end ) expr_263 ,
                        max( case dataFieldObjectId 
                            when 26222 then CAST(booleanValue AS TINYINT) 
                        end ) expr_264 ,
                        max( case dataFieldObjectId 
                            when 26223 then CAST(booleanValue AS TINYINT) 
                        end ) expr_265 ,
                        max( case dataFieldObjectId 
                            when 26224 then CAST(booleanValue AS TINYINT) 
                        end ) expr_266 ,
                        max( case dataFieldObjectId 
                            when 26225 then CAST(booleanValue AS TINYINT) 
                        end ) expr_267 ,
                        max( case dataFieldObjectId 
                            when 26226 then CAST(booleanValue AS TINYINT) 
                        end ) expr_268 ,
                        max( case dataFieldObjectId 
                            when 26227 then CAST(booleanValue AS TINYINT) 
                        end ) expr_269 ,
                        max( case dataFieldObjectId 
                            when 26228 then CAST(booleanValue AS TINYINT) 
                        end ) expr_270 ,
                        max( case dataFieldObjectId 
                            when 26229 then CAST(booleanValue AS TINYINT) 
                        end ) expr_271 ,
                        max( case dataFieldObjectId 
                            when 26230 then CAST(booleanValue AS TINYINT) 
                        end ) expr_272 ,
                        max( case dataFieldObjectId 
                            when 26231 then CAST(booleanValue AS TINYINT) 
                        end ) expr_273 ,
                        max( case dataFieldObjectId 
                            when 26232 then CAST(booleanValue AS TINYINT) 
                        end ) expr_274 ,
                        max( case dataFieldObjectId 
                            when 26233 then CAST(booleanValue AS TINYINT) 
                        end ) expr_275 ,
                        max( case dataFieldObjectId 
                            when 26234 then CAST(booleanValue AS TINYINT) 
                        end ) expr_276 ,
                        max( case dataFieldObjectId 
                            when 26235 then CAST(booleanValue AS TINYINT) 
                        end ) expr_277 ,
                        max( case dataFieldObjectId 
                            when 26236 then CAST(booleanValue AS TINYINT) 
                        end ) expr_278 ,
                        max( case dataFieldObjectId 
                            when 26243 then CAST(booleanValue AS TINYINT) 
                        end ) expr_279 ,
                        max( case dataFieldObjectId 
                            when 26244 then CAST(booleanValue AS TINYINT) 
                        end ) expr_280 ,
                        max( case dataFieldObjectId 
                            when 26245 then CAST(booleanValue AS TINYINT) 
                        end ) expr_281 ,
                        max( case dataFieldObjectId 
                            when 26246 then CAST(booleanValue AS TINYINT) 
                        end ) expr_282 ,
                        max( case dataFieldObjectId 
                            when 26247 then CAST(booleanValue AS TINYINT) 
                        end ) expr_283 ,
                        max( case dataFieldObjectId 
                            when 26248 then CAST(booleanValue AS TINYINT) 
                        end ) expr_284 ,
                        max( case dataFieldObjectId 
                            when 26249 then CAST(booleanValue AS TINYINT) 
                        end ) expr_285 ,
                        max( case dataFieldObjectId 
                            when 26250 then CAST(booleanValue AS TINYINT) 
                        end ) expr_286 ,
                        max( case dataFieldObjectId 
                            when 26258 then CAST(booleanValue AS TINYINT) 
                        end ) expr_287 ,
                        max( case dataFieldObjectId 
                            when 26260 then CAST(booleanValue AS TINYINT) 
                        end ) expr_288 ,
                        max( case dataFieldObjectId 
                            when 26588 then CAST(booleanValue AS TINYINT) 
                        end ) expr_289 ,
                        max( case dataFieldObjectId 
                            when 26262 then CAST(booleanValue AS TINYINT) 
                        end ) expr_290 ,
                        max( case dataFieldObjectId 
                            when 26264 then CAST(booleanValue AS TINYINT) 
                        end ) expr_291 ,
                        max( case dataFieldObjectId 
                            when 26265 then CAST(booleanValue AS TINYINT) 
                        end ) expr_292 ,
                        max( case dataFieldObjectId 
                            when 26266 then CAST(booleanValue AS TINYINT) 
                        end ) expr_293 ,
                        max( case dataFieldObjectId 
                            when 26214 then CAST(booleanValue AS TINYINT) 
                        end ) expr_294 ,
                        max( case dataFieldObjectId 
                            when 26215 then CAST(booleanValue AS TINYINT) 
                        end ) expr_295 ,
                        max( case dataFieldObjectId 
                            when 26216 then CAST(booleanValue AS TINYINT) 
                        end ) expr_296 ,
                        max( case dataFieldObjectId 
                            when 26217 then CAST(booleanValue AS TINYINT) 
                        end ) expr_297 ,
                        max( case dataFieldObjectId 
                            when 26490 then CAST(booleanValue AS TINYINT) 
                        end ) expr_298 ,
                        max( case dataFieldObjectId 
                            when 26218 then CAST(booleanValue AS TINYINT) 
                        end ) expr_299 ,
                        max( case dataFieldObjectId 
                            when 26219 then CAST(booleanValue AS TINYINT) 
                        end ) expr_300 ,
                        max( case dataFieldObjectId 
                            when 26485 then CAST(booleanValue AS TINYINT) 
                        end ) expr_301 ,
                        max( case dataFieldObjectId 
                            when 26211 then CAST(booleanValue AS TINYINT) 
                        end ) expr_302 ,
                        max( case dataFieldObjectId 
                            when 26204 then CAST(booleanValue AS TINYINT) 
                        end ) expr_303 ,
                        max( case dataFieldObjectId 
                            when 26205 then CAST(booleanValue AS TINYINT) 
                        end ) expr_304 ,
                        max( case dataFieldObjectId 
                            when 26206 then CAST(booleanValue AS TINYINT) 
                        end ) expr_305 ,
                        max( case dataFieldObjectId 
                            when 26207 then CAST(booleanValue AS TINYINT) 
                        end ) expr_306 ,
                        max( case dataFieldObjectId 
                            when 26208 then CAST(booleanValue AS TINYINT) 
                        end ) expr_307 ,
                        max( case dataFieldObjectId 
                            when 26209 then CAST(booleanValue AS TINYINT) 
                        end ) expr_308 ,
                        max( case dataFieldObjectId 
                            when 26210 then CAST(booleanValue AS TINYINT) 
                        end ) expr_309 ,
                        max( case dataFieldObjectId 
                            when 26212 then CAST(booleanValue AS TINYINT) 
                        end ) expr_310 ,
                        max( case dataFieldObjectId 
                            when 26213 then CAST(booleanValue AS TINYINT) 
                        end ) expr_311 ,
                        max( case dataFieldObjectId 
                            when 26251 then CAST(booleanValue AS TINYINT) 
                        end ) expr_312 ,
                        max( case dataFieldObjectId 
                            when 26259 then CAST(booleanValue AS TINYINT) 
                        end ) expr_313 ,
                        max( case dataFieldObjectId 
                            when 26252 then CAST(booleanValue AS TINYINT) 
                        end ) expr_314 ,
                        max( case dataFieldObjectId 
                            when 26253 then CAST(booleanValue AS TINYINT) 
                        end ) expr_315 ,
                        max( case dataFieldObjectId 
                            when 26261 then CAST(booleanValue AS TINYINT) 
                        end ) expr_316 ,
                        max( case dataFieldObjectId 
                            when 26254 then CAST(booleanValue AS TINYINT) 
                        end ) expr_317 ,
                        max( case dataFieldObjectId 
                            when 26255 then CAST(booleanValue AS TINYINT) 
                        end ) expr_318 ,
                        max( case dataFieldObjectId 
                            when 26256 then CAST(booleanValue AS TINYINT) 
                        end ) expr_319 ,
                        max( case dataFieldObjectId 
                            when 26263 then CAST(booleanValue AS TINYINT) 
                        end ) expr_320 ,
                        max( case dataFieldObjectId 
                            when 26257 then CAST(booleanValue AS TINYINT) 
                        end ) expr_321 ,
                        max( case dataFieldObjectId 
                            when 26237 then CAST(booleanValue AS TINYINT) 
                        end ) expr_322 ,
                        max( case dataFieldObjectId 
                            when 26238 then CAST(booleanValue AS TINYINT) 
                        end ) expr_323 ,
                        max( case dataFieldObjectId 
                            when 26239 then CAST(booleanValue AS TINYINT) 
                        end ) expr_324 ,
                        max( case dataFieldObjectId 
                            when 26240 then CAST(booleanValue AS TINYINT) 
                        end ) expr_325 ,
                        max( case dataFieldObjectId 
                            when 26241 then CAST(booleanValue AS TINYINT) 
                        end ) expr_326 ,
                        max( case dataFieldObjectId 
                            when 26242 then CAST(booleanValue AS TINYINT) 
                        end ) expr_327 ,
                        max( case dataFieldObjectId 
                            when 26735 then CAST(booleanValue AS TINYINT) 
                        end ) expr_328 ,
                        max( case dataFieldObjectId 
                            when 25932 then CAST(booleanValue AS TINYINT) 
                        end ) expr_329 ,
                        max( case dataFieldObjectId 
                            when 25933 then CAST(booleanValue AS TINYINT) 
                        end ) expr_330 ,
                        max( case dataFieldObjectId 
                            when 25934 then CAST(booleanValue AS TINYINT) 
                        end ) expr_331 ,
                        max( case dataFieldObjectId 
                            when 25935 then CAST(booleanValue AS TINYINT) 
                        end ) expr_332 ,
                        max( case dataFieldObjectId 
                            when 25968 then CAST(booleanValue AS TINYINT) 
                        end ) expr_333 ,
                        max( case dataFieldObjectId 
                            when 25969 then CAST(booleanValue AS TINYINT) 
                        end ) expr_334 ,
                        max( case dataFieldObjectId 
                            when 25970 then CAST(booleanValue AS TINYINT) 
                        end ) expr_335 ,
                        max( case dataFieldObjectId 
                            when 25971 then CAST(booleanValue AS TINYINT) 
                        end ) expr_336 ,
                        max( case dataFieldObjectId 
                            when 25972 then CAST(booleanValue AS TINYINT) 
                        end ) expr_337 ,
                        max( case dataFieldObjectId 
                            when 25973 then CAST(booleanValue AS TINYINT) 
                        end ) expr_338 ,
                        max( case dataFieldObjectId 
                            when 25974 then CAST(booleanValue AS TINYINT) 
                        end ) expr_339 ,
                        max( case dataFieldObjectId 
                            when 25975 then CAST(booleanValue AS TINYINT) 
                        end ) expr_340 ,
                        max( case dataFieldObjectId 
                            when 25976 then CAST(booleanValue AS TINYINT) 
                        end ) expr_341 ,
                        max( case dataFieldObjectId 
                            when 25977 then CAST(booleanValue AS TINYINT) 
                        end ) expr_342 ,
                        max( case dataFieldObjectId 
                            when 25978 then CAST(booleanValue AS TINYINT) 
                        end ) expr_343 ,
                        max( case dataFieldObjectId 
                            when 25979 then CAST(booleanValue AS TINYINT) 
                        end ) expr_344 ,
                        max( case dataFieldObjectId 
                            when 25980 then CAST(booleanValue AS TINYINT) 
                        end ) expr_345 ,
                        max( case dataFieldObjectId 
                            when 25981 then CAST(booleanValue AS TINYINT) 
                        end ) expr_346 ,
                        max( case dataFieldObjectId 
                            when 25982 then CAST(booleanValue AS TINYINT) 
                        end ) expr_347 ,
                        max( case dataFieldObjectId 
                            when 25983 then CAST(booleanValue AS TINYINT) 
                        end ) expr_348 ,
                        max( case dataFieldObjectId 
                            when 25984 then CAST(booleanValue AS TINYINT) 
                        end ) expr_349 ,
                        max( case dataFieldObjectId 
                            when 25991 then CAST(booleanValue AS TINYINT) 
                        end ) expr_350 ,
                        max( case dataFieldObjectId 
                            when 25992 then CAST(booleanValue AS TINYINT) 
                        end ) expr_351 ,
                        max( case dataFieldObjectId 
                            when 25993 then CAST(booleanValue AS TINYINT) 
                        end ) expr_352 ,
                        max( case dataFieldObjectId 
                            when 25994 then CAST(booleanValue AS TINYINT) 
                        end ) expr_353 ,
                        max( case dataFieldObjectId 
                            when 25995 then CAST(booleanValue AS TINYINT) 
                        end ) expr_354 ,
                        max( case dataFieldObjectId 
                            when 25996 then CAST(booleanValue AS TINYINT) 
                        end ) expr_355 ,
                        max( case dataFieldObjectId 
                            when 25997 then CAST(booleanValue AS TINYINT) 
                        end ) expr_356 ,
                        max( case dataFieldObjectId 
                            when 25998 then CAST(booleanValue AS TINYINT) 
                        end ) expr_357 ,
                        max( case dataFieldObjectId 
                            when 26006 then CAST(booleanValue AS TINYINT) 
                        end ) expr_358 ,
                        max( case dataFieldObjectId 
                            when 26008 then CAST(booleanValue AS TINYINT) 
                        end ) expr_359 ,
                        max( case dataFieldObjectId 
                            when 26589 then CAST(booleanValue AS TINYINT) 
                        end ) expr_360 ,
                        max( case dataFieldObjectId 
                            when 26010 then CAST(booleanValue AS TINYINT) 
                        end ) expr_361 ,
                        max( case dataFieldObjectId 
                            when 26012 then CAST(booleanValue AS TINYINT) 
                        end ) expr_362 ,
                        max( case dataFieldObjectId 
                            when 26013 then CAST(booleanValue AS TINYINT) 
                        end ) expr_363 ,
                        max( case dataFieldObjectId 
                            when 26014 then CAST(booleanValue AS TINYINT) 
                        end ) expr_364 ,
                        max( case dataFieldObjectId 
                            when 25962 then CAST(booleanValue AS TINYINT) 
                        end ) expr_365 ,
                        max( case dataFieldObjectId 
                            when 25963 then CAST(booleanValue AS TINYINT) 
                        end ) expr_366 ,
                        max( case dataFieldObjectId 
                            when 25964 then CAST(booleanValue AS TINYINT) 
                        end ) expr_367 ,
                        max( case dataFieldObjectId 
                            when 25965 then CAST(booleanValue AS TINYINT) 
                        end ) expr_368 ,
                        max( case dataFieldObjectId 
                            when 26486 then CAST(booleanValue AS TINYINT) 
                        end ) expr_369 ,
                        max( case dataFieldObjectId 
                            when 25966 then CAST(booleanValue AS TINYINT) 
                        end ) expr_370 ,
                        max( case dataFieldObjectId 
                            when 25967 then CAST(booleanValue AS TINYINT) 
                        end ) expr_371 ,
                        max( case dataFieldObjectId 
                            when 26481 then CAST(booleanValue AS TINYINT) 
                        end ) expr_372 ,
                        max( case dataFieldObjectId 
                            when 25959 then CAST(booleanValue AS TINYINT) 
                        end ) expr_373 ,
                        max( case dataFieldObjectId 
                            when 25952 then CAST(booleanValue AS TINYINT) 
                        end ) expr_374 ,
                        max( case dataFieldObjectId 
                            when 25953 then CAST(booleanValue AS TINYINT) 
                        end ) expr_375 ,
                        max( case dataFieldObjectId 
                            when 25954 then CAST(booleanValue AS TINYINT) 
                        end ) expr_376 ,
                        max( case dataFieldObjectId 
                            when 25955 then CAST(booleanValue AS TINYINT) 
                        end ) expr_377 ,
                        max( case dataFieldObjectId 
                            when 25956 then CAST(booleanValue AS TINYINT) 
                        end ) expr_378 ,
                        max( case dataFieldObjectId 
                            when 25957 then CAST(booleanValue AS TINYINT) 
                        end ) expr_379 ,
                        max( case dataFieldObjectId 
                            when 25958 then CAST(booleanValue AS TINYINT) 
                        end ) expr_380 ,
                        max( case dataFieldObjectId 
                            when 25960 then CAST(booleanValue AS TINYINT) 
                        end ) expr_381 ,
                        max( case dataFieldObjectId 
                            when 25961 then CAST(booleanValue AS TINYINT) 
                        end ) expr_382 ,
                        max( case dataFieldObjectId 
                            when 25999 then CAST(booleanValue AS TINYINT) 
                        end ) expr_383 ,
                        max( case dataFieldObjectId 
                            when 26007 then CAST(booleanValue AS TINYINT) 
                        end ) expr_384 ,
                        max( case dataFieldObjectId 
                            when 26000 then CAST(booleanValue AS TINYINT) 
                        end ) expr_385 ,
                        max( case dataFieldObjectId 
                            when 26001 then CAST(booleanValue AS TINYINT) 
                        end ) expr_386 ,
                        max( case dataFieldObjectId 
                            when 26009 then CAST(booleanValue AS TINYINT) 
                        end ) expr_387 ,
                        max( case dataFieldObjectId 
                            when 26002 then CAST(booleanValue AS TINYINT) 
                        end ) expr_388 ,
                        max( case dataFieldObjectId 
                            when 26003 then CAST(booleanValue AS TINYINT) 
                        end ) expr_389 ,
                        max( case dataFieldObjectId 
                            when 26004 then CAST(booleanValue AS TINYINT) 
                        end ) expr_390 ,
                        max( case dataFieldObjectId 
                            when 26011 then CAST(booleanValue AS TINYINT) 
                        end ) expr_391 ,
                        max( case dataFieldObjectId 
                            when 26005 then CAST(booleanValue AS TINYINT) 
                        end ) expr_392 ,
                        max( case dataFieldObjectId 
                            when 25985 then CAST(booleanValue AS TINYINT) 
                        end ) expr_393 ,
                        max( case dataFieldObjectId 
                            when 25986 then CAST(booleanValue AS TINYINT) 
                        end ) expr_394 ,
                        max( case dataFieldObjectId 
                            when 25987 then CAST(booleanValue AS TINYINT) 
                        end ) expr_395 ,
                        max( case dataFieldObjectId 
                            when 25988 then CAST(booleanValue AS TINYINT) 
                        end ) expr_396 ,
                        max( case dataFieldObjectId 
                            when 25989 then CAST(booleanValue AS TINYINT) 
                        end ) expr_397 ,
                        max( case dataFieldObjectId 
                            when 25990 then CAST(booleanValue AS TINYINT) 
                        end ) expr_398 ,
                        max( case dataFieldObjectId 
                            when 26736 then CAST(booleanValue AS TINYINT) 
                        end ) expr_399 ,
                        max( case dataFieldObjectId 
                            when 26031 then CAST(booleanValue AS TINYINT) 
                        end ) expr_400 ,
                        max( case dataFieldObjectId 
                            when 26032 then CAST(booleanValue AS TINYINT) 
                        end ) expr_401 ,
                        max( case dataFieldObjectId 
                            when 26033 then CAST(booleanValue AS TINYINT) 
                        end ) expr_402 ,
                        max( case dataFieldObjectId 
                            when 26034 then CAST(booleanValue AS TINYINT) 
                        end ) expr_403 ,
                        max( case dataFieldObjectId 
                            when 26035 then CAST(booleanValue AS TINYINT) 
                        end ) expr_404 ,
                        max( case dataFieldObjectId 
                            when 26036 then CAST(booleanValue AS TINYINT) 
                        end ) expr_405 ,
                        max( case dataFieldObjectId 
                            when 26037 then CAST(booleanValue AS TINYINT) 
                        end ) expr_406 ,
                        max( case dataFieldObjectId 
                            when 26038 then CAST(booleanValue AS TINYINT) 
                        end ) expr_407 ,
                        max( case dataFieldObjectId 
                            when 26039 then CAST(booleanValue AS TINYINT) 
                        end ) expr_408 ,
                        max( case dataFieldObjectId 
                            when 26040 then CAST(booleanValue AS TINYINT) 
                        end ) expr_409 ,
                        max( case dataFieldObjectId 
                            when 26041 then CAST(booleanValue AS TINYINT) 
                        end ) expr_410 ,
                        max( case dataFieldObjectId 
                            when 26042 then CAST(booleanValue AS TINYINT) 
                        end ) expr_411 ,
                        max( case dataFieldObjectId 
                            when 26043 then CAST(booleanValue AS TINYINT) 
                        end ) expr_412 ,
                        max( case dataFieldObjectId 
                            when 26044 then CAST(booleanValue AS TINYINT) 
                        end ) expr_413 ,
                        max( case dataFieldObjectId 
                            when 26045 then CAST(booleanValue AS TINYINT) 
                        end ) expr_414 ,
                        max( case dataFieldObjectId 
                            when 26046 then CAST(booleanValue AS TINYINT) 
                        end ) expr_415 ,
                        max( case dataFieldObjectId 
                            when 26047 then CAST(booleanValue AS TINYINT) 
                        end ) expr_416 ,
                        max( case dataFieldObjectId 
                            when 26054 then CAST(booleanValue AS TINYINT) 
                        end ) expr_417 ,
                        max( case dataFieldObjectId 
                            when 26055 then CAST(booleanValue AS TINYINT) 
                        end ) expr_418 ,
                        max( case dataFieldObjectId 
                            when 26056 then CAST(booleanValue AS TINYINT) 
                        end ) expr_419 ,
                        max( case dataFieldObjectId 
                            when 26057 then CAST(booleanValue AS TINYINT) 
                        end ) expr_420 ,
                        max( case dataFieldObjectId 
                            when 26058 then CAST(booleanValue AS TINYINT) 
                        end ) expr_421 ,
                        max( case dataFieldObjectId 
                            when 26059 then CAST(booleanValue AS TINYINT) 
                        end ) expr_422 ,
                        max( case dataFieldObjectId 
                            when 26060 then CAST(booleanValue AS TINYINT) 
                        end ) expr_423 ,
                        max( case dataFieldObjectId 
                            when 26061 then CAST(booleanValue AS TINYINT) 
                        end ) expr_424 ,
                        max( case dataFieldObjectId 
                            when 26069 then CAST(booleanValue AS TINYINT) 
                        end ) expr_425 ,
                        max( case dataFieldObjectId 
                            when 26071 then CAST(booleanValue AS TINYINT) 
                        end ) expr_426 ,
                        max( case dataFieldObjectId 
                            when 26590 then CAST(booleanValue AS TINYINT) 
                        end ) expr_427 ,
                        max( case dataFieldObjectId 
                            when 26073 then CAST(booleanValue AS TINYINT) 
                        end ) expr_428 ,
                        max( case dataFieldObjectId 
                            when 26075 then CAST(booleanValue AS TINYINT) 
                        end ) expr_429 ,
                        max( case dataFieldObjectId 
                            when 26076 then CAST(booleanValue AS TINYINT) 
                        end ) expr_430 ,
                        max( case dataFieldObjectId 
                            when 26077 then CAST(booleanValue AS TINYINT) 
                        end ) expr_431 ,
                        max( case dataFieldObjectId 
                            when 26025 then CAST(booleanValue AS TINYINT) 
                        end ) expr_432 ,
                        max( case dataFieldObjectId 
                            when 26026 then CAST(booleanValue AS TINYINT) 
                        end ) expr_433 ,
                        max( case dataFieldObjectId 
                            when 26027 then CAST(booleanValue AS TINYINT) 
                        end ) expr_434 ,
                        max( case dataFieldObjectId 
                            when 26028 then CAST(booleanValue AS TINYINT) 
                        end ) expr_435 ,
                        max( case dataFieldObjectId 
                            when 26487 then CAST(booleanValue AS TINYINT) 
                        end ) expr_436 ,
                        max( case dataFieldObjectId 
                            when 26029 then CAST(booleanValue AS TINYINT) 
                        end ) expr_437 ,
                        max( case dataFieldObjectId 
                            when 26030 then CAST(booleanValue AS TINYINT) 
                        end ) expr_438 ,
                        max( case dataFieldObjectId 
                            when 26482 then CAST(booleanValue AS TINYINT) 
                        end ) expr_439 ,
                        max( case dataFieldObjectId 
                            when 26022 then CAST(booleanValue AS TINYINT) 
                        end ) expr_440 ,
                        max( case dataFieldObjectId 
                            when 26015 then CAST(booleanValue AS TINYINT) 
                        end ) expr_441 ,
                        max( case dataFieldObjectId 
                            when 26016 then CAST(booleanValue AS TINYINT) 
                        end ) expr_442 ,
                        max( case dataFieldObjectId 
                            when 26017 then CAST(booleanValue AS TINYINT) 
                        end ) expr_443 ,
                        max( case dataFieldObjectId 
                            when 26018 then CAST(booleanValue AS TINYINT) 
                        end ) expr_444 ,
                        max( case dataFieldObjectId 
                            when 26019 then CAST(booleanValue AS TINYINT) 
                        end ) expr_445 ,
                        max( case dataFieldObjectId 
                            when 26020 then CAST(booleanValue AS TINYINT) 
                        end ) expr_446 ,
                        max( case dataFieldObjectId 
                            when 26021 then CAST(booleanValue AS TINYINT) 
                        end ) expr_447 ,
                        max( case dataFieldObjectId 
                            when 26023 then CAST(booleanValue AS TINYINT) 
                        end ) expr_448 ,
                        max( case dataFieldObjectId 
                            when 26024 then CAST(booleanValue AS TINYINT) 
                        end ) expr_449 ,
                        max( case dataFieldObjectId 
                            when 26062 then CAST(booleanValue AS TINYINT) 
                        end ) expr_450 ,
                        max( case dataFieldObjectId 
                            when 26070 then CAST(booleanValue AS TINYINT) 
                        end ) expr_451 ,
                        max( case dataFieldObjectId 
                            when 26063 then CAST(booleanValue AS TINYINT) 
                        end ) expr_452 ,
                        max( case dataFieldObjectId 
                            when 26064 then CAST(booleanValue AS TINYINT) 
                        end ) expr_453 ,
                        max( case dataFieldObjectId 
                            when 26072 then CAST(booleanValue AS TINYINT) 
                        end ) expr_454 ,
                        max( case dataFieldObjectId 
                            when 26065 then CAST(booleanValue AS TINYINT) 
                        end ) expr_455 ,
                        max( case dataFieldObjectId 
                            when 26066 then CAST(booleanValue AS TINYINT) 
                        end ) expr_456 ,
                        max( case dataFieldObjectId 
                            when 26067 then CAST(booleanValue AS TINYINT) 
                        end ) expr_457 ,
                        max( case dataFieldObjectId 
                            when 26074 then CAST(booleanValue AS TINYINT) 
                        end ) expr_458 ,
                        max( case dataFieldObjectId 
                            when 26068 then CAST(booleanValue AS TINYINT) 
                        end ) expr_459 ,
                        max( case dataFieldObjectId 
                            when 26048 then CAST(booleanValue AS TINYINT) 
                        end ) expr_460 ,
                        max( case dataFieldObjectId 
                            when 26049 then CAST(booleanValue AS TINYINT) 
                        end ) expr_461 ,
                        max( case dataFieldObjectId 
                            when 26050 then CAST(booleanValue AS TINYINT) 
                        end ) expr_462 ,
                        max( case dataFieldObjectId 
                            when 26051 then CAST(booleanValue AS TINYINT) 
                        end ) expr_463 ,
                        max( case dataFieldObjectId 
                            when 26052 then CAST(booleanValue AS TINYINT) 
                        end ) expr_464 ,
                        max( case dataFieldObjectId 
                            when 26053 then CAST(booleanValue AS TINYINT) 
                        end ) expr_465 ,
                        max( case dataFieldObjectId 
                            when 26737 then CAST(booleanValue AS TINYINT) 
                        end ) expr_466 ,
                        max( case dataFieldObjectId 
                            when 26377 then CAST(booleanValue AS TINYINT) 
                        end ) expr_467 ,
                        max( case dataFieldObjectId 
                            when 26378 then CAST(booleanValue AS TINYINT) 
                        end ) expr_468 ,
                        max( case dataFieldObjectId 
                            when 26379 then CAST(booleanValue AS TINYINT) 
                        end ) expr_469 ,
                        max( case dataFieldObjectId 
                            when 26380 then CAST(booleanValue AS TINYINT) 
                        end ) expr_470 ,
                        max( case dataFieldObjectId 
                            when 26381 then CAST(booleanValue AS TINYINT) 
                        end ) expr_471 ,
                        max( case dataFieldObjectId 
                            when 26616 then CAST(booleanValue AS TINYINT) 
                        end ) expr_472 ,
                        max( case dataFieldObjectId 
                            when 26305 then CAST(booleanValue AS TINYINT) 
                        end ) expr_473 ,
                        max( case dataFieldObjectId 
                            when 26306 then CAST(booleanValue AS TINYINT) 
                        end ) expr_474 ,
                        max( case dataFieldObjectId 
                            when 26307 then CAST(booleanValue AS TINYINT) 
                        end ) expr_475 ,
                        max( case dataFieldObjectId 
                            when 26267 then CAST(booleanValue AS TINYINT) 
                        end ) expr_476 ,
                        max( case dataFieldObjectId 
                            when 26268 then CAST(booleanValue AS TINYINT) 
                        end ) expr_477 ,
                        max( case dataFieldObjectId 
                            when 26269 then CAST(booleanValue AS TINYINT) 
                        end ) expr_478 ,
                        max( case dataFieldObjectId 
                            when 26270 then CAST(booleanValue AS TINYINT) 
                        end ) expr_479 ,
                        max( case dataFieldObjectId 
                            when 26271 then CAST(booleanValue AS TINYINT) 
                        end ) expr_480 ,
                        max( case dataFieldObjectId 
                            when 26272 then CAST(booleanValue AS TINYINT) 
                        end ) expr_481 ,
                        max( case dataFieldObjectId 
                            when 26273 then CAST(booleanValue AS TINYINT) 
                        end ) expr_482 ,
                        max( case dataFieldObjectId 
                            when 26285 then CAST(booleanValue AS TINYINT) 
                        end ) expr_483 ,
                        max( case dataFieldObjectId 
                            when 26286 then CAST(booleanValue AS TINYINT) 
                        end ) expr_484 ,
                        max( case dataFieldObjectId 
                            when 26287 then CAST(booleanValue AS TINYINT) 
                        end ) expr_485 ,
                        max( case dataFieldObjectId 
                            when 26288 then CAST(booleanValue AS TINYINT) 
                        end ) expr_486 ,
                        max( case dataFieldObjectId 
                            when 26289 then CAST(booleanValue AS TINYINT) 
                        end ) expr_487 ,
                        max( case dataFieldObjectId 
                            when 26290 then CAST(booleanValue AS TINYINT) 
                        end ) expr_488 ,
                        max( case dataFieldObjectId 
                            when 26291 then CAST(booleanValue AS TINYINT) 
                        end ) expr_489 ,
                        max( case dataFieldObjectId 
                            when 26559 then CAST(booleanValue AS TINYINT) 
                        end ) expr_490 ,
                        max( case dataFieldObjectId 
                            when 26560 then CAST(booleanValue AS TINYINT) 
                        end ) expr_491 ,
                        max( case dataFieldObjectId 
                            when 26308 then CAST(booleanValue AS TINYINT) 
                        end ) expr_492 ,
                        max( case dataFieldObjectId 
                            when 26309 then CAST(booleanValue AS TINYINT) 
                        end ) expr_493 ,
                        max( case dataFieldObjectId 
                            when 26310 then CAST(booleanValue AS TINYINT) 
                        end ) expr_494 ,
                        max( case dataFieldObjectId 
                            when 26311 then CAST(booleanValue AS TINYINT) 
                        end ) expr_495 ,
                        max( case dataFieldObjectId 
                            when 26312 then CAST(booleanValue AS TINYINT) 
                        end ) expr_496 ,
                        max( case dataFieldObjectId 
                            when 26313 then CAST(booleanValue AS TINYINT) 
                        end ) expr_497 ,
                        max( case dataFieldObjectId 
                            when 26274 then CAST(booleanValue AS TINYINT) 
                        end ) expr_498 ,
                        max( case dataFieldObjectId 
                            when 26275 then CAST(booleanValue AS TINYINT) 
                        end ) expr_499 ,
                        max( case dataFieldObjectId 
                            when 26276 then CAST(booleanValue AS TINYINT) 
                        end ) expr_500 ,
                        max( case dataFieldObjectId 
                            when 26277 then CAST(booleanValue AS TINYINT) 
                        end ) expr_501 ,
                        max( case dataFieldObjectId 
                            when 26278 then CAST(booleanValue AS TINYINT) 
                        end ) expr_502 ,
                        max( case dataFieldObjectId 
                            when 26279 then CAST(booleanValue AS TINYINT) 
                        end ) expr_503 ,
                        max( case dataFieldObjectId 
                            when 26280 then CAST(booleanValue AS TINYINT) 
                        end ) expr_504 ,
                        max( case dataFieldObjectId 
                            when 26281 then CAST(booleanValue AS TINYINT) 
                        end ) expr_505 ,
                        max( case dataFieldObjectId 
                            when 26282 then CAST(booleanValue AS TINYINT) 
                        end ) expr_506 ,
                        max( case dataFieldObjectId 
                            when 26283 then CAST(booleanValue AS TINYINT) 
                        end ) expr_507 ,
                        max( case dataFieldObjectId 
                            when 26284 then CAST(booleanValue AS TINYINT) 
                        end ) expr_508 ,
                        max( case dataFieldObjectId 
                            when 26314 then CAST(booleanValue AS TINYINT) 
                        end ) expr_509 ,
                        max( case dataFieldObjectId 
                            when 26315 then CAST(booleanValue AS TINYINT) 
                        end ) expr_510 ,
                        max( case dataFieldObjectId 
                            when 26316 then CAST(booleanValue AS TINYINT) 
                        end ) expr_511 ,
                        max( case dataFieldObjectId 
                            when 26317 then CAST(booleanValue AS TINYINT) 
                        end ) expr_512 ,
                        max( case dataFieldObjectId 
                            when 26318 then CAST(booleanValue AS TINYINT) 
                        end ) expr_513 ,
                        max( case dataFieldObjectId 
                            when 26296 then CAST(booleanValue AS TINYINT) 
                        end ) expr_514 ,
                        max( case dataFieldObjectId 
                            when 26297 then CAST(booleanValue AS TINYINT) 
                        end ) expr_515 ,
                        max( case dataFieldObjectId 
                            when 26298 then CAST(booleanValue AS TINYINT) 
                        end ) expr_516 ,
                        max( case dataFieldObjectId 
                            when 26299 then CAST(booleanValue AS TINYINT) 
                        end ) expr_517 ,
                        max( case dataFieldObjectId 
                            when 26593 then CAST(booleanValue AS TINYINT) 
                        end ) expr_518 ,
                        max( case dataFieldObjectId 
                            when 26594 then CAST(booleanValue AS TINYINT) 
                        end ) expr_519 ,
                        max( case dataFieldObjectId 
                            when 26595 then CAST(booleanValue AS TINYINT) 
                        end ) expr_520 ,
                        max( case dataFieldObjectId 
                            when 26604 then CAST(booleanValue AS TINYINT) 
                        end ) expr_521 ,
                        max( case dataFieldObjectId 
                            when 26605 then CAST(booleanValue AS TINYINT) 
                        end ) expr_522 ,
                        max( case dataFieldObjectId 
                            when 26606 then CAST(booleanValue AS TINYINT) 
                        end ) expr_523 ,
                        max( case dataFieldObjectId 
                            when 26607 then CAST(booleanValue AS TINYINT) 
                        end ) expr_524 ,
                        max( case dataFieldObjectId 
                            when 26608 then CAST(booleanValue AS TINYINT) 
                        end ) expr_525 ,
                        max( case dataFieldObjectId 
                            when 26609 then CAST(booleanValue AS TINYINT) 
                        end ) expr_526 ,
                        max( case dataFieldObjectId 
                            when 26292 then CAST(booleanValue AS TINYINT) 
                        end ) expr_527 ,
                        max( case dataFieldObjectId 
                            when 26293 then CAST(booleanValue AS TINYINT) 
                        end ) expr_528 ,
                        max( case dataFieldObjectId 
                            when 26294 then CAST(booleanValue AS TINYINT) 
                        end ) expr_529 ,
                        max( case dataFieldObjectId 
                            when 26295 then CAST(booleanValue AS TINYINT) 
                        end ) expr_530 ,
                        max( case dataFieldObjectId 
                            when 26300 then CAST(booleanValue AS TINYINT) 
                        end ) expr_531 ,
                        max( case dataFieldObjectId 
                            when 26301 then CAST(booleanValue AS TINYINT) 
                        end ) expr_532 ,
                        max( case dataFieldObjectId 
                            when 26302 then CAST(booleanValue AS TINYINT) 
                        end ) expr_533 ,
                        max( case dataFieldObjectId 
                            when 26303 then CAST(booleanValue AS TINYINT) 
                        end ) expr_534 ,
                        max( case dataFieldObjectId 
                            when 26304 then CAST(booleanValue AS TINYINT) 
                        end ) expr_535 ,
                        max( case dataFieldObjectId 
                            when 26362 then CAST(booleanValue AS TINYINT) 
                        end ) expr_536 ,
                        max( case dataFieldObjectId 
                            when 26363 then CAST(booleanValue AS TINYINT) 
                        end ) expr_537 ,
                        max( case dataFieldObjectId 
                            when 26364 then CAST(booleanValue AS TINYINT) 
                        end ) expr_538 ,
                        max( case dataFieldObjectId 
                            when 26365 then CAST(booleanValue AS TINYINT) 
                        end ) expr_539 ,
                        max( case dataFieldObjectId 
                            when 26601 then CAST(booleanValue AS TINYINT) 
                        end ) expr_540 ,
                        max( case dataFieldObjectId 
                            when 26602 then CAST(booleanValue AS TINYINT) 
                        end ) expr_541 ,
                        max( case dataFieldObjectId 
                            when 26603 then CAST(booleanValue AS TINYINT) 
                        end ) expr_542 ,
                        max( case dataFieldObjectId 
                            when 26354 then CAST(booleanValue AS TINYINT) 
                        end ) expr_543 ,
                        max( case dataFieldObjectId 
                            when 26355 then CAST(booleanValue AS TINYINT) 
                        end ) expr_544 ,
                        max( case dataFieldObjectId 
                            when 26356 then CAST(booleanValue AS TINYINT) 
                        end ) expr_545 ,
                        max( case dataFieldObjectId 
                            when 26357 then CAST(booleanValue AS TINYINT) 
                        end ) expr_546 ,
                        max( case dataFieldObjectId 
                            when 26358 then CAST(booleanValue AS TINYINT) 
                        end ) expr_547 ,
                        max( case dataFieldObjectId 
                            when 26359 then CAST(booleanValue AS TINYINT) 
                        end ) expr_548 ,
                        max( case dataFieldObjectId 
                            when 26360 then CAST(booleanValue AS TINYINT) 
                        end ) expr_549 ,
                        max( case dataFieldObjectId 
                            when 26361 then CAST(booleanValue AS TINYINT) 
                        end ) expr_550 ,
                        max( case dataFieldObjectId 
                            when 26371 then CAST(booleanValue AS TINYINT) 
                        end ) expr_551 ,
                        max( case dataFieldObjectId 
                            when 26372 then CAST(booleanValue AS TINYINT) 
                        end ) expr_552 ,
                        max( case dataFieldObjectId 
                            when 26373 then CAST(booleanValue AS TINYINT) 
                        end ) expr_553 ,
                        max( case dataFieldObjectId 
                            when 26374 then CAST(booleanValue AS TINYINT) 
                        end ) expr_554 ,
                        max( case dataFieldObjectId 
                            when 26375 then CAST(booleanValue AS TINYINT) 
                        end ) expr_555 ,
                        max( case dataFieldObjectId 
                            when 26617 then CAST(booleanValue AS TINYINT) 
                        end ) expr_556 ,
                        max( case dataFieldObjectId 
                            when 26376 then CAST(booleanValue AS TINYINT) 
                        end ) expr_557 ,
                        max( case dataFieldObjectId 
                            when 26404 then CAST(booleanValue AS TINYINT) 
                        end ) expr_558 ,
                        max( case dataFieldObjectId 
                            when 26403 then CAST(booleanValue AS TINYINT) 
                        end ) expr_559 ,
                        max( case dataFieldObjectId 
                            when 26610 then CAST(booleanValue AS TINYINT) 
                        end ) expr_560 ,
                        max( case dataFieldObjectId 
                            when 26577 then CAST(booleanValue AS TINYINT) 
                        end ) expr_561 ,
                        max( case dataFieldObjectId 
                            when 25885 then CAST(booleanValue AS TINYINT) 
                        end ) expr_562 ,
                        max( case dataFieldObjectId 
                            when 25886 then CAST(booleanValue AS TINYINT) 
                        end ) expr_563 ,
                        max( case dataFieldObjectId 
                            when 25887 then CAST(booleanValue AS TINYINT) 
                        end ) expr_564 ,
                        max( case dataFieldObjectId 
                            when 25888 then CAST(booleanValue AS TINYINT) 
                        end ) expr_565 ,
                        max( case dataFieldObjectId 
                            when 25889 then CAST(booleanValue AS TINYINT) 
                        end ) expr_566 ,
                        max( case dataFieldObjectId 
                            when 25890 then CAST(booleanValue AS TINYINT) 
                        end ) expr_567 ,
                        max( case dataFieldObjectId 
                            when 25891 then CAST(booleanValue AS TINYINT) 
                        end ) expr_568 ,
                        max( case dataFieldObjectId 
                            when 25892 then CAST(booleanValue AS TINYINT) 
                        end ) expr_569 ,
                        max( case dataFieldObjectId 
                            when 25893 then CAST(booleanValue AS TINYINT) 
                        end ) expr_570 ,
                        max( case dataFieldObjectId 
                            when 25894 then CAST(booleanValue AS TINYINT) 
                        end ) expr_571 ,
                        max( case dataFieldObjectId 
                            when 25895 then CAST(booleanValue AS TINYINT) 
                        end ) expr_572 ,
                        max( case dataFieldObjectId 
                            when 25896 then CAST(booleanValue AS TINYINT) 
                        end ) expr_573 ,
                        max( case dataFieldObjectId 
                            when 25897 then CAST(booleanValue AS TINYINT) 
                        end ) expr_574 ,
                        max( case dataFieldObjectId 
                            when 25898 then CAST(booleanValue AS TINYINT) 
                        end ) expr_575 ,
                        max( case dataFieldObjectId 
                            when 25899 then CAST(booleanValue AS TINYINT) 
                        end ) expr_576 ,
                        max( case dataFieldObjectId 
                            when 25900 then CAST(booleanValue AS TINYINT) 
                        end ) expr_577 ,
                        max( case dataFieldObjectId 
                            when 25901 then CAST(booleanValue AS TINYINT) 
                        end ) expr_578 ,
                        max( case dataFieldObjectId 
                            when 25908 then CAST(booleanValue AS TINYINT) 
                        end ) expr_579 ,
                        max( case dataFieldObjectId 
                            when 25909 then CAST(booleanValue AS TINYINT) 
                        end ) expr_580 ,
                        max( case dataFieldObjectId 
                            when 25910 then CAST(booleanValue AS TINYINT) 
                        end ) expr_581 ,
                        max( case dataFieldObjectId 
                            when 25911 then CAST(booleanValue AS TINYINT) 
                        end ) expr_582 ,
                        max( case dataFieldObjectId 
                            when 25912 then CAST(booleanValue AS TINYINT) 
                        end ) expr_583 ,
                        max( case dataFieldObjectId 
                            when 25913 then CAST(booleanValue AS TINYINT) 
                        end ) expr_584 ,
                        max( case dataFieldObjectId 
                            when 25914 then CAST(booleanValue AS TINYINT) 
                        end ) expr_585 ,
                        max( case dataFieldObjectId 
                            when 25915 then CAST(booleanValue AS TINYINT) 
                        end ) expr_586 ,
                        max( case dataFieldObjectId 
                            when 25923 then CAST(booleanValue AS TINYINT) 
                        end ) expr_587 ,
                        max( case dataFieldObjectId 
                            when 25925 then CAST(booleanValue AS TINYINT) 
                        end ) expr_588 ,
                        max( case dataFieldObjectId 
                            when 26591 then CAST(booleanValue AS TINYINT) 
                        end ) expr_589 ,
                        max( case dataFieldObjectId 
                            when 25927 then CAST(booleanValue AS TINYINT) 
                        end ) expr_590 ,
                        max( case dataFieldObjectId 
                            when 25929 then CAST(booleanValue AS TINYINT) 
                        end ) expr_591 ,
                        max( case dataFieldObjectId 
                            when 25930 then CAST(booleanValue AS TINYINT) 
                        end ) expr_592 ,
                        max( case dataFieldObjectId 
                            when 25931 then CAST(booleanValue AS TINYINT) 
                        end ) expr_593 ,
                        max( case dataFieldObjectId 
                            when 25879 then CAST(booleanValue AS TINYINT) 
                        end ) expr_594 ,
                        max( case dataFieldObjectId 
                            when 25880 then CAST(booleanValue AS TINYINT) 
                        end ) expr_595 ,
                        max( case dataFieldObjectId 
                            when 25881 then CAST(booleanValue AS TINYINT) 
                        end ) expr_596 ,
                        max( case dataFieldObjectId 
                            when 25882 then CAST(booleanValue AS TINYINT) 
                        end ) expr_597 ,
                        max( case dataFieldObjectId 
                            when 25883 then CAST(booleanValue AS TINYINT) 
                        end ) expr_598 ,
                        max( case dataFieldObjectId 
                            when 25884 then CAST(booleanValue AS TINYINT) 
                        end ) expr_599 ,
                        max( case dataFieldObjectId 
                            when 25860 then CAST(booleanValue AS TINYINT) 
                        end ) expr_600 ,
                        max( case dataFieldObjectId 
                            when 25861 then CAST(booleanValue AS TINYINT) 
                        end ) expr_601 ,
                        max( case dataFieldObjectId 
                            when 25862 then CAST(booleanValue AS TINYINT) 
                        end ) expr_602 ,
                        max( case dataFieldObjectId 
                            when 25863 then CAST(booleanValue AS TINYINT) 
                        end ) expr_603 ,
                        max( case dataFieldObjectId 
                            when 25864 then CAST(booleanValue AS TINYINT) 
                        end ) expr_604 ,
                        max( case dataFieldObjectId 
                            when 25865 then CAST(booleanValue AS TINYINT) 
                        end ) expr_605 ,
                        max( case dataFieldObjectId 
                            when 25866 then CAST(booleanValue AS TINYINT) 
                        end ) expr_606 ,
                        max( case dataFieldObjectId 
                            when 25867 then CAST(booleanValue AS TINYINT) 
                        end ) expr_607 ,
                        max( case dataFieldObjectId 
                            when 25868 then CAST(booleanValue AS TINYINT) 
                        end ) expr_608 ,
                        max( case dataFieldObjectId 
                            when 25869 then CAST(booleanValue AS TINYINT) 
                        end ) expr_609 ,
                        max( case dataFieldObjectId 
                            when 25870 then CAST(booleanValue AS TINYINT) 
                        end ) expr_610 ,
                        max( case dataFieldObjectId 
                            when 25871 then CAST(booleanValue AS TINYINT) 
                        end ) expr_611 ,
                        max( case dataFieldObjectId 
                            when 25872 then CAST(booleanValue AS TINYINT) 
                        end ) expr_612 ,
                        max( case dataFieldObjectId 
                            when 25873 then CAST(booleanValue AS TINYINT) 
                        end ) expr_613 ,
                        max( case dataFieldObjectId 
                            when 25874 then CAST(booleanValue AS TINYINT) 
                        end ) expr_614 ,
                        max( case dataFieldObjectId 
                            when 25875 then CAST(booleanValue AS TINYINT) 
                        end ) expr_615 ,
                        max( case dataFieldObjectId 
                            when 25876 then CAST(booleanValue AS TINYINT) 
                        end ) expr_616 ,
                        max( case dataFieldObjectId 
                            when 25877 then CAST(booleanValue AS TINYINT) 
                        end ) expr_617 ,
                        max( case dataFieldObjectId 
                            when 25878 then CAST(booleanValue AS TINYINT) 
                        end ) expr_618 ,
                        max( case dataFieldObjectId 
                            when 25916 then CAST(booleanValue AS TINYINT) 
                        end ) expr_619 ,
                        max( case dataFieldObjectId 
                            when 25924 then CAST(booleanValue AS TINYINT) 
                        end ) expr_620 ,
                        max( case dataFieldObjectId 
                            when 25917 then CAST(booleanValue AS TINYINT) 
                        end ) expr_621 ,
                        max( case dataFieldObjectId 
                            when 25918 then CAST(booleanValue AS TINYINT) 
                        end ) expr_622 ,
                        max( case dataFieldObjectId 
                            when 25926 then CAST(booleanValue AS TINYINT) 
                        end ) expr_623 ,
                        max( case dataFieldObjectId 
                            when 25919 then CAST(booleanValue AS TINYINT) 
                        end ) expr_624 ,
                        max( case dataFieldObjectId 
                            when 25920 then CAST(booleanValue AS TINYINT) 
                        end ) expr_625 ,
                        max( case dataFieldObjectId 
                            when 25921 then CAST(booleanValue AS TINYINT) 
                        end ) expr_626 ,
                        max( case dataFieldObjectId 
                            when 25928 then CAST(booleanValue AS TINYINT) 
                        end ) expr_627 ,
                        max( case dataFieldObjectId 
                            when 25922 then CAST(booleanValue AS TINYINT) 
                        end ) expr_628 ,
                        max( case dataFieldObjectId 
                            when 25902 then CAST(booleanValue AS TINYINT) 
                        end ) expr_629 ,
                        max( case dataFieldObjectId 
                            when 25903 then CAST(booleanValue AS TINYINT) 
                        end ) expr_630 ,
                        max( case dataFieldObjectId 
                            when 25904 then CAST(booleanValue AS TINYINT) 
                        end ) expr_631 ,
                        max( case dataFieldObjectId 
                            when 25905 then CAST(booleanValue AS TINYINT) 
                        end ) expr_632 ,
                        max( case dataFieldObjectId 
                            when 25906 then CAST(booleanValue AS TINYINT) 
                        end ) expr_633 ,
                        max( case dataFieldObjectId 
                            when 25907 then CAST(booleanValue AS TINYINT) 
                        end ) expr_634,
                        max( case dataFieldObjectId 
                            when 25792 then dataFieldOptionObjectId 
                        end ) expr_670,
                        max( case dataFieldObjectId 
                            when 27045 then dataFieldOptionObjectId 
                        end ) expr_671,
                        max( case dataFieldObjectId 
                            when 26958 then dataFieldOptionObjectId 
                        end ) expr_672,
                        max( case dataFieldObjectId 
                            when 26959 then dataFieldOptionObjectId 
                        end ) expr_673,
                        max( case dataFieldObjectId 
                            when 26971 then dataFieldOptionObjectId 
                        end ) expr_674,
                        max( case dataFieldObjectId 
                            when 26970 then dataFieldOptionObjectId 
                        end ) expr_675,
                        max( case dataFieldObjectId 
                            when 26972 then dataFieldOptionObjectId 
                        end ) expr_676,
                        max( case dataFieldObjectId 
                            when 26973 then dataFieldOptionObjectId 
                        end ) expr_677,
                        max( case dataFieldObjectId 
                            when 26974 then dataFieldOptionObjectId 
                        end ) expr_678,
                        max( case dataFieldObjectId 
                            when 26975 then dataFieldOptionObjectId 
                        end ) expr_679,
                        max( case dataFieldObjectId 
                            when 26976 then dataFieldOptionObjectId 
                        end ) expr_680,
                        max( case dataFieldObjectId 
                            when 26977 then dataFieldOptionObjectId 
                        end ) expr_681,
                        max( case dataFieldObjectId 
                            when 26978 then dataFieldOptionObjectId 
                        end ) expr_682,
                        max( case dataFieldObjectId 
                            when 26979 then dataFieldOptionObjectId 
                        end ) expr_683,
                        max( case dataFieldObjectId 
                            when 26980 then dataFieldOptionObjectId 
                        end ) expr_684,
                        max( case dataFieldObjectId 
                            when 26981 then dataFieldOptionObjectId 
                        end ) expr_685,
                        max( case dataFieldObjectId 
                            when 27085 then c.objectid
                        end ) expr_686,
                        max( case dataFieldObjectId 
                            when 25785 then dataFieldOptionObjectId 
                        end ) expr_687,
                        max( case dataFieldObjectId 
                            when 26480 then textvalue
                        end ) expr_688,
                        max( case dataFieldObjectId 
                            when 25802 then dataFieldOptionObjectId 
                        end ) expr_689,
                        max( case dataFieldObjectId when 25803 then dataFieldOptionObjectId end ) expr_690,
                        
						max(case dataFieldObjectid when  27226 then CAST(booleanValue AS TINYINT) end ) expr_27226,
						max(case dataFieldObjectid when  27227 then CAST(booleanValue AS TINYINT) end ) expr_27227,
						max(case dataFieldObjectid when  27228 then CAST(booleanValue AS TINYINT) end ) expr_27228,
						max(case dataFieldObjectid when  27229 then CAST(booleanValue AS TINYINT) end ) expr_27229,
						max(case dataFieldObjectid when  27230 then CAST(booleanValue AS TINYINT) end ) expr_27230,
						max(case dataFieldObjectid when  27231 then CAST(booleanValue AS TINYINT) end ) expr_27231,
						max(case dataFieldObjectid when  27232 then CAST(booleanValue AS TINYINT) end ) expr_27232,
						max(case dataFieldObjectid when  27233 then CAST(booleanValue AS TINYINT) end ) expr_27233,
						max(case dataFieldObjectid when  27234 then CAST(booleanValue AS TINYINT) end ) expr_27234,
						max(case dataFieldObjectid when  27235 then CAST(booleanValue AS TINYINT) end ) expr_27235,
						max(case dataFieldObjectid when  27236 then CAST(booleanValue AS TINYINT) end ) expr_27236,
						max(case dataFieldObjectid when  27237 then CAST(booleanValue AS TINYINT) end ) expr_27237,
						max(case dataFieldObjectid when  27238 then CAST(booleanValue AS TINYINT) end ) expr_27238,
						max(case dataFieldObjectid when  27239 then CAST(booleanValue AS TINYINT) end ) expr_27239,
						max(case dataFieldObjectid when  27240 then CAST(booleanValue AS TINYINT) end ) expr_27240,
						max(case dataFieldObjectid when  27241 then CAST(booleanValue AS TINYINT) end ) expr_27241,
						max(case dataFieldObjectid when  27242 then CAST(booleanValue AS TINYINT) end ) expr_27242,
						max(case dataFieldObjectid when  27243 then CAST(booleanValue AS TINYINT) end ) expr_27243,
						max(case dataFieldObjectid when  27244 then CAST(booleanValue AS TINYINT) end ) expr_27244,
						max(case dataFieldObjectid when  27245 then CAST(booleanValue AS TINYINT) end ) expr_27245,
						max(case dataFieldObjectid when  27246 then CAST(booleanValue AS TINYINT) end ) expr_27246,
						max(case dataFieldObjectid when  27247 then CAST(booleanValue AS TINYINT) end ) expr_27247,
						max(case dataFieldObjectid when  27248 then CAST(booleanValue AS TINYINT) end ) expr_27248,
						max(case dataFieldObjectid when  27249 then CAST(booleanValue AS TINYINT) end ) expr_27249,
						max(case dataFieldObjectid when  27250 then CAST(booleanValue AS TINYINT) end ) expr_27250,
						max(case dataFieldObjectid when  27251 then CAST(booleanValue AS TINYINT) end ) expr_27251,
						max(case dataFieldObjectid when  27252 then CAST(booleanValue AS TINYINT) end ) expr_27252,
						max(case dataFieldObjectid when  27253 then CAST(booleanValue AS TINYINT) end ) expr_27253,
						max(case dataFieldObjectid when  27254 then CAST(booleanValue AS TINYINT) end ) expr_27254,
						max(case dataFieldObjectid when  27255 then CAST(booleanValue AS TINYINT) end ) expr_27255,
						max(case dataFieldObjectid when  27256 then CAST(booleanValue AS TINYINT) end ) expr_27256,
						max(case dataFieldObjectid when  27257 then CAST(booleanValue AS TINYINT) end ) expr_27257,
						max(case dataFieldObjectid when  27258 then CAST(booleanValue AS TINYINT) end ) expr_27258,
						max(case dataFieldObjectid when  27259 then CAST(booleanValue AS TINYINT) end ) expr_27259,
						max(case dataFieldObjectid when  27260 then CAST(booleanValue AS TINYINT) end ) expr_27260,
						max(case dataFieldObjectid when  27261 then CAST(booleanValue AS TINYINT) end ) expr_27261,
						max(case dataFieldObjectid when  27262 then CAST(booleanValue AS TINYINT) end ) expr_27262,
						max(case dataFieldObjectid when  27263 then CAST(booleanValue AS TINYINT) end ) expr_27263,
						max(case dataFieldObjectid when  27264 then CAST(booleanValue AS TINYINT) end ) expr_27264,
						max(case dataFieldObjectid when  27265 then CAST(booleanValue AS TINYINT) end ) expr_27265,
						max(case dataFieldObjectid when  27266 then CAST(booleanValue AS TINYINT) end ) expr_27266,
						max(case dataFieldObjectid when  27267 then CAST(booleanValue AS TINYINT) end ) expr_27267,
						max(case dataFieldObjectid when  27268 then CAST(booleanValue AS TINYINT) end ) expr_27268,
						max(case dataFieldObjectid when  27269 then CAST(booleanValue AS TINYINT) end ) expr_27269,
						max(case dataFieldObjectid when  27270 then CAST(booleanValue AS TINYINT) end ) expr_27270,
						max(case dataFieldObjectid when  27271 then CAST(booleanValue AS TINYINT) end ) expr_27271,
						max(case dataFieldObjectid when  27272 then CAST(booleanValue AS TINYINT) end ) expr_27272,
						max(case dataFieldObjectid when  27273 then CAST(booleanValue AS TINYINT) end ) expr_27273,
						max(case dataFieldObjectid when  27274 then CAST(booleanValue AS TINYINT) end ) expr_27274,
						max(case dataFieldObjectid when  27275 then CAST(booleanValue AS TINYINT) end ) expr_27275,
						max(case dataFieldObjectid when  27276 then CAST(booleanValue AS TINYINT) end ) expr_27276,
						max(case dataFieldObjectid when  27277 then CAST(booleanValue AS TINYINT) end ) expr_27277,
						max(case dataFieldObjectid when  27278 then CAST(booleanValue AS TINYINT) end ) expr_27278,
						max(case dataFieldObjectid when  27279 then CAST(booleanValue AS TINYINT) end ) expr_27279,
						max(case dataFieldObjectid when  27280 then CAST(booleanValue AS TINYINT) end ) expr_27280,
						max(case dataFieldObjectid when  27281 then CAST(booleanValue AS TINYINT) end ) expr_27281,
						max(case dataFieldObjectid when  27282 then CAST(booleanValue AS TINYINT) end ) expr_27282,
						max(case dataFieldObjectid when  27283 then CAST(booleanValue AS TINYINT) end ) expr_27283,
						max(case dataFieldObjectid when  27284 then CAST(booleanValue AS TINYINT) end ) expr_27284,
						max(case dataFieldObjectid when  27285 then CAST(booleanValue AS TINYINT) end ) expr_27285,
						max(case dataFieldObjectid when  27286 then CAST(booleanValue AS TINYINT) end ) expr_27286,
						max(case dataFieldObjectid when  27287 then CAST(booleanValue AS TINYINT) end ) expr_27287,
						max(case dataFieldObjectid when  27288 then CAST(booleanValue AS TINYINT) end ) expr_27288,
						max(case dataFieldObjectid when  27289 then CAST(booleanValue AS TINYINT) end ) expr_27289,
						max(case dataFieldObjectid when  27290 then CAST(booleanValue AS TINYINT) end ) expr_27290,
						max(case dataFieldObjectid when  27291 then CAST(booleanValue AS TINYINT) end ) expr_27291,
						max(case dataFieldObjectid when  27292 then CAST(booleanValue AS TINYINT) end ) expr_27292,
						max(case dataFieldObjectid when  27293 then CAST(booleanValue AS TINYINT) end ) expr_27293,
						max(case dataFieldObjectid when  27294 then CAST(booleanValue AS TINYINT) end ) expr_27294,
						max(case dataFieldObjectid when  27295 then CAST(booleanValue AS TINYINT) end ) expr_27295,
						max(case dataFieldObjectid when  27296 then CAST(booleanValue AS TINYINT) end ) expr_27296,
						max(case dataFieldObjectid when  27297 then CAST(booleanValue AS TINYINT) end ) expr_27297,
						max(case dataFieldObjectid when  27298 then CAST(booleanValue AS TINYINT) end ) expr_27298,
						max(case dataFieldObjectid when  27299 then CAST(booleanValue AS TINYINT) end ) expr_27299,
						max(case dataFieldObjectid when  27300 then CAST(booleanValue AS TINYINT) end ) expr_27300,
						max(case dataFieldObjectid when  27301 then CAST(booleanValue AS TINYINT) end ) expr_27301,
						max(case dataFieldObjectid when  27302 then CAST(booleanValue AS TINYINT) end ) expr_27302,
						max(case dataFieldObjectid when  27303 then CAST(booleanValue AS TINYINT) end ) expr_27303,
						max(case dataFieldObjectid when  27304 then CAST(booleanValue AS TINYINT) end ) expr_27304,
						max(case dataFieldObjectid when  27305 then CAST(booleanValue AS TINYINT) end ) expr_27305,
						max(case dataFieldObjectid when  27306 then CAST(booleanValue AS TINYINT) end ) expr_27306,
						max(case dataFieldObjectid when  27307 then CAST(booleanValue AS TINYINT) end ) expr_27307,
						max(case dataFieldObjectid when  27308 then CAST(booleanValue AS TINYINT) end ) expr_27308,
						max(case dataFieldObjectid when  27309 then CAST(booleanValue AS TINYINT) end ) expr_27309,
						max(case dataFieldObjectid when  27310 then CAST(booleanValue AS TINYINT) end ) expr_27310,
						max(case dataFieldObjectid when  27311 then CAST(booleanValue AS TINYINT) end ) expr_27311,
						max(case dataFieldObjectid when  27312 then CAST(booleanValue AS TINYINT) end ) expr_27312,
						max(case dataFieldObjectid when  27313 then CAST(booleanValue AS TINYINT) end ) expr_27313,
						max(case dataFieldObjectid when  27314 then CAST(booleanValue AS TINYINT) end ) expr_27314,
						max(case dataFieldObjectid when  27315 then CAST(booleanValue AS TINYINT) end ) expr_27315,
						max(case dataFieldObjectid when  27316 then CAST(booleanValue AS TINYINT) end ) expr_27316,
						max(case dataFieldObjectid when  27317 then CAST(booleanValue AS TINYINT) end ) expr_27317,
						max(case dataFieldObjectid when  27318 then CAST(booleanValue AS TINYINT) end ) expr_27318,
						max(case dataFieldObjectid when  27319 then CAST(booleanValue AS TINYINT) end ) expr_27319,
						max(case dataFieldObjectid when  27320 then CAST(booleanValue AS TINYINT) end ) expr_27320,
						max(case dataFieldObjectid when  27321 then CAST(booleanValue AS TINYINT) end ) expr_27321,
						max(case dataFieldObjectid when  27322 then CAST(booleanValue AS TINYINT) end ) expr_27322,
						max(case dataFieldObjectid when  27323 then CAST(booleanValue AS TINYINT) end ) expr_27323,
						max(case dataFieldObjectid when  27324 then CAST(booleanValue AS TINYINT) end ) expr_27324,
						max(case dataFieldObjectid when  27325 then CAST(booleanValue AS TINYINT) end ) expr_27325,
						max(case dataFieldObjectid when  27326 then CAST(booleanValue AS TINYINT) end ) expr_27326,
						max(case dataFieldObjectid when  27327 then CAST(booleanValue AS TINYINT) end ) expr_27327,
						max(case dataFieldObjectid when  27328 then CAST(booleanValue AS TINYINT) end ) expr_27328,
						max(case dataFieldObjectid when  27329 then CAST(booleanValue AS TINYINT) end ) expr_27329,
						max(case dataFieldObjectid when  27330 then CAST(booleanValue AS TINYINT) end ) expr_27330,
						max(case dataFieldObjectid when  27331 then CAST(booleanValue AS TINYINT) end ) expr_27331,
						max(case dataFieldObjectid when  27332 then CAST(booleanValue AS TINYINT) end ) expr_27332,
						max(case dataFieldObjectid when  27333 then CAST(booleanValue AS TINYINT) end ) expr_27333,
						max(case dataFieldObjectid when  27334 then CAST(booleanValue AS TINYINT) end ) expr_27334,
						max(case dataFieldObjectid when  27335 then CAST(booleanValue AS TINYINT) end ) expr_27335,
						max(case dataFieldObjectid when  27336 then CAST(booleanValue AS TINYINT) end ) expr_27336,
						max(case dataFieldObjectid when  27337 then CAST(booleanValue AS TINYINT) end ) expr_27337,
						max(case dataFieldObjectid when  27338 then CAST(booleanValue AS TINYINT) end ) expr_27338,
						max(case dataFieldObjectid when  27339 then CAST(booleanValue AS TINYINT) end ) expr_27339,
						max(case dataFieldObjectid when  27340 then CAST(booleanValue AS TINYINT) end ) expr_27340,
						max(case dataFieldObjectid when  27341 then CAST(booleanValue AS TINYINT) end ) expr_27341,
						max(case dataFieldObjectid when  27342 then CAST(booleanValue AS TINYINT) end ) expr_27342,
						max(case dataFieldObjectid when  27343 then CAST(booleanValue AS TINYINT) end ) expr_27343,
						max(case dataFieldObjectid when  27344 then CAST(booleanValue AS TINYINT) end ) expr_27344,
						max(case dataFieldObjectid when  27345 then CAST(booleanValue AS TINYINT) end ) expr_27345,
						max(case dataFieldObjectid when  27346 then CAST(booleanValue AS TINYINT) end ) expr_27346,
						max(case dataFieldObjectid when  27347 then CAST(booleanValue AS TINYINT) end ) expr_27347,
						max(case dataFieldObjectid when  27348 then CAST(booleanValue AS TINYINT) end ) expr_27348,
						max(case dataFieldObjectid when  27349 then CAST(booleanValue AS TINYINT) end ) expr_27349,
						max(case dataFieldObjectid when  27350 then CAST(booleanValue AS TINYINT) end ) expr_27350,
						max(case dataFieldObjectid when  27351 then CAST(booleanValue AS TINYINT) end ) expr_27351,
						max(case dataFieldObjectid when  27352 then CAST(booleanValue AS TINYINT) end ) expr_27352,
						max(case dataFieldObjectid when  27353 then CAST(booleanValue AS TINYINT) end ) expr_27353,
						max(case dataFieldObjectid when  27354 then CAST(booleanValue AS TINYINT) end ) expr_27354,
						max(case dataFieldObjectid when  27355 then CAST(booleanValue AS TINYINT) end ) expr_27355,
						max(case dataFieldObjectid when  27356 then CAST(booleanValue AS TINYINT) end ) expr_27356,
						max(case dataFieldObjectid when  27357 then CAST(booleanValue AS TINYINT) end ) expr_27357,
						max(case dataFieldObjectid when  27358 then CAST(booleanValue AS TINYINT) end ) expr_27358,
						max(case dataFieldObjectid when  27359 then CAST(booleanValue AS TINYINT) end ) expr_27359,
						max(case dataFieldObjectid when  27360 then CAST(booleanValue AS TINYINT) end ) expr_27360,
						max(case dataFieldObjectid when  27361 then CAST(booleanValue AS TINYINT) end ) expr_27361,
						max(case dataFieldObjectid when  27362 then CAST(booleanValue AS TINYINT) end ) expr_27362,
						max(case dataFieldObjectid when  27363 then CAST(booleanValue AS TINYINT) end ) expr_27363,
						max(case dataFieldObjectid when  27364 then CAST(booleanValue AS TINYINT) end ) expr_27364,
						max(case dataFieldObjectid when  27365 then CAST(booleanValue AS TINYINT) end ) expr_27365,
						max(case dataFieldObjectid when  27366 then CAST(booleanValue AS TINYINT) end ) expr_27366,
						max(case dataFieldObjectid when  27367 then CAST(booleanValue AS TINYINT) end ) expr_27367,
						max(case dataFieldObjectid when  27368 then CAST(booleanValue AS TINYINT) end ) expr_27368,
						max(case dataFieldObjectid when  27369 then CAST(booleanValue AS TINYINT) end ) expr_27369,
						max(case dataFieldObjectid when  27370 then CAST(booleanValue AS TINYINT) end ) expr_27370,
						max(case dataFieldObjectid when  27371 then CAST(booleanValue AS TINYINT) end ) expr_27371,
						max(case dataFieldObjectid when  27372 then CAST(booleanValue AS TINYINT) end ) expr_27372,
						max(case dataFieldObjectid when  27373 then CAST(booleanValue AS TINYINT) end ) expr_27373,
						max(case dataFieldObjectid when  27374 then CAST(booleanValue AS TINYINT) end ) expr_27374,
						max(case dataFieldObjectid when  27375 then CAST(booleanValue AS TINYINT) end ) expr_27375,
						max(case dataFieldObjectid when  27376 then CAST(booleanValue AS TINYINT) end ) expr_27376,
						max(case dataFieldObjectid when  27377 then CAST(booleanValue AS TINYINT) end ) expr_27377,
						max(case dataFieldObjectid when  27378 then CAST(booleanValue AS TINYINT) end ) expr_27378,
						max(case dataFieldObjectid when  27379 then CAST(booleanValue AS TINYINT) end ) expr_27379,
						max(case dataFieldObjectid when  27380 then CAST(booleanValue AS TINYINT) end ) expr_27380,
						max(case dataFieldObjectid when  27381 then CAST(booleanValue AS TINYINT) end ) expr_27381,
						max(case dataFieldObjectid when  27382 then CAST(booleanValue AS TINYINT) end ) expr_27382,
						max(case dataFieldObjectid when  27383 then CAST(booleanValue AS TINYINT) end ) expr_27383,
						max(case dataFieldObjectid when  27384 then CAST(booleanValue AS TINYINT) end ) expr_27384,
						max(case dataFieldObjectid when  27385 then CAST(booleanValue AS TINYINT) end ) expr_27385,
						max(case dataFieldObjectid when  27386 then CAST(booleanValue AS TINYINT) end ) expr_27386,
						max(case dataFieldObjectid when  27387 then CAST(booleanValue AS TINYINT) end ) expr_27387,
						max(case dataFieldObjectid when  27388 then CAST(booleanValue AS TINYINT) end ) expr_27388,
						max(case dataFieldObjectid when  27389 then CAST(booleanValue AS TINYINT) end ) expr_27389,
						max(case dataFieldObjectid when  27390 then CAST(booleanValue AS TINYINT) end ) expr_27390,
						max(case dataFieldObjectid when  27391 then CAST(booleanValue AS TINYINT) end ) expr_27391,
						max(case dataFieldObjectid when  27392 then CAST(booleanValue AS TINYINT) end ) expr_27392,
						max(case dataFieldObjectid when  27393 then CAST(booleanValue AS TINYINT) end ) expr_27393,
						max(case dataFieldObjectid when  27394 then CAST(booleanValue AS TINYINT) end ) expr_27394,
						max(case dataFieldObjectid when  27395 then CAST(booleanValue AS TINYINT) end ) expr_27395,
						max(case dataFieldObjectid when  27396 then CAST(booleanValue AS TINYINT) end ) expr_27396,
						max(case dataFieldObjectid when  27397 then CAST(booleanValue AS TINYINT) end ) expr_27397,
						max(case dataFieldObjectid when  27398 then CAST(booleanValue AS TINYINT) end ) expr_27398,
						max(case dataFieldObjectid when  27399 then CAST(booleanValue AS TINYINT) end ) expr_27399,
						max(case dataFieldObjectid when  27400 then CAST(booleanValue AS TINYINT) end ) expr_27400,
						max(case dataFieldObjectid when  27401 then CAST(booleanValue AS TINYINT) end ) expr_27401,
						max(case dataFieldObjectid when  27402 then CAST(booleanValue AS TINYINT) end ) expr_27402,
						max(case dataFieldObjectid when  27403 then CAST(booleanValue AS TINYINT) end ) expr_27403,
						max(case dataFieldObjectid when  27404 then CAST(booleanValue AS TINYINT) end ) expr_27404,
						max(case dataFieldObjectid when  27405 then CAST(booleanValue AS TINYINT) end ) expr_27405,
						max(case dataFieldObjectid when  27406 then CAST(booleanValue AS TINYINT) end ) expr_27406,
						max(case dataFieldObjectid when  27407 then CAST(booleanValue AS TINYINT) end ) expr_27407,
						max(case dataFieldObjectid when  27408 then CAST(booleanValue AS TINYINT) end ) expr_27408,
						max(case dataFieldObjectid when  27409 then CAST(booleanValue AS TINYINT) end ) expr_27409,
						max(case dataFieldObjectid when  27410 then CAST(booleanValue AS TINYINT) end ) expr_27410,
						max(case dataFieldObjectid when  27411 then CAST(booleanValue AS TINYINT) end ) expr_27411,
						max(case dataFieldObjectid when  27412 then CAST(booleanValue AS TINYINT) end ) expr_27412,
						max(case dataFieldObjectid when  27413 then CAST(booleanValue AS TINYINT) end ) expr_27413,
						max(case dataFieldObjectid when  27414 then CAST(booleanValue AS TINYINT) end ) expr_27414,
						max(case dataFieldObjectid when  27415 then CAST(booleanValue AS TINYINT) end ) expr_27415,
						max(case dataFieldObjectid when  27416 then CAST(booleanValue AS TINYINT) end ) expr_27416,
						max(case dataFieldObjectid when  27417 then CAST(booleanValue AS TINYINT) end ) expr_27417,
						max(case dataFieldObjectid when  27418 then CAST(booleanValue AS TINYINT) end ) expr_27418,
						max(case dataFieldObjectid when  27419 then CAST(booleanValue AS TINYINT) end ) expr_27419,
						max(case dataFieldObjectid when  27420 then CAST(booleanValue AS TINYINT) end ) expr_27420,
						max(case dataFieldObjectid when  27421 then CAST(booleanValue AS TINYINT) end ) expr_27421,
						max(case dataFieldObjectid when  27422 then CAST(booleanValue AS TINYINT) end ) expr_27422,
						max(case dataFieldObjectid when  27423 then CAST(booleanValue AS TINYINT) end ) expr_27423,
						max(case dataFieldObjectid when  27424 then CAST(booleanValue AS TINYINT) end ) expr_27424,
						max(case dataFieldObjectid when  27425 then CAST(booleanValue AS TINYINT) end ) expr_27425,
						max(case dataFieldObjectid when  27426 then CAST(booleanValue AS TINYINT) end ) expr_27426,
						max(case dataFieldObjectid when  27427 then CAST(booleanValue AS TINYINT) end ) expr_27427,
						max(case dataFieldObjectid when  27428 then CAST(booleanValue AS TINYINT) end ) expr_27428,
						max(case dataFieldObjectid when  27429 then CAST(booleanValue AS TINYINT) end ) expr_27429,
						max(case dataFieldObjectid when  27430 then CAST(booleanValue AS TINYINT) end ) expr_27430,
						max(case dataFieldObjectid when  27431 then CAST(booleanValue AS TINYINT) end ) expr_27431,
						max(case dataFieldObjectid when  27432 then CAST(booleanValue AS TINYINT) end ) expr_27432,
						max(case dataFieldObjectid when  27433 then CAST(booleanValue AS TINYINT) end ) expr_27433,
						max(case dataFieldObjectid when  27434 then CAST(booleanValue AS TINYINT) end ) expr_27434,
						max(case dataFieldObjectid when  27435 then CAST(booleanValue AS TINYINT) end ) expr_27435,
						max(case dataFieldObjectid when  27436 then CAST(booleanValue AS TINYINT) end ) expr_27436,
						max(case dataFieldObjectid when  27437 then CAST(booleanValue AS TINYINT) end ) expr_27437,
						max(case dataFieldObjectid when  27438 then CAST(booleanValue AS TINYINT) end ) expr_27438,
						max(case dataFieldObjectid when  27439 then CAST(booleanValue AS TINYINT) end ) expr_27439,
						max(case dataFieldObjectid when  27440 then CAST(booleanValue AS TINYINT) end ) expr_27440,
						max(case dataFieldObjectid when  27441 then CAST(booleanValue AS TINYINT) end ) expr_27441,
						max(case dataFieldObjectid when  27442 then CAST(booleanValue AS TINYINT) end ) expr_27442,
						max(case dataFieldObjectid when  27443 then CAST(booleanValue AS TINYINT) end ) expr_27443,
						max(case dataFieldObjectid when  27444 then CAST(booleanValue AS TINYINT) end ) expr_27444,
						max(case dataFieldObjectid when  27445 then CAST(booleanValue AS TINYINT) end ) expr_27445,
						max(case dataFieldObjectid when  27446 then CAST(booleanValue AS TINYINT) end ) expr_27446,
						max(case dataFieldObjectid when  27447 then CAST(booleanValue AS TINYINT) end ) expr_27447,
						max(case dataFieldObjectid when  27448 then CAST(booleanValue AS TINYINT) end ) expr_27448,
						max(case dataFieldObjectid when  27449 then CAST(booleanValue AS TINYINT) end ) expr_27449,
						max(case dataFieldObjectid when  27450 then CAST(booleanValue AS TINYINT) end ) expr_27450,
						max(case dataFieldObjectid when  27451 then CAST(booleanValue AS TINYINT) end ) expr_27451,
						max(case dataFieldObjectid when  27452 then CAST(booleanValue AS TINYINT) end ) expr_27452,
						max(case dataFieldObjectid when  27453 then CAST(booleanValue AS TINYINT) end ) expr_27453,
						max(case dataFieldObjectid when  27454 then CAST(booleanValue AS TINYINT) end ) expr_27454,
						max(case dataFieldObjectid when  27455 then CAST(booleanValue AS TINYINT) end ) expr_27455,
						max(case dataFieldObjectid when  27456 then CAST(booleanValue AS TINYINT) end ) expr_27456,
						max(case dataFieldObjectid when  27457 then CAST(booleanValue AS TINYINT) end ) expr_27457,
						max(case dataFieldObjectid when  27458 then CAST(booleanValue AS TINYINT) end ) expr_27458,
						max(case dataFieldObjectid when  27459 then CAST(booleanValue AS TINYINT) end ) expr_27459,
						max(case dataFieldObjectid when  27460 then CAST(booleanValue AS TINYINT) end ) expr_27460,
						max(case dataFieldObjectid when  27461 then CAST(booleanValue AS TINYINT) end ) expr_27461,
						max(case dataFieldObjectid when  27462 then CAST(booleanValue AS TINYINT) end ) expr_27462,
						max(case dataFieldObjectid when  27463 then CAST(booleanValue AS TINYINT) end ) expr_27463,
						max(case dataFieldObjectid when  27464 then CAST(booleanValue AS TINYINT) end ) expr_27464,
						max(case dataFieldObjectid when  27465 then CAST(booleanValue AS TINYINT) end ) expr_27465,
						max(case dataFieldObjectid when  27466 then CAST(booleanValue AS TINYINT) end ) expr_27466,
						max(case dataFieldObjectid when  27467 then CAST(booleanValue AS TINYINT) end ) expr_27467,
						max(case dataFieldObjectid when  27468 then CAST(booleanValue AS TINYINT) end ) expr_27468,
						max(case dataFieldObjectid when  27469 then CAST(booleanValue AS TINYINT) end ) expr_27469,
						max(case dataFieldObjectid when  27470 then CAST(booleanValue AS TINYINT) end ) expr_27470,
						max(case dataFieldObjectid when  27471 then CAST(booleanValue AS TINYINT) end ) expr_27471,
						max(case dataFieldObjectid when  27472 then CAST(booleanValue AS TINYINT) end ) expr_27472,
						max(case dataFieldObjectid when  27473 then CAST(booleanValue AS TINYINT) end ) expr_27473,
						max(case dataFieldObjectid when  27474 then CAST(booleanValue AS TINYINT) end ) expr_27474,
						max(case dataFieldObjectid when  27475 then CAST(booleanValue AS TINYINT) end ) expr_27475,
						max(case dataFieldObjectid when  27476 then CAST(booleanValue AS TINYINT) end ) expr_27476,
						max(case dataFieldObjectid when  27477 then CAST(booleanValue AS TINYINT) end ) expr_27477,
						max(case dataFieldObjectid when  27478 then CAST(booleanValue AS TINYINT) end ) expr_27478,
						max(case dataFieldObjectid when  27479 then CAST(booleanValue AS TINYINT) end ) expr_27479,
						max(case dataFieldObjectid when  27480 then CAST(booleanValue AS TINYINT) end ) expr_27480,
						max(case dataFieldObjectid when  27481 then CAST(booleanValue AS TINYINT) end ) expr_27481,
						max(case dataFieldObjectid when  27482 then CAST(booleanValue AS TINYINT) end ) expr_27482,
						max(case dataFieldObjectid when  27483 then CAST(booleanValue AS TINYINT) end ) expr_27483,
						max(case dataFieldObjectid when  27484 then CAST(booleanValue AS TINYINT) end ) expr_27484,
						max(case dataFieldObjectid when  27485 then CAST(booleanValue AS TINYINT) end ) expr_27485,
						max(case dataFieldObjectid when  27486 then CAST(booleanValue AS TINYINT) end ) expr_27486,
						max(case dataFieldObjectid when  27487 then CAST(booleanValue AS TINYINT) end ) expr_27487,
						max(case dataFieldObjectid when  27488 then CAST(booleanValue AS TINYINT) end ) expr_27488,
						max(case dataFieldObjectid when  27489 then CAST(booleanValue AS TINYINT) end ) expr_27489,
						max(case dataFieldObjectid when  27490 then CAST(booleanValue AS TINYINT) end ) expr_27490,
						max(case dataFieldObjectid when  27491 then CAST(booleanValue AS TINYINT) end ) expr_27491,
						max(case dataFieldObjectid when  27492 then CAST(booleanValue AS TINYINT) end ) expr_27492,
						max(case dataFieldObjectid when  27493 then CAST(booleanValue AS TINYINT) end ) expr_27493,
						max(case dataFieldObjectid when  27494 then CAST(booleanValue AS TINYINT) end ) expr_27494,
						max(case dataFieldObjectid when  27495 then CAST(booleanValue AS TINYINT) end ) expr_27495,
						max(case dataFieldObjectid when  27496 then CAST(booleanValue AS TINYINT) end ) expr_27496,
						max(case dataFieldObjectid when  27497 then CAST(booleanValue AS TINYINT) end ) expr_27497,
						max(case dataFieldObjectid when  27498 then CAST(booleanValue AS TINYINT) end ) expr_27498,
						max(case dataFieldObjectid when  27499 then CAST(booleanValue AS TINYINT) end ) expr_27499,
						max(case dataFieldObjectid when  27500 then CAST(booleanValue AS TINYINT) end ) expr_27500,
						max(case dataFieldObjectid when  27501 then CAST(booleanValue AS TINYINT) end ) expr_27501,
						max(case dataFieldObjectid when  27502 then CAST(booleanValue AS TINYINT) end ) expr_27502,
						max(case dataFieldObjectid when  27503 then CAST(booleanValue AS TINYINT) end ) expr_27503,
						max(case dataFieldObjectid when  27504 then CAST(booleanValue AS TINYINT) end ) expr_27504,
						max(case dataFieldObjectid when  27505 then CAST(booleanValue AS TINYINT) end ) expr_27505,
						max(case dataFieldObjectid when  27506 then CAST(booleanValue AS TINYINT) end ) expr_27506,
						max(case dataFieldObjectid when  27507 then CAST(booleanValue AS TINYINT) end ) expr_27507,
						max(case dataFieldObjectid when  27508 then CAST(booleanValue AS TINYINT) end ) expr_27508,
						max(case dataFieldObjectid when  27509 then CAST(booleanValue AS TINYINT) end ) expr_27509,
						max(case dataFieldObjectid when  27510 then CAST(booleanValue AS TINYINT) end ) expr_27510,
						max(case dataFieldObjectid when  27511 then CAST(booleanValue AS TINYINT) end ) expr_27511,
						max(case dataFieldObjectid when  27512 then CAST(booleanValue AS TINYINT) end ) expr_27512,
						max(case dataFieldObjectid when  27513 then CAST(booleanValue AS TINYINT) end ) expr_27513,
						max(case dataFieldObjectid when  27514 then CAST(booleanValue AS TINYINT) end ) expr_27514,
						max(case dataFieldObjectid when  27515 then CAST(booleanValue AS TINYINT) end ) expr_27515,
						max(case dataFieldObjectid when  27516 then CAST(booleanValue AS TINYINT) end ) expr_27516,
						max(case dataFieldObjectid when  27517 then CAST(booleanValue AS TINYINT) end ) expr_27517,
						max(case dataFieldObjectid when  27518 then CAST(booleanValue AS TINYINT) end ) expr_27518,
						max(case dataFieldObjectid when  27519 then CAST(booleanValue AS TINYINT) end ) expr_27519,
						max(case dataFieldObjectid when  27520 then CAST(booleanValue AS TINYINT) end ) expr_27520,
						max(case dataFieldObjectid when  27521 then CAST(booleanValue AS TINYINT) end ) expr_27521,
						max(case dataFieldObjectid when  27522 then CAST(booleanValue AS TINYINT) end ) expr_27522,
						max(case dataFieldObjectid when  27523 then CAST(booleanValue AS TINYINT) end ) expr_27523,
						max(case dataFieldObjectid when  27524 then CAST(booleanValue AS TINYINT) end ) expr_27524,
						max(case dataFieldObjectid when  27525 then CAST(booleanValue AS TINYINT) end ) expr_27525,
						max(case dataFieldObjectid when  27526 then CAST(booleanValue AS TINYINT) end ) expr_27526,
						max(case dataFieldObjectid when  27527 then CAST(booleanValue AS TINYINT) end ) expr_27527,
						max(case dataFieldObjectid when  27528 then CAST(booleanValue AS TINYINT) end ) expr_27528,
						max(case dataFieldObjectid when  27529 then CAST(booleanValue AS TINYINT) end ) expr_27529,
						max(case dataFieldObjectid when  27530 then CAST(booleanValue AS TINYINT) end ) expr_27530,
						max(case dataFieldObjectid when  27531 then CAST(booleanValue AS TINYINT) end ) expr_27531,
						max(case dataFieldObjectid when  27532 then CAST(booleanValue AS TINYINT) end ) expr_27532,
						max(case dataFieldObjectid when  27533 then CAST(booleanValue AS TINYINT) end ) expr_27533,
						max(case dataFieldObjectid when  27534 then CAST(booleanValue AS TINYINT) end ) expr_27534,
						max(case dataFieldObjectid when  27535 then CAST(booleanValue AS TINYINT) end ) expr_27535,
						max(case dataFieldObjectid when  27536 then CAST(booleanValue AS TINYINT) end ) expr_27536,
						max(case dataFieldObjectid when  27537 then CAST(booleanValue AS TINYINT) end ) expr_27537,
						max(case dataFieldObjectid when  27538 then CAST(booleanValue AS TINYINT) end ) expr_27538,
						max(case dataFieldObjectid when  27539 then CAST(booleanValue AS TINYINT) end ) expr_27539,
						max(case dataFieldObjectid when  27540 then CAST(booleanValue AS TINYINT) end ) expr_27540,
						max(case dataFieldObjectid when  27541 then CAST(booleanValue AS TINYINT) end ) expr_27541,
						max(case dataFieldObjectid when  27542 then CAST(booleanValue AS TINYINT) end ) expr_27542,
						max(case dataFieldObjectid when  27543 then CAST(booleanValue AS TINYINT) end ) expr_27543,
						max(case dataFieldObjectid when  27544 then CAST(booleanValue AS TINYINT) end ) expr_27544,
						max(case dataFieldObjectid when  27545 then CAST(booleanValue AS TINYINT) end ) expr_27545,
						max(case dataFieldObjectid when  27546 then CAST(booleanValue AS TINYINT) end ) expr_27546,
						max(case dataFieldObjectid when  27547 then CAST(booleanValue AS TINYINT) end ) expr_27547,
						max(case dataFieldObjectid when  27548 then CAST(booleanValue AS TINYINT) end ) expr_27548,
						max(case dataFieldObjectid when  27549 then CAST(booleanValue AS TINYINT) end ) expr_27549,
						max(case dataFieldObjectid when  27550 then CAST(booleanValue AS TINYINT) end ) expr_27550,
						max(case dataFieldObjectid when  27551 then CAST(booleanValue AS TINYINT) end ) expr_27551,
						max(case dataFieldObjectid when  27552 then CAST(booleanValue AS TINYINT) end ) expr_27552,
						max(case dataFieldObjectid when  27553 then CAST(booleanValue AS TINYINT) end ) expr_27553,
						max(case dataFieldObjectid when  27554 then CAST(booleanValue AS TINYINT) end ) expr_27554,
						max(case dataFieldObjectid when  27555 then CAST(booleanValue AS TINYINT) end ) expr_27555,
						max(case dataFieldObjectid when  27556 then CAST(booleanValue AS TINYINT) end ) expr_27556,
						max(case dataFieldObjectid when  27557 then CAST(booleanValue AS TINYINT) end ) expr_27557,
						max(case dataFieldObjectid when  27558 then CAST(booleanValue AS TINYINT) end ) expr_27558,
						max(case dataFieldObjectid when  27559 then CAST(booleanValue AS TINYINT) end ) expr_27559,
						max(case dataFieldObjectid when  27560 then CAST(booleanValue AS TINYINT) end ) expr_27560,
						max(case dataFieldObjectid when  27561 then CAST(booleanValue AS TINYINT) end ) expr_27561,
						max(case dataFieldObjectid when  27562 then CAST(booleanValue AS TINYINT) end ) expr_27562,
						max(case dataFieldObjectid when  27563 then CAST(booleanValue AS TINYINT) end ) expr_27563,
						max(case dataFieldObjectid when  27564 then CAST(booleanValue AS TINYINT) end ) expr_27564,
						max(case dataFieldObjectid when  27565 then CAST(booleanValue AS TINYINT) end ) expr_27565,
						max(case dataFieldObjectid when  27566 then CAST(booleanValue AS TINYINT) end ) expr_27566,
						max(case dataFieldObjectid when  27567 then CAST(booleanValue AS TINYINT) end ) expr_27567,
						max(case dataFieldObjectid when  27568 then CAST(booleanValue AS TINYINT) end ) expr_27568,
						max(case dataFieldObjectid when  27569 then CAST(booleanValue AS TINYINT) end ) expr_27569,
						max(case dataFieldObjectid when  27570 then CAST(booleanValue AS TINYINT) end ) expr_27570,
						max(case dataFieldObjectid when  27571 then CAST(booleanValue AS TINYINT) end ) expr_27571,
						max(case dataFieldObjectid when  27572 then CAST(booleanValue AS TINYINT) end ) expr_27572,
						max(case dataFieldObjectid when  27573 then CAST(booleanValue AS TINYINT) end ) expr_27573,
						max(case dataFieldObjectid when  27574 then CAST(booleanValue AS TINYINT) end ) expr_27574,
						max(case dataFieldObjectid when  27575 then CAST(booleanValue AS TINYINT) end ) expr_27575,
						max(case dataFieldObjectid when  27576 then CAST(booleanValue AS TINYINT) end ) expr_27576,
						max(case dataFieldObjectid when  27577 then CAST(booleanValue AS TINYINT) end ) expr_27577,
						max(case dataFieldObjectid when  27578 then CAST(booleanValue AS TINYINT) end ) expr_27578,
						max(case dataFieldObjectid when  27579 then CAST(booleanValue AS TINYINT) end ) expr_27579,
						max(case dataFieldObjectid when  27580 then CAST(booleanValue AS TINYINT) end ) expr_27580,
						max(case dataFieldObjectid when  27581 then CAST(booleanValue AS TINYINT) end ) expr_27581,
						max(case dataFieldObjectid when  27582 then CAST(booleanValue AS TINYINT) end ) expr_27582,
						max(case dataFieldObjectid when  27583 then CAST(booleanValue AS TINYINT) end ) expr_27583,
						max(case dataFieldObjectid when  27584 then CAST(booleanValue AS TINYINT) end ) expr_27584,
						max(case dataFieldObjectid when  27585 then CAST(booleanValue AS TINYINT) end ) expr_27585,
						max(case dataFieldObjectid when  27586 then CAST(booleanValue AS TINYINT) end ) expr_27586,
						max(case dataFieldObjectid when  27587 then CAST(booleanValue AS TINYINT) end ) expr_27587,
						max(case dataFieldObjectid when  27588 then CAST(booleanValue AS TINYINT) end ) expr_27588,
						max(case dataFieldObjectid when  27589 then CAST(booleanValue AS TINYINT) end ) expr_27589,
						max(case dataFieldObjectid when  27590 then CAST(booleanValue AS TINYINT) end ) expr_27590,
						max(case dataFieldObjectid when  27591 then CAST(booleanValue AS TINYINT) end ) expr_27591,
						max(case dataFieldObjectid when  27592 then CAST(booleanValue AS TINYINT) end ) expr_27592,
						max(case dataFieldObjectid when  27593 then CAST(booleanValue AS TINYINT) end ) expr_27593,
						max(case dataFieldObjectid when  27594 then CAST(booleanValue AS TINYINT) end ) expr_27594,
						max(case dataFieldObjectid when  27595 then CAST(booleanValue AS TINYINT) end ) expr_27595,
						max(case dataFieldObjectid when  27596 then CAST(booleanValue AS TINYINT) end ) expr_27596,
						max(case dataFieldObjectid when  27597 then CAST(booleanValue AS TINYINT) end ) expr_27597,
						max(case dataFieldObjectid when  27598 then CAST(booleanValue AS TINYINT) end ) expr_27598,
						max(case dataFieldObjectid when  27599 then CAST(booleanValue AS TINYINT) end ) expr_27599,
						max(case dataFieldObjectid when  27600 then CAST(booleanValue AS TINYINT) end ) expr_27600,
						max(case dataFieldObjectid when  27601 then CAST(booleanValue AS TINYINT) end ) expr_27601,
						max(case dataFieldObjectid when  27602 then CAST(booleanValue AS TINYINT) end ) expr_27602,
						max(case dataFieldObjectid when  27603 then CAST(booleanValue AS TINYINT) end ) expr_27603,
						max(case dataFieldObjectid when  27604 then CAST(booleanValue AS TINYINT) end ) expr_27604,
						max(case dataFieldObjectid when  27605 then CAST(booleanValue AS TINYINT) end ) expr_27605,
						max(case dataFieldObjectid when  27606 then CAST(booleanValue AS TINYINT) end ) expr_27606,
						max(case dataFieldObjectid when  27607 then CAST(booleanValue AS TINYINT) end ) expr_27607,
						max(case dataFieldObjectid when  27608 then CAST(booleanValue AS TINYINT) end ) expr_27608,
						max(case dataFieldObjectid when  27609 then CAST(booleanValue AS TINYINT) end ) expr_27609,
						max(case dataFieldObjectid when  27610 then CAST(booleanValue AS TINYINT) end ) expr_27610,
						max(case dataFieldObjectid when  27611 then CAST(booleanValue AS TINYINT) end ) expr_27611,
						max(case dataFieldObjectid when  27612 then CAST(booleanValue AS TINYINT) end ) expr_27612,
						max(case dataFieldObjectid when  27613 then CAST(booleanValue AS TINYINT) end ) expr_27613,
						max(case dataFieldObjectid when  27614 then CAST(booleanValue AS TINYINT) end ) expr_27614,
						max(case dataFieldObjectid when  27615 then CAST(booleanValue AS TINYINT) end ) expr_27615,
						max(case dataFieldObjectid when  27616 then CAST(booleanValue AS TINYINT) end ) expr_27616,
						max(case dataFieldObjectid when  27617 then CAST(booleanValue AS TINYINT) end ) expr_27617,
						max(case dataFieldObjectid when  27618 then CAST(booleanValue AS TINYINT) end ) expr_27618,
						max(case dataFieldObjectid when  27619 then CAST(booleanValue AS TINYINT) end ) expr_27619,
						max(case dataFieldObjectid when  27620 then CAST(booleanValue AS TINYINT) end ) expr_27620,
						max(case dataFieldObjectid when  27621 then CAST(booleanValue AS TINYINT) end ) expr_27621,
						max(case dataFieldObjectid when  27622 then CAST(booleanValue AS TINYINT) end ) expr_27622,
						max(case dataFieldObjectid when  27623 then CAST(booleanValue AS TINYINT) end ) expr_27623,
						max(case dataFieldObjectid when  27624 then CAST(booleanValue AS TINYINT) end ) expr_27624,
						max(case dataFieldObjectid when  27625 then CAST(booleanValue AS TINYINT) end ) expr_27625,
						max(case dataFieldObjectid when  27626 then CAST(booleanValue AS TINYINT) end ) expr_27626,
						max(case dataFieldObjectid when  27627 then CAST(booleanValue AS TINYINT) end ) expr_27627,
						max(case dataFieldObjectid when  27628 then CAST(booleanValue AS TINYINT) end ) expr_27628,
						max(case dataFieldObjectid when  27629 then CAST(booleanValue AS TINYINT) end ) expr_27629,
						max(case dataFieldObjectid when  27630 then CAST(booleanValue AS TINYINT) end ) expr_27630,
						max(case dataFieldObjectid when  27631 then CAST(booleanValue AS TINYINT) end ) expr_27631,
						max(case dataFieldObjectid when  27632 then CAST(booleanValue AS TINYINT) end ) expr_27632,
						max(case dataFieldObjectid when  27633 then CAST(booleanValue AS TINYINT) end ) expr_27633,
						max(case dataFieldObjectid when  27634 then CAST(booleanValue AS TINYINT) end ) expr_27634,
						max(case dataFieldObjectid when  27635 then CAST(booleanValue AS TINYINT) end ) expr_27635,
						max(case dataFieldObjectid when  27636 then CAST(booleanValue AS TINYINT) end ) expr_27636,
						max(case dataFieldObjectid when  27637 then CAST(booleanValue AS TINYINT) end ) expr_27637,
						max(case dataFieldObjectid when  27638 then CAST(booleanValue AS TINYINT) end ) expr_27638,
						max(case dataFieldObjectid when  27639 then CAST(booleanValue AS TINYINT) end ) expr_27639,
						max(case dataFieldObjectid when  27640 then CAST(booleanValue AS TINYINT) end ) expr_27640,
						max(case dataFieldObjectid when  27641 then CAST(booleanValue AS TINYINT) end ) expr_27641,
						max(case dataFieldObjectid when  27642 then CAST(booleanValue AS TINYINT) end ) expr_27642,
						max(case dataFieldObjectid when  27643 then CAST(booleanValue AS TINYINT) end ) expr_27643,
						max(case dataFieldObjectid when  27644 then CAST(booleanValue AS TINYINT) end ) expr_27644,
						max(case dataFieldObjectid when  27645 then CAST(booleanValue AS TINYINT) end ) expr_27645,
						max(case dataFieldObjectid when  27646 then CAST(booleanValue AS TINYINT) end ) expr_27646,
						max(case dataFieldObjectid when  27647 then CAST(booleanValue AS TINYINT) end ) expr_27647,
						max(case dataFieldObjectid when  27648 then CAST(booleanValue AS TINYINT) end ) expr_27648,
						max(case dataFieldObjectid when  27649 then CAST(booleanValue AS TINYINT) end ) expr_27649,
						max(case dataFieldObjectid when  27650 then CAST(booleanValue AS TINYINT) end ) expr_27650,
						max(case dataFieldObjectid when  27651 then CAST(booleanValue AS TINYINT) end ) expr_27651,
						max(case dataFieldObjectid when  27652 then CAST(booleanValue AS TINYINT) end ) expr_27652,
						max(case dataFieldObjectid when  27653 then CAST(booleanValue AS TINYINT) end ) expr_27653,
						max(case dataFieldObjectid when  27654 then CAST(booleanValue AS TINYINT) end ) expr_27654,
						max(case dataFieldObjectid when  27655 then CAST(booleanValue AS TINYINT) end ) expr_27655,
						max(case dataFieldObjectid when  27656 then CAST(booleanValue AS TINYINT) end ) expr_27656,
						max(case dataFieldObjectid when  27657 then CAST(booleanValue AS TINYINT) end ) expr_27657,
						max(case dataFieldObjectid when  27658 then CAST(booleanValue AS TINYINT) end ) expr_27658,
						max(case dataFieldObjectid when  27659 then CAST(booleanValue AS TINYINT) end ) expr_27659,
						max(case dataFieldObjectid when  27660 then CAST(booleanValue AS TINYINT) end ) expr_27660,
						max(case dataFieldObjectid when  27661 then CAST(booleanValue AS TINYINT) end ) expr_27661,
						max(case dataFieldObjectid when  27662 then CAST(booleanValue AS TINYINT) end ) expr_27662,
						max(case dataFieldObjectid when  27663 then CAST(booleanValue AS TINYINT) end ) expr_27663,
						max(case dataFieldObjectid when  27664 then CAST(booleanValue AS TINYINT) end ) expr_27664,
						max(case dataFieldObjectid when  27665 then CAST(booleanValue AS TINYINT) end ) expr_27665,
						max(case dataFieldObjectid when  27666 then CAST(booleanValue AS TINYINT) end ) expr_27666,
						max(case dataFieldObjectid when  27667 then CAST(booleanValue AS TINYINT) end ) expr_27667,
						max(case dataFieldObjectid when  27668 then CAST(booleanValue AS TINYINT) end ) expr_27668,
						max(case dataFieldObjectid when  27669 then CAST(booleanValue AS TINYINT) end ) expr_27669,
						max(case dataFieldObjectid when  27670 then CAST(booleanValue AS TINYINT) end ) expr_27670,
						max(case dataFieldObjectid when  27671 then CAST(booleanValue AS TINYINT) end ) expr_27671,
						max(case dataFieldObjectid when  27672 then CAST(booleanValue AS TINYINT) end ) expr_27672,
						max(case dataFieldObjectid when  27673 then CAST(booleanValue AS TINYINT) end ) expr_27673,
						max(case dataFieldObjectid when  27674 then CAST(booleanValue AS TINYINT) end ) expr_27674,
						max(case dataFieldObjectid when  27675 then CAST(booleanValue AS TINYINT) end ) expr_27675,
						max(case dataFieldObjectid when  27676 then CAST(booleanValue AS TINYINT) end ) expr_27676,
						max(case dataFieldObjectid when  27677 then CAST(booleanValue AS TINYINT) end ) expr_27677,
						max(case dataFieldObjectid when  27678 then CAST(booleanValue AS TINYINT) end ) expr_27678,
						max(case dataFieldObjectid when  27679 then CAST(booleanValue AS TINYINT) end ) expr_27679,
						max(case dataFieldObjectid when  27680 then CAST(booleanValue AS TINYINT) end ) expr_27680,
						max(case dataFieldObjectid when  27681 then CAST(booleanValue AS TINYINT) end ) expr_27681,
						max(case dataFieldObjectid when  27682 then CAST(booleanValue AS TINYINT) end ) expr_27682,
						max(case dataFieldObjectid when  27683 then CAST(booleanValue AS TINYINT) end ) expr_27683,
						max(case dataFieldObjectid when  27684 then CAST(booleanValue AS TINYINT) end ) expr_27684,
						max(case dataFieldObjectid when  27685 then CAST(booleanValue AS TINYINT) end ) expr_27685,
						max(case dataFieldObjectid when  27686 then CAST(booleanValue AS TINYINT) end ) expr_27686,
						max(case dataFieldObjectid when  27687 then CAST(booleanValue AS TINYINT) end ) expr_27687,
						max(case dataFieldObjectid when  27688 then CAST(booleanValue AS TINYINT) end ) expr_27688,
						max(case dataFieldObjectid when  27689 then CAST(booleanValue AS TINYINT) end ) expr_27689,
						max(case dataFieldObjectid when  27690 then CAST(booleanValue AS TINYINT) end ) expr_27690,
						max(case dataFieldObjectid when  27691 then CAST(booleanValue AS TINYINT) end ) expr_27691,
						max(case dataFieldObjectid when  27692 then CAST(booleanValue AS TINYINT) end ) expr_27692,
						max(case dataFieldObjectid when  27693 then CAST(booleanValue AS TINYINT) end ) expr_27693,
						max(case dataFieldObjectid when  27694 then CAST(booleanValue AS TINYINT) end ) expr_27694,
						max(case dataFieldObjectid when  27695 then CAST(booleanValue AS TINYINT) end ) expr_27695,
						max(case dataFieldObjectid when  27696 then CAST(booleanValue AS TINYINT) end ) expr_27696,
						max(case dataFieldObjectid when  27697 then CAST(booleanValue AS TINYINT) end ) expr_27697,
						max(case dataFieldObjectid when  27698 then CAST(booleanValue AS TINYINT) end ) expr_27698,
						max(case dataFieldObjectid when  27699 then CAST(booleanValue AS TINYINT) end ) expr_27699,
						max(case dataFieldObjectid when  27700 then CAST(booleanValue AS TINYINT) end ) expr_27700,
						max(case dataFieldObjectid when  27701 then CAST(booleanValue AS TINYINT) end ) expr_27701,
						max(case dataFieldObjectid when  27702 then CAST(booleanValue AS TINYINT) end ) expr_27702,
						max(case dataFieldObjectid when  27703 then CAST(booleanValue AS TINYINT) end ) expr_27703,
						max(case dataFieldObjectid when  27704 then CAST(booleanValue AS TINYINT) end ) expr_27704,
						max(case dataFieldObjectid when  27705 then CAST(booleanValue AS TINYINT) end ) expr_27705,
						max(case dataFieldObjectid when  27706 then CAST(booleanValue AS TINYINT) end ) expr_27706,
						max(case dataFieldObjectid when  27707 then CAST(booleanValue AS TINYINT) end ) expr_27707,
						max(case dataFieldObjectid when  27708 then CAST(booleanValue AS TINYINT) end ) expr_27708,
						max(case dataFieldObjectid when  27709 then CAST(booleanValue AS TINYINT) end ) expr_27709,
						max(case dataFieldObjectid when  27710 then CAST(booleanValue AS TINYINT) end ) expr_27710,
						max(case dataFieldObjectid when  27711 then CAST(booleanValue AS TINYINT) end ) expr_27711,
						max(case dataFieldObjectid when  27712 then CAST(booleanValue AS TINYINT) end ) expr_27712,
						max(case dataFieldObjectid when  27713 then CAST(booleanValue AS TINYINT) end ) expr_27713,
						max(case dataFieldObjectid when  27714 then CAST(booleanValue AS TINYINT) end ) expr_27714,
						max(case dataFieldObjectid when  27715 then CAST(booleanValue AS TINYINT) end ) expr_27715,
						max(case dataFieldObjectid when  27716 then CAST(booleanValue AS TINYINT) end ) expr_27716,
						max(case dataFieldObjectid when  27717 then CAST(booleanValue AS TINYINT) end ) expr_27717,
						max(case dataFieldObjectid when  27718 then CAST(booleanValue AS TINYINT) end ) expr_27718,
						max(case dataFieldObjectid when  27719 then CAST(booleanValue AS TINYINT) end ) expr_27719,
						max(case dataFieldObjectid when  27720 then CAST(booleanValue AS TINYINT) end ) expr_27720,
						max(case dataFieldObjectid when  27721 then CAST(booleanValue AS TINYINT) end ) expr_27721,
						max(case dataFieldObjectid when  27722 then CAST(booleanValue AS TINYINT) end ) expr_27722,
						max(case dataFieldObjectid when  27723 then CAST(booleanValue AS TINYINT) end ) expr_27723,
						max(case dataFieldObjectid when  27724 then CAST(booleanValue AS TINYINT) end ) expr_27724,
						max(case dataFieldObjectid when  27725 then CAST(booleanValue AS TINYINT) end ) expr_27725,
						max(case dataFieldObjectid when  27726 then CAST(booleanValue AS TINYINT) end ) expr_27726,
						max(case dataFieldObjectid when  27727 then CAST(booleanValue AS TINYINT) end ) expr_27727,
						max(case dataFieldObjectid when  27728 then CAST(booleanValue AS TINYINT) end ) expr_27728,
						max(case dataFieldObjectid when  27729 then CAST(booleanValue AS TINYINT) end ) expr_27729,
						max(case dataFieldObjectid when  27730 then CAST(booleanValue AS TINYINT) end ) expr_27730,
						max(case dataFieldObjectid when  27731 then CAST(booleanValue AS TINYINT) end ) expr_27731,
						max(case dataFieldObjectid when  27732 then CAST(booleanValue AS TINYINT) end ) expr_27732,
						max(case dataFieldObjectid when  27733 then CAST(booleanValue AS TINYINT) end ) expr_27733,
						max(case dataFieldObjectid when  27734 then CAST(booleanValue AS TINYINT) end ) expr_27734,
						max(case dataFieldObjectid when  27735 then CAST(booleanValue AS TINYINT) end ) expr_27735,
						max(case dataFieldObjectid when  27736 then CAST(booleanValue AS TINYINT) end ) expr_27736,
						max(case dataFieldObjectid when  27737 then CAST(booleanValue AS TINYINT) end ) expr_27737,
						max(case dataFieldObjectid when  27738 then CAST(booleanValue AS TINYINT) end ) expr_27738,
						max(case dataFieldObjectid when  27739 then CAST(booleanValue AS TINYINT) end ) expr_27739,
						max(case dataFieldObjectid when  27740 then CAST(booleanValue AS TINYINT) end ) expr_27740,
						max(case dataFieldObjectid when  27741 then CAST(booleanValue AS TINYINT) end ) expr_27741,
						max(case dataFieldObjectid when  27742 then CAST(booleanValue AS TINYINT) end ) expr_27742,
						max(case dataFieldObjectid when  27743 then CAST(booleanValue AS TINYINT) end ) expr_27743,
						max(case dataFieldObjectid when  27744 then CAST(booleanValue AS TINYINT) end ) expr_27744,
						max(case dataFieldObjectid when  27745 then CAST(booleanValue AS TINYINT) end ) expr_27745,
						max(case dataFieldObjectid when  27746 then CAST(booleanValue AS TINYINT) end ) expr_27746,
						max(case dataFieldObjectid when  27747 then CAST(booleanValue AS TINYINT) end ) expr_27747,
						max(case dataFieldObjectid when  27748 then CAST(booleanValue AS TINYINT) end ) expr_27748,
						max(case dataFieldObjectid when  27749 then CAST(booleanValue AS TINYINT) end ) expr_27749,
						max(case dataFieldObjectid when  27750 then CAST(booleanValue AS TINYINT) end ) expr_27750,
						max(case dataFieldObjectid when  27751 then CAST(booleanValue AS TINYINT) end ) expr_27751,
						max(case dataFieldObjectid when  27752 then CAST(booleanValue AS TINYINT) end ) expr_27752,
						max(case dataFieldObjectid when  27753 then CAST(booleanValue AS TINYINT) end ) expr_27753,
						max(case dataFieldObjectid when  27754 then CAST(booleanValue AS TINYINT) end ) expr_27754,
						max(case dataFieldObjectid when  27755 then CAST(booleanValue AS TINYINT) end ) expr_27755,
						max(case dataFieldObjectid when  27756 then CAST(booleanValue AS TINYINT) end ) expr_27756,
						max(case dataFieldObjectid when  27757 then CAST(booleanValue AS TINYINT) end ) expr_27757,
						max(case dataFieldObjectid when  27758 then CAST(booleanValue AS TINYINT) end ) expr_27758,
						max(case dataFieldObjectid when  27759 then CAST(booleanValue AS TINYINT) end ) expr_27759,
						max(case dataFieldObjectid when  27760 then CAST(booleanValue AS TINYINT) end ) expr_27760,
						max(case dataFieldObjectid when  27761 then CAST(booleanValue AS TINYINT) end ) expr_27761,
						max(case dataFieldObjectid when  27762 then CAST(booleanValue AS TINYINT) end ) expr_27762,
						max(case dataFieldObjectid when  27763 then CAST(booleanValue AS TINYINT) end ) expr_27763,
						max(case dataFieldObjectid when  27764 then CAST(booleanValue AS TINYINT) end ) expr_27764,
						max(case dataFieldObjectid when  27765 then CAST(booleanValue AS TINYINT) end ) expr_27765,
						max(case dataFieldObjectid when  27766 then CAST(booleanValue AS TINYINT) end ) expr_27766,
						max(case dataFieldObjectid when  27767 then CAST(booleanValue AS TINYINT) end ) expr_27767,
						max(case dataFieldObjectid when  27768 then CAST(booleanValue AS TINYINT) end ) expr_27768,
						max(case dataFieldObjectid when  27769 then CAST(booleanValue AS TINYINT) end ) expr_27769,
						max(case dataFieldObjectid when  27770 then CAST(booleanValue AS TINYINT) end ) expr_27770,
						max(case dataFieldObjectid when  27771 then CAST(booleanValue AS TINYINT) end ) expr_27771,
						max(case dataFieldObjectid when  27772 then CAST(booleanValue AS TINYINT) end ) expr_27772,
						max(case dataFieldObjectid when  27773 then CAST(booleanValue AS TINYINT) end ) expr_27773,
						max(case dataFieldObjectid when  27774 then CAST(booleanValue AS TINYINT) end ) expr_27774,
						max(case dataFieldObjectid when  27775 then CAST(booleanValue AS TINYINT) end ) expr_27775,
						max(case dataFieldObjectid when  27776 then CAST(booleanValue AS TINYINT) end ) expr_27776,
						max(case dataFieldObjectid when  27777 then CAST(booleanValue AS TINYINT) end ) expr_27777,
						max(case dataFieldObjectid when  27778 then CAST(booleanValue AS TINYINT) end ) expr_27778,
						max(case dataFieldObjectid when  27779 then CAST(booleanValue AS TINYINT) end ) expr_27779,
						max(case dataFieldObjectid when  27780 then CAST(booleanValue AS TINYINT) end ) expr_27780,
						max(case dataFieldObjectid when  27781 then CAST(booleanValue AS TINYINT) end ) expr_27781,
						max(case dataFieldObjectid when  27782 then CAST(booleanValue AS TINYINT) end ) expr_27782,
						max(case dataFieldObjectid when  27783 then CAST(booleanValue AS TINYINT) end ) expr_27783,
						max(case dataFieldObjectid when  27784 then CAST(booleanValue AS TINYINT) end ) expr_27784,
						max(case dataFieldObjectid when  27785 then CAST(booleanValue AS TINYINT) end ) expr_27785,
						max(case dataFieldObjectid when  27786 then CAST(booleanValue AS TINYINT) end ) expr_27786,
						max(case dataFieldObjectid when  27787 then CAST(booleanValue AS TINYINT) end ) expr_27787,
						max(case dataFieldObjectid when  27788 then CAST(booleanValue AS TINYINT) end ) expr_27788,
						max(case dataFieldObjectid when  27789 then CAST(booleanValue AS TINYINT) end ) expr_27789,
						max(case dataFieldObjectid when  27790 then CAST(booleanValue AS TINYINT) end ) expr_27790,
						max(case dataFieldObjectid when  27791 then CAST(booleanValue AS TINYINT) end ) expr_27791,
						max(case dataFieldObjectid when  27792 then CAST(booleanValue AS TINYINT) end ) expr_27792,
						max(case dataFieldObjectid when  27793 then CAST(booleanValue AS TINYINT) end ) expr_27793,
						max(case dataFieldObjectid when  27794 then CAST(booleanValue AS TINYINT) end ) expr_27794,
						max(case dataFieldObjectid when  27795 then CAST(booleanValue AS TINYINT) end ) expr_27795,
						max(case dataFieldObjectid when  27796 then CAST(booleanValue AS TINYINT) end ) expr_27796,
						max(case dataFieldObjectid when  27797 then CAST(booleanValue AS TINYINT) end ) expr_27797,
						max(case dataFieldObjectid when  27798 then CAST(booleanValue AS TINYINT) end ) expr_27798,
						max(case dataFieldObjectid when  27799 then CAST(booleanValue AS TINYINT) end ) expr_27799,
						max(case dataFieldObjectid when  27800 then CAST(booleanValue AS TINYINT) end ) expr_27800,
						max(case dataFieldObjectid when  27801 then CAST(booleanValue AS TINYINT) end ) expr_27801,
						max(case dataFieldObjectid when  27802 then CAST(booleanValue AS TINYINT) end ) expr_27802,
						max(case dataFieldObjectid when  27803 then CAST(booleanValue AS TINYINT) end ) expr_27803,
						max(case dataFieldObjectid when  27804 then CAST(booleanValue AS TINYINT) end ) expr_27804,
						max(case dataFieldObjectid when  27805 then CAST(booleanValue AS TINYINT) end ) expr_27805,
						max(case dataFieldObjectid when  27806 then CAST(booleanValue AS TINYINT) end ) expr_27806,
						max(case dataFieldObjectid when  27807 then CAST(booleanValue AS TINYINT) end ) expr_27807,
						max(case dataFieldObjectid when  27808 then CAST(booleanValue AS TINYINT) end ) expr_27808,
						max(case dataFieldObjectid when  27809 then CAST(booleanValue AS TINYINT) end ) expr_27809,
						max(case dataFieldObjectid when  27810 then CAST(booleanValue AS TINYINT) end ) expr_27810,
						max(case dataFieldObjectid when  27811 then CAST(booleanValue AS TINYINT) end ) expr_27811,
						max(case dataFieldObjectid when  27812 then CAST(booleanValue AS TINYINT) end ) expr_27812,
						max(case dataFieldObjectid when  27813 then CAST(booleanValue AS TINYINT) end ) expr_27813,
						max(case dataFieldObjectid when  27814 then CAST(booleanValue AS TINYINT) end ) expr_27814,
						max(case dataFieldObjectid when  27815 then CAST(booleanValue AS TINYINT) end ) expr_27815,
						max(case dataFieldObjectid when  27816 then CAST(booleanValue AS TINYINT) end ) expr_27816,
						max(case dataFieldObjectid when  27817 then CAST(booleanValue AS TINYINT) end ) expr_27817,
						max(case dataFieldObjectid when  27818 then CAST(booleanValue AS TINYINT) end ) expr_27818,
						max(case dataFieldObjectid when  27819 then CAST(booleanValue AS TINYINT) end ) expr_27819,
						max(case dataFieldObjectid when  27820 then CAST(booleanValue AS TINYINT) end ) expr_27820,
						max(case dataFieldObjectid when  27821 then CAST(booleanValue AS TINYINT) end ) expr_27821,
						max(case dataFieldObjectid when  27822 then CAST(booleanValue AS TINYINT) end ) expr_27822,
						max(case dataFieldObjectid when  27823 then CAST(booleanValue AS TINYINT) end ) expr_27823,
						max(case dataFieldObjectid when  27824 then CAST(booleanValue AS TINYINT) end ) expr_27824,
						max(case dataFieldObjectid when  27825 then CAST(booleanValue AS TINYINT) end ) expr_27825,
						max(case dataFieldObjectid when  27826 then CAST(booleanValue AS TINYINT) end ) expr_27826,
						max(case dataFieldObjectid when  27827 then CAST(booleanValue AS TINYINT) end ) expr_27827,
						max(case dataFieldObjectid when  27828 then CAST(booleanValue AS TINYINT) end ) expr_27828,
						max(case dataFieldObjectid when  27829 then CAST(booleanValue AS TINYINT) end ) expr_27829,
						max(case dataFieldObjectid when  27830 then CAST(booleanValue AS TINYINT) end ) expr_27830,
						max(case dataFieldObjectid when  27831 then CAST(booleanValue AS TINYINT) end ) expr_27831,
						max(case dataFieldObjectid when  27832 then CAST(booleanValue AS TINYINT) end ) expr_27832,
						max(case dataFieldObjectid when  27833 then CAST(booleanValue AS TINYINT) end ) expr_27833,
						max(case dataFieldObjectid when  27834 then CAST(booleanValue AS TINYINT) end ) expr_27834,
						max(case dataFieldObjectid when  27835 then CAST(booleanValue AS TINYINT) end ) expr_27835,
						max(case dataFieldObjectid when  27836 then CAST(booleanValue AS TINYINT) end ) expr_27836,
						max(case dataFieldObjectid when  27837 then CAST(booleanValue AS TINYINT) end ) expr_27837,
						max(case dataFieldObjectid when  27838 then CAST(booleanValue AS TINYINT) end ) expr_27838,
						max(case dataFieldObjectid when  27839 then CAST(booleanValue AS TINYINT) end ) expr_27839,
						max(case dataFieldObjectid when  27840 then CAST(booleanValue AS TINYINT) end ) expr_27840,
						max(case dataFieldObjectid when  27841 then CAST(booleanValue AS TINYINT) end ) expr_27841,
						max(case dataFieldObjectid when  27842 then CAST(booleanValue AS TINYINT) end ) expr_27842,
						max(case dataFieldObjectid when  27843 then CAST(booleanValue AS TINYINT) end ) expr_27843,
						max(case dataFieldObjectid when  27876 then CAST(booleanValue AS TINYINT) end ) expr_27876,
						max(case dataFieldObjectid when  27877 then CAST(booleanValue AS TINYINT) end ) expr_27877,
						max(case dataFieldObjectid when  27888 then CAST(booleanValue AS TINYINT) end ) expr_27888,
						max(case dataFieldObjectid when  27928 then CAST(booleanValue AS TINYINT) end ) expr_27928,
						max(case dataFieldObjectid when  27929 then CAST(booleanValue AS TINYINT) end ) expr_27929,
						max(case dataFieldObjectid when  27930 then CAST(booleanValue AS TINYINT) end ) expr_27930,
						max(case dataFieldObjectid when  27931 then CAST(booleanValue AS TINYINT) end ) expr_27931,
						max(case dataFieldObjectid when  27932 then CAST(booleanValue AS TINYINT) end ) expr_27932,
						max(case dataFieldObjectid when  27933 then CAST(booleanValue AS TINYINT) end ) expr_27933,
						max(case dataFieldObjectid when  27934 then CAST(booleanValue AS TINYINT) end ) expr_27934,
						max(case dataFieldObjectid when  27935 then CAST(booleanValue AS TINYINT) end ) expr_27935,
						max(case dataFieldObjectid when  27936 then CAST(booleanValue AS TINYINT) end ) expr_27936,
						max(case dataFieldObjectid when  27937 then CAST(booleanValue AS TINYINT) end ) expr_27937,
						max(case dataFieldObjectid when  27938 then CAST(booleanValue AS TINYINT) end ) expr_27938,
						max(case dataFieldObjectid when  27939 then CAST(booleanValue AS TINYINT) end ) expr_27939,
						max(case dataFieldObjectid when  27940 then CAST(booleanValue AS TINYINT) end ) expr_27940,
						max(case dataFieldObjectid when  27941 then CAST(booleanValue AS TINYINT) end ) expr_27941,
						max(case dataFieldObjectid when  27942 then CAST(booleanValue AS TINYINT) end ) expr_27942,
						max(case dataFieldObjectid when  27943 then CAST(booleanValue AS TINYINT) end ) expr_27943,
						max(case dataFieldObjectid when  27944 then CAST(booleanValue AS TINYINT) end ) expr_27944,
						max(case dataFieldObjectid when  27945 then CAST(booleanValue AS TINYINT) end ) expr_27945,
						max(case dataFieldObjectid when  27946 then CAST(booleanValue AS TINYINT) end ) expr_27946,
						max(case dataFieldObjectid when  27947 then CAST(booleanValue AS TINYINT) end ) expr_27947,
						max(case dataFieldObjectid when  27948 then CAST(booleanValue AS TINYINT) end ) expr_27948,
						max(case dataFieldObjectid when  27951 then CAST(booleanValue AS TINYINT) end ) expr_27951,
						max(case dataFieldObjectid when  27952 then CAST(booleanValue AS TINYINT) end ) expr_27952,
						max(case dataFieldObjectid when  27953 then CAST(booleanValue AS TINYINT) end ) expr_27953,
						max(case dataFieldObjectid when  27954 then CAST(booleanValue AS TINYINT) end ) expr_27954,
						max(case dataFieldObjectid when  27955 then CAST(booleanValue AS TINYINT) end ) expr_27955,
						max(case dataFieldObjectid when  27956 then CAST(booleanValue AS TINYINT) end ) expr_27956,
						max(case dataFieldObjectid when  27957 then CAST(booleanValue AS TINYINT) end ) expr_27957,
						max(case dataFieldObjectid when  27958 then CAST(booleanValue AS TINYINT) end ) expr_27958,
						max(case dataFieldObjectid when  27959 then CAST(booleanValue AS TINYINT) end ) expr_27959,
						max(case dataFieldObjectid when  27960 then CAST(booleanValue AS TINYINT) end ) expr_27960,
						max(case dataFieldObjectid when  27961 then CAST(booleanValue AS TINYINT) end ) expr_27961,
						max(case dataFieldObjectid when  27962 then CAST(booleanValue AS TINYINT) end ) expr_27962,
						--max(case dataFieldObjectid when  27988 then CAST(booleanValue AS TINYINT) end ) expr_27988,
						max(case dataFieldObjectid when  27989 then CAST(booleanValue AS TINYINT) end ) expr_27989,
						max(case dataFieldObjectid when  27990 then CAST(booleanValue AS TINYINT) end ) expr_27990,
						max(case dataFieldObjectid when  27992 then CAST(booleanValue AS TINYINT) end ) expr_27992,
						max(case dataFieldObjectid when  27993 then CAST(booleanValue AS TINYINT) end ) expr_27993,
						max(case dataFieldObjectid when  27994 then CAST(booleanValue AS TINYINT) end ) expr_27994,
						max(case dataFieldObjectid when  27995 then CAST(booleanValue AS TINYINT) end ) expr_27995,
						max(case dataFieldObjectid when  27996 then CAST(booleanValue AS TINYINT) end ) expr_27996,
						max(case dataFieldObjectid when  27997 then CAST(booleanValue AS TINYINT) end ) expr_27997,
	                    max(case dataFieldObjectId when 26569 then dataFieldOptionObjectId end) expr_26569,
	                    max(case dataFieldObjectId when 27988 then dataFieldOptionObjectId end) expr_27988,
						max(case dataFieldObjectid when  33113 then CAST(booleanValue AS TINYINT) end ) expr_33113,
						max(case dataFieldObjectid when  33114 then CAST(booleanValue AS TINYINT) end ) expr_33114,
						max(case dataFieldObjectid when  33115 then CAST(booleanValue AS TINYINT) end ) expr_33115,
						max(case dataFieldObjectid when  33116 then CAST(booleanValue AS TINYINT) end ) expr_33116,
						max(case dataFieldObjectid when  33117 then CAST(booleanValue AS TINYINT) end ) expr_33117,
						max(case dataFieldObjectid when  33118 then CAST(booleanValue AS TINYINT) end ) expr_33118,
						max(case dataFieldObjectid when  33119 then CAST(booleanValue AS TINYINT) end ) expr_33119,
						max(case dataFieldObjectid when  33120 then CAST(booleanValue AS TINYINT) end ) expr_33120,
						max(case dataFieldObjectid when  33121 then CAST(booleanValue AS TINYINT) end ) expr_33121,
						max(case dataFieldObjectid when  33122 then CAST(booleanValue AS TINYINT) end ) expr_33122,
						max(case dataFieldObjectid when  33125 then CAST(booleanValue AS TINYINT) end ) expr_33125,
						max(case dataFieldObjectid when  33126 then CAST(booleanValue AS TINYINT) end ) expr_33126,
						max(case dataFieldObjectid when  33127 then CAST(booleanValue AS TINYINT) end ) expr_33127,
						max(case dataFieldObjectid when  33128 then CAST(booleanValue AS TINYINT) end ) expr_33128,
						max(case dataFieldObjectid when  33129 then CAST(booleanValue AS TINYINT) end ) expr_33129,
						max(case dataFieldObjectid when  33130 then CAST(booleanValue AS TINYINT) end ) expr_33130,
						max(case dataFieldObjectid when  33131 then CAST(booleanValue AS TINYINT) end ) expr_33131,

max(case dataFieldObjectid when 37229 then CAST(booleanValue AS TINYINT) end ) expr_37229,
max(case dataFieldObjectid when 37226 then CAST(booleanValue AS TINYINT) end ) expr_37226,
max(case dataFieldObjectid when 37230 then CAST(booleanValue AS TINYINT) end ) expr_37230,
max(case dataFieldObjectid when 37232 then CAST(booleanValue AS TINYINT) end ) expr_37232,
max(case dataFieldObjectid when 37231 then CAST(booleanValue AS TINYINT) end ) expr_37231,
max(case dataFieldObjectid when 37233 then CAST(booleanValue AS TINYINT) end ) expr_37233,
max(case dataFieldObjectid when 37235 then CAST(booleanValue AS TINYINT) end ) expr_37235,
max(case dataFieldObjectid when 37234 then CAST(booleanValue AS TINYINT) end ) expr_37234,
max(case dataFieldObjectid when 37236 then CAST(booleanValue AS TINYINT) end ) expr_37236,
max(case dataFieldObjectid when 37238 then CAST(booleanValue AS TINYINT) end ) expr_37238,
max(case dataFieldObjectid when 37237 then CAST(booleanValue AS TINYINT) end ) expr_37237,
max(case dataFieldObjectid when 37239 then CAST(booleanValue AS TINYINT) end ) expr_37239,
max(case dataFieldObjectid when 37241 then CAST(booleanValue AS TINYINT) end ) expr_37241,
max(case dataFieldObjectid when 37240 then CAST(booleanValue AS TINYINT) end ) expr_37240,
max(case dataFieldObjectid when 37242 then CAST(booleanValue AS TINYINT) end ) expr_37242,
max(case dataFieldObjectid when 37277 then CAST(booleanValue AS TINYINT) end ) expr_37277,
max(case dataFieldObjectid when 37276 then CAST(booleanValue AS TINYINT) end ) expr_37276,
max(case dataFieldObjectid when 37278 then CAST(booleanValue AS TINYINT) end ) expr_37278,
max(case dataFieldObjectid when 37244 then CAST(booleanValue AS TINYINT) end ) expr_37244,
max(case dataFieldObjectid when 37247 then CAST(booleanValue AS TINYINT) end ) expr_37247,
max(case dataFieldObjectid when 37250 then CAST(booleanValue AS TINYINT) end ) expr_37250,
max(case dataFieldObjectid when 37253 then CAST(booleanValue AS TINYINT) end ) expr_37253,
max(case dataFieldObjectid when 37256 then CAST(booleanValue AS TINYINT) end ) expr_37256,
max(case dataFieldObjectid when 37259 then CAST(booleanValue AS TINYINT) end ) expr_37259,
max(case dataFieldObjectid when 37262 then CAST(booleanValue AS TINYINT) end ) expr_37262,
max(case dataFieldObjectid when 37265 then CAST(booleanValue AS TINYINT) end ) expr_37265,
max(case dataFieldObjectid when 37268 then CAST(booleanValue AS TINYINT) end ) expr_37268,
max(case dataFieldObjectid when 37271 then CAST(booleanValue AS TINYINT) end ) expr_37271,
max(case dataFieldObjectid when 37274 then CAST(booleanValue AS TINYINT) end ) expr_37274,
max(case dataFieldObjectid when 37243 then CAST(booleanValue AS TINYINT) end ) expr_37243,
max(case dataFieldObjectid when 37246 then CAST(booleanValue AS TINYINT) end ) expr_37246,
max(case dataFieldObjectid when 37249 then CAST(booleanValue AS TINYINT) end ) expr_37249,
max(case dataFieldObjectid when 37252 then CAST(booleanValue AS TINYINT) end ) expr_37252,
max(case dataFieldObjectid when 37255 then CAST(booleanValue AS TINYINT) end ) expr_37255,
max(case dataFieldObjectid when 37258 then CAST(booleanValue AS TINYINT) end ) expr_37258,
max(case dataFieldObjectid when 37261 then CAST(booleanValue AS TINYINT) end ) expr_37261,
max(case dataFieldObjectid when 37264 then CAST(booleanValue AS TINYINT) end ) expr_37264,
max(case dataFieldObjectid when 37267 then CAST(booleanValue AS TINYINT) end ) expr_37267,
max(case dataFieldObjectid when 37270 then CAST(booleanValue AS TINYINT) end ) expr_37270,
max(case dataFieldObjectid when 37273 then CAST(booleanValue AS TINYINT) end ) expr_37273,
max(case dataFieldObjectid when 37245 then CAST(booleanValue AS TINYINT) end ) expr_37245,
max(case dataFieldObjectid when 37248 then CAST(booleanValue AS TINYINT) end ) expr_37248,
max(case dataFieldObjectid when 37251 then CAST(booleanValue AS TINYINT) end ) expr_37251,
max(case dataFieldObjectid when 37254 then CAST(booleanValue AS TINYINT) end ) expr_37254,
max(case dataFieldObjectid when 37257 then CAST(booleanValue AS TINYINT) end ) expr_37257,
max(case dataFieldObjectid when 37260 then CAST(booleanValue AS TINYINT) end ) expr_37260,
max(case dataFieldObjectid when 37263 then CAST(booleanValue AS TINYINT) end ) expr_37263,
max(case dataFieldObjectid when 37266 then CAST(booleanValue AS TINYINT) end ) expr_37266,
max(case dataFieldObjectid when 37269 then CAST(booleanValue AS TINYINT) end ) expr_37269,
max(case dataFieldObjectid when 37272 then CAST(booleanValue AS TINYINT) end ) expr_37272,
max(case dataFieldObjectid when 37275 then CAST(booleanValue AS TINYINT) end ) expr_37275,
	                    max(case dataFieldObjectId when 39540  then dataFieldOptionObjectId end) expr_39540,
max(case datafieldObjectid when  43647 then CAST(booleanValue AS TINYINT) end )  expr_43647,
max(case datafieldObjectid when  43648 then CAST(booleanValue AS TINYINT) end )  expr_43648,
max(case datafieldObjectid when  43649 then CAST(booleanValue AS TINYINT) end )  expr_43649,
max(case datafieldObjectid when  43805 then CAST(booleanValue AS TINYINT) end )  expr_43805,
max(case datafieldObjectid when  43615 then CAST(booleanValue AS TINYINT) end )  expr_43615,
max(case datafieldObjectid when  43616 then CAST(booleanValue AS TINYINT) end )  expr_43616,
max(case datafieldObjectid when  43617 then CAST(booleanValue AS TINYINT) end )  expr_43617,
max(case datafieldObjectid when  43800 then CAST(booleanValue AS TINYINT) end )  expr_43800,
max(case datafieldObjectid when  43759 then CAST(booleanValue AS TINYINT) end )  expr_43759,
max(case datafieldObjectid when  43760 then CAST(booleanValue AS TINYINT) end )  expr_43760,
max(case datafieldObjectid when  43761 then CAST(booleanValue AS TINYINT) end )  expr_43761,
max(case datafieldObjectid when  43810 then CAST(booleanValue AS TINYINT) end )  expr_43810,
max(case datafieldObjectid when  43968 then CAST(booleanValue AS TINYINT) end )  expr_43968,
max(case datafieldObjectid when  43969 then CAST(booleanValue AS TINYINT) end )  expr_43969,
max(case datafieldObjectid when  43970 then CAST(booleanValue AS TINYINT) end )  expr_43970,
max(case datafieldObjectid when  43971 then CAST(booleanValue AS TINYINT) end )  expr_43971,
max(case datafieldObjectid when  43972 then CAST(booleanValue AS TINYINT) end )  expr_43972,
max(case datafieldObjectid when  43973 then CAST(booleanValue AS TINYINT) end )  expr_43973,
max(case datafieldObjectid when  43974 then CAST(booleanValue AS TINYINT) end )  expr_43974,
max(case datafieldObjectid when  43975 then CAST(booleanValue AS TINYINT) end )  expr_43975,
max(case datafieldObjectid when  43807 then CAST(booleanValue AS TINYINT) end )  expr_43807,
max(case datafieldObjectid when  43808 then CAST(booleanValue AS TINYINT) end )  expr_43808,
max(case datafieldObjectid when  43809 then CAST(booleanValue AS TINYINT) end )  expr_43809,
max(case datafieldObjectid when  43651 then CAST(booleanValue AS TINYINT) end )  expr_43651,
max(case datafieldObjectid when  43652 then CAST(booleanValue AS TINYINT) end )  expr_43652,
max(case datafieldObjectid when  43653 then CAST(booleanValue AS TINYINT) end )  expr_43653,
max(case datafieldObjectid when  43656 then CAST(booleanValue AS TINYINT) end )  expr_43656,
max(case datafieldObjectid when  43657 then CAST(booleanValue AS TINYINT) end )  expr_43657,
max(case datafieldObjectid when  43658 then CAST(booleanValue AS TINYINT) end )  expr_43658,
max(case datafieldObjectid when  43660 then CAST(booleanValue AS TINYINT) end )  expr_43660,
max(case datafieldObjectid when  43661 then CAST(booleanValue AS TINYINT) end )  expr_43661,
max(case datafieldObjectid when  43662 then CAST(booleanValue AS TINYINT) end )  expr_43662,
max(case datafieldObjectid when  43801 then CAST(booleanValue AS TINYINT) end )  expr_43801,
max(case datafieldObjectid when  43802 then CAST(booleanValue AS TINYINT) end )  expr_43802,
max(case datafieldObjectid when  43803 then CAST(booleanValue AS TINYINT) end )  expr_43803,
max(case datafieldObjectid when  43622 then CAST(booleanValue AS TINYINT) end )  expr_43622,
max(case datafieldObjectid when  43631 then CAST(booleanValue AS TINYINT) end )  expr_43631,
max(case datafieldObjectid when  43632 then CAST(booleanValue AS TINYINT) end )  expr_43632,
max(case datafieldObjectid when  43637 then CAST(booleanValue AS TINYINT) end )  expr_43637,
max(case datafieldObjectid when  43638 then CAST(booleanValue AS TINYINT) end )  expr_43638,
max(case datafieldObjectid when  43639 then CAST(booleanValue AS TINYINT) end )  expr_43639,
max(case datafieldObjectid when  43641 then CAST(booleanValue AS TINYINT) end )  expr_43641,
max(case datafieldObjectid when  43644 then CAST(booleanValue AS TINYINT) end )  expr_43644,
max(case datafieldObjectid when  43645 then CAST(booleanValue AS TINYINT) end )  expr_43645,
max(case datafieldObjectid when  43646 then CAST(booleanValue AS TINYINT) end )  expr_43646,
max(case datafieldObjectid when  43584 then CAST(booleanValue AS TINYINT) end )  expr_43584,
max(case datafieldObjectid when  43585 then CAST(booleanValue AS TINYINT) end )  expr_43585,
max(case datafieldObjectid when  43587 then CAST(booleanValue AS TINYINT) end )  expr_43587,
max(case datafieldObjectid when  43799 then CAST(booleanValue AS TINYINT) end )  expr_43799,
--added4/2/2011
max(case datafieldObjectid when  43618 then CAST(booleanValue AS TINYINT) end )  expr_43618,
max(case datafieldObjectid when  43619 then CAST(booleanValue AS TINYINT) end )  expr_43619,
max(case datafieldObjectid when  43620 then CAST(booleanValue AS TINYINT) end )  expr_43620,
max(case datafieldObjectid when  43621 then CAST(booleanValue AS TINYINT) end )  expr_43621,
max(case datafieldObjectid when  43633 then CAST(booleanValue AS TINYINT) end )  expr_43633,
max(case datafieldObjectid when  43634 then CAST(booleanValue AS TINYINT) end )  expr_43634,
max(case datafieldObjectid when  43635 then CAST(booleanValue AS TINYINT) end )  expr_43635,
max(case datafieldObjectid when  43636 then CAST(booleanValue AS TINYINT) end )  expr_43636,
max(case datafieldObjectid when  43640 then CAST(booleanValue AS TINYINT) end )  expr_43640,
max(case datafieldObjectid when  43642 then CAST(booleanValue AS TINYINT) end )  expr_43642,
max(case datafieldObjectid when  43650 then CAST(booleanValue AS TINYINT) end )  expr_43650,
max(case datafieldObjectid when  43655 then CAST(booleanValue AS TINYINT) end )  expr_43655,
max(case datafieldObjectid when  43659 then CAST(booleanValue AS TINYINT) end )  expr_43659,

--added 5/1/2011
max(case datafieldobjectid when 45760 then cast (BooleanValue as Tinyint) end) expr_45760,
max(case datafieldobjectid when 45739 then cast (BooleanValue as Tinyint) end) expr_45739,
max(case datafieldobjectid when 45740 then cast (BooleanValue as Tinyint) end) expr_45740,
max(case datafieldobjectid when 45741 then cast (BooleanValue as Tinyint) end) expr_45741,
max(case datafieldobjectid when 45742 then cast (BooleanValue as Tinyint) end) expr_45742,
max(case datafieldobjectid when 45743 then cast (BooleanValue as Tinyint) end) expr_45743,
max(case datafieldobjectid when 45744 then cast (BooleanValue as Tinyint) end) expr_45744,
max(case datafieldobjectid when 45745 then cast (BooleanValue as Tinyint) end) expr_45745,
max(case datafieldobjectid when 45746 then cast (BooleanValue as Tinyint) end) expr_45746,
max(case datafieldobjectid when 45747 then cast (BooleanValue as Tinyint) end) expr_45747,
max(case datafieldobjectid when 45748 then cast (BooleanValue as Tinyint) end) expr_45748,
max(case datafieldobjectid when 45749 then cast (BooleanValue as Tinyint) end) expr_45749,
max(case datafieldobjectid when 45761 then cast (BooleanValue as Tinyint) end) expr_45761,
max(case datafieldobjectid when 45750 then cast (BooleanValue as Tinyint) end) expr_45750,
max(case datafieldobjectid when 45751 then cast (BooleanValue as Tinyint) end) expr_45751,
max(case datafieldobjectid when 45752 then cast (BooleanValue as Tinyint) end) expr_45752,
max(case datafieldobjectid when 45753 then cast (BooleanValue as Tinyint) end) expr_45753,
max(case datafieldobjectid when 45754 then cast (BooleanValue as Tinyint) end) expr_45754,
max(case datafieldobjectid when 45755 then cast (BooleanValue as Tinyint) end) expr_45755,
max(case datafieldobjectid when 45756 then cast (BooleanValue as Tinyint) end) expr_45756,
max(case datafieldobjectid when 45757 then cast (BooleanValue as Tinyint) end) expr_45757,
max(case datafieldobjectid when 45758 then cast (BooleanValue as Tinyint) end) expr_45758,
max(case datafieldobjectid when 45759 then cast (BooleanValue as Tinyint) end) expr_45759,
--5/2
max(case datafieldobjectid when 46408 then cast (BooleanValue as Tinyint) end) expr_46408,
max(case datafieldobjectid when 46375 then cast (BooleanValue as Tinyint) end) expr_46375,
max(case datafieldobjectid when 46376 then cast (BooleanValue as Tinyint) end) expr_46376,
max(case datafieldobjectid when 46377 then cast (BooleanValue as Tinyint) end) expr_46377,
max(case datafieldobjectid when 46378 then cast (BooleanValue as Tinyint) end) expr_46378,
max(case datafieldobjectid when 46380 then cast (BooleanValue as Tinyint) end) expr_46380,
max(case datafieldobjectid when 46389 then cast (BooleanValue as Tinyint) end) expr_46389,
max(case datafieldobjectid when 46391 then cast (BooleanValue as Tinyint) end) expr_46391,
max(case datafieldobjectid when 46399 then cast (BooleanValue as Tinyint) end) expr_46399,
max(case datafieldobjectid when 46400 then cast (BooleanValue as Tinyint) end) expr_46400,
max(case datafieldobjectid when 46401 then cast (BooleanValue as Tinyint) end) expr_46401,
max(case datafieldobjectid when 46402 then cast (BooleanValue as Tinyint) end) expr_46402,
max(case datafieldobjectid when 46403 then cast (BooleanValue as Tinyint) end) expr_46403,
max(case datafieldobjectid when 46382 then cast (BooleanValue as Tinyint) end) expr_46382,
max(case datafieldobjectid when 46381 then cast (BooleanValue as Tinyint) end) expr_46381,
max(case datafieldobjectid when 46383 then cast (BooleanValue as Tinyint) end) expr_46383,
max(case datafieldobjectid when 46384 then cast (BooleanValue as Tinyint) end) expr_46384,
max(case datafieldobjectid when 46385 then cast (BooleanValue as Tinyint) end) expr_46385,
max(case datafieldobjectid when 46386 then cast (BooleanValue as Tinyint) end) expr_46386,
max(case datafieldobjectid when 46387 then cast (BooleanValue as Tinyint) end) expr_46387,
max(case datafieldobjectid when 46388 then cast (BooleanValue as Tinyint) end) expr_46388,

--added 7/5/2008
max(case datafieldobjectid when 46793 then cast (BooleanValue as Tinyint) end) expr_46793,
max(case datafieldobjectid when 46789 then cast (BooleanValue as Tinyint) end) expr_46789,
max(case datafieldobjectid when 46790 then cast (BooleanValue as Tinyint) end) expr_46790,
max(case datafieldobjectid when 46791 then cast (BooleanValue as Tinyint) end) expr_46791,
max(case datafieldobjectid when 46792 then cast (BooleanValue as Tinyint) end) expr_46792,
max(case datafieldobjectid when 46954 then cast (BooleanValue as Tinyint) end) expr_46954,
max(case datafieldobjectid when 46794 then cast (BooleanValue as Tinyint) end) expr_46794,
max(case datafieldobjectid when 46795 then cast (BooleanValue as Tinyint) end) expr_46795,
max(case datafieldobjectid when 46796 then cast (BooleanValue as Tinyint) end) expr_46796,
max(case datafieldobjectid when 46797 then cast (BooleanValue as Tinyint) end) expr_46797,
max(case datafieldobjectid when 46798 then cast (BooleanValue as Tinyint) end) expr_46798,
max(case datafieldobjectid when 46799 then cast (BooleanValue as Tinyint) end) expr_46799,
max(case datafieldobjectid when 46800 then cast (BooleanValue as Tinyint) end) expr_46800,
max(case datafieldobjectid when 46801 then cast (BooleanValue as Tinyint) end) expr_46801,
max(case datafieldobjectid when 46803 then cast (BooleanValue as Tinyint) end) expr_46803,
max(case datafieldobjectid when 46804 then cast (BooleanValue as Tinyint) end) expr_46804,
max(case datafieldobjectid when 46807 then cast (BooleanValue as Tinyint) end) expr_46807,
max(case datafieldobjectid when 46808 then cast (BooleanValue as Tinyint) end) expr_46808,
max(case datafieldobjectid when 46811 then cast (BooleanValue as Tinyint) end) expr_46811,
max(case datafieldobjectid when 46812 then cast (BooleanValue as Tinyint) end) expr_46812,
max(case datafieldobjectid when 46814 then cast (BooleanValue as Tinyint) end) expr_46814,
max(case datafieldobjectid when 46817 then cast (BooleanValue as Tinyint) end) expr_46817,
max(case datafieldobjectid when 46999 then cast (BooleanValue as Tinyint) end) expr_46999,
max(case datafieldobjectid when 47000 then cast (BooleanValue as Tinyint) end) expr_47000,

--added 082911
max(case datafieldobjectid when  48874 then cast (BooleanValue as Tinyint) end) expr_48874,
max(case datafieldobjectid when  48497 then cast (BooleanValue as Tinyint) end) expr_48497,
max(case datafieldobjectid when  48498 then cast (BooleanValue as Tinyint) end) expr_48498,
max(case datafieldobjectid when  48499 then cast (BooleanValue as Tinyint) end) expr_48499,
max(case datafieldobjectid when  48500 then cast (BooleanValue as Tinyint) end) expr_48500,
max(case datafieldobjectid when  48501 then cast (BooleanValue as Tinyint) end) expr_48501,
max(case datafieldobjectid when  48502 then cast (BooleanValue as Tinyint) end) expr_48502,
max(case datafieldobjectid when  48889 then cast (BooleanValue as Tinyint) end) expr_48889,
max(case datafieldobjectid when  48539 then cast (BooleanValue as Tinyint) end) expr_48539,
max(case datafieldobjectid when  48540 then cast (BooleanValue as Tinyint) end) expr_48540,
max(case datafieldobjectid when  48541 then cast (BooleanValue as Tinyint) end) expr_48541,
max(case datafieldobjectid when  48542 then cast (BooleanValue as Tinyint) end) expr_48542,
max(case datafieldobjectid when  48543 then cast (BooleanValue as Tinyint) end) expr_48543,
max(case datafieldobjectid when  48544 then cast (BooleanValue as Tinyint) end) expr_48544,
max(case datafieldobjectid when  48890 then cast (BooleanValue as Tinyint) end) expr_48890,
max(case datafieldobjectid when  48588 then cast (BooleanValue as Tinyint) end) expr_48588,
max(case datafieldobjectid when  48589 then cast (BooleanValue as Tinyint) end) expr_48589,
max(case datafieldobjectid when  48590 then cast (BooleanValue as Tinyint) end) expr_48590,
max(case datafieldobjectid when  48591 then cast (BooleanValue as Tinyint) end) expr_48591,
max(case datafieldobjectid when  48592 then cast (BooleanValue as Tinyint) end) expr_48592,
max(case datafieldobjectid when  48605 then cast (BooleanValue as Tinyint) end) expr_48605,
max(case datafieldobjectid when  48607 then cast (BooleanValue as Tinyint) end) expr_48607,
max(case datafieldobjectid when  48608 then cast (BooleanValue as Tinyint) end) expr_48608,
max(case datafieldobjectid when  48891 then cast (BooleanValue as Tinyint) end) expr_48891,
max(case datafieldobjectid when  48561 then cast (BooleanValue as Tinyint) end) expr_48561,
max(case datafieldobjectid when  48563 then cast (BooleanValue as Tinyint) end) expr_48563,
max(case datafieldobjectid when  48565 then cast (BooleanValue as Tinyint) end) expr_48565,
max(case datafieldobjectid when  48566 then cast (BooleanValue as Tinyint) end) expr_48566,
max(case datafieldobjectid when  48568 then cast (BooleanValue as Tinyint) end) expr_48568,
max(case datafieldobjectid when  48582 then cast (BooleanValue as Tinyint) end) expr_48582,
max(case datafieldobjectid when  48583 then cast (BooleanValue as Tinyint) end) expr_48583,
max(case datafieldobjectid when  48584 then cast (BooleanValue as Tinyint) end) expr_48584,
max(case datafieldobjectid when  48585 then cast (BooleanValue as Tinyint) end) expr_48585,
max(case datafieldobjectid when  48586 then cast (BooleanValue as Tinyint) end) expr_48586,
max(case datafieldobjectid when  48587 then cast (BooleanValue as Tinyint) end) expr_48587,
max(case datafieldobjectid when  48885 then cast (BooleanValue as Tinyint) end) expr_48885,
max(case datafieldobjectid when  48518 then cast (BooleanValue as Tinyint) end) expr_48518,
max(case datafieldobjectid when  48521 then cast (BooleanValue as Tinyint) end) expr_48521,
max(case datafieldobjectid when  48522 then cast (BooleanValue as Tinyint) end) expr_48522,
max(case datafieldobjectid when  48523 then cast (BooleanValue as Tinyint) end) expr_48523,
max(case datafieldobjectid when  48524 then cast (BooleanValue as Tinyint) end) expr_48524,
max(case datafieldobjectid when  48525 then cast (BooleanValue as Tinyint) end) expr_48525,
max(case datafieldobjectid when  48526 then cast (BooleanValue as Tinyint) end) expr_48526,
max(case datafieldobjectid when  48527 then cast (BooleanValue as Tinyint) end) expr_48527,
max(case datafieldobjectid when  48528 then cast (BooleanValue as Tinyint) end) expr_48528,
max(case datafieldobjectid when  48875 then cast (BooleanValue as Tinyint) end) expr_48875,
max(case datafieldobjectid when  48477 then cast (BooleanValue as Tinyint) end) expr_48477,
max(case datafieldobjectid when  48481 then cast (BooleanValue as Tinyint) end) expr_48481,
max(case datafieldobjectid when  48482 then cast (BooleanValue as Tinyint) end) expr_48482,
max(case datafieldobjectid when  48483 then cast (BooleanValue as Tinyint) end) expr_48483,
max(case datafieldobjectid when  48484 then cast (BooleanValue as Tinyint) end) expr_48484,
max(case datafieldobjectid when  48485 then cast (BooleanValue as Tinyint) end) expr_48485,
max(case datafieldobjectid when  48486 then cast (BooleanValue as Tinyint) end) expr_48486,
max(case datafieldobjectid when  48488 then cast (BooleanValue as Tinyint) end) expr_48488,
max(case datafieldobjectid when  48503 then cast (BooleanValue as Tinyint) end) expr_48503,
max(case datafieldobjectid when  48507 then cast (BooleanValue as Tinyint) end) expr_48507,
max(case datafieldobjectid when  48512 then cast (BooleanValue as Tinyint) end) expr_48512,
max(case datafieldobjectid when  48489 then cast (BooleanValue as Tinyint) end) expr_48489,
max(case datafieldobjectid when  48508 then cast (BooleanValue as Tinyint) end) expr_48508,
max(case datafieldobjectid when  48513 then cast (BooleanValue as Tinyint) end) expr_48513,
max(case datafieldobjectid when  48504 then cast (BooleanValue as Tinyint) end) expr_48504,
max(case datafieldobjectid when  48509 then cast (BooleanValue as Tinyint) end) expr_48509,
max(case datafieldobjectid when  48514 then cast (BooleanValue as Tinyint) end) expr_48514,
max(case datafieldobjectid when  48505 then cast (BooleanValue as Tinyint) end) expr_48505,
max(case datafieldobjectid when  48510 then cast (BooleanValue as Tinyint) end) expr_48510,
max(case datafieldobjectid when  48515 then cast (BooleanValue as Tinyint) end) expr_48515,
max(case datafieldobjectid when  48506 then cast (BooleanValue as Tinyint) end) expr_48506,
max(case datafieldobjectid when  48511 then cast (BooleanValue as Tinyint) end) expr_48511,
max(case datafieldobjectid when  48517 then cast (BooleanValue as Tinyint) end) expr_48517,
max(case datafieldobjectid when  48661 then cast (BooleanValue as Tinyint) end) expr_48661,
max(case datafieldobjectid when  48665 then cast (BooleanValue as Tinyint) end) expr_48665,
max(case datafieldobjectid when  48666 then cast (BooleanValue as Tinyint) end) expr_48666,
max(case datafieldobjectid when  49827 then cast (BooleanValue as Tinyint) end) expr_49827,
max(case datafieldobjectid when  49809 then cast (BooleanValue as Tinyint) end) expr_49809,
max(case datafieldobjectid when  49810 then cast (BooleanValue as Tinyint) end) expr_49810,
max(case datafieldobjectid when  49811 then cast (BooleanValue as Tinyint) end) expr_49811,
max(case datafieldobjectid when  49812 then cast (BooleanValue as Tinyint) end) expr_49812,
max(case datafieldobjectid when  49813 then cast (BooleanValue as Tinyint) end) expr_49813,
max(case datafieldobjectid when  49821 then cast (BooleanValue as Tinyint) end) expr_49821,
max(case datafieldobjectid when  49823 then cast (BooleanValue as Tinyint) end) expr_49823,
max(case datafieldobjectid when  49824 then cast (BooleanValue as Tinyint) end) expr_49824,
max(case datafieldobjectid when  49825 then cast (BooleanValue as Tinyint) end) expr_49825,
max(case datafieldobjectid when  49826 then cast (BooleanValue as Tinyint) end) expr_49826,
max(case datafieldobjectid when  49804 then cast (BooleanValue as Tinyint) end) expr_49804,
max(case datafieldobjectid when  49783 then cast (BooleanValue as Tinyint) end) expr_49783,
max(case datafieldobjectid when  49784 then cast (BooleanValue as Tinyint) end) expr_49784,
max(case datafieldobjectid when  49785 then cast (BooleanValue as Tinyint) end) expr_49785,
max(case datafieldobjectid when  49786 then cast (BooleanValue as Tinyint) end) expr_49786,
max(case datafieldobjectid when  49795 then cast (BooleanValue as Tinyint) end) expr_49795,
max(case datafieldobjectid when  49797 then cast (BooleanValue as Tinyint) end) expr_49797,
max(case datafieldobjectid when  49798 then cast (BooleanValue as Tinyint) end) expr_49798,
max(case datafieldobjectid when  49799 then cast (BooleanValue as Tinyint) end) expr_49799,
max(case datafieldobjectid when  49801 then cast (BooleanValue as Tinyint) end) expr_49801,
max(case datafieldobjectid when  49802 then cast (BooleanValue as Tinyint) end) expr_49802,
max(case datafieldobjectid when  49778 then cast (BooleanValue as Tinyint) end) expr_49778,
max(case datafieldobjectid when  49779 then cast (BooleanValue as Tinyint) end) expr_49779,
max(case datafieldobjectid when  49780 then cast (BooleanValue as Tinyint) end) expr_49780,
max(case datafieldobjectid when  49781 then cast (BooleanValue as Tinyint) end) expr_49781,
max(case datafieldobjectid when  49782 then cast (BooleanValue as Tinyint) end) expr_49782,
max(case datafieldobjectid when  49975 then cast (BooleanValue as Tinyint) end) expr_49975,
max(case datafieldobjectid when  49960 then cast (BooleanValue as Tinyint) end) expr_49960,
max(case datafieldobjectid when  49961 then cast (BooleanValue as Tinyint) end) expr_49961,
max(case dataFieldObjectId when 49957  then dataFieldOptionObjectId end) expr_49957,

--added 120211
max(case datafieldobjectid when 51339 then cast (booleanValue as Tinyint) end) expr_51339,
max(case datafieldobjectid when 51340 then cast (booleanValue as Tinyint) end) expr_51340,
max(case datafieldobjectid when 51341 then cast (booleanValue as Tinyint) end) expr_51341,
max(case datafieldobjectid when 51342 then cast (booleanValue as Tinyint) end) expr_51342,
max(case datafieldobjectid when 51344 then cast (booleanValue as Tinyint) end) expr_51344,
max(case datafieldobjectid when 51345 then cast (booleanValue as Tinyint) end) expr_51345,
max(case datafieldobjectid when 51024 then cast (booleanValue as Tinyint) end) expr_51024,
max(case datafieldobjectid when 51025 then cast (booleanValue as Tinyint) end) expr_51025,
max(case datafieldobjectid when 51026 then cast (booleanValue as Tinyint) end) expr_51026,
max(case datafieldobjectid when 51027 then cast (booleanValue as Tinyint) end) expr_51027,
max(case datafieldobjectid when 51028 then cast (booleanValue as Tinyint) end) expr_51028,
max(case datafieldobjectid when 51029 then cast (booleanValue as Tinyint) end) expr_51029,
max(case datafieldobjectid when 51030 then cast (booleanValue as Tinyint) end) expr_51030,
max(case datafieldobjectid when 51031 then cast (booleanValue as Tinyint) end) expr_51031,
max(case datafieldobjectid when 51347 then cast (booleanValue as Tinyint) end) expr_51347,
max(case datafieldobjectid when 51015 then cast (booleanValue as Tinyint) end) expr_51015,
max(case datafieldobjectid when 51016 then cast (booleanValue as Tinyint) end) expr_51016,
max(case datafieldobjectid when 51017 then cast (booleanValue as Tinyint) end) expr_51017,
max(case datafieldobjectid when 51018 then cast (booleanValue as Tinyint) end) expr_51018,
max(case datafieldobjectid when 51019 then cast (booleanValue as Tinyint) end) expr_51019,
max(case datafieldobjectid when 51020 then cast (booleanValue as Tinyint) end) expr_51020,
max(case datafieldobjectid when 51021 then cast (booleanValue as Tinyint) end) expr_51021,
max(case datafieldobjectid when 51022 then cast (booleanValue as Tinyint) end) expr_51022,
max(case datafieldobjectid when 51023 then cast (booleanValue as Tinyint) end) expr_51023,
max(case datafieldobjectid when 51348 then cast (booleanValue as Tinyint) end) expr_51348,

max(case datafieldobjectid when 53503 then cast (booleanValue as Tinyint) end) expr_53503,
max(case datafieldobjectid when 53504 then cast (booleanValue as Tinyint) end) expr_53504,
max(case datafieldobjectid when 53505 then cast (booleanValue as Tinyint) end) expr_53505,
max(case datafieldobjectid when 53506 then cast (booleanValue as Tinyint) end) expr_53506,
max(case datafieldobjectid when 53507 then cast (booleanValue as Tinyint) end) expr_53507,
max(case datafieldobjectid when 53518 then cast (booleanValue as Tinyint) end) expr_53518,
max(case datafieldobjectid when 53519 then cast (booleanValue as Tinyint) end) expr_53519,
max(case datafieldobjectid when 53521 then cast (booleanValue as Tinyint) end) expr_53521,
max(case datafieldobjectid when 53522 then cast (booleanValue as Tinyint) end) expr_53522,
max(case datafieldobjectid when 53523 then cast (booleanValue as Tinyint) end) expr_53523,
max(case datafieldobjectid when 53524 then cast (booleanValue as Tinyint) end) expr_53524,
max(case datafieldobjectid when 53508 then cast (booleanValue as Tinyint) end) expr_53508,
max(case datafieldobjectid when 53509 then cast (booleanValue as Tinyint) end) expr_53509,
max(case datafieldobjectid when 53511 then cast (booleanValue as Tinyint) end) expr_53511,
max(case datafieldobjectid when 53512 then cast (booleanValue as Tinyint) end) expr_53512,
max(case datafieldobjectid when 53513 then cast (booleanValue as Tinyint) end) expr_53513,
max(case datafieldobjectid when 53514 then cast (booleanValue as Tinyint) end) expr_53514,
max(case datafieldobjectid when 53515 then cast (booleanValue as Tinyint) end) expr_53515,
max(case datafieldobjectid when 53516 then cast (booleanValue as Tinyint) end) expr_53516,
max(case datafieldobjectid when 53517 then cast (booleanValue as Tinyint) end) expr_53517,
max(case datafieldobjectid when 53525 then cast (booleanValue as Tinyint) end) expr_53525,
max(case datafieldobjectid when 53526 then cast (booleanValue as Tinyint) end) expr_53526,
max(case datafieldobjectid when 53527 then cast (booleanValue as Tinyint) end) expr_53527,
max(case datafieldobjectid when 53528 then cast (booleanValue as Tinyint) end) expr_53528,
max(case datafieldobjectid when 53532 then cast (booleanValue as Tinyint) end) expr_53532,

max(case datafieldobjectid when 52806 then cast (booleanValue as Tinyint) end) expr_52806,
max(case datafieldobjectid when 52807 then cast (booleanValue as Tinyint) end) expr_52807,
max(case datafieldobjectid when 52808 then cast (booleanValue as Tinyint) end) expr_52808,
max(case datafieldobjectid when 52809 then cast (booleanValue as Tinyint) end) expr_52809,
max(case datafieldobjectid when 52810 then cast (booleanValue as Tinyint) end) expr_52810,
max(case datafieldobjectid when 52811 then cast (booleanValue as Tinyint) end) expr_52811,
max(case datafieldobjectid when 52812 then cast (booleanValue as Tinyint) end) expr_52812,
max(case datafieldobjectid when 52813 then cast (booleanValue as Tinyint) end) expr_52813,
max(case datafieldobjectid when 52814 then cast (booleanValue as Tinyint) end) expr_52814,
max(case datafieldobjectid when 52815 then cast (booleanValue as Tinyint) end) expr_52815,
max(case datafieldobjectid when 52816 then cast (booleanValue as Tinyint) end) expr_52816,
max(case datafieldobjectid when 52817 then cast (booleanValue as Tinyint) end) expr_52817,
max(case datafieldobjectid when 52818 then cast (booleanValue as Tinyint) end) expr_52818,
max(case datafieldobjectid when 52819 then cast (booleanValue as Tinyint) end) expr_52819,
max(case datafieldobjectid when 52820 then cast (booleanValue as Tinyint) end) expr_52820,
max(case datafieldobjectid when 52821 then cast (booleanValue as Tinyint) end) expr_52821,
max(case datafieldobjectid when 52822 then cast (booleanValue as Tinyint) end) expr_52822,
max(case datafieldobjectid when 52823 then cast (booleanValue as Tinyint) end) expr_52823,
max(case datafieldobjectid when 52824 then cast (booleanValue as Tinyint) end) expr_52824,
max(case datafieldobjectid when 52825 then cast (booleanValue as Tinyint) end) expr_52825,
max(case datafieldobjectid when 52834 then cast (booleanValue as Tinyint) end) expr_52834,

max(case datafieldobjectid when 53529 then cast (booleanValue as Tinyint) end) expr_53529,
max(case datafieldobjectid when 53559 then cast (booleanValue as Tinyint) end) expr_53559,
max(case datafieldobjectid when 53546 then cast (booleanValue as Tinyint) end) expr_53546,
max(case datafieldobjectid when 53561 then cast (booleanValue as Tinyint) end) expr_53561,
max(case datafieldobjectid when 53553 then cast (booleanValue as Tinyint) end) expr_53553,
max(case datafieldobjectid when 53563 then cast (booleanValue as Tinyint) end) expr_53563,
max(case datafieldobjectid when 53556 then cast (booleanValue as Tinyint) end) expr_53556,
max(case datafieldobjectid when 53596 then cast (booleanValue as Tinyint) end) expr_53596,
max(case datafieldobjectid when 53530 then cast (booleanValue as Tinyint) end) expr_53530,
max(case datafieldobjectid when 53560 then cast (booleanValue as Tinyint) end) expr_53560,
max(case datafieldobjectid when 53549 then cast (booleanValue as Tinyint) end) expr_53549,
max(case datafieldobjectid when 53562 then cast (booleanValue as Tinyint) end) expr_53562,
max(case datafieldobjectid when 53552 then cast (booleanValue as Tinyint) end) expr_53552,
max(case datafieldobjectid when 53564 then cast (booleanValue as Tinyint) end) expr_53564,
max(case datafieldobjectid when 53557 then cast (booleanValue as Tinyint) end) expr_53557,
max(case datafieldobjectid when 53598 then cast (booleanValue as Tinyint) end) expr_53598,
max(case datafieldobjectid when 53531 then cast (booleanValue as Tinyint) end) expr_53531,
max(case datafieldobjectid when 53558 then cast (booleanValue as Tinyint) end) expr_53558,
max(case datafieldobjectid when 53545 then cast (booleanValue as Tinyint) end) expr_53545,
max(case datafieldobjectid when 53550 then cast (booleanValue as Tinyint) end) expr_53550,
max(case datafieldobjectid when 53555 then cast (booleanValue as Tinyint) end) expr_53555,
max(case datafieldobjectid when 53597 then cast (booleanValue as Tinyint) end) expr_53597,

max(case dataFieldObjectId when 53593  then dataFieldOptionObjectId end) expr_53593,
max(case dataFieldObjectId when 53594  then dataFieldOptionObjectId end) expr_53594,
max(case dataFieldObjectId when 53595  then dataFieldOptionObjectId end) expr_53595,
--added 02012012
max (case dataFieldObjectid when 54210 then cast (booleanValue as tinyint) end) expr_54210,
max (case dataFieldObjectid when 54212 then cast (booleanValue as tinyint) end) expr_54212,
max (case dataFieldObjectid when 54213 then cast (booleanValue as tinyint) end) expr_54213,
max (case dataFieldObjectid when 54214 then cast (booleanValue as tinyint) end) expr_54214,
max (case dataFieldObjectid when 54215 then cast (booleanValue as tinyint) end) expr_54215,
max (case dataFieldObjectid when 54216 then cast (booleanValue as tinyint) end) expr_54216,
max (case dataFieldObjectid when 54217 then cast (booleanValue as tinyint) end) expr_54217,
max (case dataFieldObjectid when 54218 then cast (booleanValue as tinyint) end) expr_54218,
max (case dataFieldObjectid when 54219 then cast (booleanValue as tinyint) end) expr_54219,
max (case dataFieldObjectid when 54220 then cast (booleanValue as tinyint) end) expr_54220,
max (case dataFieldObjectid when 54221 then cast (booleanValue as tinyint) end) expr_54221,
max (case dataFieldObjectid when 54222 then cast (booleanValue as tinyint) end) expr_54222,
max (case dataFieldObjectid when 54223 then cast (booleanValue as tinyint) end) expr_54223,
max (case dataFieldObjectid when 54224 then cast (booleanValue as tinyint) end) expr_54224,
max (case dataFieldObjectid when 54225 then cast (booleanValue as tinyint) end) expr_54225,
                        max( case dataFieldObjectId 
                            when 54226 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_54226, 
--max (case dataFieldObjectid when 54226 then cast (booleanValue as tinyint) end) expr_54226,
max (case dataFieldObjectid when 54227 then cast (booleanValue as tinyint) end) expr_54227,
max (case dataFieldObjectid when 54228 then cast (booleanValue as tinyint) end) expr_54228,
max (case dataFieldObjectid when 54229 then cast (booleanValue as tinyint) end) expr_54229,
max (case dataFieldObjectid when 54230 then cast (booleanValue as tinyint) end) expr_54230,
max (case dataFieldObjectid when 54231 then cast (booleanValue as tinyint) end) expr_54231,
max (case dataFieldObjectid when 54232 then cast (booleanValue as tinyint) end) expr_54232,
--max (case dataFieldObjectid when 54233 then cast (booleanValue as tinyint) end) expr_54233,
                        max( case dataFieldObjectId 
                            when 54233 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_54233,
max (case dataFieldObjectid when 54234 then cast (booleanValue as tinyint) end) expr_54234,
max (case dataFieldObjectid when 54235 then cast (booleanValue as tinyint) end) expr_54235,
max (case dataFieldObjectid when 54236 then cast (booleanValue as tinyint) end) expr_54236,
--max (case dataFieldObjectid when 54237 then cast (booleanValue as tinyint) end) expr_54237,
                        max( case dataFieldObjectId 
                            when 54237 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_54237, 
max (case dataFieldObjectid when 54238 then cast (booleanValue as tinyint) end) expr_54238,

--added 030212
max (case dataFieldObjectid when 55315 then cast (BooleanValue as tinyint) end) Expr_55315,

max (case dataFieldObjectid when 55110 then cast (BooleanValue as tinyint) end) Expr_55110,
max (case dataFieldObjectid when 55115 then cast (BooleanValue as tinyint) end) Expr_55115,
max (case dataFieldObjectid when 55137 then cast (BooleanValue as tinyint) end) Expr_55137,
max (case dataFieldObjectid when 55140 then cast (BooleanValue as tinyint) end) Expr_55140,
max (case dataFieldObjectid when 55144 then cast (BooleanValue as tinyint) end) Expr_55144,

max (case dataFieldObjectid when 55185 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end )  Expr_55185,
max (case dataFieldObjectid when 55166 then cast (BooleanValue as tinyint) end) Expr_55166,
max (case dataFieldObjectid when 55167 then cast (BooleanValue as tinyint) end) Expr_55167,
max (case dataFieldObjectid when 55168 then cast (BooleanValue as tinyint) end) Expr_55168,
max (case dataFieldObjectid when 55176 then cast (BooleanValue as tinyint) end) Expr_55176,
max (case dataFieldObjectid when 55177 then cast (BooleanValue as tinyint) end) Expr_55177,
max (case dataFieldObjectid when 55178 then cast (BooleanValue as tinyint) end) Expr_55178,
max (case dataFieldObjectid when 55179 then cast (BooleanValue as tinyint) end) Expr_55179,
max (case dataFieldObjectid when 55180 then cast (BooleanValue as tinyint) end) Expr_55180,
max (case dataFieldObjectid when 56896 then cast (BooleanValue as tinyint) end) Expr_56896,

max (case dataFieldObjectid when  55153
 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end )  Expr_55153,
max (case dataFieldObjectid when 55147 then cast (BooleanValue as tinyint) end) Expr_55147,
max (case dataFieldObjectid when 55148 then cast (BooleanValue as tinyint) end) Expr_55148,
max (case dataFieldObjectid when 55149 then cast (BooleanValue as tinyint) end) Expr_55149,
max (case dataFieldObjectid when 55150 then cast (BooleanValue as tinyint) end) Expr_55150,
max (case dataFieldObjectid when 55151 then cast (BooleanValue as tinyint) end) Expr_55151,
max (case dataFieldObjectid when 55152 then cast (BooleanValue as tinyint) end) Expr_55152,


max (case dataFieldObjectid when 55317 then cast (BooleanValue as tinyint) end) Expr_55317,

max (case dataFieldObjectid when 55112 then cast (BooleanValue as tinyint) end) Expr_55112,
max (case dataFieldObjectid when 55136 then cast (BooleanValue as tinyint) end) Expr_55136,
max (case dataFieldObjectid when 55139 then cast (BooleanValue as tinyint) end) Expr_55139,
max (case dataFieldObjectid when 55143 then cast (BooleanValue as tinyint) end) Expr_55143,
max (case dataFieldObjectid when 55146 then cast (BooleanValue as tinyint) end) Expr_55146,

max (case dataFieldObjectid when 55301  then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end )  Expr_55301,
max (case dataFieldObjectid when 55287 then cast (BooleanValue as tinyint) end) Expr_55287,
max (case dataFieldObjectid when 55288 then cast (BooleanValue as tinyint) end) Expr_55288,
max (case dataFieldObjectid when 55289 then cast (BooleanValue as tinyint) end) Expr_55289,
max (case dataFieldObjectid when 55291 then cast (BooleanValue as tinyint) end) Expr_55291,
max (case dataFieldObjectid when 55292 then cast (BooleanValue as tinyint) end) Expr_55292,
max (case dataFieldObjectid when 55294 then cast (BooleanValue as tinyint) end) Expr_55294,
max (case dataFieldObjectid when 55295 then cast (BooleanValue as tinyint) end) Expr_55295,
max (case dataFieldObjectid when 55296 then cast (BooleanValue as tinyint) end) Expr_55296,
max (case dataFieldObjectid when 55297 then cast (BooleanValue as tinyint) end) Expr_55297,
max (case dataFieldObjectid when 55298 then cast (BooleanValue as tinyint) end) Expr_55298,
max (case dataFieldObjectid when 55299 then cast (BooleanValue as tinyint) end) Expr_55299,
max (case dataFieldObjectid when 56894 then cast (BooleanValue as tinyint) end) Expr_56894,

max (case dataFieldObjectid when 55313 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end )  Expr_55313,
max (case dataFieldObjectid when 55304 then cast (BooleanValue as tinyint) end) Expr_55304,
max (case dataFieldObjectid when 55305 then cast (BooleanValue as tinyint) end) Expr_55305,
max (case dataFieldObjectid when 55306 then cast (BooleanValue as tinyint) end) Expr_55306,
max (case dataFieldObjectid when 55307 then cast (BooleanValue as tinyint) end) Expr_55307,
max (case dataFieldObjectid when 55309 then cast (BooleanValue as tinyint) end) Expr_55309,
max (case dataFieldObjectid when 55310 then cast (BooleanValue as tinyint) end) Expr_55310,
max (case dataFieldObjectid when 55311 then cast (BooleanValue as tinyint) end) Expr_55311,
max (case dataFieldObjectid when 55312 then cast (BooleanValue as tinyint) end) Expr_55312,


max (case dataFieldObjectid when 55316 then cast (BooleanValue as tinyint) end) Expr_55316,

max (case dataFieldObjectid when 55111 then cast (BooleanValue as tinyint) end) Expr_55111,
max (case dataFieldObjectid when 55135 then cast (BooleanValue as tinyint) end) Expr_55135,
max (case dataFieldObjectid when 55138 then cast (BooleanValue as tinyint) end) Expr_55138,
max (case dataFieldObjectid when 55142 then cast (BooleanValue as tinyint) end) Expr_55142,
max (case dataFieldObjectid when 55145 then cast (BooleanValue as tinyint) end) Expr_55145,

max (case dataFieldObjectid when 55276 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end )  Expr_55276,
max (case dataFieldObjectid when 55202 then cast (BooleanValue as tinyint) end) Expr_55202,
max (case dataFieldObjectid when 55203 then cast (BooleanValue as tinyint) end) Expr_55203,
max (case dataFieldObjectid when 55204 then cast (BooleanValue as tinyint) end) Expr_55204,
max (case dataFieldObjectid when 55205 then cast (BooleanValue as tinyint) end) Expr_55205,
max (case dataFieldObjectid when 55206 then cast (BooleanValue as tinyint) end) Expr_55206,
max (case dataFieldObjectid when 55207 then cast (BooleanValue as tinyint) end) Expr_55207,

max (case dataFieldObjectid when 55286 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end )  Expr_55286,
max (case dataFieldObjectid when 55277 then cast (BooleanValue as tinyint) end) Expr_55277,
max (case dataFieldObjectid when 55278 then cast (BooleanValue as tinyint) end) Expr_55278,
max (case dataFieldObjectid when 55279 then cast (BooleanValue as tinyint) end) Expr_55279,
max (case dataFieldObjectid when 55280 then cast (BooleanValue as tinyint) end) Expr_55280,
max (case dataFieldObjectid when 55281 then cast (BooleanValue as tinyint) end) Expr_55281,
max (case dataFieldObjectid when 55282 then cast (BooleanValue as tinyint) end) Expr_55282,
max (case dataFieldObjectid when 55283 then cast (BooleanValue as tinyint) end) Expr_55283,
max (case dataFieldObjectid when 55284 then cast (BooleanValue as tinyint) end) Expr_55284,
max (case dataFieldObjectid when 55285 then cast (BooleanValue as tinyint) end) Expr_55285,
max (case dataFieldObjectid when 56895 then cast (BooleanValue as tinyint) end) Expr_56895,

--added 4/2/2012
                        max( case dataFieldObjectId when 56890 then dataFieldOptionObjectId end ) expr_56890,
                        max( case dataFieldObjectId when 56887 then dataFieldOptionObjectId end ) expr_56887,
                        max( case dataFieldObjectId when 56891 then dataFieldOptionObjectId end ) expr_56891,
                        max( case dataFieldObjectId when 56889 then dataFieldOptionObjectId end ) expr_56889,
                        max( case dataFieldObjectId when 56888 then dataFieldOptionObjectId end ) expr_56888,
                        max( case dataFieldObjectId when 56892 then dataFieldOptionObjectId end ) expr_56892,
                        max( case dataFieldObjectId when 56893 then dataFieldOptionObjectId end ) expr_56893,
                        
--max (case dataFieldObjectid when 56890 then cast (BooleanValue as tinyint) end) Expr_56890,
--max (case dataFieldObjectid when 56887 then cast (BooleanValue as tinyint) end) Expr_56887,
--max (case dataFieldObjectid when 56891 then cast (BooleanValue as tinyint) end) Expr_56891,
--max (case dataFieldObjectid when 56889 then cast (BooleanValue as tinyint) end) Expr_56889,
--max (case dataFieldObjectid when 56888 then cast (BooleanValue as tinyint) end) Expr_56888,
--max (case dataFieldObjectid when 56892 then cast (BooleanValue as tinyint) end) Expr_56892,
--max (case dataFieldObjectid when 56893 then cast (BooleanValue as tinyint) end) Expr_56893,

--added 5/2/2012
max (case datafieldobjectid when 58138 then cast (BooleanValue as tinyint) end) Expr_58138,
max (case datafieldobjectid when 58139 then cast (BooleanValue as tinyint) end) Expr_58139,
max (case datafieldobjectid when 58140 then cast (BooleanValue as tinyint) end) Expr_58140,
max (case datafieldobjectid when 58141 then cast (BooleanValue as tinyint) end) Expr_58141,
max (case datafieldobjectid when 58142 then cast (BooleanValue as tinyint) end) Expr_58142,
max (case datafieldobjectid when 58137 then cast (BooleanValue as tinyint) end) Expr_58137,

max (case datafieldobjectid when 58217 then cast (BooleanValue as tinyint) end) Expr_58217,
max (case datafieldobjectid when 58143 then cast (BooleanValue as tinyint) end) Expr_58143,
max (case datafieldobjectid when 58144 then cast (BooleanValue as tinyint) end) Expr_58144,
max (case datafieldobjectid when 58145 then cast (BooleanValue as tinyint) end) Expr_58145,
max (case datafieldobjectid when 58146 then cast (BooleanValue as tinyint) end) Expr_58146,
max (case datafieldobjectid when 58147 then cast (BooleanValue as tinyint) end) Expr_58147,
max (case datafieldobjectid when 58206 then cast (BooleanValue as tinyint) end) Expr_58206,
max (case datafieldobjectid when 58207 then cast (BooleanValue as tinyint) end) Expr_58207,

max (case datafieldobjectid when 58219 then cast (BooleanValue as tinyint) end) Expr_58219,
max (case datafieldobjectid when 58210 then cast (BooleanValue as tinyint) end) Expr_58210,
max (case datafieldobjectid when 58211 then cast (BooleanValue as tinyint) end) Expr_58211,
max (case datafieldobjectid when 58213 then cast (BooleanValue as tinyint) end) Expr_58213,
max (case datafieldobjectid when 58214 then cast (BooleanValue as tinyint) end) Expr_58214,
max (case datafieldobjectid when 58215 then cast (BooleanValue as tinyint) end) Expr_58215,

max (case datafieldobjectid when 58126 then cast (BooleanValue as tinyint) end) Expr_58126,
max (case datafieldobjectid when 58926 then cast (BooleanValue as tinyint) end) Expr_58926,
max (case datafieldobjectid when 58927 then cast (BooleanValue as tinyint) end) Expr_58927,

--added 6/1/2012
max (case datafieldobjectid when 58875 then cast (BooleanValue as tinyint) end) Expr_58875,
max (case datafieldobjectid when 58876 then cast (BooleanValue as tinyint) end) Expr_58876,
max (case datafieldobjectid when 58877 then cast (BooleanValue as tinyint) end) Expr_58877,
max (case datafieldobjectid when 58880 then cast (BooleanValue as tinyint) end) Expr_58880,
max (case datafieldobjectid when 58881 then cast (BooleanValue as tinyint) end) Expr_58881,
max (case datafieldobjectid when 58882 then cast (BooleanValue as tinyint) end) Expr_58882,
max (case datafieldobjectid when 58883 then cast (BooleanValue as tinyint) end) Expr_58883,
max (case datafieldobjectid when 58884 then cast (BooleanValue as tinyint) end) Expr_58884,

max (case datafieldobjectid when 58885 then cast (BooleanValue as tinyint) end) Expr_58885,
max (case datafieldobjectid when 58886 then cast (BooleanValue as tinyint) end) Expr_58886,
max (case datafieldobjectid when 58887 then cast (BooleanValue as tinyint) end) Expr_58887,
max (case datafieldobjectid when 58888 then cast (BooleanValue as tinyint) end) Expr_58888,
max (case datafieldobjectid when 58889 then cast (BooleanValue as tinyint) end) Expr_58889,
max (case datafieldobjectid when 58890 then cast (BooleanValue as tinyint) end) Expr_58890,
max (case datafieldobjectid when 58891 then cast (BooleanValue as tinyint) end) Expr_58891,
max (case datafieldobjectid when 58892 then cast (BooleanValue as tinyint) end) Expr_58892,

max (case datafieldobjectid when 58893 then cast (BooleanValue as tinyint) end) Expr_58893,
max (case datafieldobjectid when 58894 then cast (BooleanValue as tinyint) end) Expr_58894,
max (case datafieldobjectid when 58895 then cast (BooleanValue as tinyint) end) Expr_58895,
max (case datafieldobjectid when 58896 then cast (BooleanValue as tinyint) end) Expr_58896,
max (case datafieldobjectid when 58897 then cast (BooleanValue as tinyint) end) Expr_58897,
max (case datafieldobjectid when 58899 then cast (BooleanValue as tinyint) end) Expr_58899,
max (case datafieldobjectid when 58900 then cast (BooleanValue as tinyint) end) Expr_58900,

max (case datafieldobjectid when 58901 then cast (BooleanValue as tinyint) end) Expr_58901,
max (case datafieldobjectid when 59054 then cast (BooleanValue as tinyint) end) Expr_59054,
max (case datafieldobjectid when 59055 then cast (BooleanValue as tinyint) end) Expr_59055,
max (case datafieldobjectid when 59059 then cast (BooleanValue as tinyint) end) Expr_59059,
max (case datafieldobjectid when 59064 then cast (BooleanValue as tinyint) end) Expr_59064,
max (case datafieldobjectid when 59065 then cast (BooleanValue as tinyint) end) Expr_59065,
max (case datafieldobjectid when 59066 then cast (BooleanValue as tinyint) end) Expr_59066,
max (case datafieldobjectid when 59068 then cast (BooleanValue as tinyint) end) Expr_59068,

max (case datafieldobjectid when 59281 then cast (BooleanValue as tinyint) end) Expr_59281,
max (case datafieldobjectid when 59285 then cast (BooleanValue as tinyint) end) Expr_59285,
max (case datafieldobjectid when 59306 then cast (BooleanValue as tinyint) end) Expr_59306,
max (case datafieldobjectid when 59307 then cast (BooleanValue as tinyint) end) Expr_59307,
max (case datafieldobjectid when 59309 then cast (BooleanValue as tinyint) end) Expr_59309,
max (case datafieldobjectid when 59311 then cast (BooleanValue as tinyint) end) Expr_59311,
max (case datafieldobjectid when 59312 then cast (BooleanValue as tinyint) end) Expr_59312,
max (case datafieldobjectid when 59313 then cast (BooleanValue as tinyint) end) Expr_59313,

max (case datafieldobjectid when 58749 then cast (BooleanValue as tinyint) end) Expr_58749,
max (case datafieldobjectid when 58750 then cast (BooleanValue as tinyint) end) Expr_58750,
max (case datafieldobjectid when 58751 then cast (BooleanValue as tinyint) end) Expr_58751,
max (case datafieldobjectid when 58752 then cast (BooleanValue as tinyint) end) Expr_58752,
max (case datafieldobjectid when 58753 then cast (BooleanValue as tinyint) end) Expr_58753,
max (case datafieldobjectid when 58754 then cast (BooleanValue as tinyint) end) Expr_58754,
max (case datafieldobjectid when 58755 then cast (BooleanValue as tinyint) end) Expr_58755,
max( case dataFieldObjectId when 59323 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59323,

max (case datafieldobjectid when 58788 then cast (BooleanValue as tinyint) end) Expr_58788,
max (case datafieldobjectid when 58790 then cast (BooleanValue as tinyint) end) Expr_58790,
max (case datafieldobjectid when 58792 then cast (BooleanValue as tinyint) end) Expr_58792,
max (case datafieldobjectid when 58796 then cast (BooleanValue as tinyint) end) Expr_58796,
max (case datafieldobjectid when 58798 then cast (BooleanValue as tinyint) end) Expr_58798,
max (case datafieldobjectid when 58799 then cast (BooleanValue as tinyint) end) Expr_58799,
max (case datafieldobjectid when 58800 then cast (BooleanValue as tinyint) end) Expr_58800,
max( case dataFieldObjectId when 59330 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59330,

max (case datafieldobjectid when 58841 then cast (BooleanValue as tinyint) end) Expr_58841,
max (case datafieldobjectid when 58842 then cast (BooleanValue as tinyint) end) Expr_58842,
max (case datafieldobjectid when 58843 then cast (BooleanValue as tinyint) end) Expr_58843,
max (case datafieldobjectid when 58844 then cast (BooleanValue as tinyint) end) Expr_58844,
max (case datafieldobjectid when 58848 then cast (BooleanValue as tinyint) end) Expr_58848,
max (case datafieldobjectid when 58849 then cast (BooleanValue as tinyint) end) Expr_58849,
max (case datafieldobjectid when 58850 then cast (BooleanValue as tinyint) end) Expr_58850,
max( case dataFieldObjectId when 59332 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59332,

max (case datafieldobjectid when 58728 then cast (BooleanValue as tinyint) end) Expr_58728,
max (case datafieldobjectid when 58729 then cast (BooleanValue as tinyint) end) Expr_58729,
max (case datafieldobjectid when 58730 then cast (BooleanValue as tinyint) end) Expr_58730,
max (case datafieldobjectid when 58731 then cast (BooleanValue as tinyint) end) Expr_58731,
max (case datafieldobjectid when 58732 then cast (BooleanValue as tinyint) end) Expr_58732,
max( case dataFieldObjectId when 59318 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59318,

max (case datafieldobjectid when 58723 then cast (BooleanValue as tinyint) end) Expr_58723,
max (case datafieldobjectid when 58724 then cast (BooleanValue as tinyint) end) Expr_58724,
max (case datafieldobjectid when 58725 then cast (BooleanValue as tinyint) end) Expr_58725,
max (case datafieldobjectid when 58726 then cast (BooleanValue as tinyint) end) Expr_58726,
max (case datafieldobjectid when 58727 then cast (BooleanValue as tinyint) end) Expr_58727,
max( case dataFieldObjectId when 59317 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59317,

max (case datafieldobjectid when 58742 then cast (BooleanValue as tinyint) end) Expr_58742,
max (case datafieldobjectid when 58743 then cast (BooleanValue as tinyint) end) Expr_58743,
max (case datafieldobjectid when 58744 then cast (BooleanValue as tinyint) end) Expr_58744,
max (case datafieldobjectid when 58745 then cast (BooleanValue as tinyint) end) Expr_58745,
max (case datafieldobjectid when 58746 then cast (BooleanValue as tinyint) end) Expr_58746,
max (case datafieldobjectid when 58747 then cast (BooleanValue as tinyint) end) Expr_58747,
max (case datafieldobjectid when 58748 then cast (BooleanValue as tinyint) end) Expr_58748,
max( case dataFieldObjectId when 59322 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59322,

max (case datafieldobjectid when 58801 then cast (BooleanValue as tinyint) end) Expr_58801,
max (case datafieldobjectid when 58802 then cast (BooleanValue as tinyint) end) Expr_58802,
max (case datafieldobjectid when 58803 then cast (BooleanValue as tinyint) end) Expr_58803,
max (case datafieldobjectid when 58804 then cast (BooleanValue as tinyint) end) Expr_58804,
max (case datafieldobjectid when 58805 then cast (BooleanValue as tinyint) end) Expr_58805,
max (case datafieldobjectid when 58806 then cast (BooleanValue as tinyint) end) Expr_58806,
max (case datafieldobjectid when 58807 then cast (BooleanValue as tinyint) end) Expr_58807,
max( case dataFieldObjectId when 59326 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59326,

max (case datafieldobjectid when 58852 then cast (BooleanValue as tinyint) end) Expr_58852,
max (case datafieldobjectid when 58853 then cast (BooleanValue as tinyint) end) Expr_58853,
max (case datafieldobjectid when 58854 then cast (BooleanValue as tinyint) end) Expr_58854,
max (case datafieldobjectid when 58856 then cast (BooleanValue as tinyint) end) Expr_58856,
max (case datafieldobjectid when 58858 then cast (BooleanValue as tinyint) end) Expr_58858,
max (case datafieldobjectid when 58859 then cast (BooleanValue as tinyint) end) Expr_58859,
max (case datafieldobjectid when 58861 then cast (BooleanValue as tinyint) end) Expr_58861,
max( case dataFieldObjectId when 59331 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59331,

max (case datafieldobjectid when 58756 then cast (BooleanValue as tinyint) end) Expr_58756,
max (case datafieldobjectid when 58758 then cast (BooleanValue as tinyint) end) Expr_58758,
max (case datafieldobjectid when 58759 then cast (BooleanValue as tinyint) end) Expr_58759,
max (case datafieldobjectid when 58760 then cast (BooleanValue as tinyint) end) Expr_58760,
max (case datafieldobjectid when 58761 then cast (BooleanValue as tinyint) end) Expr_58761,
max (case datafieldobjectid when 58762 then cast (BooleanValue as tinyint) end) Expr_58762,
max( case dataFieldObjectId when 59361 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59361,

max (case datafieldobjectid when 58773 then cast (BooleanValue as tinyint) end) Expr_58773,
max (case datafieldobjectid when 58774 then cast (BooleanValue as tinyint) end) Expr_58774,
max (case datafieldobjectid when 58775 then cast (BooleanValue as tinyint) end) Expr_58775,
max (case datafieldobjectid when 58776 then cast (BooleanValue as tinyint) end) Expr_58776,
max (case datafieldobjectid when 58777 then cast (BooleanValue as tinyint) end) Expr_58777,
max (case datafieldobjectid when 58778 then cast (BooleanValue as tinyint) end) Expr_58778,
max (case datafieldobjectid when 58779 then cast (BooleanValue as tinyint) end) Expr_58779,
max (case datafieldobjectid when 58780 then cast (BooleanValue as tinyint) end) Expr_58780,
max( case dataFieldObjectId when 59368 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59368,

max (case datafieldobjectid when 58817 then cast (BooleanValue as tinyint) end) Expr_58817,
max (case datafieldobjectid when 58818 then cast (BooleanValue as tinyint) end) Expr_58818,
max (case datafieldobjectid when 58812 then cast (BooleanValue as tinyint) end) Expr_58812,
max (case datafieldobjectid when 58820 then cast (BooleanValue as tinyint) end) Expr_58820,
max (case datafieldobjectid when 58821 then cast (BooleanValue as tinyint) end) Expr_58821,
max (case datafieldobjectid when 58822 then cast (BooleanValue as tinyint) end) Expr_58822,
max (case datafieldobjectid when 58823 then cast (BooleanValue as tinyint) end) Expr_58823,
max( case dataFieldObjectId when 59370 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59370,

max (case datafieldobjectid when 58733 then cast (BooleanValue as tinyint) end) Expr_58733,
max (case datafieldobjectid when 58734 then cast (BooleanValue as tinyint) end) Expr_58734,
max (case datafieldobjectid when 58735 then cast (BooleanValue as tinyint) end) Expr_58735,
max( case dataFieldObjectId when 59357 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59357,

max (case datafieldobjectid when 58720 then cast (BooleanValue as tinyint) end) Expr_58720,
max (case datafieldobjectid when 58721 then cast (BooleanValue as tinyint) end) Expr_58721,
max (case datafieldobjectid when 58722 then cast (BooleanValue as tinyint) end) Expr_58722,
max( case dataFieldObjectId when 59343 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59343,

max (case datafieldobjectid when 58736 then cast (BooleanValue as tinyint) end) Expr_58736,
max (case datafieldobjectid when 58737 then cast (BooleanValue as tinyint) end) Expr_58737,
max (case datafieldobjectid when 58738 then cast (BooleanValue as tinyint) end) Expr_58738,
max (case datafieldobjectid when 58739 then cast (BooleanValue as tinyint) end) Expr_58739,
max (case datafieldobjectid when 58740 then cast (BooleanValue as tinyint) end) Expr_58740,
max (case datafieldobjectid when 58741 then cast (BooleanValue as tinyint) end) Expr_58741,
max( case dataFieldObjectId when 59359 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59359,

max (case datafieldobjectid when 58765 then cast (BooleanValue as tinyint) end) Expr_58765,
max (case datafieldobjectid when 58766 then cast (BooleanValue as tinyint) end) Expr_58766,
max (case datafieldobjectid when 58767 then cast (BooleanValue as tinyint) end) Expr_58767,
max (case datafieldobjectid when 58768 then cast (BooleanValue as tinyint) end) Expr_58768,
max (case datafieldobjectid when 58769 then cast (BooleanValue as tinyint) end) Expr_58769,
max (case datafieldobjectid when 58770 then cast (BooleanValue as tinyint) end) Expr_58770,
max (case datafieldobjectid when 58771 then cast (BooleanValue as tinyint) end) Expr_58771,
max (case datafieldobjectid when 58772 then cast (BooleanValue as tinyint) end) Expr_58772,
max( case dataFieldObjectId when 59364 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59364,

max (case datafieldobjectid when 58808 then cast (BooleanValue as tinyint) end) Expr_58808,
max (case datafieldobjectid when 58809 then cast (BooleanValue as tinyint) end) Expr_58809,
max (case datafieldobjectid when 58810 then cast (BooleanValue as tinyint) end) Expr_58810,
max (case datafieldobjectid when 58811 then cast (BooleanValue as tinyint) end) Expr_58811,
max (case datafieldobjectid when 58813 then cast (BooleanValue as tinyint) end) Expr_58813,
max (case datafieldobjectid when 58814 then cast (BooleanValue as tinyint) end) Expr_58814,
max (case datafieldobjectid when 58815 then cast (BooleanValue as tinyint) end) Expr_58815,
max (case datafieldobjectid when 58816 then cast (BooleanValue as tinyint) end) Expr_58816,
max( case dataFieldObjectId when 59369 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_59369,

max (case datafieldobjectid when 58864 then cast (BooleanValue as tinyint) end) Expr_58864,
max (case datafieldobjectid when 58865 then cast (BooleanValue as tinyint) end) Expr_58865,
max (case datafieldobjectid when 58869 then cast (BooleanValue as tinyint) end) Expr_58869,
max (case datafieldobjectid when 58870 then cast (BooleanValue as tinyint) end) Expr_58870,
max (case datafieldobjectid when 58871 then cast (BooleanValue as tinyint) end) Expr_58871,
max (case datafieldobjectid when 58872 then cast (BooleanValue as tinyint) end) Expr_58872,
max (case datafieldobjectid when 58873 then cast (BooleanValue as tinyint) end) Expr_58873,
max (case datafieldobjectid when 58874 then cast (BooleanValue as tinyint) end) Expr_58874,

--added 6/8/2012
max (case datafieldobjectid when 58898 then cast (booleanValue as tinyint) end) Expr_58898,
max (case datafieldobjectid when 58819 then cast (booleanValue as tinyint) end) Expr_58819,

max (case datafieldobjectid when 58413 then cast (booleanValue as tinyint) end) Expr_58413,
max (case datafieldobjectid when 58416 then cast (booleanValue as tinyint) end) Expr_58416,
max (case datafieldobjectid when 58417 then cast (booleanValue as tinyint) end) Expr_58417,
max (case datafieldobjectid when 58418 then cast (booleanValue as tinyint) end) Expr_58418,
max (case datafieldobjectid when 58420 then cast (booleanValue as tinyint) end) Expr_58420,
max (case datafieldobjectid when 58421 then cast (booleanValue as tinyint) end) Expr_58421,

max( case dataFieldObjectId when 58444 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_58444,

max (case datafieldobjectid when 58436 then cast (booleanValue as tinyint) end) Expr_58436,
max (case datafieldobjectid when 58437 then cast (booleanValue as tinyint) end) Expr_58437,
max (case datafieldobjectid when 58438 then cast (booleanValue as tinyint) end) Expr_58438,
max (case datafieldobjectid when 58439 then cast (booleanValue as tinyint) end) Expr_58439,
max (case datafieldobjectid when 58441 then cast (booleanValue as tinyint) end) Expr_58441,
max (case datafieldobjectid when 58442 then cast (booleanValue as tinyint) end) Expr_58442,
max (case datafieldobjectid when 58443 then cast (booleanValue as tinyint) end) Expr_58443,

max( case dataFieldObjectId when 58433 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_58433,

max (case datafieldobjectid when 58422 then cast (booleanValue as tinyint) end) Expr_58422,
max (case datafieldobjectid when 58424 then cast (booleanValue as tinyint) end) Expr_58424,
max (case datafieldobjectid when 58425 then cast (booleanValue as tinyint) end) Expr_58425,
max (case datafieldobjectid when 58426 then cast (booleanValue as tinyint) end) Expr_58426,
max (case datafieldobjectid when 58427 then cast (booleanValue as tinyint) end) Expr_58427,
max (case datafieldobjectid when 58428 then cast (booleanValue as tinyint) end) Expr_58428,
max (case datafieldobjectid when 58429 then cast (booleanValue as tinyint) end) Expr_58429,
max (case datafieldobjectid when 58430 then cast (booleanValue as tinyint) end) Expr_58430,
max (case datafieldobjectid when 58431 then cast (booleanValue as tinyint) end) Expr_58431,
--11/2/2012
max (case datafieldobjectid when 68895 then cast (booleanValue as tinyint) end) Expr_68895,
max (case datafieldobjectid when 68849 then cast (booleanValue as tinyint) end) Expr_68849,
max (case datafieldobjectid when 68924 then cast (booleanValue as tinyint) end) Expr_68924,
--max (case datafieldobjectid when 68618 then cast (booleanValue as tinyint) end) Expr_68618,
max( case dataFieldObjectId when 68618 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_68618,
max (case datafieldobjectid when 68614 then cast (booleanValue as tinyint) end) Expr_68614,
max (case datafieldobjectid when 68615 then cast (booleanValue as tinyint) end) Expr_68615,
max (case datafieldobjectid when 68616 then cast (booleanValue as tinyint) end) Expr_68616,
max (case datafieldobjectid when 68617 then cast (booleanValue as tinyint) end) Expr_68617,
max (case datafieldobjectid when 68925 then cast (booleanValue as tinyint) end) Expr_68925,
max (case datafieldobjectid when 68926 then cast (booleanValue as tinyint) end) Expr_68926,
--max (case datafieldobjectid when 68647 then cast (booleanValue as tinyint) end) Expr_68647,
max( case dataFieldObjectId when 68647 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_68647,
max (case datafieldobjectid when 68626 then cast (booleanValue as tinyint) end) Expr_68626,
max (case datafieldobjectid when 68629 then cast (booleanValue as tinyint) end) Expr_68629,
max (case datafieldobjectid when 68631 then cast (booleanValue as tinyint) end) Expr_68631,
max (case datafieldobjectid when 68632 then cast (booleanValue as tinyint) end) Expr_68632,
max (case datafieldobjectid when 68635 then cast (booleanValue as tinyint) end) Expr_68635,
max (case datafieldobjectid when 68927 then cast (booleanValue as tinyint) end) Expr_68927,

--added 6/3/2013
max (case datafieldobjectid when 94682 then cast (booleanValue as tinyint) end) Expr_94682,
max (case datafieldobjectid when 94938 then cast (booleanValue as tinyint) end) Expr_94938,
max (case datafieldobjectid when 94939 then cast (booleanValue as tinyint) end) Expr_94939,
max (case datafieldobjectid when 94995 then cast (booleanValue as tinyint) end) Expr_94995,
max (case datafieldobjectid when 94930 then cast (booleanValue as tinyint) end) Expr_94930,
max (case datafieldobjectid when 94933 then cast (booleanValue as tinyint) end) Expr_94933,

max (case datafieldobjectid when 94698 then cast (booleanValue as tinyint) end) Expr_94698,
max (case datafieldobjectid when 94940 then cast (booleanValue as tinyint) end) Expr_94940,
max (case datafieldobjectid when 94937 then cast (booleanValue as tinyint) end) Expr_94937,
max (case datafieldobjectid when 94998 then cast (booleanValue as tinyint) end) Expr_94998,
max (case datafieldobjectid when 94931 then cast (booleanValue as tinyint) end) Expr_94931,
max (case datafieldobjectid when 94934 then cast (booleanValue as tinyint) end) Expr_94934,

max (case datafieldobjectid when 94710 then cast (booleanValue as tinyint) end) Expr_94710,
max (case datafieldobjectid when 94941 then cast (booleanValue as tinyint) end) Expr_94941,
max (case datafieldobjectid when 94936 then cast (booleanValue as tinyint) end) Expr_94936,
max (case datafieldobjectid when 94999 then cast (booleanValue as tinyint) end) Expr_94999,
max (case datafieldobjectid when 94932 then cast (booleanValue as tinyint) end) Expr_94932,
max (case datafieldobjectid when 94935 then cast (booleanValue as tinyint) end) Expr_94935,

max(case dataFieldObjectId when 94683  then dataFieldOptionObjectId end) expr_94683,
max(case dataFieldObjectId when 94699  then dataFieldOptionObjectId end) expr_94699,
max(case dataFieldObjectId when 94712  then dataFieldOptionObjectId end) expr_94712,

max (case datafieldobjectid when 94685 then cast (booleanValue as tinyint) end) Expr_94685,
max (case datafieldobjectid when 94688 then cast (booleanValue as tinyint) end) Expr_94688,
max (case datafieldobjectid when 94689 then cast (booleanValue as tinyint) end) Expr_94689,
max (case datafieldobjectid when 94690 then cast (booleanValue as tinyint) end) Expr_94690,
max (case datafieldobjectid when 94691 then cast (booleanValue as tinyint) end) Expr_94691,
max (case datafieldobjectid when 94692 then cast (booleanValue as tinyint) end) Expr_94692,
max (case datafieldobjectid when 94693 then cast (booleanValue as tinyint) end) Expr_94693,
max (case datafieldobjectid when 94694 then cast (booleanValue as tinyint) end) Expr_94694,
max (case datafieldobjectid when 94695 then cast (booleanValue as tinyint) end) Expr_94695,
max (case datafieldobjectid when 94696 then cast (booleanValue as tinyint) end) Expr_94696,
max( case dataFieldObjectId when 94697 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_94697,
max (case datafieldobjectid when 95506 then cast (booleanValue as tinyint) end) Expr_95506,

max (case datafieldobjectid when 94735 then cast (booleanValue as tinyint) end) Expr_94735,
max (case datafieldobjectid when 94736 then cast (booleanValue as tinyint) end) Expr_94736,
max (case datafieldobjectid when 94738 then cast (booleanValue as tinyint) end) Expr_94738,
max (case datafieldobjectid when 94737 then cast (booleanValue as tinyint) end) Expr_94737,
max( case dataFieldObjectId when 94739 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_94739,
max (case datafieldobjectid when 95507 then cast (booleanValue as tinyint) end) Expr_95507,

max (case datafieldobjectid when 94700 then cast (booleanValue as tinyint) end) Expr_94700,
max (case datafieldobjectid when 94701 then cast (booleanValue as tinyint) end) Expr_94701,
max (case datafieldobjectid when 94702 then cast (booleanValue as tinyint) end) Expr_94702,
max (case datafieldobjectid when 94703 then cast (booleanValue as tinyint) end) Expr_94703,
max (case datafieldobjectid when 94704 then cast (booleanValue as tinyint) end) Expr_94704,
max (case datafieldobjectid when 94705 then cast (booleanValue as tinyint) end) Expr_94705,
max (case datafieldobjectid when 94706 then cast (booleanValue as tinyint) end) Expr_94706,
max (case datafieldobjectid when 94707 then cast (booleanValue as tinyint) end) Expr_94707,
max (case datafieldobjectid when 94708 then cast (booleanValue as tinyint) end) Expr_94708,
max( case dataFieldObjectId when 94709 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_94709,
max (case datafieldobjectid when 95508 then cast (booleanValue as tinyint) end) Expr_95508,

max (case datafieldobjectid when 94741 then cast (booleanValue as tinyint) end) Expr_94741,
max (case datafieldobjectid when 94743 then cast (booleanValue as tinyint) end) Expr_94743,
max (case datafieldobjectid when 94745 then cast (booleanValue as tinyint) end) Expr_94745,
max (case datafieldobjectid when 94747 then cast (booleanValue as tinyint) end) Expr_94747,
max( case dataFieldObjectId when 94749 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_94749,
max (case datafieldobjectid when 95509 then cast (booleanValue as tinyint) end) Expr_95509,

max (case datafieldobjectid when 94713 then cast (booleanValue as tinyint) end) Expr_94713,
max (case datafieldobjectid when 94715 then cast (booleanValue as tinyint) end) Expr_94715,
max (case datafieldobjectid when 94716 then cast (booleanValue as tinyint) end) Expr_94716,
max (case datafieldobjectid when 94717 then cast (booleanValue as tinyint) end) Expr_94717,
max (case datafieldobjectid when 94718 then cast (booleanValue as tinyint) end) Expr_94718,
max (case datafieldobjectid when 94719 then cast (booleanValue as tinyint) end) Expr_94719,
max (case datafieldobjectid when 94720 then cast (booleanValue as tinyint) end) Expr_94720,
max (case datafieldobjectid when 94721 then cast (booleanValue as tinyint) end) Expr_94721,
max (case datafieldobjectid when 94722 then cast (booleanValue as tinyint) end) Expr_94722,
max( case dataFieldObjectId when 94714 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_94714,
max (case datafieldobjectid when 95510 then cast (booleanValue as tinyint) end) Expr_95510,

max (case datafieldobjectid when 94742 then cast (booleanValue as tinyint) end) Expr_94742,
max (case datafieldobjectid when 94744 then cast (booleanValue as tinyint) end) Expr_94744,
max (case datafieldobjectid when 94746 then cast (booleanValue as tinyint) end) Expr_94746,
max (case datafieldobjectid when 94748 then cast (booleanValue as tinyint) end) Expr_94748,
max( case dataFieldObjectId when 94750 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_94750,
max (case datafieldobjectid when 95511 then cast (booleanValue as tinyint) end) Expr_95511,

max (case datafieldobjectid when 95519 then cast (booleanValue as tinyint) end) Expr_95519,
max (case datafieldobjectid when 95634 then cast (booleanValue as tinyint) end) Expr_95634,
max (case datafieldobjectid when 95655 then cast (booleanValue as tinyint) end) Expr_95655,
max (case datafieldobjectid when 95638 then cast (booleanValue as tinyint) end) Expr_95638,
max (case datafieldobjectid when 95625 then cast (booleanValue as tinyint) end) Expr_95625,
max (case datafieldobjectid when 95629 then cast (booleanValue as tinyint) end) Expr_95629,

max (case datafieldobjectid when 95520 then cast (booleanValue as tinyint) end) Expr_95520,
max (case datafieldobjectid when 95635 then cast (booleanValue as tinyint) end) Expr_95635,
max (case datafieldobjectid when 95658 then cast (booleanValue as tinyint) end) Expr_95658,
max (case datafieldobjectid when 95642 then cast (booleanValue as tinyint) end) Expr_95642,
max (case datafieldobjectid when 95626 then cast (booleanValue as tinyint) end) Expr_95626,
max (case datafieldobjectid when 95630 then cast (booleanValue as tinyint) end) Expr_95630,

max (case datafieldobjectid when 95521 then cast (booleanValue as tinyint) end) Expr_95521,
max (case datafieldobjectid when 95523 then cast (booleanValue as tinyint) end) Expr_95523,
max (case datafieldobjectid when 95524 then cast (booleanValue as tinyint) end) Expr_95524,
max (case datafieldobjectid when 95525 then cast (booleanValue as tinyint) end) Expr_95525,
max (case datafieldobjectid when 95526 then cast (booleanValue as tinyint) end) Expr_95526,
max (case datafieldobjectid when 95527 then cast (booleanValue as tinyint) end) Expr_95527,
max (case datafieldobjectid when 95528 then cast (booleanValue as tinyint) end) Expr_95528,
max (case datafieldobjectid when 95529 then cast (booleanValue as tinyint) end) Expr_95529,
max (case datafieldobjectid when 95530 then cast (booleanValue as tinyint) end) Expr_95530,
max (case datafieldobjectid when 95545 then cast (booleanValue as tinyint) end) Expr_95545,
max (case datafieldobjectid when 95546 then cast (booleanValue as tinyint) end) Expr_95546,
max( case dataFieldObjectId when 95547 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_95547,

max (case datafieldobjectid when 95548 then cast (booleanValue as tinyint) end) Expr_95548,
max (case datafieldobjectid when 95549 then cast (booleanValue as tinyint) end) Expr_95549,
max (case datafieldobjectid when 95556 then cast (booleanValue as tinyint) end) Expr_95556,
max (case datafieldobjectid when 95558 then cast (booleanValue as tinyint) end) Expr_95558,
max (case datafieldobjectid when 95559 then cast (booleanValue as tinyint) end) Expr_95559,
max (case datafieldobjectid when 95560 then cast (booleanValue as tinyint) end) Expr_95560,
max( case dataFieldObjectId when 95562 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_95562,

max (case datafieldobjectid when 95561 then cast (booleanValue as tinyint) end) Expr_95561,
max (case datafieldobjectid when 95563 then cast (booleanValue as tinyint) end) Expr_95563,
max( case dataFieldObjectId when 95564 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_95564,

max (case datafieldobjectid when 95585 then cast (booleanValue as tinyint) end) Expr_95585,
max (case datafieldobjectid when 95586 then cast (booleanValue as tinyint) end) Expr_95586,
max (case datafieldobjectid when 95587 then cast (booleanValue as tinyint) end) Expr_95587,
max (case datafieldobjectid when 95588 then cast (booleanValue as tinyint) end) Expr_95588,
max (case datafieldobjectid when 95589 then cast (booleanValue as tinyint) end) Expr_95589,
max (case datafieldobjectid when 95590 then cast (booleanValue as tinyint) end) Expr_95590,
max (case datafieldobjectid when 95591 then cast (booleanValue as tinyint) end) Expr_95591,
max (case datafieldobjectid when 95592 then cast (booleanValue as tinyint) end) Expr_95592,
max (case datafieldobjectid when 95593 then cast (booleanValue as tinyint) end) Expr_95593,
max (case datafieldobjectid when 95594 then cast (booleanValue as tinyint) end) Expr_95594,
max (case datafieldobjectid when 95595 then cast (booleanValue as tinyint) end) Expr_95595,
max( case dataFieldObjectId when 95596 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_95596,

max (case datafieldobjectid when 95597 then cast (booleanValue as tinyint) end) Expr_95597,
max (case datafieldobjectid when 95598 then cast (booleanValue as tinyint) end) Expr_95598,
max (case datafieldobjectid when 95599 then cast (booleanValue as tinyint) end) Expr_95599,
max (case datafieldobjectid when 95600 then cast (booleanValue as tinyint) end) Expr_95600,
max (case datafieldobjectid when 95601 then cast (booleanValue as tinyint) end) Expr_95601,
max (case datafieldobjectid when 95602 then cast (booleanValue as tinyint) end) Expr_95602,
max( case dataFieldObjectId when 95603 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_95603,

max (case datafieldobjectid when 95604 then cast (booleanValue as tinyint) end) Expr_95604,
max (case datafieldobjectid when 95606 then cast (booleanValue as tinyint) end) Expr_95606,
max( case dataFieldObjectId when 95607 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_95607,

max( case dataFieldObjectId when 94627 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_94627,
max(case dataFieldObjectId when 94628  then dataFieldOptionObjectId end) expr_94628,

--added 9/1/13
max (case datafieldobjectid when 98629 then cast (booleanValue as tinyint) end) Expr_98629,
max (case datafieldobjectid when 98627 then cast (booleanValue as tinyint) end) Expr_98627,
max (case datafieldobjectid when 98643 then cast (booleanValue as tinyint) end) Expr_98643,
max (case datafieldobjectid when 98554 then cast (booleanValue as tinyint) end) Expr_98554,
max (case datafieldobjectid when 98556 then cast (booleanValue as tinyint) end) Expr_98556,
max (case datafieldobjectid when 98557 then cast (booleanValue as tinyint) end) Expr_98557,
max (case datafieldobjectid when 98558 then cast (booleanValue as tinyint) end) Expr_98558,
max (case datafieldobjectid when 98560 then cast (booleanValue as tinyint) end) Expr_98560,
max (case datafieldobjectid when 98605 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_98605,
max (case datafieldobjectid when 98622 then cast (booleanValue as tinyint) end) Expr_98622,
max (case datafieldobjectid when 98626 then cast (booleanValue as tinyint) end) Expr_98626,
max (case datafieldobjectid when 98230 then cast (booleanValue as tinyint) end) Expr_98230,
max (case datafieldobjectid when 98235 then cast (booleanValue as tinyint) end) Expr_98235,
max (case datafieldobjectid when 98238 then cast (booleanValue as tinyint) end) Expr_98238,
max (case datafieldobjectid when 98241 then cast (booleanValue as tinyint) end) Expr_98241,
max (case datafieldobjectid when 98242 then cast (booleanValue as tinyint) end) Expr_98242,
max (case datafieldobjectid when 98245 then cast (booleanValue as tinyint) end) Expr_98245,
max (case datafieldobjectid when 98247 then cast (booleanValue as tinyint) end) Expr_98247,
max (case datafieldobjectid when 98248 then cast (booleanValue as tinyint) end) Expr_98248,
max (case datafieldobjectid when 98249 then cast (booleanValue as tinyint) end) Expr_98249,
max (case datafieldobjectid when 98250 then cast (booleanValue as tinyint) end) Expr_98250,
max (case datafieldobjectid when 98552 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_98552,
max (case datafieldobjectid when 98221 then cast (booleanValue as tinyint) end) Expr_98221,
max (case datafieldobjectid when 98630 then cast (booleanValue as tinyint) end) Expr_98630,
max (case datafieldobjectid when 98628 then cast (booleanValue as tinyint) end) Expr_98628,
max (case datafieldobjectid when 98711 then cast (booleanValue as tinyint) end) Expr_98711,
max (case datafieldobjectid when 98591 then cast (booleanValue as tinyint) end) Expr_98591,
max (case datafieldobjectid when 98592 then cast (booleanValue as tinyint) end) Expr_98592,
max (case datafieldobjectid when 98595 then cast (booleanValue as tinyint) end) Expr_98595,
max (case datafieldobjectid when 98597 then cast (booleanValue as tinyint) end) Expr_98597,
max (case datafieldobjectid when 98598 then cast (booleanValue as tinyint) end) Expr_98598,
max (case datafieldobjectid when 98601 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_98601,
max (case datafieldobjectid when 98624 then cast (booleanValue as tinyint) end) Expr_98624,
max (case datafieldobjectid when 98625 then cast (booleanValue as tinyint) end) Expr_98625,
max (case datafieldobjectid when 98564 then cast (booleanValue as tinyint) end) Expr_98564,
max (case datafieldobjectid when 98565 then cast (booleanValue as tinyint) end) Expr_98565,
max (case datafieldobjectid when 98566 then cast (booleanValue as tinyint) end) Expr_98566,
max (case datafieldobjectid when 98567 then cast (booleanValue as tinyint) end) Expr_98567,
max (case datafieldobjectid when 98569 then cast (booleanValue as tinyint) end) Expr_98569,
max (case datafieldobjectid when 98570 then cast (booleanValue as tinyint) end) Expr_98570,
max (case datafieldobjectid when 98571 then cast (booleanValue as tinyint) end) Expr_98571,
max (case datafieldobjectid when 98572 then cast (booleanValue as tinyint) end) Expr_98572,
max (case datafieldobjectid when 98573 then cast (booleanValue as tinyint) end) Expr_98573,
max (case datafieldobjectid when 98586 then cast (booleanValue as tinyint) end) Expr_98586,
max (case datafieldobjectid when 98588 then cast (booleanValue as tinyint) end) Expr_98588,
max (case datafieldobjectid when 98590 then replace(replace(replace(replace(Textvalue,',',''),char(9),''),char(39),''),char(44),'') end ) expr_98590,
max (case datafieldobjectid when 98223 then cast (booleanValue as tinyint) end) Expr_98223,
max (case datafieldobjectid when 94759 then cast (booleanValue as tinyint) end) Expr_94759



                    from
                        SurveyResponseAnswer 
                        left join comment c on c.SurveyResponseAnswerobjectid =SurveyResponseAnswer.objectid
                    group by
                        surveyResponseObjectId 
                ) as AnswerPivot 
                    on AnswerPivot.surveyResponseObjectId = SurveyResponse.objectId 
            inner join
                Offer 
                    on Offer.objectId=SurveyResponse.offerObjectId 
            left outer join
                #cat1003 cat1003 
                    on cat1003.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat997 cat997 
                    on cat997.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat995 cat995 
                    on cat995.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat996 cat996 
                    on cat996.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat998 cat998 
                    on cat998.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1032 cat1032 
                    on cat1032.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1014 cat1014 
                    on cat1014.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1008 cat1008 
                    on cat1008.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1013 cat1013 
                    on cat1013.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1007 cat1007 
                    on cat1007.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1012 cat1012 
                    on cat1012.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1006 cat1006 
                    on cat1006.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1011 cat1011 
                    on cat1011.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1005 cat1005 
                    on cat1005.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1010 cat1010 
                    on cat1010.locationObjectId=SurveyResponse.locationObjectId 
--
--            left outer join
--                #cat887 cat887 
--                    on cat887.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat886 cat886 
                    on cat886.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat1002 cat1002 
                    on cat1002.locationObjectId=SurveyResponse.locationObjectId 

            left outer join
                #cat3478 cat3478 
                    on cat3478.locationObjectId=SurveyResponse.locationObjectId 
            left outer join
                #cat3479 cat3479 
                    on cat3479.locationObjectId=SurveyResponse.locationObjectId 
            left outer join
                #cat3480 cat3480 
                    on cat3480.locationObjectId=SurveyResponse.locationObjectId 
            left outer join
                #cat3481 cat3481 
                    on cat3481.locationObjectId=SurveyResponse.locationObjectId 
            left outer join
                #cat3482 cat3482 
                    on cat3482.locationObjectId=SurveyResponse.locationObjectId 
            left outer join
                #cat3483 cat3483 
                    on cat3483.locationObjectId=SurveyResponse.locationObjectId 
            where
                SurveyResponse.beginDate >= @begindt 
				and SurveyResponse.beginDate < @enddt
                
				--and Location.enabled =1
                and SurveyResponse.complete = 1 
                and Location.organizationObjectId = 569 
				and SurveyResponse.exclusionReason=0
				and Location.hidden = 0
				--and Surveyresponse.modeType=2 
 
       
                and (
                    Offer.objectId in (
                        1223,1222,2829
                    ) 
                ) 
                and (
                    cat1003.locationCategoryObjectId in (
                        14999
                    ) 
                ) 
) as a
            order by
                SurveyResponseobjectId ; 
; if OBJECT_ID(N'tempdb..#cat1003',
                N'U') IS NOT NULL drop table #cat1003;

; if OBJECT_ID(N'tempdb..#cat997',
                N'U') IS NOT NULL drop table #cat997;
--select * from #cat997
; if OBJECT_ID(N'tempdb..#cat995',
                N'U') IS NOT NULL drop table #cat995;
; if OBJECT_ID(N'tempdb..#cat996',
                N'U') IS NOT NULL drop table #cat996;
; if OBJECT_ID(N'tempdb..#cat998',
                N'U') IS NOT NULL drop table #cat998;
; if OBJECT_ID(N'tempdb..#cat1032',
                N'U') IS NOT NULL drop table #cat1032;
; if OBJECT_ID(N'tempdb..#cat1014',
                N'U') IS NOT NULL drop table #cat1014;
; if OBJECT_ID(N'tempdb..#cat1008',
                N'U') IS NOT NULL drop table #cat1008;
; if OBJECT_ID(N'tempdb..#cat1013',
                N'U') IS NOT NULL drop table #cat1013;
; if OBJECT_ID(N'tempdb..#cat1007',
                N'U') IS NOT NULL drop table #cat1007;
; if OBJECT_ID(N'tempdb..#cat1012',
                N'U') IS NOT NULL drop table #cat1012;
; if OBJECT_ID(N'tempdb..#cat1006',
                N'U') IS NOT NULL drop table #cat1006;
; if OBJECT_ID(N'tempdb..#cat1011',
                N'U') IS NOT NULL drop table #cat1011;
; if OBJECT_ID(N'tempdb..#cat1005',
                N'U') IS NOT NULL drop table #cat1005;
; if OBJECT_ID(N'tempdb..#cat1010',
                N'U') IS NOT NULL drop table #cat1010;
--; if OBJECT_ID(N'tempdb..#cat887',
--                N'U') IS NOT NULL drop table #cat887;
; if OBJECT_ID(N'tempdb..#cat886',
                N'U') IS NOT NULL drop table #cat886;
; if OBJECT_ID(N'tempdb..#cat1002',
                N'U') IS NOT NULL drop table #cat1002;
; if OBJECT_ID(N'tempdb..#cat3478',
                N'U') IS NOT NULL drop table #cat3478;
; if OBJECT_ID(N'tempdb..#cat3479',
                N'U') IS NOT NULL drop table #cat3479;
; if OBJECT_ID(N'tempdb..#cat3480',
                N'U') IS NOT NULL drop table #cat3480;
; if OBJECT_ID(N'tempdb..#cat3481',
                N'U') IS NOT NULL drop table #cat3481;
; if OBJECT_ID(N'tempdb..#cat3482',
                N'U') IS NOT NULL drop table #cat3482;
; if OBJECT_ID(N'tempdb..#cat3483',
                N'U') IS NOT NULL drop table #cat3483;

--exec dbo.usp_cust_McDCandaExport30
--select * from _McDExtract where [Ordered Breakfast Menu] is not null and [Menu Type (Web)] ='Regular menu'
--select [how dined],count([how dined])  from _McDExtract group by [how dined] with rollup
--select state,count(state) from _McDExtract
--group by state
--------


--select * from datafield where organizationobjectid =569 and name like '%how dined%'
--select * from datafield where organizationobjectid =569 and name like '%time of visit%'
--select * from datafield where organizationobjectid =569 and name like '%ordered breakfast%'
--select * from datafield where organizationobjectid =569 and name like '%AMI07A - Menu Type (Web)%'
--select * from datafield where organizationobjectid =569 and name like '%AML02%'
--select * from datafield where organizationobjectid =569 and name like '%AmdPAH05%'



-------------
--select * from _McDExtract where name like '%comments%'
--select [how dined],count([how dined])  from _McDExtract group by [how dined] with rollup
--select count([Time of visit])  from _McDExtract 
--select count([Ordered Breakfast Menu])  from _McDExtract
--select [menu type (web)],count([menu type (web)])  from _McDExtract group by [menu type (web)] with rollup 
--select [how compared to previous visit],count([how compared to previous visit])  from _McDExtract group by [how compared to previous visit] with rollup 
--select [Recommend THIS McDonalds],count([Recommend THIS McDonalds])  from _McDExtract group by [Recommend THIS McDonalds] with rollup 
--select count([comments])  from _McDExtract
--select [menu type (web)],count([menu type (web)])  from _McDExtract group by [menu type (web)] with rollup 
--select [how Often Eat Or Buy From McDonalds],count([how Often Eat Or Buy From McDonalds])  from _McDExtract group by [how Often Eat Or Buy From McDonalds] with rollup 
--select [how Often Eat Or Buy From QSRs],count([how Often Eat Or Buy From QSRs])  from _McDExtract group by [how Often Eat Or Buy From QSRs] with rollup 
--select count([amdpah05 - french fries hm])  from _McDExtract
--select count([amdpan05 - iced tea])  from _McDExtract
--select count([amdpth05 - french fries hm])  from _McDExtract
--select count([AMDPTN03 - Juice])  from _McDExtract
--select count([AMDPTN05 - Iced Tea ])  from _McDExtract
--select count([AMDPTN07 - Iced Mocha  ])  from _McDExtract
--select count([AMDPUH05 - French Fries HM ])  from _McDExtract
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
