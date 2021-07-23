SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_cust_WalgreensCallCenterDataOKfiles]
as

--exec dbo.usp_cust_WalgreensCallCenterDataOKfiles

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_wg_CallCenterDataOKfiles]') AND type in (N'U'))
DROP TABLE [dbo].[_wg_CallCenterDataOKfiles];


/* generated 
by
    mssql reportEngine: report = Raw Data Detail [48785],
    org = Walgreens[1030] 
    Eastern
    */ 
    declare @enddt date,@begindt date

--set @enddt=(select DATEADD(dd, DATEDIFF(dd,0,getdate()), 0))

    set @begindt=(select DATEADD(wk, -1, DATEADD(wk, DATEDIFF(wk, 0,getdate()), -1)))   
    set @enddt=(DATEADD(wk, DATEDIFF(wk, 0, getdate()), -2))
    select @begindt,@enddt
--set @begindt=dateadd(dd,-1,getdate())
--set @enddt=dateadd(dd,-1,getdate())
--SET @begindt='1/12/2014 00:00:00'
--SET @enddt='1/12/2014 00:00:00'

   select @begindt,@enddt


 if OBJECT_ID(N'tempdb..#cat8383',
    N'U') IS NOT NULL drop table #cat8383; 
    create table #cat8383 (locationObjectId int not null,
    locationCategoryObjectId int not null,
    locationCategoryName varchar(100) not null,
    primary key(locationObjectId,
    locationCategoryObjectId)); 
    
    insert 
    into
        #cat8383
        select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(8383) ; 
            
            if OBJECT_ID(N'tempdb..#cat8384',
            N'U') IS NOT NULL drop table #cat8384; 
            
            create table #cat8384 (locationObjectId int not null,
            locationCategoryObjectId int not null,
            locationCategoryName varchar(100) not null,
            primary key(locationObjectId,
            locationCategoryObjectId)); 
            
            insert 
            into
                #cat8384
                select
                    locationObjectId,
                    locationCategoryObjectId,
                    locationCategoryName 
                from
                    dbo.ufn_app_LocationsInCategoryOfType(8384) ; if OBJECT_ID(N'tempdb..#cat8385',
                    N'U') IS NOT NULL drop table #cat8385; create table #cat8385 (locationObjectId int not null,
                    locationCategoryObjectId int not null,
                    locationCategoryName varchar(100) not null,
                    primary key(locationObjectId,
                    locationCategoryObjectId)); insert 
                    into
                        #cat8385
                        select
                            locationObjectId,
                            locationCategoryObjectId,
                            locationCategoryName 
                        from
                            dbo.ufn_app_LocationsInCategoryOfType(8385) ; if OBJECT_ID(N'tempdb..#cat8386',
                            N'U') IS NOT NULL drop table #cat8386; create table #cat8386 (locationObjectId int not null,
                            locationCategoryObjectId int not null,
                            locationCategoryName varchar(100) not null,
                            primary key(locationObjectId,
                            locationCategoryObjectId)); insert 
                            into
                                #cat8386
                                select
                                    locationObjectId,
                                    locationCategoryObjectId,
                                    locationCategoryName 
                                from
                                    dbo.ufn_app_LocationsInCategoryOfType(8386) ; if OBJECT_ID(N'tempdb..#cat8379',
                                    N'U') IS NOT NULL drop table #cat8379; create table #cat8379 (locationObjectId int not null,
                                    locationCategoryObjectId int not null,
                                    locationCategoryName varchar(100) not null,
                                    primary key(locationObjectId,
                                    locationCategoryObjectId)); insert 
                                    into
                                        #cat8379
                                        select
                                            locationObjectId,
                                            locationCategoryObjectId,
                                            locationCategoryName 
                                        from
                                            dbo.ufn_app_LocationsInCategoryOfType(8379) ; if OBJECT_ID(N'tempdb..#cat8380',
                                            N'U') IS NOT NULL drop table #cat8380; create table #cat8380 (locationObjectId int not null,
                                            locationCategoryObjectId int not null,
                                            locationCategoryName varchar(100) not null,
                                            primary key(locationObjectId,
                                            locationCategoryObjectId)); insert 
                                            into
                                                #cat8380
                                                select
                                                    locationObjectId,
                                                    locationCategoryObjectId,
                                                    locationCategoryName 
                                                from
                                                    dbo.ufn_app_LocationsInCategoryOfType(8380) ; if OBJECT_ID(N'tempdb..#cat8381',
                                                    N'U') IS NOT NULL drop table #cat8381; create table #cat8381 (locationObjectId int not null,
                                                    locationCategoryObjectId int not null,
                                                    locationCategoryName varchar(100) not null,
                                                    primary key(locationObjectId,
                                                    locationCategoryObjectId)); insert 
                                                    into
                                                        #cat8381
                                                        select
                                                            locationObjectId,
                                                            locationCategoryObjectId,
                                                            locationCategoryName 
                                                        from
                                                            dbo.ufn_app_LocationsInCategoryOfType(8381) ; if OBJECT_ID(N'tempdb..#cat29538',
                                                            N'U') IS NOT NULL drop table #cat29538; create table #cat29538 (locationObjectId int not null,
                                                            locationCategoryObjectId int not null,
                                                            locationCategoryName varchar(100) not null,
                                                            primary key(locationObjectId,
                                                            locationCategoryObjectId)); insert 
                                                            into
                                                                #cat29538
                                                                select
                                                                    locationObjectId,
                                                                    locationCategoryObjectId,
                                                                    locationCategoryName 
                                                                from
                                                                    dbo.ufn_app_LocationsInCategoryOfType(29538) ; if OBJECT_ID(N'tempdb..#cat8382',
                                                                    N'U') IS NOT NULL drop table #cat8382; create table #cat8382 (locationObjectId int not null,
                                                                    locationCategoryObjectId int not null,
                                                                    locationCategoryName varchar(100) not null,
                                                                    primary key(locationObjectId,
                                                                    locationCategoryObjectId)); insert 
                                                                    into
                                                                        #cat8382
                                                                        select
                                                                            locationObjectId,
                                                                            locationCategoryObjectId,
                                                                            locationCategoryName 
                                                                        from
                                                                            dbo.ufn_app_LocationsInCategoryOfType(8382) ; 
   select *
	into _WG_CallCenterDataOKfiles
          from(                                                                            
                                                                            
                                                                            
                                                                            select
                                                                                distinct SurveyResponse.objectId as surveyResponseObjectId ,
                                                                                (case expr_101 
                                                                                    when 209028 then N'4' 
                                                                                    when 209027 then N'3' 
                                                                                    when 209026 then N'2' 
                                                                                    when 209025 then N'1' 
                                                                                    when 209024 then N'0' 
                                                                                end) as expr_101 ,
                                                                                (select
                                                                                    top 1 score 
                                                                                from
                                                                                    SurveyResponseScore srsc 
                                                                                where
                                                                                    srsc.surveyResponseObjectId = SurveyResponse.objectId 
                                                                                    and srsc.dataFieldObjectId = 104103) as expr_103 ,
                                                                                (case expr_35 
                                                                                    when 161454 then N'Contacted more than once' 
                                                                                    when 161455 then N'Contacted Once' 
                                                                                end) as expr_35 ,
                                                                                Location.name as expr_8 ,
                                                                                expr_79 as expr_79 ,
                                                                                (case expr_26 
                                                                                    when 161390 then N'6' 
                                                                                    when 161391 then N'5' 
                                                                                    when 161389 then N'7' 
                                                                                    when 161392 then N'4' 
                                                                                    when 161387 then N'9' 
                                                                                    when 161394 then N'2' 
                                                                                    when 161395 then N'1' 
                                                                                    when 161388 then N'8' 
                                                                                    when 161393 then N'3' 
                                                                                end) as expr_26 ,
                                                                                (case expr_47 
                                                                                    when 161850 then N'5' 
                                                                                    when 161846 then N'9' 
                                                                                    when 161849 then N'6' 
                                                                                    when 161853 then N'2' 
                                                                                    when 161854 then N'1' 
                                                                                    when 161851 then N'4' 
                                                                                    when 161852 then N'3' 
                                                                                    when 161847 then N'8' 
                                                                                    when 161848 then N'7' 
                                                                                end) as expr_47 ,
                                                                                (case expr_32 
                                                                                    when 161438 then N'7' 
                                                                                    when 161439 then N'6' 
                                                                                    when 161441 then N'4' 
                                                                                    when 161444 then N'1' 
                                                                                    when 161443 then N'2' 
                                                                                    when 161436 then N'9' 
                                                                                    when 161440 then N'5' 
                                                                                    when 161437 then N'8' 
                                                                                    when 161442 then N'3' 
                                                                                end) as expr_32 ,
                                                                                expr_69 as expr_69 ,
                                                                                (case expr_104 
                                                                                    when 208710 then N'7' 
                                                                                    when 208711 then N'8' 
                                                                                    when 208706 then N'3' 
                                                                                    when 208707 then N'4' 
                                                                                    when 208708 then N'5' 
                                                                                    when 208709 then N'6' 
                                                                                    when 208712 then N'9' 
                                                                                    when 208705 then N'2' 
                                                                                    when 208704 then N'1' 
                                                                                end) as expr_104 ,
                                                                                (case expr_51 
                                                                                    when 161787 then N'Online at Walgreens.com' 
                                                                                    when 161785 then N'Store photo kiosk' 
                                                                                    when 161789 then N'QR code' 
                                                                                    when 161790 then N'Call center specialist' 
                                                                                    when 161786 then N'Elsewhere in the store' 
                                                                                    when 161784 then N'Pharmacy' 
                                                                                    when 165442 then N'Store Checkout' 
                                                                                    when 161791 then N'Don’t remember' 
                                                                                    when 161788 then N'Mobile Phone/App' 
                                                                                end) as expr_51 ,
                                                                                (case expr_58 
                                                                                    when 161859 then N'2-4 times per month' 
                                                                                    when 161857 then N'First Time' 
                                                                                    when 161860 then N'More than 4 times per month' 
                                                                                    when 161858 then N'1 time per month' 
                                                                                end) as expr_58 ,
                                                                                (case expr_60 
                                                                                    when 161751 then N'55 - 64' 
                                                                                    when 161748 then N'18 - 34' 
                                                                                    when 161753 then N'Prefer not to answer' 
                                                                                    when 161749 then N'35 - 44' 
                                                                                    when 161747 then N'Under 18' 
                                                                                    when 161752 then N'Over 65' 
                                                                                    when 161750 then N'45 - 54' 
                                                                                end) as expr_60 ,
                                                                                (case expr_102 
                                                                                    when 209029 then N'Continue' 
                                                                                    when 208703 then N'Another Method' 
                                                                                end) as expr_102 ,
                                                                                (case expr_40 
                                                                                    when 165386 then N'5' 
                                                                                    when 165384 then N'3' 
                                                                                    when 165390 then N'9 - Extremely Satisfied' 
                                                                                    when 165382 then N'1 - Not At All Satisfied' 
                                                                                    when 165388 then N'7' 
                                                                                    when 165385 then N'4' 
                                                                                    when 165383 then N'2' 
                                                                                    when 165387 then N'6' 
                                                                                    when 165389 then N'8' 
                                                                                end) as expr_40 ,
                                                                                (case expr_49 
                                                                                    when 165363 then N'No' 
                                                                                    when 165362 then N'Yes' 
                                                                                end) as expr_49 ,
                                                                                (case expr_55 
                                                                                    when 161726 then N'Yes' 
                                                                                    when 161727 then N'No' 
                                                                                end) as expr_55 ,
                                                                                (case expr_19 
                                                                                    when 161332 then N'Spanish' 
                                                                                    when 161331 then N'English' 
                                                                                end) as expr_19 ,
                                                                                (case expr_59 
                                                                                    when 161743 then N'Prefer not to answer' 
                                                                                    when 161741 then N'Male' 
                                                                                    when 161740 then N'Female' 
                                                                                end) as expr_59 ,
                                                                                (case expr_63 
                                                                                    when 161769 then N'Yes' 
                                                                                    when 161770 then N'No' 
                                                                                end) as expr_63 ,
                                                                                expr_86 as expr_86 ,
                                                                                SurveyResponse.objectId as expr_88 ,
                                                                                (case expr_53 
                                                                                    when 161794 then N'7' 
                                                                                    when 161798 then N'3' 
                                                                                    when 161800 then N'1' 
                                                                                    when 161797 then N'4' 
                                                                                    when 161795 then N'6' 
                                                                                    when 161792 then N'9' 
                                                                                    when 161796 then N'5' 
                                                                                    when 161793 then N'8' 
                                                                                    when 161799 then N'2' 
                                                                                end) as expr_53 ,
                                                                                (case expr_95 
                                                                                    when 208695 then N'Yes' 
                                                                                    when 208696 then N'No' 
                                                                                    when 208697 then N'Unsure' 
                                                                                end) as expr_95 ,
                                                                                expr_64 as expr_64 ,
                                                                                (case expr_62 
                                                                                    when 161763 then N'$35,000 to under $50,000' 
                                                                                    when 161764 then N'$50,000 to under $75,000' 
                                                                                    when 161762 then N'$25,000 to under $35,000' 
                                                                                    when 161761 then N'Under $25,000' 
                                                                                    when 161767 then N'$150,000 or more' 
                                                                                    when 161765 then N'$75,000 to under $100,000' 
                                                                                    when 161766 then N'$100,000 to under $150,000' 
                                                                                    when 161768 then N'Prefer not to answer' 
                                                                                end) as expr_62 ,
                                                                                Location.objectId as entityId_9 ,
                                                                                (case expr_25 
                                                                                    when 161385 then N'2' 
                                                                                    when 161384 then N'3' 
                                                                                    when 161381 then N'6' 
                                                                                    when 161383 then N'4' 
                                                                                    when 161378 then N'9' 
                                                                                    when 161386 then N'1' 
                                                                                    when 161379 then N'8' 
                                                                                    when 161380 then N'7' 
                                                                                    when 161382 then N'5' 
                                                                                end) as expr_25 ,
                                                                                expr_57 as expr_57 ,
                                                                                (case expr_61 
                                                                                    when 161757 then N'Asian or Pacific Islander' 
                                                                                    when 161754 then N'White or Caucasian' 
                                                                                    when 161755 then N'Black or African American' 
                                                                                    when 161759 then N'Mixed racial background' 
                                                                                    when 161760 then N'Prefer not to answer' 
                                                                                    when 161758 then N'Native American or Alaskan Native' 
                                                                                    when 161756 then N'Hispanic or Latino' 
                                                                                end) as expr_61 ,
                                                                                (case expr_27 
                                                                                    when 164713 then N'5' 
                                                                                    when 164715 then N'3' 
                                                                                    when 164716 then N'2' 
                                                                                    when 164709 then N'9' 
                                                                                    when 164717 then N'1' 
                                                                                    when 164714 then N'4' 
                                                                                    when 164711 then N'7' 
                                                                                    when 164710 then N'8' 
                                                                                    when 164712 then N'6' 
                                                                                end) as expr_27 ,
                                                                                cat8386.locationCategoryName as expr_6 ,
                                                                                cat8379.locationCategoryName as expr_10 ,
                                                                                cat8384.locationCategoryObjectId as entityId_3 ,
                                                                                cat8379.locationCategoryObjectId as entityId_11 ,
                                                                                (case expr_77 
                                                                                    when 163573 then N'AZ - WE' 
                                                                                    when 169919 then N'NY' 
                                                                                    when 176199 then N'All' 
                                                                                    when 163579 then N'NV' 
                                                                                    when 163574 then N'DC' 
                                                                                    when 163572 then N'AZ' 
                                                                                    when 174919 then N'Default' 
                                                                                    when 163577 then N'IL' 
                                                                                    when 163578 then N'IN' 
                                                                                    when 163575 then N'FL' 
                                                                                    when 163581 then N'Pilot' 
                                                                                    when 163580 then N'NY-DR' 
                                                                                    when 163576 then N'FL - WE' 
                                                                                end) as expr_77 ,
                                                                                (case expr_76 
                                                                                    when 163569 then N'AO' 
                                                                                    when 163570 then N'HV' 
                                                                                    when 163571 then N'WE' 
                                                                                end) as expr_76 ,
                                                                                (case expr_20 
                                                                                    when 161338 then N'4' 
                                                                                    when 161340 then N'2' 
                                                                                    when 161337 then N'5' 
                                                                                    when 161335 then N'7' 
                                                                                    when 161334 then N'8' 
                                                                                    when 161333 then N'9' 
                                                                                    when 161341 then N'1' 
                                                                                    when 161336 then N'6' 
                                                                                    when 161339 then N'3' 
                                                                                end) as expr_20 ,
                                                                                (case expr_98 
                                                                                    when 209013 then N'4' 
                                                                                    when 209012 then N'3' 
                                                                                    when 209010 then N'1' 
                                                                                    when 209009 then N'0' 
                                                                                    when 209011 then N'2' 
                                                                                end) as expr_98 ,
                                                                                cat8383.locationCategoryObjectId as entityId_1 ,
                                                                                cat8380.locationCategoryName as expr_12 ,
                                                                                (case expr_24 
                                                                                    when 161371 then N'7' 
                                                                                    when 161370 then N'8' 
                                                                                    when 161372 then N'6' 
                                                                                    when 161373 then N'5' 
                                                                                    when 161375 then N'3' 
                                                                                    when 161376 then N'2' 
                                                                                    when 161369 then N'9' 
                                                                                    when 161377 then N'1' 
                                                                                    when 161374 then N'4' 
                                                                                end) as expr_24 ,
                                                                                SurveyGateway.name as expr_89 ,
                                                                                cat8386.locationCategoryObjectId as entityId_7 ,
                                                                                (case expr_96 
                                                                                    when 208999 then N'4' 
                                                                                    when 209002 then N'1' 
                                                                                    when 209000 then N'3' 
                                                                                    when 208997 then N'6' 
                                                                                    when 208995 then N'8' 
                                                                                    when 208996 then N'7' 
                                                                                    when 208994 then N'9' 
                                                                                    when 209001 then N'2' 
                                                                                    when 208998 then N'5' 
                                                                                end) as expr_96 ,
                                                                                (case expr_109 
                                                                                    when 208753 then N'5' 
                                                                                    when 208754 then N'6' 
                                                                                    when 208757 then N'9' 
                                                                                    when 208749 then N'1' 
                                                                                    when 208751 then N'3' 
                                                                                    when 208750 then N'2' 
                                                                                    when 208755 then N'7' 
                                                                                    when 208756 then N'8' 
                                                                                    when 208752 then N'4' 
                                                                                end) as expr_109 ,
                                                                                expr_80 as expr_80 ,
                                                                                expr_84 as expr_84 ,
                                                                                cat29538.locationCategoryName as expr_92 ,
                                                                                (case expr_52 
                                                                                    when 169915 then N'No' 
                                                                                    when 169914 then N'Yes' 
                                                                                end) as expr_52 ,
                                                                                (case expr_48 
                                                                                    when 161737 then N'Yes' 
                                                                                    when 161738 then N'No' 
                                                                                end) as expr_48 ,
                                                                                (case expr_106 
                                                                                    when 208727 then N'6' 
                                                                                    when 208728 then N'7' 
                                                                                    when 208723 then N'2' 
                                                                                    when 208722 then N'1' 
                                                                                    when 208725 then N'4' 
                                                                                    when 208724 then N'3' 
                                                                                    when 208729 then N'8' 
                                                                                    when 208730 then N'9' 
                                                                                    when 208726 then N'5' 
                                                                                end) as expr_106 ,
                                                                                (case expr_22 
                                                                                    when 161358 then N'2' 
                                                                                    when 161359 then N'1' 
                                                                                    when 161356 then N'4' 
                                                                                    when 161351 then N'9' 
                                                                                    when 161354 then N'6' 
                                                                                    when 161353 then N'7' 
                                                                                    when 161355 then N'5' 
                                                                                    when 161352 then N'8' 
                                                                                    when 161357 then N'3' 
                                                                                end) as expr_22 ,
                                                                                (case expr_21 
                                                                                    when 161778 then N'4' 
                                                                                    when 161777 then N'5' 
                                                                                    when 161780 then N'2' 
                                                                                    when 161773 then N'9' 
                                                                                    when 161776 then N'6' 
                                                                                    when 161779 then N'3' 
                                                                                    when 161774 then N'8' 
                                                                                    when 161775 then N'7' 
                                                                                    when 161781 then N'1' 
                                                                                end) as expr_21 ,
                                                                                (case expr_71 
                                                                                    when 161863 then N'English' 
                                                                                    when 161864 then N'Spanish' 
                                                                                end) as expr_71 ,
                                                                                (case expr_44 
                                                                                    when 161561 then N'4' 
                                                                                    when 161556 then N'9' 
                                                                                    when 161559 then N'6' 
                                                                                    when 161560 then N'5' 
                                                                                    when 161558 then N'7' 
                                                                                    when 161557 then N'8' 
                                                                                    when 161562 then N'3' 
                                                                                    when 161563 then N'2' 
                                                                                    when 161564 then N'1' 
                                                                                end) as expr_44 ,
                                                                                cat8385.locationCategoryName as expr_4 ,
                                                                                expr_65 as expr_65 ,
                                                                                cat29538.locationCategoryObjectId as entityId_93 ,
                                                                                cat8384.locationCategoryName as expr_2 ,
                                                                                expr_82 as expr_82 ,
                                                                                (case expr_43 
                                                                                    when 165412 then N'Do not participate in other reward programs' 
                                                                                    when 165411 then N'Worse than Most' 
                                                                                    when 165409 then N'Better than Most' 
                                                                                    when 165410 then N'About the Same' 
                                                                                end) as expr_43 ,
                                                                                expr_70 as expr_70 ,
                                                                                cat8383.locationCategoryName as expr_0 ,
                                                                                (case expr_74 
                                                                                    when 163566 then N'Spanish' 
                                                                                    when 163565 then N'English' 
                                                                                end) as expr_74 ,
                                                                                expr_68 as expr_68 ,
                                                                                expr_67 as expr_67 ,
                                                                                SurveyGateway.objectId as entityId_90 ,
                                                                                SurveyResponse.offerCode as expr_72 ,
                                                                                (case expr_105 
                                                                                    when 208715 then N'3' 
                                                                                    when 208721 then N'9' 
                                                                                    when 208713 then N'1' 
                                                                                    when 208719 then N'7' 
                                                                                    when 208717 then N'5' 
                                                                                    when 208718 then N'6' 
                                                                                    when 208714 then N'2' 
                                                                                    when 208716 then N'4' 
                                                                                    when 208720 then N'8' 
                                                                                end) as expr_105 ,
                                                                                (case expr_100 
                                                                                    when 209020 then N'1' 
                                                                                    when 209019 then N'0' 
                                                                                    when 209021 then N'2' 
                                                                                    when 209022 then N'3' 
                                                                                    when 209023 then N'4' 
                                                                                end) as expr_100 ,
                                                                                (case expr_41 
                                                                                    when 165395 then N'5' 
                                                                                    when 165397 then N'7' 
                                                                                    when 165392 then N'2' 
                                                                                    when 165399 then N'9 - Extremely Satisfied' 
                                                                                    when 165396 then N'6' 
                                                                                    when 165398 then N'8' 
                                                                                    when 165391 then N'1 - Not At All Satisfied' 
                                                                                    when 165393 then N'3' 
                                                                                    when 165394 then N'4' 
                                                                                end) as expr_41 ,
                                                                                (case expr_23 
                                                                                    when 161364 then N'5' 
                                                                                    when 161365 then N'4' 
                                                                                    when 161367 then N'2' 
                                                                                    when 161362 then N'7' 
                                                                                    when 161361 then N'8' 
                                                                                    when 161360 then N'9' 
                                                                                    when 161366 then N'3' 
                                                                                    when 161363 then N'6' 
                                                                                    when 161368 then N'1' 
                                                                                end) as expr_23 ,
                                                                                (case expr_97 
                                                                                    when 209006 then N'2' 
                                                                                    when 209008 then N'4' 
                                                                                    when 209007 then N'3' 
                                                                                    when 209005 then N'1' 
                                                                                    when 209004 then N'0' 
                                                                                end) as expr_97 ,
                                                                                convert(varchar,
                                                                                SurveyResponse.beginTime,
                                                                                8) as expr_17 ,
                                                                                SurveyResponse.minutes as expr_18 ,
                                                                                (case expr_99 
                                                                                    when 209016 then N'2' 
                                                                                    when 209018 then N'4' 
                                                                                    when 209015 then N'1' 
                                                                                    when 209017 then N'3' 
                                                                                    when 209014 then N'0' 
                                                                                end) as expr_99 ,
                                                                                SurveyResponse.beginDate as expr_16 ,
                                                                                (case expr_37 
                                                                                    when 161717 then N'Automated Phone' 
                                                                                    when 161716 then N'Website' 
                                                                                    when 161718 then N'Agent on Phone' 
                                                                                    when 161719 then N'Another Method' 
                                                                                    when 161715 then N'Visited a Store' 
                                                                                end) as expr_37 ,
                                                                                (case expr_56 
                                                                                    when 161731 then N'Continue' 
                                                                                    when 161730 then N'Leave your Contact Info' 
                                                                                end) as expr_56 ,
                                                                                (case expr_28 
                                                                                    when 161396 then N'9' 
                                                                                    when 161397 then N'8' 
                                                                                    when 161398 then N'7' 
                                                                                    when 161400 then N'5' 
                                                                                    when 161403 then N'2' 
                                                                                    when 161402 then N'3' 
                                                                                    when 161401 then N'4' 
                                                                                    when 161404 then N'1' 
                                                                                    when 161399 then N'6' 
                                                                                end) as expr_28 ,
                                                                                (case expr_94 
                                                                                    when 208976 then N'5' 
                                                                                    when 208974 then N'7' 
                                                                                    when 208979 then N'2' 
                                                                                    when 208978 then N'3' 
                                                                                    when 208977 then N'4' 
                                                                                    when 208980 then N'1' 
                                                                                    when 208975 then N'6' 
                                                                                    when 208973 then N'8' 
                                                                                    when 208972 then N'9' 
                                                                                end) as expr_94 ,
                                                                                expr_78 as expr_78 ,
                                                                                (case expr_107 
                                                                                    when 208732 then N'2' 
                                                                                    when 208734 then N'4' 
                                                                                    when 208733 then N'3' 
                                                                                    when 208736 then N'6' 
                                                                                    when 208738 then N'8' 
                                                                                    when 208731 then N'1' 
                                                                                    when 208737 then N'7' 
                                                                                    when 208735 then N'5' 
                                                                                    when 208739 then N'9' 
                                                                                end) as expr_107 ,
                                                                                (case expr_83 
                                                                                    when 164768 then N'CCC - CCR Assistance ' 
                                                                                    when 164933 then N'WCD - WEL - Lost or Stolen Cards ' 
                                                                                    when 202240 then N'WRC - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 202249 then N'ECO - Balance Financial Inquiry (No Transfer)' 
                                                                                    when 167944 then N'WRC - WRC Specialist - Inbound Call - Specialty' 
                                                                                    when 164134 then N'WHI - Supervisor Override ' 
                                                                                    when 164100 then N'WRC - Days of Supply ' 
                                                                                    when 164891 then N'WCD - PSC - Enrolled - Not in System ' 
                                                                                    when 167956 then N'WRC - WRC - HD / Plan Not Contracted' 
                                                                                    when 164932 then N'WCD - WEL - Products Eligible for Rebate Rewards Inquiry ' 
                                                                                    when 184431 then N'YES - ESC - General Inquiry' 
                                                                                    when 184462 then N'WMS - ESC - Non-Escalation: CCR Assistance' 
                                                                                    when 202219 then N'MTM - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 184520 then N'ECO - ESC - Store Assistance' 
                                                                                    when 164718 then N'YES - Schraft''s (Infertility) ' 
                                                                                    when 164816 then N'WHI - WellCare - Non-After Hours ' 
                                                                                    when 164778 then N'WMS - Enrollment Status Check ' 
                                                                                    when 184476 then N'WAG - ESC - Complaint - Pharmacy' 
                                                                                    when 202251 then N'WAG - REW - Balance Financial Inquiry (No Transfer)' 
                                                                                    when 164761 then N'CMC - Corporate / District / Walgreens Call ' 
                                                                                    when 184574 then N'WAG - REW - ESC - Non-Escalation: CCR Assistance' 
                                                                                    when 164854 then N'WMS - Autofill On ' 
                                                                                    when 165034 then N'WHI - HD/TL DMR ' 
                                                                                    when 164839 then N'WMS - Complaint - Collections ' 
                                                                                    when 184551 then N'WAG - DailyMed Enrollment' 
                                                                                    when 184496 then N'WAG - ESC - Store Assistance' 
                                                                                    when 190838 then N'WAG - DailyMed Patient Information Update' 
                                                                                    when 164096 then N'MTM - AOT Intervention ' 
                                                                                    when 164965 then N'WAG - REW - Other ' 
                                                                                    when 164624 then N'WFV - Patient - Rx Status ' 
                                                                                    when 184461 then N'WMS - ESC - Mobile App' 
                                                                                    when 167903 then N'WAG - REW - Employee Account Linking Assistance' 
                                                                                    when 167938 then N'WAG - BR - Activation - Other Activation Options - How to Verify On-line' 
                                                                                    when 202237 then N'WMS - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 202206 then N'CCC - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164751 then N'CMC - Inventory / Price ' 
                                                                                    when 164109 then N'WRC - Invalid Prescriber ID ' 
                                                                                    when 164971 then N'WAG - REW - Rewards Program not Available in their area ' 
                                                                                    when 164906 then N'WCD - PSC - Rebate Rewards Under 48 Hours ' 
                                                                                    when 164144 then N'WFV - Patient - Consultation ' 
                                                                                    when 164052 then N'WMS - Order Status ' 
                                                                                    when 202205 then N'CCC - ACA Call - Referred to Website' 
                                                                                    when 164108 then N'WRC - Not Processed ' 
                                                                                    when 164976 then N'WAG - WOW - Enrollment - General Question ' 
                                                                                    when 184489 then N'WAG - ESC - Non - Escalation: Compliment' 
                                                                                    when 165059 then N'ECO - Pharmacy ' 
                                                                                    when 164905 then N'WCD - PSC - Rebate Rewards Over 48 Hours ' 
                                                                                    when 184503 then N'ECO - ESC - Contact Lens Order' 
                                                                                    when 165060 then N'ECO - Photo ' 
                                                                                    when 164913 then N'WCD - PSC - Verify Rebate Rewards Balance Available ' 
                                                                                    when 164638 then N'WHC - Complaint ' 
                                                                                    when 164828 then N'CMC - Invalid Transfer ' 
                                                                                    when 202255 then N'WAG - Campaigns- Script Alignment Declined' 
                                                                                    when 202229 then N'WHC - ACA Call - Referred to Website' 
                                                                                    when 165010 then N'WAG - REW - Inquiry from an AARP Member ' 
                                                                                    when 165009 then N'WAG - REW - Inquiry from an AARP Member ' 
                                                                                    when 166113 then N'WRC - WRC Specialist - Inbound Call - Prescriber' 
                                                                                    when 184434 then N'YES - ESC - Mobile App' 
                                                                                    when 164958 then N'WAG - REW - Issues Redeeming Points ' 
                                                                                    when 164779 then N'WMS - Insurance ' 
                                                                                    when 184526 then N'WCD - ESC - Card Attached to Wrong Account' 
                                                                                    when 167904 then N'ECO - Activation' 
                                                                                    when 165041 then N'WMS - HD/TL Website Issues ' 
                                                                                    when 164047 then N'WMS - Copay/Price ' 
                                                                                    when 164681 then N'WMS - Service Appreciation ' 
                                                                                    when 184524 then N'WCD - ESC - Cancel Request' 
                                                                                    when 164736 then N'MPB - Order Status No Issue ' 
                                                                                    when 164088 then N'MTM - Spanish Member General (Question or Inquiry) ' 
                                                                                    when 164696 then N'YES - Immunizations ' 
                                                                                    when 202208 then N'CMC - ACA Call - Referred to Website' 
                                                                                    when 164700 then N'YES - Institutional Pharmacy ' 
                                                                                    when 165011 then N'WAG - REW - CCR Enrollment ' 
                                                                                    when 164918 then N'WCD - PSC - On Line Enrollment Questions ' 
                                                                                    when 184481 then N'WAG - ESC - Ghost Call' 
                                                                                    when 164770 then N'CCC - Escalation ' 
                                                                                    when 167958 then N'WRC - WRC - HD / Recommendation of refresher training' 
                                                                                    when 184441 then N'YES - ESC - Website' 
                                                                                    when 164899 then N'WCD - PSC - Name/Address Change Send New Card ' 
                                                                                    when 164117 then N'WMS - HD/TL Other ' 
                                                                                    when 167950 then N'WRC - WRC - HD / New/Update Process Question' 
                                                                                    when 164852 then N'CMC - SSC Deskside Support ' 
                                                                                    when 184429 then N'YES - ESC - Complaint - Store' 
                                                                                    when 164054 then N'WMS - Registration ' 
                                                                                    when 164635 then N'WFV - Patient - Transfer to competitor ' 
                                                                                    when 164935 then N'WCD - WEL - Refer to Benefits Administrator ' 
                                                                                    when 164141 then N'WFV - Prescriber - Interaction ' 
                                                                                    when 164072 then N'CCC - Copay Questions ' 
                                                                                    when 164832 then N'WAG - RD Damaged or Lost ' 
                                                                                    when 184571 then N'WAG - REW - ESC - Link/De-Link Accounts' 
                                                                                    when 184540 then N'WCD - ESC - Non-Escalation: Compliment' 
                                                                                    when 164631 then N'WFV - Other - Employee/Personal Calls ' 
                                                                                    when 165004 then N'WAG - REW - Neg Cust Comments Re: Company ' 
                                                                                    when 164680 then N'WMS - Complaint - Delivery Delay, within timeframe ' 
                                                                                    when 164954 then N'WAG - REW - Account Info not Found Online ' 
                                                                                    when 164065 then N'WHI - DMR Status ' 
                                                                                    when 164094 then N'MTM - CP 2 Intervention ' 
                                                                                    when 184457 then N'WMS - ESC - Ghost Call' 
                                                                                    when 167932 then N'WAG - BR - Activation - Other' 
                                                                                    when 172343 then N'WMS - WH MS User Transition - Credit Card' 
                                                                                    when 164637 then N'WHC - Billing ' 
                                                                                    when 164967 then N'WAG - REW - Points Balance Concern - Corrective ' 
                                                                                    when 184493 then N'WAG - ESC - Promotion Related' 
                                                                                    when 184579 then N'WAG - REW - ESC - Program Exclusions' 
                                                                                    when 172345 then N'WMS - WH MS User Transition - Prescription Issues' 
                                                                                    when 165045 then N'WAG - CR WRPR Status Inquiry ' 
                                                                                    when 164853 then N'WMS - Autofill Off ' 
                                                                                    when 184537 then N'WCD - ESC - IVR' 
                                                                                    when 164966 then N'WAG - REW - Parent Calling re: Child''s Account ' 
                                                                                    when 164977 then N'WAG - ECO - ECom Inquiry ' 
                                                                                    when 164844 then N'CMC - Transfer From Competitor ' 
                                                                                    when 167937 then N'WAG - BR - Activation - Cannot Activate w/Code - Other' 
                                                                                    when 190835 then N'WAG - DailyMed Cancellation' 
                                                                                    when 164729 then N'MPB - WAG MPB Program Information ' 
                                                                                    when 184525 then N'WCD - ESC - Cancelled in Error' 
                                                                                    when 164848 then N'WAG - COR - Store Complaint ' 
                                                                                    when 164119 then N'WMS - HD/TL Short Term Supply ' 
                                                                                    when 164640 then N'WHC - Copay/Price ' 
                                                                                    when 184536 then N'WCD - ESC - Gov''t Funded' 
                                                                                    when 164926 then N'WCD - RRC - Rebate Rewards Over 48 Hours ' 
                                                                                    when 184559 then N'WAG - REW - ESC - Card Attached to Wrong Account' 
                                                                                    when 164890 then N'WCD - PSC - Duplicate Card Request ' 
                                                                                    when 164859 then N'WCD - WGC - General Information ' 
                                                                                    when 184471 then N'WMS - ESC - Shipping' 
                                                                                    when 164997 then N'WCD - RRC - Ghost Call ' 
                                                                                    when 184466 then N'WMS - ESC - Order Not Received' 
                                                                                    when 184497 then N'WAG - ESC - System Error' 
                                                                                    when 184463 then N'WMS - ESC - Non-Escalation: Compliment' 
                                                                                    when 164760 then N'CMC - Personal Call For Store Staff ' 
                                                                                    when 164066 then N'WHI - DUR Rejects ' 
                                                                                    when 167948 then N'WRC - WRC Specialist - Patient/Prescriber Complaint' 
                                                                                    when 184518 then N'ECO - ESC - Promotion Related' 
                                                                                    when 167921 then N'WAG - BR - Points - Points Balance Inquiry' 
                                                                                    when 184516 then N'ECO - ESC - Payment Related' 
                                                                                    when 184499 then N'ECO - ESC - Cancel Request' 
                                                                                    when 164787 then N'WAG - RD Enrolled ' 
                                                                                    when 184538 then N'WCD - ESC - Mobile App' 
                                                                                    when 164648 then N'WHC - New Referral / New Starts ' 
                                                                                    when 202245 then N'YES - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 184585 then N'WAG - REW - ESC - Website' 
                                                                                    when 165032 then N'WHI - HD/TL Website Issues ' 
                                                                                    when 164928 then N'WCD - RRC - Unable to Add Purchases On-line ' 
                                                                                    when 167923 then N'WAG - BR - Points - Points Balance Concern/ Correction' 
                                                                                    when 167915 then N'WAG - BR - Memerbership/Account - Program Detail Request' 
                                                                                    when 164142 then N'WFV - Prescriber - Substitution ' 
                                                                                    when 165043 then N'WMS - HD/TL Issue Category ' 
                                                                                    when 164791 then N'WAG - RD Other ' 
                                                                                    when 164742 then N'MPB - Refill - Declined Up Sell Offer ' 
                                                                                    when 184581 then N'WAG - REW - ESC - Return/Refund' 
                                                                                    when 164776 then N'WHI - HIPAA Privacy Office ' 
                                                                                    when 164820 then N'WAG - CR Employee Issue - Pharmacy ' 
                                                                                    when 166115 then N'WRC - WRC - HD/General SOP Question' 
                                                                                    when 164044 then N'WHI - Pharmacy Locator ' 
                                                                                    when 164923 then N'WCD - RRC - Products Eligible for Rebate Rewards Inquiry ' 
                                                                                    when 202238 then N'WRC - ACA Call - Referred to Website' 
                                                                                    when 167961 then N'WAG - REW - Link Customer Account' 
                                                                                    when 164762 then N'CMC - Other - Call from Store ' 
                                                                                    when 164823 then N'WAG - CR Rx or Drug Concern ' 
                                                                                    when 167953 then N'WRC - WRC - HD / Technical Issues' 
                                                                                    when 164048 then N'WMS - Complaint - Delivery Delay, outside timeframe ' 
                                                                                    when 164910 then N'WCD - PSC - Re-Issue Card ' 
                                                                                    when 164857 then N'WCD - WGC - Add to Balance ' 
                                                                                    when 167933 then N'WAG - BR - Activation - Cannot Activate w/Code - Calling for Family Member' 
                                                                                    when 164980 then N'WCD - WGC - Spanish Call ' 
                                                                                    when 167936 then N'WAG - BR - Activation - Cannot Activate w/Code - Sent Pin Letter' 
                                                                                    when 202243 then N'WSP - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 164978 then N'WAG - ECO - ECom Concern ' 
                                                                                    when 165015 then N'WAG - Flu - Pricing ' 
                                                                                    when 164903 then N'WCD - PSC - Products Eligible for Rebate Rewards Inquiry ' 
                                                                                    when 165038 then N'WMS - HD/TL Cancel Order ' 
                                                                                    when 164097 then N'MTM - IMIE Intervention ' 
                                                                                    when 184508 then N'ECO - ESC - IVR' 
                                                                                    when 164863 then N'WCD - SWC - General Information ' 
                                                                                    when 184440 then N'YES - ESC - System error' 
                                                                                    when 164869 then N'WCD - VGC - Transaction History ' 
                                                                                    when 164660 then N'WHC - Route Check ' 
                                                                                    when 164664 then N'WMS - Transfer to WHI ' 
                                                                                    when 164780 then N'WMS - Prescription-Transfer ' 
                                                                                    when 164623 then N'WFV - Patient - Refill Request ' 
                                                                                    when 202236 then N'WMS - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164881 then N'WCD - CSG - Transaction History ' 
                                                                                    when 164929 then N'WCD - WEL - Add Purchases to Card ' 
                                                                                    when 165049 then N'WAG - REW - Points Expire Concern ' 
                                                                                    when 164947 then N'WAG - REW - Cannot Link to walgreens.com ' 
                                                                                    when 184479 then N'WAG - ESC - DNC Request' 
                                                                                    when 184468 then N'WMS - ESC - Payment Related' 
                                                                                    when 184484 then N'WAG - ESC - IVR' 
                                                                                    when 165036 then N'WHI - HD/TL Copay/Formulary ' 
                                                                                    when 164741 then N'MPB - Order Status Other Issue/Callback ' 
                                                                                    when 184565 then N'WAG - REW - ESC - Duplicate Account' 
                                                                                    when 164887 then N'WCD - PSC - Claims Processing ' 
                                                                                    when 164130 then N'WMS - Website Issues ' 
                                                                                    when 164120 then N'WMS - HD/TL Issue ' 
                                                                                    when 184464 then N'WMS - ESC - Non-Escalation:Other' 
                                                                                    when 164057 then N'WMS - Rph (Pharmacist) ' 
                                                                                    when 184541 then N'WCD - ESC - Non-Escalation: Other' 
                                                                                    when 164666 then N'WMS - Mis Filled Rx ' 
                                                                                    when 202222 then N'WAG - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 165023 then N'WHI - Flu - Pricing ' 
                                                                                    when 164846 then N'WAG - COR - Pharmacy Complaint ' 
                                                                                    when 164998 then N'WCD - RRC - Spanish Call ' 
                                                                                    when 164771 then N'CCC - Ghost Call ' 
                                                                                    when 164985 then N'WCD - VGC - Ghost Call ' 
                                                                                    when 165006 then N'WAG - REW - Product or Service Question ' 
                                                                                    when 164982 then N'WCD - SWC - Ghost Call ' 
                                                                                    when 164894 then N'WCD - PSC - Value Priced Generic List ' 
                                                                                    when 164963 then N'WAG - REW - Multiple Enrollments ' 
                                                                                    when 202247 then N'HCC - Patient Calls' 
                                                                                    when 164875 then N'WCD - PRC - Transaction History ' 
                                                                                    when 164964 then N'WAG - REW - Never Received Permanent Cards ' 
                                                                                    when 164122 then N'WHI - HD/TL Other ' 
                                                                                    when 184517 then N'ECO - ESC - Program Exclusions' 
                                                                                    when 164884 then N'WCD - PSC - Benefit Termination Questions ' 
                                                                                    when 167942 then N'WAG - BR - Activation - Other Activation Options - Other' 
                                                                                    when 164920 then N'WCD - RRC - Add Rebate Rewards ' 
                                                                                    when 164105 then N'WRC - Drug Utilization Review (DUR) ' 
                                                                                    when 172349 then N'WAG - REW - Chicago Public Schools Program Question ' 
                                                                                    when 164856 then N'WAG - COR - Store Praise ' 
                                                                                    when 184491 then N'WAG - ESC - Other' 
                                                                                    when 164766 then N'CMC - Voicemail Prescriber - Other ' 
                                                                                    when 167908 then N'WAG - BR - Memerbership/Account - Does not want to enroll' 
                                                                                    when 184453 then N'WMS - ESC - Doctor Call' 
                                                                                    when 184567 then N'WAG - REW - ESC - General Inquiry' 
                                                                                    when 164722 then N'YES - Take Care Health Clinics ' 
                                                                                    when 184564 then N'WAG - REW - ESC - DNC Request' 
                                                                                    when 184445 then N'WMS - ESC - Cancel Request' 
                                                                                    when 184552 then N'WAG - DailyMed Billing' 
                                                                                    when 165001 then N'WCD - WEL - Spanish Call ' 
                                                                                    when 164748 then N'CMC - Prescription Status ' 
                                                                                    when 164986 then N'WCD - VGC - Spanish Call ' 
                                                                                    when 202234 then N'WHI - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 164898 then N'WCD - PSC - Membership Renewal ' 
                                                                                    when 164723 then N'MPB - New Customer Order ' 
                                                                                    when 184488 then N'WAG - ESC - Non-Escalation: CCR Assistance' 
                                                                                    when 202258 then N'WAG - WCR Field Support' 
                                                                                    when 164953 then N'WAG - REW - Duplicate Card Request - Re-enroll ' 
                                                                                    when 165047 then N'WAG - CR W-CARD - WRPR Status Inquiry ' 
                                                                                    when 164626 then N'WFV - Patient - Non-TRP exception ' 
                                                                                    when 164077 then N'CCC - Other ' 
                                                                                    when 164113 then N'WRC - Other TPO ' 
                                                                                    when 165002 then N'WCD - WEL - Store Information ' 
                                                                                    when 164972 then N'WAG - REW - Store Call for Assistance ' 
                                                                                    when 164781 then N'WMS - Refill Attempt - No Refills ' 
                                                                                    when 164754 then N'CMC - Pat - Compliment / Complaint ' 
                                                                                    when 164043 then N'WHI - ID Card Request ' 
                                                                                    when 164974 then N'WAG - REW - Verify Rewards Points Balance ' 
                                                                                    when 164080 then N'MTM - Patient Opt Out (All Others) ' 
                                                                                    when 165028 then N'WHI - Flu - Insurance Coverage (MPB) ' 
                                                                                    when 164782 then N'WMS - Refill Qty Remaining Inquiry ' 
                                                                                    when 184498 then N'WAG - ESC - Website' 
                                                                                    when 184586 then N'ECO - Helpdesk' 
                                                                                    when 167909 then N'WAG - BR - Memerbership/Account - Cancellation Request' 
                                                                                    when 164646 then N'WHC - Ghost Call ' 
                                                                                    when 164074 then N'CCC - CPA, Stepcare, SPA ' 
                                                                                    when 167951 then N'WRC - WRC - HD / Specialty Process Question' 
                                                                                    when 164908 then N'WCD - PSC - Store Inquiry-Card not Working at Register ' 
                                                                                    when 164794 then N'WAG - RD Website Assistance ' 
                                                                                    when 184433 then N'YES - ESC - IVR ' 
                                                                                    when 184451 then N'WMS - ESC - Damage/Shortage' 
                                                                                    when 184465 then N'WMS - ESC - Order Incorrect' 
                                                                                    when 164833 then N'WAG - PMR - Completed PMR ' 
                                                                                    when 164994 then N'WCD - PSC - Ghost Call ' 
                                                                                    when 164662 then N'WHC - Update Profile/Account Information ' 
                                                                                    when 164652 then N'WHC - Order Status ' 
                                                                                    when 172347 then N'WMS - WH MS User Transition - Auto Refill Issues' 
                                                                                    when 165005 then N'WAG - REW - Neg Cust Comments Re: Program ' 
                                                                                    when 184539 then N'WCD - ESC - Non - Escalation: CCR Assistance' 
                                                                                    when 164703 then N'YES - Nursing ' 
                                                                                    when 164901 then N'WCD - PSC - Plan Change / Family to Individual ' 
                                                                                    when 165062 then N'ECO - Web Pickup ' 
                                                                                    when 184443 then N'WMS - ESC - Balance Issues' 
                                                                                    when 167947 then N'WRC - WRC Specialist - Store Complaint(s)' 
                                                                                    when 164924 then N'WCD - RRC - Store Inquiry ' 
                                                                                    when 190837 then N'WAG - DailyMed Order Status' 
                                                                                    when 202207 then N'CCC - ACA Call - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 164917 then N'WCD - PSC - Medicare/Medicaid Questions ' 
                                                                                    when 164979 then N'WCD - WGC - Ghost Call ' 
                                                                                    when 164962 then N'WAG - REW - Merge Cards/Accounts ' 
                                                                                    when 167906 then N'ECO - Balance Rewards' 
                                                                                    when 164914 then N'WCD - PSC - Cannot Link Card to walgreens.com ' 
                                                                                    when 167910 then N'WAG - BR - Memerbership/Account - Duplicate Card Request' 
                                                                                    when 165014 then N'WAG - REW - Add Raincheck Bonus Points ' 
                                                                                    when 167905 then N'ECO - Username/Password/Resets' 
                                                                                    when 164735 then N'MPB - Cancel Order Audit Issue ' 
                                                                                    when 164095 then N'MTM - CP 3 Intervention ' 
                                                                                    when 203282 then N'WRC - WRC Field Support' 
                                                                                    when 184542 then N'WCD - ESC - Other' 
                                                                                    when 164059 then N'WMS - Other ' 
                                                                                    when 164909 then N'WCD - PSC - Store Inquiry-Store Calling on Behalf of Customer ' 
                                                                                    when 167935 then N'WAG - BR - Activation - Cannot Activate w/Code - Customer to Call Back' 
                                                                                    when 165030 then N'WHI - Flu - Dosage / Age Requirement ' 
                                                                                    when 164064 then N'WHI - Clinical Prior Authorization ' 
                                                                                    when 202216 then N'MPB - ACA Call - Customer declined transfer/referral to Go Health' 
                                                                                    when 164934 then N'WCD - WEL - Name / Address Change ' 
                                                                                    when 164864 then N'WCD - SWC - Transaction History ' 
                                                                                    when 184506 then N'ECO - ESC - General Inquiry' 
                                                                                    when 164663 then N'WMS - Request Spanish Rep - Transfer ' 
                                                                                    when 184442 then N'WMS - ESC - Autofill' 
                                                                                    when 164831 then N'WAG - RD Billing ' 
                                                                                    when 164817 then N'WHI - HD Questions ' 
                                                                                    when 167931 then N'WAG - BR - Activation - Calling for Family Member' 
                                                                                    when 164107 then N'WRC - Other ' 
                                                                                    when 164973 then N'WAG - REW - Unable to Add Purchases On-line ' 
                                                                                    when 184504 then N'ECO - ESC - DNC Request' 
                                                                                    when 164641 then N'WHC - Did Not Receive Order ' 
                                                                                    when 164988 then N'WCD - PRC - Ghost Call ' 
                                                                                    when 184455 then N'WMS - ESC - Failure to Contact' 
                                                                                    when 165013 then N'CMC - Store Complaint ' 
                                                                                    when 184477 then N'WAG - ESC - Complaint - Store' 
                                                                                    when 164889 then N'WCD - PSC - Dependent Coverage ' 
                                                                                    when 184566 then N'WAG - REW - ESC - Employee Discount' 
                                                                                    when 184543 then N'WCD - ESC - Payment Related' 
                                                                                    when 184469 then N'WMS - ESC - Plan' 
                                                                                    when 164834 then N'WAG - PMR - Did Not Complete PMR ' 
                                                                                    when 164099 then N'MTM - Offline Inquiry ' 
                                                                                    when 164855 then N'WAG - COR - Pharmacy Praise ' 
                                                                                    when 164086 then N'MTM - Physician Call General (Question) ' 
                                                                                    when 202246 then N'YES - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 164789 then N'WAG - RD Information ' 
                                                                                    when 164143 then N'WFV - Patient - Feedback ' 
                                                                                    when 202235 then N'WMS - ACA Call - Referred to Website' 
                                                                                    when 164071 then N'CCC - Admin Override ' 
                                                                                    when 184428 then N'YES - ESC - Complaint - Pharmacy' 
                                                                                    when 184555 then N'WAG - DailyMed Pharmacy' 
                                                                                    when 164082 then N'MTM - Pharmacy Opting Patient Out ' 
                                                                                    when 164957 then N'WAG - REW - Cancel Card ' 
                                                                                    when 184449 then N'WMS - ESC - Complaint - Program' 
                                                                                    when 167941 then N'WAG - BR - Activation - Other Activation Options - Unhappy with On-line Verification' 
                                                                                    when 165061 then N'ECO - WCARD ' 
                                                                                    when 164840 then N'YES - Local Store Question ' 
                                                                                    when 164829 then N'CMC - Valid Transfer ' 
                                                                                    when 184549 then N'WCD - ESC - System Error' 
                                                                                    when 202233 then N'WHI - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164975 then N'WAG - WOW - Scheduling - Member Not Found ' 
                                                                                    when 202212 then N'ECO - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164907 then N'WCD - PSC - Rx Price ' 
                                                                                    when 184494 then N'WAG - ESC - Return/Refund' 
                                                                                    when 164858 then N'WCD - WGC - Balance Inquiry ' 
                                                                                    when 164868 then N'WCD - VGC - Lost or Stolen Card ' 
                                                                                    when 167945 then N'WRC - WRC Specialist - Inbound Call - Fax Machine' 
                                                                                    when 190836 then N'WAG - DailyMed Ghost Call' 
                                                                                    when 164783 then N'WMS - Transfer to AARP CCR ' 
                                                                                    when 184424 then N'WRC - WRC - Inbound Call - PCC New' 
                                                                                    when 164880 then N'WCD - CSG - Lost or Stolen Card ' 
                                                                                    when 184447 then N'WMS - ESC - Complaint - CCR' 
                                                                                    when 184558 then N'WAG - REW - ESC - Cancel Request' 
                                                                                    when 164786 then N'WAG - RD Cancelled ' 
                                                                                    when 164825 then N'WAG - CR Other ' 
                                                                                    when 164118 then N'WMS - HD/TL Escalation ' 
                                                                                    when 164691 then N'WSP - After Hours ' 
                                                                                    when 164893 then N'WCD - PSC - Fee Paid No Coverage ' 
                                                                                    when 164659 then N'WHC - Return Request ' 
                                                                                    when 164750 then N'CMC - Pharmacist Consultation ' 
                                                                                    when 164991 then N'WCD - CSG - Ghost Call ' 
                                                                                    when 164058 then N'WMS - Update Profile/Account Information ' 
                                                                                    when 164089 then N'MTM - Spanish General ' 
                                                                                    when 167927 then N'WAG - BR - Points - Point Redemption at Store' 
                                                                                    when 184487 then N'WAG - ESC - No Response' 
                                                                                    when 165033 then N'WHI - HD/TL Pharmacy Pay Status ' 
                                                                                    when 164952 then N'WAG - REW - Combine Family Points ' 
                                                                                    when 184515 then N'ECO - ESC - Other' 
                                                                                    when 184561 then N'WAG - REW - ESC - Complaint - Pharmacy' 
                                                                                    when 184510 then N'ECO - ESC - Mobile App' 
                                                                                    when 164955 then N'WAG - REW - Card not Recognized at POS ' 
                                                                                    when 164984 then N'WCD - SWC - Store Information ' 
                                                                                    when 202228 then N'WFV - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 202232 then N'WHI - ACA Call - Referred to Website' 
                                                                                    when 164960 then N'WAG - REW - Lost or Stolen Card - Re-enroll ' 
                                                                                    when 164915 then N'WCD - PSC - Received Another Member''s Card ' 
                                                                                    when 184502 then N'ECO - ESC - Complaint - Store' 
                                                                                    when 164922 then N'WCD - RRC - Name / Address Change ' 
                                                                                    when 164996 then N'WCD - PSC - Store Information ' 
                                                                                    when 164775 then N'WMS - AARP Enrollment ' 
                                                                                    when 164862 then N'WCD - SWC - Balance Inquiry ' 
                                                                                    when 165003 then N'WAG - REW - Explain Mailing ' 
                                                                                    when 184580 then N'WAG - REW - ESC - Promotion Related' 
                                                                                    when 164050 then N'WMS - Emergency Prescription ' 
                                                                                    when 165046 then N'WAG - CR W-CARD - WRPR Corporate Escalation ' 
                                                                                    when 164755 then N'CMC - Pat - Transfer to/from Competitor ' 
                                                                                    when 164653 then N'WHC - Other ' 
                                                                                    when 184553 then N'WAG - DailyMed Escalation' 
                                                                                    when 202217 then N'MTM - ACA Call - Referred to Website' 
                                                                                    when 167907 then N'WAG - BR - Memerbership/Account - Enroll' 
                                                                                    when 166114 then N'WRC - WRC Specialist - Inbound Call - Store' 
                                                                                    when 164818 then N'WHI - Transfer to AARP CCR ' 
                                                                                    when 164999 then N'WCD - RRC - Store Information ' 
                                                                                    when 164695 then N'YES - HME ' 
                                                                                    when 164665 then N'WMS - Systems Down ' 
                                                                                    when 164873 then N'WCD - PRC - General Information ' 
                                                                                    when 164056 then N'WMS - Return Request ' 
                                                                                    when 164841 then N'CMC - Specific Employee Request ' 
                                                                                    when 202252 then N'WAG - REW - Balance Financial - Transfer' 
                                                                                    when 164871 then N'WCD - PRC - Balance Inquiry ' 
                                                                                    when 164758 then N'CMC - Pbr - Refill Authorization ' 
                                                                                    when 202223 then N'WCD - ACA Call - Referred to Website' 
                                                                                    when 164098 then N'MTM - Training ' 
                                                                                    when 164649 then N'WHC - No Go Equipment ' 
                                                                                    when 164078 then N'CCC - Pharmacy Errors ' 
                                                                                    when 184427 then N'YES - ESC - Complaint - CCR' 
                                                                                    when 164827 then N'CMC - Escalation ' 
                                                                                    when 202227 then N'WFV - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 202210 then N'CMC - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 164719 then N'YES - Specialty Pharmacy ' 
                                                                                    when 164650 then N'WHC - No Go Insurance ' 
                                                                                    when 164627 then N'WFV - Patient - Non-Rx Questions ' 
                                                                                    when 165349 then N'null' 
                                                                                    when 164951 then N'WAG - REW - Check Points Balance on Account ' 
                                                                                    when 164765 then N'CMC - Voicemail Prescriber - Refill ' 
                                                                                    when 164744 then N'MPB - DVN Invoice Issue/Callback ' 
                                                                                    when 184575 then N'WAG - REW - ESC - Non-Escalation - Compliment' 
                                                                                    when 164702 then N'YES - Medical Supplies ' 
                                                                                    when 164788 then N'WAG - RD Feedback / Issues ' 
                                                                                    when 165035 then N'WHI - HD/TL Claim Status ' 
                                                                                    when 184582 then N'WAG - REW - ESC - Someone Else Redeemed Points' 
                                                                                    when 164656 then N'WHC - Prior Authorization ' 
                                                                                    when 164686 then N'WHI - Transfer to WMS ' 
                                                                                    when 184584 then N'WAG - REW - ESC - System Error' 
                                                                                    when 167934 then N'WAG - BR - Activation - Cannot Activate w/Code - Technical Issue w/Code' 
                                                                                    when 164634 then N'WFV - Patient - Transfer from competitor ' 
                                                                                    when 165040 then N'WMS - HD/TL Change Address ' 
                                                                                    when 202225 then N'WCD - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 172346 then N'WMS - WH MS User Transition - KBA Authentication Issues' 
                                                                                    when 164055 then N'WMS - Retail Questions ' 
                                                                                    when 184572 then N'WAG - REW - ESC - Member Info Incorrect' 
                                                                                    when 164930 then N'WCD - WEL - Add to Balance ' 
                                                                                    when 164865 then N'WCD - VGC - Add to Balance ' 
                                                                                    when 164847 then N'WAG - COR - Pharmacy Inquiry ' 
                                                                                    when 164763 then N'CMC - Other ' 
                                                                                    when 167940 then N'WAG - BR- Activation - Other Activation Options - How to Activate w/Rx #' 
                                                                                    when 167962 then N'WAG - REW - Govt Funded Script ' 
                                                                                    when 164931 then N'WCD - WEL - Balance Inquiry ' 
                                                                                    when 164688 then N'CCC - Systems Down ' 
                                                                                    when 164734 then N'MPB - Item Not Covered by WSSC Issue ' 
                                                                                    when 164885 then N'WCD - PSC - Cancel Card; Refund Requested ' 
                                                                                    when 164879 then N'WCD - CSG - General Information ' 
                                                                                    when 164942 then N'YES - H1N1 ' 
                                                                                    when 164079 then N'MTM - Patient Opt In (Ovations Only) ' 
                                                                                    when 184436 then N'YES - ESC - Non-Escalation: Compliment' 
                                                                                    when 165065 then N'WAG - REW - CustFeedbackPositive - Company ' 
                                                                                    when 164053 then N'WMS - Plan Information ' 
                                                                                    when 184577 then N'WAG - REW - ESC - Other' 
                                                                                    when 164706 then N'YES - Other ' 
                                                                                    when 164707 then N'YES - PBM (Walgreens Health Initiatives) ' 
                                                                                    when 165017 then N'WAG - Flu - Gift Card ' 
                                                                                    when 167955 then N'WRC - WRC - HD / New Hire Process Question' 
                                                                                    when 164990 then N'WCD - PRC - Store Information ' 
                                                                                    when 164824 then N'WAG - CR Store Facility Complaint-Cleanliness Parking Safety ' 
                                                                                    when 164062 then N'WHI - CCR Override ' 
                                                                                    when 164837 then N'WAG - PMR - Not a PMR Call ' 
                                                                                    when 164757 then N'CMC - New Prescription ' 
                                                                                    when 184522 then N'ECO - ESC - Website' 
                                                                                    when 164861 then N'WCD - WGC - Transaction History ' 
                                                                                    when 167911 then N'WAG - BR - Memerbership/Account - Link to Existing Membership' 
                                                                                    when 164774 then N'YES - Ghost Call ' 
                                                                                    when 164851 then N'CMC - SSC Education ' 
                                                                                    when 167957 then N'WRC - WRC - HD / Claim Reversal' 
                                                                                    when 202213 then N'ECO - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 164969 then N'WAG - REW - Redeem Rewards Points ' 
                                                                                    when 164115 then N'WRC - Coordination of Benefits (COB) ' 
                                                                                    when 164970 then N'WAG - REW - Rewards Not Received ' 
                                                                                    when 164129 then N'WMS - Website - Password Reset ' 
                                                                                    when 165022 then N'WAG - Flu - Dosage / Age Requirement ' 
                                                                                    when 184557 then N'WAG - REW - ESC - Add Transaction' 
                                                                                    when 184523 then N'WCD - ESC - Add Transaction' 
                                                                                    when 164878 then N'WCD - CSG - Card Activation ' 
                                                                                    when 165021 then N'WAG - Flu - Immunization (Flu Mist/Pneumonia) ' 
                                                                                    when 164950 then N'WAG - REW - Check Balance on Rewards Certificate ' 
                                                                                    when 202242 then N'WSP - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 165008 then N'WAG - REW - Update Password ' 
                                                                                    when 164732 then N'MPB - WAG MPB Product Information ' 
                                                                                    when 165054 then N'ECO - Account Information ' 
                                                                                    when 164790 then N'WAG - RD Inquiry - Order/Acct ' 
                                                                                    when 184507 then N'ECO - ESC - Ghost Call' 
                                                                                    when 165067 then N'WAG - REW - Points Balance Concern - Goodwill ' 
                                                                                    when 164872 then N'WCD - PRC - Card Activation ' 
                                                                                    when 164849 then N'WAG - COR - Store Inquiry ' 
                                                                                    when 164110 then N'WRC - Refill Not Covered ' 
                                                                                    when 184530 then N'WCD - ESC - Complaint - Store' 
                                                                                    when 184473 then N'WMS - ESC - System Error' 
                                                                                    when 164655 then N'WHC - Payment Information ' 
                                                                                    when 184500 then N'ECO - ESC - Complaint - CCR' 
                                                                                    when 167939 then N'WAG - BR - Activation - Other Activation Options - How to Activate with Pin' 
                                                                                    when 164114 then N'WRC - Other-No TPR(wrong number) ' 
                                                                                    when 164694 then N'YES - Compounding ' 
                                                                                    when 202250 then N'ECO - Balance Financial - Transfer' 
                                                                                    when 164045 then N'WHI - Other ' 
                                                                                    when 202239 then N'WRC - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164102 then N'WRC - Drug Not Covered ' 
                                                                                    when 167917 then N'WAG - BR - Memerbership/Account - Update Account Information' 
                                                                                    when 164815 then N'WHI - Member Information Not Found ' 
                                                                                    when 184456 then N'WMS - ESC - General Inquiry' 
                                                                                    when 164661 then N'WHC - Transfer Out Call ' 
                                                                                    when 164767 then N'CMC - Voicemail Patient ' 
                                                                                    when 164752 then N'CMC - Pat - Location / Hours ' 
                                                                                    when 164630 then N'WFV - Stores - Other stores calling for products ' 
                                                                                    when 202244 then N'YES - ACA Call - Referred to Website' 
                                                                                    when 164919 then N'WCD - PSC - Add Rebate Rewards on Day Card Purchased ' 
                                                                                    when 165056 then N'ECO - General Website ' 
                                                                                    when 165042 then N'WMS - HD/TL Exception Status ' 
                                                                                    when 184509 then N'ECO - ESC - Lift Chairs' 
                                                                                    when 164836 then N'WAG - PMR - Complaint About Store ' 
                                                                                    when 202226 then N'WFV - ACA Call - Referred to Website' 
                                                                                    when 184454 then N'WMS - ESC - Duplicate Account' 
                                                                                    when 202256 then N'WAG - Campaigns- Script Alignment Opt-Out/DNC' 
                                                                                    when 164116 then N'WMS - HD/TL Split Order ' 
                                                                                    when 165066 then N'WAG - REW - CustFeedbackPositive - Program ' 
                                                                                    when 164995 then N'WCD - PSC - Spanish Call ' 
                                                                                    when 164126 then N'WMS - Escalation ' 
                                                                                    when 167922 then N'WAG - BR - Points - Recent Transaction Inquiry' 
                                                                                    when 164726 then N'MPB - Existing Customer New Order ' 
                                                                                    when 165052 then N'WRC - Inappropriate Transfer ' 
                                                                                    when 184495 then N'WAG - ESC - RPh Denied C-II Fill' 
                                                                                    when 202230 then N'WHC - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 184486 then N'WAG - ESC - Mobile App' 
                                                                                    when 164091 then N'MTM - Polypharmacy Review ' 
                                                                                    when 164076 then N'CCC - Expedite Request ' 
                                                                                    when 164900 then N'WCD - PSC - Never Received Permanent Cards ' 
                                                                                    when 184438 then N'YES - ESC - Other' 
                                                                                    when 184521 then N'ECO - ESC - System Error' 
                                                                                    when 164819 then N'WAG - CR Employee Issue - Store ' 
                                                                                    when 164068 then N'WHI - Payment Information ' 
                                                                                    when 164106 then N'WRC - Prior Authorization ' 
                                                                                    when 184511 then N'ECO - ESC - Non - Escalation: CCR Assistance' 
                                                                                    when 164882 then N'WCD - PSC - Add Purchases to Card ' 
                                                                                    when 164632 then N'WFV - Other - WAG Corporate Calls ' 
                                                                                    when 164075 then N'CCC - Drug Not covered ' 
                                                                                    when 165026 then N'WHI - Flu - Service ' 
                                                                                    when 184583 then N'WAG - REW - ESC - Store Assistance' 
                                                                                    when 184475 then N'WAG - ESC - Complaint - CCR' 
                                                                                    when 164936 then N'WCD - Other ' 
                                                                                    when 164948 then N'WAG - REW - Change Contact Preferences ' 
                                                                                    when 164136 then N'WHI - Website Issues ' 
                                                                                    when 164740 then N'MPB - Order Status Supplemental Insurance Issue/Callback ' 
                                                                                    when 165044 then N'WAG - CR WRPR Corporate Escalation ' 
                                                                                    when 164749 then N'CMC - Refill Request ' 
                                                                                    when 164041 then N'WHI - Claim Status ' 
                                                                                    when 164793 then N'WAG - RD Update - Order/Acct ' 
                                                                                    when 164842 then N'CMC - Insurance ' 
                                                                                    when 164639 then N'WHC - Coordination of Benefits ' 
                                                                                    when 184501 then N'ECO - ESC - Complaint - Pharmacy' 
                                                                                    when 164921 then N'WCD - RRC - Lost or Stolen Card ' 
                                                                                    when 184437 then N'YES - ESC - Non-Escalation: Other' 
                                                                                    when 164746 then N'MPB - WSSC Courtesy Callback ' 
                                                                                    when 164687 then N'WHI - Service Appreciation ' 
                                                                                    when 164090 then N'MTM - Intervention General ' 
                                                                                    when 164644 then N'WHC - Escalation ' 
                                                                                    when 184483 then N'WAG - ESC - Gov''t Funded' 
                                                                                    when 164911 then N'WCD - PSC - Store Inquiry-Rx Pricing ' 
                                                                                    when 164777 then N'WMS - Doctor - Rph ' 
                                                                                    when 184450 then N'WMS - ESC - Copay/Price' 
                                                                                    when 167946 then N'WRC - WRC Specialist - Incorrect call/fax routing' 
                                                                                    when 164860 then N'WCD - WGC - Lost or Stolen Card ' 
                                                                                    when 184425 then N'WRC - WRC - HD / PCC Call - New' 
                                                                                    when 167913 then N'WAG - BR- Memerbership/Account - Merge Cards / Accounts' 
                                                                                    when 164764 then N'CMC - Voicemail Prescriber - New Rx ' 
                                                                                    when 164937 then N'CMC - Flu Program ' 
                                                                                    when 164051 then N'WMS - Manual Refill ' 
                                                                                    when 164701 then N'YES - Mail Service ' 
                                                                                    when 164888 then N'WCD - PSC - Coverage Termed Should be Active ' 
                                                                                    when 164912 then N'WCD - PSC - Unable to Add Purchases On-line ' 
                                                                                    when 164084 then N'MTM - Member General (Question or Inquiry) ' 
                                                                                    when 164083 then N'MTM - Patient Question (General) ' 
                                                                                    when 202221 then N'WAG - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164682 then N'WHI - Request Spanish Rep - Transfer ' 
                                                                                    when 167943 then N'WRC - WRC Specialist - Inbound Call - PBM' 
                                                                                    when 164843 then N'CMC - Transfer to Competitor ' 
                                                                                    when 184576 then N'WAG - REW - ESC - Non-Escalation - Other' 
                                                                                    when 165051 then N'WAG - ESIESCPROJECT-ESI Escalation Project ' 
                                                                                    when 184560 then N'WAG - REW - ESC - Complaint - CCR' 
                                                                                    when 164093 then N'MTM - CP 1 Intervention ' 
                                                                                    when 164870 then N'WCD - PRC - Add to Balance ' 
                                                                                    when 184533 then N'WCD - ESC - Employee Discount' 
                                                                                    when 164708 then N'YES - Respiratory/Home Oxygen ' 
                                                                                    when 164830 then N'CMC - Verification ' 
                                                                                    when 164904 then N'WCD - PSC - Qualification for PSC Participation ' 
                                                                                    when 164046 then N'WMS - Accounting ' 
                                                                                    when 184474 then N'WMS - ESC - Website' 
                                                                                    when 202220 then N'WAG - ACA Call - Referred to Website' 
                                                                                    when 165058 then N'ECO - Online Store(OTC) ' 
                                                                                    when 164821 then N'WAG - CR Product Out Of Stock ' 
                                                                                    when 167928 then N'WAG - BR - Points - Point Redemption On-line' 
                                                                                    when 167960 then N'WRC - WRC - HD / Escalated Call' 
                                                                                    when 164876 then N'WCD - CSG - Add to Balance ' 
                                                                                    when 184570 then N'WAG - REW - ESC - IVR' 
                                                                                    when 184439 then N'YES - ESC - Store Assistance' 
                                                                                    when 202209 then N'CMC - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164140 then N'WFV - Prescriber - Approval ' 
                                                                                    when 164111 then N'WRC - Invalid Pharmacy Provider ' 
                                                                                    when 164739 then N'MPB - Order Status CMN Issue/Callback ' 
                                                                                    when 164989 then N'WCD - PRC - Spanish Call ' 
                                                                                    when 165018 then N'WAG - Flu - Service ' 
                                                                                    when 164946 then N'WAG - REW - Cancel Membership ' 
                                                                                    when 184470 then N'WMS - ESC - Return/Refund' 
                                                                                    when 164139 then N'WFV - Prescriber - Refill ' 
                                                                                    when 174293 then N'CMC - Express Rx Request' 
                                                                                    when 165057 then N'ECO - Mobile ' 
                                                                                    when 167929 then N'WAG - BR - Points - Other' 
                                                                                    when 184435 then N'YES - ESC - Non-Escalation: CCR Assistance' 
                                                                                    when 164916 then N'WCD - PSC - Customer Enrolled Multiple Times ' 
                                                                                    when 184529 then N'WCD - ESC - Complaint - Program' 
                                                                                    when 184514 then N'ECO - ESC - Order Not Received' 
                                                                                    when 167925 then N'WAG - BR - Points - Request Missing On-line Points' 
                                                                                    when 167919 then N'WAG - BR - Memerbership/Account - Other' 
                                                                                    when 202254 then N'WAG - Campaigns- Script Alignment Enrollment' 
                                                                                    when 164101 then N'WRC - Refill Too Soon ' 
                                                                                    when 184544 then N'WCD - ESC - Program Exclusions' 
                                                                                    when 164944 then N'WAG - CR H1N1 ' 
                                                                                    when 164112 then N'WRC - Prescriber Not Covered ' 
                                                                                    when 164743 then N'MPB - Refill - Accepted Up-sell Offer ' 
                                                                                    when 184569 then N'WAG - REW - ESC - Gov''t Funded' 
                                                                                    when 164647 then N'WHC - Issue ' 
                                                                                    when 202211 then N'ECO - ACA Call - Referred to Website' 
                                                                                    when 164826 then N'CMC - Education ' 
                                                                                    when 164070 then N'WHI - Specialty Pharmacy ' 
                                                                                    when 184444 then N'WMS - ESC - Brand/Generic' 
                                                                                    when 184432 then N'YES - ESC - Ghost Call' 
                                                                                    when 166111 then N'CMC - PCC - Balance Rewards Inquiry' 
                                                                                    when 164137 then N'WHC - After Hours ' 
                                                                                    when 164658 then N'WHC - Retail Questions ' 
                                                                                    when 164838 then N'WAG - PMR - Other ' 
                                                                                    when 164850 then N'WAG - COR - Corporate Call ' 
                                                                                    when 164961 then N'WAG - REW - Lost or Stolen Certificate ' 
                                                                                    when 164938 then N'WCD - PSC - Rebate Rewards Balance Inquiry ' 
                                                                                    when 184448 then N'WMS - ESC - Complaint - Pharmacy' 
                                                                                    when 164941 then N'YES - Flu / Immunization ' 
                                                                                    when 167924 then N'WAG - BR - Points - Request Missing Store Points' 
                                                                                    when 164897 then N'WCD - PSC - Lost or Stolen Card ' 
                                                                                    when 184562 then N'WAG - REW - ESC - Complaint - Program' 
                                                                                    when 166112 then N'WRC - WRC Specialist - Inbound Call - Patient' 
                                                                                    when 172320 then N'WMS - WH MS User Transition - Insurance Coverage' 
                                                                                    when 164092 then N'MTM - Polypharmacy Counseling Session ' 
                                                                                    when 165048 then N'WAG - Flu - Caller scheduling flu vaccination appointment ' 
                                                                                    when 164874 then N'WCD - PRC - Lost or Stolen Card ' 
                                                                                    when 202241 then N'WSP - ACA Call - Referred to Website' 
                                                                                    when 184459 then N'WMS - ESC - Manufacturer' 
                                                                                    when 167916 then N'WAG - BR- Memerbership/Account - Program Detail Request for AARP' 
                                                                                    when 164877 then N'WCD - CSG - Balance Inquiry ' 
                                                                                    when 164983 then N'WCD - SWC - Spanish Call ' 
                                                                                    when 184472 then N'WMS - ESC - STS' 
                                                                                    when 184532 then N'WCD - ESC - Duplicate Account' 
                                                                                    when 165012 then N'WAG - REW - Ghost Call ' 
                                                                                    when 165000 then N'WCD - WEL - Ghost Call ' 
                                                                                    when 184485 then N'WAG - ESC - Legal' 
                                                                                    when 167920 then N'WAG - BR - Points - Combine Family Points' 
                                                                                    when 164927 then N'WCD - RRC - Rebate Rewards Under 48 Hours ' 
                                                                                    when 164063 then N'WHI - Claim Reversals ' 
                                                                                    when 184446 then N'WMS - ESC - Cancelled in Error' 
                                                                                    when 164087 then N'MTM - Transfer Out Call ' 
                                                                                    when 164689 then N'CCC - Service Appreciation ' 
                                                                                    when 184534 then N'WCD - ESC - General Inquiry' 
                                                                                    when 164642 then N'WHC - Duplicate Order ' 
                                                                                    when 164042 then N'WHI - Copay/Benefit Information ' 
                                                                                    when 164727 then N'MPB - Existing Customer Refill ' 
                                                                                    when 184452 then N'WMS - ESC - DNC Request' 
                                                                                    when 167930 then N'WAG - BR - Activation - Own Account' 
                                                                                    when 164792 then N'WAG - RD Transfer to C&M ' 
                                                                                    when 164745 then N'MPB - PHX Invoice Issue/Callback ' 
                                                                                    when 164645 then N'WHC - Facility Info Inquiry ' 
                                                                                    when 165039 then N'WMS - HD/TL Change Shipper ' 
                                                                                    when 165020 then N'WAG - Flu - Insurance Coverage (MPB) ' 
                                                                                    when 164061 then N'WMS - Issue ' 
                                                                                    when 167959 then N'WRC - WRC - HD / Other' 
                                                                                    when 184535 then N'WCD - ESC - Ghost Call' 
                                                                                    when 184519 then N'ECO - ESC - Return/Refund' 
                                                                                    when 165063 then N'ECO - Ghost Call ' 
                                                                                    when 164654 then N'WHC - Patient Question (General) ' 
                                                                                    when 164845 then N'CMC - No Answer / Dropped Call ' 
                                                                                    when 184531 then N'WCD - ESC - DNC Request' 
                                                                                    when 164981 then N'WCD - WGC - Store Information ' 
                                                                                    when 184554 then N'WAG - DailyMed Other' 
                                                                                    when 184556 then N'WAG - DailyMed Refill' 
                                                                                    when 164759 then N'CMC - Pbr - Other ' 
                                                                                    when 164939 then N'WHI - Flu / Immunization ' 
                                                                                    when 165050 then N'WAG - REW - Positive Feedback ' 
                                                                                    when 164902 then N'WCD - PSC - Plan Change / Individual to Family ' 
                                                                                    when 164895 then N'WCD - PSC - Formulary List ' 
                                                                                    when 165053 then N'ECO - AARP ' 
                                                                                    when 184528 then N'WCD - ESC - Complaint - Pharmacy' 
                                                                                    when 184546 then N'WCD - ESC - Rebate Rewards' 
                                                                                    when 165031 then N'WHI - HD/TL Claim Reversal ' 
                                                                                    when 210879 then N'WRC - WRC - FCR' 
                                                                                    when 202214 then N'MPB - ACA Call - Referred to Website' 
                                                                                    when 164127 then N'WMS - Facility Info Inquiry ' 
                                                                                    when 164697 then N'YES - Infusion ' 
                                                                                    when 184513 then N'ECO - ESC - Non - Escalation: Other' 
                                                                                    when 164657 then N'WHC - Reorder ' 
                                                                                    when 164049 then N'WMS - Duplicate Order ' 
                                                                                    when 190839 then N'WAG - DailyMed Program Inquiry' 
                                                                                    when 164940 then N'WHI - H1N1 ' 
                                                                                    when 164103 then N'WRC - Non Matched Plan Information ' 
                                                                                    when 184545 then N'WCD - ESC - Promotion Related' 
                                                                                    when 165029 then N'WHI - Flu - Immunization (Flu Mist/Pneumonia) ' 
                                                                                    when 164773 then N'CCC - Tobacco Free/Diabetes Program ' 
                                                                                    when 165027 then N'WHI - Flu - Advertising ' 
                                                                                    when 164733 then N'MPB - WAG MPB Price Information ' 
                                                                                    when 184527 then N'WCD - ESC - Complaint - CCR' 
                                                                                    when 164769 then N'CCC - Delete CPA ' 
                                                                                    when 202218 then N'MTM - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164690 then N'CCC - Forward to Review Board ' 
                                                                                    when 164866 then N'WCD - VGC - Balance Inquiry ' 
                                                                                    when 164125 then N'WMS - Complaint - Service ' 
                                                                                    when 164651 then N'WHC - No Go Labor ' 
                                                                                    when 184578 then N'WAG - REW - ESC - Points Adjustment' 
                                                                                    when 164835 then N'WAG - PMR - Complaint About Pharmacy ' 
                                                                                    when 164728 then N'MPB - Not CMS Eligible ' 
                                                                                    when 164643 then N'WHC - Eligibility ' 
                                                                                    when 164925 then N'WCD - RRC - Verify Rebate Rewards Balance Available ' 
                                                                                    when 184563 then N'WAG - REW - ESC - Complaint - Store' 
                                                                                    when 167912 then N'WAG - BR - Memerbership/Account - Link to AARP Membership' 
                                                                                    when 184547 then N'WCD - ESC - Return/Refund' 
                                                                                    when 184480 then N'WAG - ESC - General Inquiry' 
                                                                                    when 164683 then N'WHI - Systems Down ' 
                                                                                    when 184568 then N'WAG - REW - ESC - Ghost Call' 
                                                                                    when 164133 then N'WHI - Ghost Call ' 
                                                                                    when 164085 then N'MTM - Pharmacy Call General (Question) ' 
                                                                                    when 184478 then N'WAG - ESC - District Manager Needed' 
                                                                                    when 202253 then N'WAG - Campaigns-Script Alignment Inquiry' 
                                                                                    when 202224 then N'WCD - ACA Call - Transferred/Referred to partner Insurance Advisor' 
                                                                                    when 164968 then N'WAG - REW - Problems using On-Line Redemption ' 
                                                                                    when 184492 then N'WAG - ESC - Program Exclusions' 
                                                                                    when 164121 then N'WMS - HD/TL Exception Updates ' 
                                                                                    when 172348 then N'WMS - WH MS User Transition - Escalated Items' 
                                                                                    when 164104 then N'WRC - Invalid Coverage ' 
                                                                                    when 165068 then N'WAG - REW - Points Forfeit Concern ' 
                                                                                    when 164756 then N'CMC - Pat - Other ' 
                                                                                    when 202215 then N'MPB - ACA Call - Transferred/Referred to Go Health' 
                                                                                    when 164886 then N'WCD - PSC - Cancel Membership Request ' 
                                                                                    when 184467 then N'WMS - ESC - Other' 
                                                                                    when 164747 then N'MPB - Other ' 
                                                                                    when 164138 then N'WFV - Prescriber - New Rx ' 
                                                                                    when 165019 then N'WAG - Flu - Advertising ' 
                                                                                    when 164060 then N'WHI - Issue ' 
                                                                                    when 164892 then N'WCD - PSC - Enrollment Questions ' 
                                                                                    when 164949 then N'WAG - REW - Change Member Information ' 
                                                                                    when 164992 then N'WCD - CSG - Spanish Call ' 
                                                                                    when 184512 then N'ECO - ESC - Non-Escalation: Compliment' 
                                                                                    when 165007 then N'WAG - REW - Returned Award ' 
                                                                                    when 164633 then N'WFV - Other - Field Validation Team Calls ' 
                                                                                    when 164067 then N'WHI - Eligibility ' 
                                                                                    when 164772 then N'CCC - Pharmacy Research ' 
                                                                                    when 165024 then N'WHI - Flu - Hours / Location ' 
                                                                                    when 164131 then N'WHI - Complaint ' 
                                                                                    when 164124 then N'WMS - Buyout Transfer ' 
                                                                                    when 164945 then N'WAG - REW - Add Purchases to Card ' 
                                                                                    when 165055 then N'ECO - Contact Lens ' 
                                                                                    when 164753 then N'CMC - Pat - Front-of-Store ' 
                                                                                    when 184490 then N'WAG - ESC - Non-Escalation: Other' 
                                                                                    when 202248 then N'HCC - Provider Calls' 
                                                                                    when 164628 then N'WFV - Patient - Non-WAG Customer ' 
                                                                                    when 164943 then N'WAG - CR Flu / Immunization ' 
                                                                                    when 164959 then N'WAG - REW - Issues with Rewards being Applied Correctly ' 
                                                                                    when 164822 then N'WAG - CR Pricing Concern ' 
                                                                                    when 184505 then N'ECO - ESC - Duplicate Account' 
                                                                                    when 164867 then N'WCD - VGC - General Information ' 
                                                                                    when 184458 then N'WMS - ESC - IVR' 
                                                                                    when 184550 then N'WCD - ESC - Website' 
                                                                                    when 165025 then N'WHI - Flu - Gift Card ' 
                                                                                    when 164883 then N'WCD - PSC - POS Incomplete Transaction ' 
                                                                                    when 184426 then N'WAG - REW - Earn/Redeem Inquiry' 
                                                                                    when 202257 then N'WAG - Campaigns- Script Alignment Global Opt-Out' 
                                                                                    when 165016 then N'WAG - Flu - Hours / Location ' 
                                                                                    when 184573 then N'WAG - REW - ESC - Mobile App' 
                                                                                    when 164987 then N'WCD - VGC - Store Information ' 
                                                                                    when 164896 then N'WCD - PSC - General Inquiry ' 
                                                                                    when 164993 then N'WCD - CSG - Store Information ' 
                                                                                    when 164128 then N'WMS - Ghost Call ' 
                                                                                    when 184460 then N'WMS - ESC - Member Info Incorrect' 
                                                                                    when 172344 then N'WMS - WH MS User Transition - Family Prescription Management' 
                                                                                    when 164069 then N'WHI - Plan Prior Authorization ' 
                                                                                    when 164123 then N'WMS - Brand/Generic ' 
                                                                                    when 164135 then N'WHI - Website - Password Reset ' 
                                                                                    when 164625 then N'WFV - Patient - Insurance ' 
                                                                                    when 202231 then N'WHC - ACA Call - Customer declined transfer/referral to partner Insurance ' 
                                                                                    when 165037 then N'WHI - HD/TL Escalation ' 
                                                                                    when 164132 then N'WHI - Escalation ' 
                                                                                    when 184482 then N'WAG - ESC - Gift Cards' 
                                                                                    when 167954 then N'WRC - WRC - HD / Inappropriate Transfer' 
                                                                                    when 184430 then N'YES - ESC - DNC - Request' 
                                                                                    when 164956 then N'WAG - REW - General Inquiry ' 
                                                                                    when 164073 then N'CCC - CPA Status ' 
                                                                                    when 184548 then N'WCD - ESC - Store Assistance' 
                                                                                    when 165064 then N'ECO - Spanish ' 
                                                                                    when 169803 then N'WAG - REW - Two-Tier Pricing Concern' 
                                                                                    when 164081 then N'MTM - Patient Opt Out (Ovations Only) ' 
                                                                                end) as expr_83 ,
                                                                                (case expr_87 
                                                                                    when 177288 then N'Pharmacist Only' 
                                                                                    when 161925 then N'Agent Only' 
                                                                                    when 161924 then N'Agent to Resolution Center' 
                                                                                    when 161921 then N'Agent to Store' 
                                                                                    when 161922 then N'Agent to Pharmacist' 
                                                                                end) as expr_87 ,
                                                                                expr_85 as expr_85 ,
                                                                                (case expr_110 
                                                                                    when 209569 then N'4' 
                                                                                    when 209572 then N'1' 
                                                                                    when 209570 then N'3' 
                                                                                    when 209571 then N'2' 
                                                                                    when 209566 then N'7' 
                                                                                    when 209568 then N'5' 
                                                                                    when 209565 then N'8' 
                                                                                    when 209567 then N'6' 
                                                                                    when 209573 then N'0' 
                                                                                    when 209564 then N'9' 
                                                                                end) as expr_110 ,
                                                                                (case expr_33 
                                                                                    when 166024 then N'5' 
                                                                                    when 166027 then N'2' 
                                                                                    when 166022 then N'7' 
                                                                                    when 166021 then N'8' 
                                                                                    when 166020 then N'9' 
                                                                                    when 166023 then N'6' 
                                                                                    when 166028 then N'1' 
                                                                                    when 166026 then N'3' 
                                                                                    when 166025 then N'4' 
                                                                                end) as expr_33 ,
                                                                                cat8385.locationCategoryObjectId as entityId_5 ,
                                                                                expr_73 as expr_73 ,
                                                                                (case expr_29 
                                                                                    when 161343 then N'8' 
                                                                                    when 161342 then N'9' 
                                                                                    when 161344 then N'7' 
                                                                                    when 161345 then N'6' 
                                                                                    when 161350 then N'1' 
                                                                                    when 161347 then N'4' 
                                                                                    when 161348 then N'3' 
                                                                                    when 161349 then N'2' 
                                                                                    when 161346 then N'5' 
                                                                                end) as expr_29 ,
                                                                                cat8380.locationCategoryObjectId as entityId_13 ,
                                                                                (case expr_34 
                                                                                    when 161413 then N'5' 
                                                                                    when 161412 then N'6' 
                                                                                    when 161411 then N'7' 
                                                                                    when 161414 then N'4' 
                                                                                    when 161416 then N'2' 
                                                                                    when 161409 then N'9' 
                                                                                    when 161417 then N'1' 
                                                                                    when 161410 then N'8' 
                                                                                    when 161415 then N'3' 
                                                                                end) as expr_34 ,
                                                                                cat8381.locationCategoryObjectId as entityId_15 ,
                                                                                expr_91 as expr_91 ,
                                                                                (case expr_39 
                                                                                    when 161807 then N'3' 
                                                                                    when 161805 then N'5' 
                                                                                    when 161803 then N'7' 
                                                                                    when 161806 then N'4' 
                                                                                    when 161801 then N'9' 
                                                                                    when 161802 then N'8' 
                                                                                    when 161804 then N'6' 
                                                                                    when 161809 then N'1' 
                                                                                    when 161808 then N'2' 
                                                                                end) as expr_39 ,
                                                                                (case expr_50 
                                                                                    when 165355 then N'Call Center Specialist' 
                                                                                    when 165360 then N'Pharmacy' 
                                                                                    when 165357 then N'Store Photo Kiosk' 
                                                                                    when 165361 then N'Don''t Remember' 
                                                                                    when 165359 then N'Mobile Phone / App' 
                                                                                    when 165356 then N'Store Check-Out' 
                                                                                    when 165413 then N'QR Code' 
                                                                                    when 165358 then N'Walgreens.com' 
                                                                                end) as expr_50 ,
                                                                                expr_81 as expr_81 ,
                                                                                (case expr_46 
                                                                                    when 161524 then N'3' 
                                                                                    when 161519 then N'8' 
                                                                                    when 161525 then N'2' 
                                                                                    when 161518 then N'9' 
                                                                                    when 161523 then N'4' 
                                                                                    when 161520 then N'7' 
                                                                                    when 161526 then N'1' 
                                                                                    when 161521 then N'6' 
                                                                                    when 161522 then N'5' 
                                                                                end) as expr_46 ,
                                                                                (case expr_38 
                                                                                    when 161934 then N'Agent on Phone' 
                                                                                    when 161931 then N'Store' 
                                                                                    when 161932 then N'Website' 
                                                                                    when 161933 then N'Automated Phone' 
                                                                                    when 161935 then N'Another Method' 
                                                                                end) as expr_38 ,
                                                                                (case expr_42 
                                                                                    when 165407 then N'8' 
                                                                                    when 165406 then N'7' 
                                                                                    when 165405 then N'6' 
                                                                                    when 165401 then N'2' 
                                                                                    when 165403 then N'4' 
                                                                                    when 165402 then N'3' 
                                                                                    when 165408 then N'9 - Extremely Satisfied' 
                                                                                    when 165404 then N'5' 
                                                                                    when 165400 then N'1 - Not At All Satisfied' 
                                                                                end) as expr_42 ,
                                                                                (case expr_30 
                                                                                    when 161420 then N'7' 
                                                                                    when 161419 then N'8' 
                                                                                    when 161422 then N'5' 
                                                                                    when 161425 then N'2' 
                                                                                    when 161424 then N'3' 
                                                                                    when 161423 then N'4' 
                                                                                    when 161418 then N'9' 
                                                                                    when 161426 then N'1' 
                                                                                    when 161421 then N'6' 
                                                                                end) as expr_30 ,
                                                                                (case expr_54 
                                                                                    when 161745 then N'2-4 Times per Month' 
                                                                                    when 161742 then N'Your First Time' 
                                                                                    when 161746 then N'More than 4 times per month' 
                                                                                    when 161744 then N'1 Time per Month' 
                                                                                end) as expr_54 ,
                                                                                (case expr_108 
                                                                                    when 208740 then N'1' 
                                                                                    when 208744 then N'5' 
                                                                                    when 208748 then N'9' 
                                                                                    when 208741 then N'2' 
                                                                                    when 208742 then N'3' 
                                                                                    when 208746 then N'7' 
                                                                                    when 208743 then N'4' 
                                                                                    when 208747 then N'8' 
                                                                                    when 208745 then N'6' 
                                                                                end) as expr_108 ,
                                                                                cat8381.locationCategoryName as expr_14 ,
                                                                                (case expr_45 
                                                                                    when 161842 then N'4' 
                                                                                    when 161845 then N'1' 
                                                                                    when 161839 then N'7' 
                                                                                    when 161838 then N'8' 
                                                                                    when 161840 then N'6' 
                                                                                    when 161843 then N'3' 
                                                                                    when 161837 then N'9' 
                                                                                    when 161841 then N'5' 
                                                                                    when 161844 then N'2' 
                                                                                end) as expr_45 ,
                                                                                (case expr_75 
                                                                                    when 163567 then N'Rph' 
                                                                                    when 163568 then N'Specialist' 
                                                                                    when 176198 then N'Team Lead' 
                                                                                end) as expr_75 ,
                                                                                (case expr_31 
                                                                                    when 161427 then N'9' 
                                                                                    when 161434 then N'2' 
                                                                                    when 161435 then N'1' 
                                                                                    when 161428 then N'8' 
                                                                                    when 161433 then N'3' 
                                                                                    when 161430 then N'6' 
                                                                                    when 161431 then N'5' 
                                                                                    when 161429 then N'7' 
                                                                                    when 161432 then N'4' 
                                                                                end) as expr_31 ,
                                                                                (case expr_36 
                                                                                    when 161862 then N'Only contacted one time' 
                                                                                    when 161861 then N'Contacted more than once' 
                                                                                end) as expr_36 ,
                                                                                SurveyResponse.ani as expr_66 
                                                                            from
                                                                                SurveyResponse 
                                                                            inner join
                                                                                Location 
                                                                                    on Location.objectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8383 cat8383 
                                                                                    on cat8383.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8384 cat8384 
                                                                                    on cat8384.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8385 cat8385 
                                                                                    on cat8385.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8386 cat8386 
                                                                                    on cat8386.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8379 cat8379 
                                                                                    on cat8379.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8380 cat8380 
                                                                                    on cat8380.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8381 cat8381 
                                                                                    on cat8381.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                (
                                                                                    select
                                                                                        surveyResponseObjectId ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65078 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_19 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65080 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_20 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65213 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_21 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65082 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_22 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65083 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_23 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65084 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_24 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65085 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_25 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65086 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_26 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66526 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_27 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65087 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_28 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65081 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_29 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65089 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_30 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65090 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_31 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65091 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_32 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 67015 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_33 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65088 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_34 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65093 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_35 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65214 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_36 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65185 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_37 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65279 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_38 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65221 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_39 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66684 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_40 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66685 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_41 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66686 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_42 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66687 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_43 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65125 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_44 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65225 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_45 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65120 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_46 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65226 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_47 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65200 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_48 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66681 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_49 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66678 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_50 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65215 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_51 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 68446 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_52 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65217 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_53 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65202 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_54 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65191 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_55 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65194 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_56 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65197 then sra.textValue 
                                                                                        end) expr_57 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65231 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_58 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65203 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_59 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65204 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_60 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65205 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_61 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65206 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_62 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65207 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_63 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65256 then sra.textValue 
                                                                                        end) expr_64 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65227 then sra.textValue 
                                                                                        end) expr_65 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65218 then sra.textValue 
                                                                                        end) expr_67 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65219 then sra.textValue 
                                                                                        end) expr_68 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65220 then sra.textValue 
                                                                                        end) expr_69 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65234 then sra.textValue 
                                                                                        end) expr_70 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65235 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_71 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65249 then sra.textValue 
                                                                                        end) expr_73 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65910 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_74 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65911 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_75 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65912 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_76 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65913 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_77 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65251 then sra.textValue 
                                                                                        end) expr_78 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65252 then sra.textValue 
                                                                                        end) expr_79 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65253 then sra.numericValue 
                                                                                        end) expr_80 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65262 then sra.numericValue 
                                                                                        end) expr_81 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65268 then sra.numericValue 
                                                                                        end) expr_82 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66186 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_83 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66225 then sra.textValue 
                                                                                        end) expr_84 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65270 then sra.textValue 
                                                                                        end) expr_85 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65271 then sra.textValue 
                                                                                        end) expr_86 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 65272 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_87 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 66700 then sra.textValue 
                                                                                        end) expr_91 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103509 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_94 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103356 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_95 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103526 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_96 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103357 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_97 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103358 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_98 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103359 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_99 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103360 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_100 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103361 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_101 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103362 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_102 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103363 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_104 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103364 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_105 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103365 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_106 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103366 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_107 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103367 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_108 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103368 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_109 ,
                                                                                        max(case dataFieldObjectId 
                                                                                            when 103676 then sra.dataFieldOptionObjectId 
                                                                                        end) expr_110 
                                                                                    from
                                                                                        SurveyResponseAnswer sra 
                                                                                    group by
                                                                                        surveyResponseObjectId 
                                                                                ) as AnswerPivot 
                                                                                    on AnswerPivot.surveyResponseObjectId = SurveyResponse.objectId 
                                                                            inner join
                                                                                SurveyGateway 
                                                                                    on SurveyGateway.objectId=SurveyResponse.surveyGatewayObjectId 
                                                                            left outer join
                                                                                #cat29538 cat29538 
                                                                                    on cat29538.locationObjectId=SurveyResponse.locationObjectId 
                                                                            left outer join
                                                                                #cat8382 cat8382 
                                                                                    on cat8382.locationObjectId=SurveyResponse.locationObjectId 
                                                                            where
                                                                                Location.hidden = 0 
                                                                                and SurveyResponse.complete = 1 
                                                                                and Location.organizationObjectId = 1030 
                                                                                and (
                                                                                    --SurveyResponse.beginDate between '2014-01-28' and '2014-01-28'
                                                                                    SurveyResponse.beginDate between @begindt and @enddt 
                                                                                ) 
                                                                                and (
                                                                                    cat8382.locationCategoryObjectId in (
                                                                                        132989
                                                                                    ) 
                                                                                ) 
                                                                                and SurveyResponse.exclusionReason = 0 
                                                                                
                        )as a 

                
                        select * from _WG_CallCenterDataOKfiles --where deptRated=-1
                                                                            order by
                                                                                SurveyResponseobjectId ; ; if OBJECT_ID(N'tempdb..#cat8383',
                                                                                N'U') IS NOT NULL drop table #cat8383; ; if OBJECT_ID(N'tempdb..#cat8384',
                                                                                N'U') IS NOT NULL drop table #cat8384; ; if OBJECT_ID(N'tempdb..#cat8385',
                                                                                N'U') IS NOT NULL drop table #cat8385; ; if OBJECT_ID(N'tempdb..#cat8386',
                                                                                N'U') IS NOT NULL drop table #cat8386; ; if OBJECT_ID(N'tempdb..#cat8379',
                                                                                N'U') IS NOT NULL drop table #cat8379; ; if OBJECT_ID(N'tempdb..#cat8380',
                                                                                N'U') IS NOT NULL drop table #cat8380; ; if OBJECT_ID(N'tempdb..#cat8381',
                                                                                N'U') IS NOT NULL drop table #cat8381; ; if OBJECT_ID(N'tempdb..#cat29538',
                                                                                N'U') IS NOT NULL drop table #cat29538; ; if OBJECT_ID(N'tempdb..#cat8382',
                                                                                N'U') IS NOT NULL drop table #cat8382;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
