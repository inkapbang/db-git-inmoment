SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create procedure [dbo].[usp_cust_WalgreensRawDataOKfiles_bob]
as

--exec dbo.usp_cust_WalgreensRawDataOKfiles_bob

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_wg_RawDataOKfiles]') AND type in (N'U'))
DROP TABLE [dbo].[_wg_RawDataOKfiles];


/* generated 
by
    mssql reportEngine: report = Raw Data Detail [48785],
    org = Walgreens[1030] 
    Eastern
    */ 
    declare @enddt date,@begindt date

--set @enddt=(select DATEADD(dd, DATEDIFF(dd,0,getdate()), 0))
--set @begindt=dateadd(dd,-1,getdate())
--set @enddt=dateadd(dd,-1,getdate())
SET @begindt='10/18/2014 00:00:00'
SET @enddt='10/18/2014 00:00:00'

   select @begindt,@enddt


    if OBJECT_ID(N'tempdb..#cat7933',N'U') IS NOT NULL drop table #cat7933; 
    create table #cat7933 (locationObjectId int not null,
    locationCategoryObjectId int not null,
    locationCategoryName varchar(100) not null,
    primary key(locationObjectId,
    locationCategoryObjectId)); 
    insert 
    into
        #cat7933
        select
            locationObjectId,
            locationCategoryObjectId,
            locationCategoryName 
        from
            dbo.ufn_app_LocationsInCategoryOfType(7933) ; if OBJECT_ID(N'tempdb..#cat7930',
            N'U') IS NOT NULL drop table #cat7930; create table #cat7930 (locationObjectId int not null,
            locationCategoryObjectId int not null,
            locationCategoryName varchar(100) not null,
            primary key(locationObjectId,
            locationCategoryObjectId)); insert 
            into
                #cat7930
                select
                    locationObjectId,
                    locationCategoryObjectId,
                    locationCategoryName 
                from
                    dbo.ufn_app_LocationsInCategoryOfType(7930) ; if OBJECT_ID(N'tempdb..#cat7931',
                    N'U') IS NOT NULL drop table #cat7931; create table #cat7931 (locationObjectId int not null,
                    locationCategoryObjectId int not null,
                    locationCategoryName varchar(100) not null,
                    primary key(locationObjectId,
                    locationCategoryObjectId)); insert 
                    into
                        #cat7931
                        select
                            locationObjectId,
                            locationCategoryObjectId,
                            locationCategoryName 
                        from
                            dbo.ufn_app_LocationsInCategoryOfType(7931) ; if OBJECT_ID(N'tempdb..#cat7932',
                            N'U') IS NOT NULL drop table #cat7932; create table #cat7932 (locationObjectId int not null,
                            locationCategoryObjectId int not null,
                            locationCategoryName varchar(100) not null,
                            primary key(locationObjectId,
                            locationCategoryObjectId)); insert 
                            into
                                #cat7932
                                select
                                    locationObjectId,
                                    locationCategoryObjectId,
                                    locationCategoryName 
                                from
                                    dbo.ufn_app_LocationsInCategoryOfType(7932) ; if OBJECT_ID(N'tempdb..#cat8970',
                                    N'U') IS NOT NULL drop table #cat8970; create table #cat8970 (locationObjectId int not null,
                                    locationCategoryObjectId int not null,
                                    locationCategoryName varchar(100) not null,
                                    primary key(locationObjectId,
                                    locationCategoryObjectId)); insert 
                                    into
                                        #cat8970
                                        select
                                            locationObjectId,
                                            locationCategoryObjectId,
                                            locationCategoryName 
                                        from
                                            dbo.ufn_app_LocationsInCategoryOfType(8970) ; 
     
  select *
	into _WG_RawDataOKfiles
          from(  
            select 	                                  
   
                                                distinct SurveyResponse.objectId as surveyResponseObjectId ,
                                                (case expr_131 
                                                    when 181918 then N'Yes' 
                                                    when 181919 then N'No' 
                                                end) as expr_131 ,
                                                (case expr_70 
                                                    when 161014 then N'Both flu shot and another immunization' 
                                                    when 161016 then N'Just immunization' 
                                                    when 161015 then N'Just flu shot' 
                                                end) as expr_70 ,
                                                expr_90 as expr_90 ,
                                                cat7930.locationCategoryName as expr_2 ,
                                                expr_101 as expr_101 ,
                                                expr_157 as expr_157 ,
                                                (case expr_134 
                                                    when 188388 then N'No' 
                                                    when 188387 then N'Yes' 
                                                end) as expr_134 ,
                                                SurveyResponse.loyaltyNumber as expr_22 ,
                                                (case expr_67 
                                                    when 175864 then N'1' 
                                                    when 175871 then N'8' 
                                                    when 175868 then N'5' 
                                                    when 175867 then N'4' 
                                                    when 175872 then N'9' 
                                                    when 176877 then N'N/A' 
                                                    when 175866 then N'3' 
                                                    when 175869 then N'6' 
                                                    when 175870 then N'7' 
                                                    when 175865 then N'2' 
                                                end) as expr_67 ,
                                                expr_172 as expr_172 ,
                                                expr_128 as expr_128 ,
                                                expr_109 as expr_109 ,
                                                expr_107 as expr_107 ,
                                                (case expr_43 
                                                    when 175759 then N'Yes' 
                                                    when 175760 then N'No' 
                                                end) as expr_43 ,
                                                (case expr_29 
                                                    when 175678 then N'7' 
                                                    when 175674 then N'3' 
                                                    when 175677 then N'6' 
                                                    when 175675 then N'4' 
                                                    when 175679 then N'8' 
                                                    when 175673 then N'2' 
                                                    when 175676 then N'5' 
                                                    when 175672 then N'1' 
                                                    when 175680 then N'9' 
                                                end) as expr_29 ,
                                                (case expr_83 
                                                    when 153177 then N'I am not comfortable answering this question' 
                                                    when 153176 then N'Female' 
                                                    when 153175 then N'Male' 
                                                end) as expr_83 ,
                                                expr_164 as expr_164 ,
                                                (case expr_143 
                                                    when 151065 then N'6' 
                                                    when 151063 then N'4' 
                                                    when 151061 then N'2' 
                                                    when 151060 then N'1' 
                                                    when 151064 then N'5' 
                                                    when 151066 then N'7' 
                                                    when 151068 then N'9' 
                                                    when 151062 then N'3' 
                                                    when 151067 then N'8' 
                                                end) as expr_143 ,
                                                expr_106 as expr_106 ,
                                                expr_116 as expr_116 ,
                                                (case expr_87 
                                                    when 160406 then N'No' 
                                                    when 160405 then N'Yes' 
                                                end) as expr_87 ,
                                                (case expr_69 
                                                    when 175882 then N'1' 
                                                    when 175889 then N'8' 
                                                    when 175886 then N'5' 
                                                    when 175885 then N'4' 
                                                    when 175890 then N'9' 
                                                    when 175887 then N'6' 
                                                    when 175888 then N'7' 
                                                    when 175884 then N'3' 
                                                    when 175883 then N'2' 
                                                end) as expr_69 ,
                                                cat8970.locationCategoryName as expr_8 ,
                                                (case expr_80 
                                                    when 161019 then N'Item hard to reach' 
                                                    when 219449 then N'Price tag was unclear' 
                                                    when 161018 then N'Specific brand, size or variety not available' 
                                                    when 175901 then N'Insufficient quantity' 
                                                    when 161022 then N'Another reason' 
                                                    when 161021 then N'Forgot to purchase' 
                                                    when 161017 then N'Couldn''t locate product' 
                                                    when 161020 then N'Price too high' 
                                                end) as expr_80 ,
                                                Location.name as expr_10 ,
                                                (case expr_27 
                                                    when 175669 then N'8' 
                                                    when 175665 then N'4' 
                                                    when 175664 then N'3' 
                                                    when 175666 then N'5' 
                                                    when 175662 then N'1' 
                                                    when 175670 then N'9' 
                                                    when 175668 then N'7' 
                                                    when 175667 then N'6' 
                                                    when 175663 then N'2' 
                                                end) as expr_27 ,
                                                (case expr_146 
                                                    when 189179 then N'N/A' 
                                                    when 188490 then N'Yes' 
                                                    when 188491 then N'No' 
                                                end) as expr_146 ,
                                                expr_173 as expr_173 ,
                                                (case expr_31 
                                                    when 160153 then N'4' 
                                                    when 160151 then N'2' 
                                                    when 160155 then N'6' 
                                                    when 160150 then N'1' 
                                                    when 160158 then N'9' 
                                                    when 160152 then N'3' 
                                                    when 160154 then N'5' 
                                                    when 160156 then N'7' 
                                                    when 160157 then N'8' 
                                                end) as expr_31 ,
                                                expr_123 as expr_123 ,
                                                (case expr_59 
                                                    when 175825 then N'7' 
                                                    when 175819 then N'1' 
                                                    when 175827 then N'9' 
                                                    when 175826 then N'8' 
                                                    when 175822 then N'4' 
                                                    when 175821 then N'3' 
                                                    when 175824 then N'6' 
                                                    when 175820 then N'2' 
                                                    when 175823 then N'5' 
                                                end) as expr_59 ,
                                                (case expr_38 
                                                    when 175713 then N'9' 
                                                    when 175712 then N'8' 
                                                    when 175710 then N'6' 
                                                    when 175708 then N'4' 
                                                    when 175705 then N'1' 
                                                    when 175711 then N'7' 
                                                    when 175707 then N'3' 
                                                    when 175706 then N'2' 
                                                    when 175709 then N'5' 
                                                end) as expr_38 ,
                                                expr_102 as expr_102 ,
                                                (case expr_55 
                                                    when 175805 then N'7' 
                                                    when 175807 then N'9' 
                                                    when 175803 then N'5' 
                                                    when 175806 then N'8' 
                                                    when 175802 then N'4' 
                                                    when 175800 then N'2' 
                                                    when 175799 then N'1' 
                                                    when 175804 then N'6' 
                                                    when 175801 then N'3' 
                                                end) as expr_55 ,
                                                (case expr_77 
                                                    when 159053 then N'8' 
                                                    when 159049 then N'4' 
                                                    when 159048 then N'3' 
                                                    when 159047 then N'2' 
                                                    when 159051 then N'6' 
                                                    when 159054 then N'9' 
                                                    when 159050 then N'5' 
                                                    when 159046 then N'1' 
                                                    when 159052 then N'7' 
                                                end) as expr_77 ,
                                                expr_118 as expr_118 ,
                                                (case expr_56 
                                                    when 175813 then N'6' 
                                                    when 175810 then N'3' 
                                                    when 175814 then N'7' 
                                                    when 175808 then N'1' 
                                                    when 175812 then N'5' 
                                                    when 175809 then N'2' 
                                                    when 175811 then N'4' 
                                                    when 175816 then N'9' 
                                                    when 175815 then N'8' 
                                                end) as expr_56 ,
                                                (case expr_93 
                                                    when 160367 then N'2' 
                                                    when 160371 then N'6' 
                                                    when 160370 then N'5' 
                                                    when 160374 then N'9' 
                                                    when 160372 then N'7' 
                                                    when 160368 then N'3' 
                                                    when 160366 then N'1' 
                                                    when 160373 then N'8' 
                                                    when 160369 then N'4' 
                                                end) as expr_93 ,
                                                (case expr_133 
                                                    when 184056 then N'Not compatible with the fitness device or mobile app I use to track healthy activities' 
                                                    when 184058 then N'Does not offer enough Balance Rewards points' 
                                                    when 184063 then N'I often forget to track health or fitness activities' 
                                                    when 184057 then N'Fitness devices are too expensive' 
                                                    when 184060 then N'I am not interested in tracking my healthy activities' 
                                                    when 184061 then N'I like to keep my healthy activities private' 
                                                    when 184062 then N'I do not see Walgreens as the right partner for tracking my personal health' 
                                                    when 184059 then N'Unclear about how the program works' 
                                                    when 184064 then N'Another Reason' 
                                                end) as expr_133 ,
                                                expr_112 as expr_112 ,
                                                (case expr_147 
                                                    when 175740 then N'9' 
                                                    when 175735 then N'4' 
                                                    when 175739 then N'8' 
                                                    when 175733 then N'2' 
                                                    when 175737 then N'6' 
                                                    when 175736 then N'5' 
                                                    when 175734 then N'3' 
                                                    when 175738 then N'7' 
                                                    when 175732 then N'1' 
                                                end) as expr_147 ,
                                                (case expr_41 
                                                    when 175752 then N'3' 
                                                    when 175756 then N'7' 
                                                    when 175757 then N'8' 
                                                    when 175751 then N'2' 
                                                    when 175755 then N'6' 
                                                    when 175753 then N'4' 
                                                    when 175754 then N'5' 
                                                    when 175750 then N'1' 
                                                    when 175758 then N'9' 
                                                end) as expr_41 ,
                                                (case expr_176 
                                                    when 209333 then N'Other' 
                                                    when 209329 then N'Quality of the item looked poor' 
                                                    when 209332 then N'Confusion over the offer (aimed at any confusion over an offer in the store)' 
                                                    when 209330 then N'I didn’t like the selection of products available' 
                                                    when 209327 then N'Store was disorganized and cluttered' 
                                                    when 209331 then N'Long lines at checkout' 
                                                    when 209326 then N'Product was not available' 
                                                    when 209328 then N' couldn’t find an employee to help me find the item I was looking for' 
                                                end) as expr_176 ,
                                                expr_125 as expr_125 ,
                                                expr_108 as expr_108 ,
                                                (case expr_42 
                                                    when 175731 then N'9' 
                                                    when 175723 then N'1' 
                                                    when 175727 then N'5' 
                                                    when 175725 then N'3' 
                                                    when 175729 then N'7' 
                                                    when 176273 then N'N/A' 
                                                    when 175730 then N'8' 
                                                    when 175728 then N'6' 
                                                    when 175724 then N'2' 
                                                    when 175726 then N'4' 
                                                end) as expr_42 ,
                                                (case expr_72 
                                                    when 154702 then N'3' 
                                                    when 154705 then N'6' 
                                                    when 154708 then N'9' 
                                                    when 154706 then N'7' 
                                                    when 154703 then N'4' 
                                                    when 154700 then N'1' 
                                                    when 154707 then N'8' 
                                                    when 154704 then N'5' 
                                                    when 154701 then N'2' 
                                                end) as expr_72 ,
                                                (case expr_104 
                                                    when 160330 then N'No' 
                                                    when 160329 then N'Yes' 
                                                end) as expr_104 ,
                                                case SurveyResponse.modeType 
                                                    when 1 then N'Phone' 
                                                    when 2 then N'Web' 
                                                    when 3 then N'Import' 
                                                    when 4 then N'Social' 
                                                end as expr_16 ,
                                                (case expr_81 
                                                    when 160341 then N'No' 
                                                    when 160340 then N'Yes' 
                                                end) as expr_81 ,
                                                expr_111 as expr_111 ,
                                                SurveyResponse.objectId as expr_19 ,
                                                (case expr_52 
                                                    when 175787 then N'7' 
                                                    when 175783 then N'3' 
                                                    when 175789 then N'9' 
                                                    when 175781 then N'1' 
                                                    when 175785 then N'5' 
                                                    when 175782 then N'2' 
                                                    when 175786 then N'6' 
                                                    when 175788 then N'8' 
                                                    when 175784 then N'4' 
                                                end) as expr_52 ,
                                                (case expr_140 
                                                    when 189161 then N'No' 
                                                    when 189160 then N'Yes' 
                                                end) as expr_140 ,
                                                cat7931.locationCategoryName as expr_4 ,
                                                (case expr_51 
                                                    when 175775 then N'4' 
                                                    when 175774 then N'3' 
                                                    when 175779 then N'8' 
                                                    when 175778 then N'7' 
                                                    when 175780 then N'9' 
                                                    when 175777 then N'6' 
                                                    when 175773 then N'2' 
                                                    when 175772 then N'1' 
                                                    when 175776 then N'5' 
                                                end) as expr_51 ,
                                                expr_180 as expr_180 ,
                                                (case expr_48 
                                                    when 160234 then N'For me' 
                                                    when 160236 then N'Both' 
                                                    when 160235 then N'Someone else' 
                                                end) as expr_48 ,
                                                cat7930.locationCategoryObjectId as entityId_3 ,
                                                (case expr_54 
                                                    when 151130 then N'8' 
                                                    when 151125 then N'3' 
                                                    when 151123 then N'1' 
                                                    when 151127 then N'5' 
                                                    when 151129 then N'7' 
                                                    when 151131 then N'9' 
                                                    when 151126 then N'4' 
                                                    when 151124 then N'2' 
                                                    when 151128 then N'6' 
                                                end) as expr_54 ,
                                                (case expr_148 
                                                    when 153155 then N'No' 
                                                    when 153154 then N'Yes' 
                                                end) as expr_148 ,
                                                (case expr_152 
                                                    when 202968 then N'7' 
                                                    when 202963 then N'2' 
                                                    when 202962 then N'1' 
                                                    when 202970 then N'9' 
                                                    when 202967 then N'6' 
                                                    when 202966 then N'5' 
                                                    when 202964 then N'3' 
                                                    when 202969 then N'8' 
                                                    when 202965 then N'4' 
                                                end) as expr_152 ,
                                                (case expr_115 
                                                    when 151388 then N'Yes, I am 18 years of age or older' 
                                                    when 151389 then N'No, I am under 18 years of age' 
                                                end) as expr_115 ,
                                                (case expr_105 
                                                    when 160339 then N'9' 
                                                    when 160335 then N'5' 
                                                    when 160331 then N'1' 
                                                    when 160338 then N'8' 
                                                    when 160337 then N'7' 
                                                    when 160332 then N'2' 
                                                    when 160333 then N'3' 
                                                    when 160336 then N'6' 
                                                    when 160334 then N'4' 
                                                end) as expr_105 ,
                                                (case expr_174 
                                                    when 209310 then N'6' 
                                                    when 209309 then N'5' 
                                                    when 209313 then N'9' 
                                                    when 209308 then N'1' 
                                                    when 209300 then N'2' 
                                                    when 209307 then N'4' 
                                                    when 209306 then N'3' 
                                                    when 209312 then N'8' 
                                                    when 209311 then N'7' 
                                                end) as expr_174 ,
                                                (case expr_97 
                                                    when 164344 then N'9' 
                                                    when 164342 then N'7' 
                                                    when 164339 then N'4' 
                                                    when 164340 then N'5' 
                                                    when 164338 then N'3' 
                                                    when 164336 then N'1' 
                                                    when 164343 then N'8' 
                                                    when 164341 then N'6' 
                                                    when 164337 then N'2' 
                                                end) as expr_97 ,
                                                (case expr_99 
                                                    when 164348 then N'Better than Most' 
                                                    when 164352 then N'Do not participate in other reward programs' 
                                                    when 164351 then N'Worse than Most' 
                                                    when 164349 then N'About the Same' 
                                                end) as expr_99 ,
                                                expr_127 as expr_127 ,
                                                expr_113 as expr_113 ,
                                                expr_171 as expr_171 ,
                                                (case expr_25 
                                                    when 175641 then N'8' 
                                                    when 175634 then N'1' 
                                                    when 175636 then N'3' 
                                                    when 175635 then N'2' 
                                                    when 175640 then N'7' 
                                                    when 175639 then N'6' 
                                                    when 175642 then N'9' 
                                                    when 175637 then N'4' 
                                                    when 175638 then N'5' 
                                                end) as expr_25 ,
                                                expr_162 as expr_162 ,
                                                cat7932.locationCategoryObjectId as entityId_7 ,
                                                (case expr_156 
                                                    when 209267 then N'It was a typical shopping trip' 
                                                    when 209266 then N'Walgreens was open when other retailers were closed (special holiday hours)' 
                                                    when 209263 then N'Thanksgiving weekend promotions or offers' 
                                                end) as expr_156 ,
                                                (case expr_63 
                                                    when 151190 then N'1' 
                                                    when 151195 then N'6' 
                                                    when 151194 then N'5' 
                                                    when 151191 then N'2' 
                                                    when 151198 then N'9' 
                                                    when 151193 then N'4' 
                                                    when 151197 then N'8' 
                                                    when 151196 then N'7' 
                                                    when 151192 then N'3' 
                                                end) as expr_63 ,
                                                (case expr_142 
                                                    when 151044 then N'3' 
                                                    when 151046 then N'5' 
                                                    when 151048 then N'7' 
                                                    when 151042 then N'1' 
                                                    when 151043 then N'2' 
                                                    when 151047 then N'6' 
                                                    when 151050 then N'9' 
                                                    when 151045 then N'4' 
                                                    when 151049 then N'8' 
                                                end) as expr_142 ,
                                                (case expr_32 
                                                    when 161159 then N'Doctor on Premise' 
                                                    when 160180 then N'Purchase any other items' 
                                                    when 160178 then N'Visit the Healthcare Clinic' 
                                                    when 160179 then N'Order or pick up photos' 
                                                    when 160175 then N'Pick up or drop off a prescription' 
                                                    when 160177 then N'Receive a flu shot or immunization' 
                                                    when 160176 then N'Purchase beauty, cosmetics or personal care products' 
                                                end) as expr_32 ,
                                                SurveyResponse.beginDate as expr_12 ,
                                                (case expr_139 
                                                    when 188453 then N'Yes' 
                                                    when 188454 then N'No' 
                                                end) as expr_139 ,
                                                (case expr_76 
                                                    when 159044 then N'No' 
                                                    when 159043 then N'Yes' 
                                                    when 159045 then N'Don''t know' 
                                                end) as expr_76 ,
                                                (case expr_154 
                                                    when 212706 then N'1' 
                                                    when 212711 then N'6' 
                                                    when 212709 then N'4' 
                                                    when 212707 then N'2' 
                                                    when 212714 then N'9' 
                                                    when 212710 then N'5' 
                                                    when 212713 then N'8' 
                                                    when 212712 then N'7' 
                                                    when 212708 then N'3' 
                                                end) as expr_154 ,
                                                expr_159 as expr_159 ,
                                                (case expr_45 
                                                    when 160218 then N'4' 
                                                    when 160221 then N'7' 
                                                    when 160220 then N'6' 
                                                    when 160216 then N'2' 
                                                    when 160223 then N'9' 
                                                    when 160222 then N'8' 
                                                    when 160219 then N'5' 
                                                    when 160215 then N'1' 
                                                    when 160217 then N'3' 
                                                end) as expr_45 ,
                                                (case expr_35 
                                                    when 175892 then N'No' 
                                                    when 175891 then N'Yes' 
                                                    when 175893 then N'Don''t remember' 
                                                end) as expr_35 ,
                                                (case expr_136 
                                                    when 189159 then N'No' 
                                                    when 189158 then N'Yes' 
                                                end) as expr_136 ,
                                                SurveyResponse.ani as expr_17 ,
                                                expr_169 as expr_169 ,
                                                (case expr_75 
                                                    when 154760 then N'4' 
                                                    when 154757 then N'1' 
                                                    when 154764 then N'8' 
                                                    when 154759 then N'3' 
                                                    when 154765 then N'9' 
                                                    when 154762 then N'6' 
                                                    when 154758 then N'2' 
                                                    when 154761 then N'5' 
                                                    when 154763 then N'7' 
                                                end) as expr_75 ,
                                                (case expr_150 
                                                    when 201269 then N'Yes (had unplanned purchases)' 
                                                    when 201270 then N'No (no unplanned purchases)' 
                                                end) as expr_150 ,
                                                (case expr_95 
                                                    when 164323 then N'6' 
                                                    when 164325 then N'8' 
                                                    when 164321 then N'4' 
                                                    when 164319 then N'2' 
                                                    when 164324 then N'7' 
                                                    when 164322 then N'5' 
                                                    when 164318 then N'1' 
                                                    when 164320 then N'3' 
                                                    when 164326 then N'9' 
                                                end) as expr_95 ,
                                                (case expr_98 
                                                    when 166193 then N'Another reason' 
                                                    when 171257 then N'Due to not being able to receive points for Medica' 
                                                    when 171258 then N'Due to employee lack of knowledge about the progra' 
                                                    when 171256 then N'You are unclear about how the program works' 
                                                    when 164346 then N'Lack of ease of participating in the reward program' 
                                                    when 164347 then N'Due to range of products available with reward discounts' 
                                                    when 164345 then N'Does not offer an opportunity to earn meaningful r' 
                                                end) as expr_98 ,
                                                (case expr_65 
                                                    when 176255 then N'No' 
                                                    when 176254 then N'Yes' 
                                                end) as expr_65 ,
                                                (case expr_34 
                                                    when 175694 then N'Order or pick up photos' 
                                                    when 175690 then N'Pick up or drop off a prescription' 
                                                    when 175695 then N'Purchase any other items' 
                                                    when 175692 then N'Receive a flu shot or immunization' 
                                                    when 175693 then N'Visit the Take Care Clinic' 
                                                    when 175691 then N'Purchase beauty, cosmetics or personal care products' 
                                                end) as expr_34 ,
                                                expr_166 as expr_166 ,
                                                (case expr_21 
                                                    when 152263 then N'S' 
                                                    when 152262 then N'E' 
                                                end) as expr_21 ,
                                                (case expr_74 
                                                    when 154756 then N'9' 
                                                    when 154748 then N'3' 
                                                    when 154750 then N'5' 
                                                    when 154754 then N'7' 
                                                    when 154751 then N'6' 
                                                    when 154746 then N'1' 
                                                    when 154749 then N'4' 
                                                    when 154747 then N'2' 
                                                    when 154755 then N'8' 
                                                end) as expr_74 ,
                                                (case expr_153 
                                                    when 202960 then N'Yes' 
                                                    when 202961 then N'No' 
                                                end) as expr_153 ,
                                                (case expr_39 
                                                    when 175717 then N'4' 
                                                    when 175722 then N'9' 
                                                    when 175718 then N'5' 
                                                    when 175716 then N'3' 
                                                    when 175720 then N'7' 
                                                    when 175719 then N'6' 
                                                    when 175715 then N'2' 
                                                    when 175721 then N'8' 
                                                    when 175714 then N'1' 
                                                end) as expr_39 ,
                                                (case expr_33 
                                                    when 176248 then N'No' 
                                                    when 176247 then N'Yes' 
                                                end) as expr_33 ,
                                                (case expr_71 
                                                    when 153156 then N'1' 
                                                    when 153159 then N'4' 
                                                    when 153157 then N'2' 
                                                    when 153161 then N'6' 
                                                    when 153163 then N'8' 
                                                    when 153164 then N'9' 
                                                    when 153158 then N'3' 
                                                    when 153160 then N'5' 
                                                    when 153162 then N'7' 
                                                end) as expr_71 ,
                                                (case expr_185 
                                                    when 212822 then N'2' 
                                                    when 212825 then N'5' 
                                                    when 212827 then N'7' 
                                                    when 212821 then N'1' 
                                                    when 212823 then N'3' 
                                                    when 212829 then N'9' 
                                                    when 212824 then N'4' 
                                                    when 212828 then N'8' 
                                                    when 212826 then N'6' 
                                                end) as expr_185 ,
                                                (case expr_183 
                                                    when 212831 then N'2' 
                                                    when 212836 then N'7' 
                                                    when 212835 then N'6' 
                                                    when 212832 then N'3' 
                                                    when 212830 then N'1' 
                                                    when 212838 then N'9' 
                                                    when 212833 then N'4' 
                                                    when 212834 then N'5' 
                                                    when 212837 then N'8' 
                                                end) as expr_183 ,
                                                (case expr_82 
                                                    when 160400 then N'More than 4 times per month' 
                                                    when 160399 then N'2-4 times per month' 
                                                    when 160398 then N'1 time per month' 
                                                    when 160397 then N'First time' 
                                                end) as expr_82 ,
                                                (case expr_78 
                                                    when 172443 then N'The personal care/cosmetic counter' 
                                                    when 172444 then N'The front registers' 
                                                    when 172441 then N'The photo counter' 
                                                    when 172445 then N'Don''t know or remember' 
                                                    when 172442 then N'The pharmacy counter' 
                                                end) as expr_78 ,
                                                (case expr_64 
                                                    when 176243 then N'6' 
                                                    when 176239 then N'2' 
                                                    when 176241 then N'4' 
                                                    when 176246 then N'9' 
                                                    when 176245 then N'8' 
                                                    when 176242 then N'5' 
                                                    when 176244 then N'7' 
                                                    when 176240 then N'3' 
                                                    when 176238 then N'1' 
                                                end) as expr_64 ,
                                                expr_181 as expr_181 ,
                                                SurveyResponse.minutes as expr_15 ,
                                                (case expr_85 
                                                    when 161066 then N'Native American or Alaskan Native' 
                                                    when 161063 then N'Black or African American' 
                                                    when 161065 then N'Asian or Pacific Islander' 
                                                    when 161062 then N'White or Caucasian' 
                                                    when 161067 then N'Mixed racial background' 
                                                    when 161069 then N'Prefer not to answer' 
                                                    when 161064 then N'Hispanic' 
                                                end) as expr_85 ,
                                                (case expr_175 
                                                    when 209324 then N'Yes' 
                                                    when 209325 then N'No' 
                                                end) as expr_175 ,
                                                (case expr_23 
                                                    when 153146 then N'Photo' 
                                                    when 153148 then N'Front of Store' 
                                                    when 153145 then N'Pharmacy' 
                                                    when 153147 then N'Beauty' 
                                                end) as expr_23 ,
                                                cat7931.locationCategoryObjectId as entityId_5 ,
                                                expr_160 as expr_160 ,
                                                (case expr_66 
                                                    when 160290 then N'6' 
                                                    when 160288 then N'4' 
                                                    when 160292 then N'8' 
                                                    when 160287 then N'3' 
                                                    when 160285 then N'1' 
                                                    when 160293 then N'9' 
                                                    when 160291 then N'7' 
                                                    when 160286 then N'2' 
                                                    when 160289 then N'5' 
                                                end) as expr_66 ,
                                                expr_178 as expr_178 ,
                                                expr_124 as expr_124 ,
                                                expr_120 as expr_120 ,
                                                (case expr_50 
                                                    when 175770 then N'8' 
                                                    when 175769 then N'7' 
                                                    when 175765 then N'3' 
                                                    when 175764 then N'2' 
                                                    when 175766 then N'4' 
                                                    when 175771 then N'9' 
                                                    when 175767 then N'5' 
                                                    when 176305 then N'10' 
                                                    when 175768 then N'6' 
                                                    when 175763 then N'1' 
                                                end) as expr_50 ,
                                                Location.objectId as entityId_11 ,
                                                expr_20 as expr_20 ,
                                                (case expr_91 
                                                    when 164317 then N'With a call center specialist' 
                                                    when 160352 then N'At the store photo kiosk' 
                                                    when 160356 then N'Don''t remember' 
                                                    when 176298 then N'At the pharmacy' 
                                                    when 160354 then N'On mobile phone/mobile app' 
                                                    when 160353 then N'Online' 
                                                    when 160355 then N'Using QR code ' 
                                                    when 160351 then N'At the store check-out' 
                                                end) as expr_91 ,
                                                (case expr_149 
                                                    when 195588 then N'Yes' 
                                                    when 195589 then N'No' 
                                                end) as expr_149 ,
                                                (case expr_24 
                                                    when 152002 then N'6' 
                                                    when 152004 then N'8' 
                                                    when 151999 then N'3' 
                                                    when 151997 then N'1' 
                                                    when 152000 then N'4' 
                                                    when 152003 then N'7' 
                                                    when 151998 then N'2' 
                                                    when 152001 then N'5' 
                                                    when 152005 then N'9' 
                                                end) as expr_24 ,
                                                (case expr_103 
                                                    when 151390 then N'Yes' 
                                                    when 151391 then N'No' 
                                                end) as expr_103 ,
                                                (case expr_53 
                                                    when 175795 then N'6' 
                                                    when 175792 then N'3' 
                                                    when 175791 then N'2' 
                                                    when 175797 then N'8' 
                                                    when 176304 then N'10' 
                                                    when 175798 then N'9' 
                                                    when 175794 then N'5' 
                                                    when 175793 then N'4' 
                                                    when 175790 then N'1' 
                                                    when 175796 then N'7' 
                                                end) as expr_53 ,
                                                (case expr_73 
                                                    when 154740 then N'4' 
                                                    when 154737 then N'1' 
                                                    when 154744 then N'8' 
                                                    when 154741 then N'5' 
                                                    when 154743 then N'7' 
                                                    when 154738 then N'2' 
                                                    when 154742 then N'6' 
                                                    when 154739 then N'3' 
                                                    when 154745 then N'9' 
                                                end) as expr_73 ,
                                                expr_121 as expr_121 ,
                                                expr_158 as expr_158 ,
                                                (case expr_49 
                                                    when 150940 then N'6' 
                                                    when 150936 then N'2' 
                                                    when 150942 then N'8' 
                                                    when 150943 then N'9 ' 
                                                    when 150938 then N'4' 
                                                    when 150939 then N'5' 
                                                    when 150937 then N'3' 
                                                    when 150935 then N'1 ' 
                                                    when 150941 then N'7' 
                                                end) as expr_49 ,
                                                (case expr_94 
                                                    when 160364 then N'8' 
                                                    when 160362 then N'6' 
                                                    when 160358 then N'2' 
                                                    when 160360 then N'4' 
                                                    when 160361 then N'5' 
                                                    when 160363 then N'7' 
                                                    when 160357 then N'1' 
                                                    when 160365 then N'9' 
                                                    when 160359 then N'3' 
                                                end) as expr_94 ,
                                                (case expr_88 
                                                    when 160342 then N'Yes' 
                                                    when 160343 then N'No' 
                                                end) as expr_88 ,
                                                expr_114 as expr_114 ,
                                                expr_119 as expr_119 ,
                                                expr_167 as expr_167 ,
                                                (case expr_60 
                                                    when 175836 then N'9' 
                                                    when 175834 then N'7' 
                                                    when 175832 then N'5' 
                                                    when 175828 then N'1' 
                                                    when 175835 then N'8' 
                                                    when 175831 then N'4' 
                                                    when 175829 then N'2' 
                                                    when 175833 then N'6' 
                                                    when 175830 then N'3' 
                                                end) as expr_60 ,
                                                (case expr_182 
                                                    when 212817 then N'6' 
                                                    when 212813 then N'2' 
                                                    when 212818 then N'7' 
                                                    when 212816 then N'5' 
                                                    when 212812 then N'1' 
                                                    when 212820 then N'9' 
                                                    when 212814 then N'3' 
                                                    when 212815 then N'4' 
                                                    when 212819 then N'8' 
                                                end) as expr_182 ,
                                                (case expr_144 
                                                    when 188486 then N'Yes' 
                                                    when 188487 then N'No' 
                                                    when 189181 then N'N/A' 
                                                end) as expr_144 ,
                                                (case expr_44 
                                                    when 175761 then N'Yes' 
                                                    when 175762 then N'No' 
                                                end) as expr_44 ,
                                                cat7933.locationCategoryObjectId as entityId_1 ,
                                                SurveyResponse.dateOfService as expr_13 ,
                                                expr_163 as expr_163 ,
                                                (case expr_145 
                                                    when 188488 then N'Yes' 
                                                    when 188489 then N'No' 
                                                    when 189180 then N'N/A' 
                                                end) as expr_145 ,
                                                expr_117 as expr_117 ,
                                                (case expr_96 
                                                    when 164332 then N'6' 
                                                    when 164334 then N'8' 
                                                    when 164330 then N'4' 
                                                    when 164327 then N'1' 
                                                    when 164335 then N'9' 
                                                    when 164331 then N'5' 
                                                    when 164329 then N'3' 
                                                    when 164333 then N'7' 
                                                    when 164328 then N'2' 
                                                end) as expr_96 ,
                                                (case expr_36 
                                                    when 151023 then N'3' 
                                                    when 151022 then N'2' 
                                                    when 151027 then N'7' 
                                                    when 151026 then N'6' 
                                                    when 151025 then N'5' 
                                                    when 151029 then N'9' 
                                                    when 151028 then N'8' 
                                                    when 151024 then N'4' 
                                                    when 151021 then N'1' 
                                                end) as expr_36 ,
                                                expr_161 as expr_161 ,
                                                expr_179 as expr_179 ,
                                                (case expr_100 
                                                    when 161515 then N'Exceptional Service' 
                                                    when 161517 then N'Improve Service' 
                                                    when 161516 then N'Neutral' 
                                                end) as expr_100 ,
                                                (case expr_132 
                                                    when 183982 then N'More than a month ago' 
                                                    when 183983 then N'I have never used/signed up for this feature of the Balance Reward program' 
                                                    when 183980 then N'Within the past week' 
                                                    when 183981 then N'Within the past month' 
                                                end) as expr_132 ,
                                                cat7933.locationCategoryName as expr_0 ,
                                                (case expr_151 
                                                    when 202973 then N'3' 
                                                    when 202978 then N'8' 
                                                    when 202977 then N'7' 
                                                    when 202974 then N'4' 
                                                    when 202972 then N'2' 
                                                    when 202975 then N'5' 
                                                    when 202971 then N'1' 
                                                    when 202979 then N'9' 
                                                    when 202976 then N'6' 
                                                end) as expr_151 ,
                                                expr_129 as expr_129 ,
                                                (case expr_40 
                                                    when 175748 then N'8' 
                                                    when 175743 then N'3' 
                                                    when 175747 then N'7' 
                                                    when 175741 then N'1' 
                                                    when 176274 then N'10' 
                                                    when 175749 then N'9' 
                                                    when 175745 then N'5' 
                                                    when 175744 then N'4' 
                                                    when 175742 then N'2' 
                                                    when 175746 then N'6' 
                                                end) as expr_40 ,
                                                (case expr_37 
                                                    when 160192 then N'1' 
                                                    when 160200 then N'9' 
                                                    when 160194 then N'3' 
                                                    when 160196 then N'5' 
                                                    when 160198 then N'7' 
                                                    when 160199 then N'8' 
                                                    when 160195 then N'4' 
                                                    when 160193 then N'2' 
                                                    when 160197 then N'6' 
                                                end) as expr_37 ,
                                                (case expr_135 
                                                    when 188389 then N'Yes' 
                                                    when 188390 then N'No' 
                                                end) as expr_135 ,
                                                (case expr_92 
                                                    when 169209 then N'Yes' 
                                                    when 169210 then N'No' 
                                                end) as expr_92 ,
                                                expr_177 as expr_177 ,
                                                expr_122 as expr_122 ,
                                                (case expr_61 
                                                    when 175840 then N'4' 
                                                    when 175838 then N'2' 
                                                    when 175839 then N'3' 
                                                    when 175844 then N'8' 
                                                    when 175843 then N'7' 
                                                    when 175842 then N'6' 
                                                    when 175837 then N'1' 
                                                    when 175845 then N'9' 
                                                    when 175841 then N'5' 
                                                end) as expr_61 ,
                                                (case expr_68 
                                                    when 175877 then N'5' 
                                                    when 175881 then N'9' 
                                                    when 175876 then N'4' 
                                                    when 175879 then N'7' 
                                                    when 175878 then N'6' 
                                                    when 175875 then N'3' 
                                                    when 175874 then N'2' 
                                                    when 175873 then N'1' 
                                                    when 175880 then N'8' 
                                                end) as expr_68 ,
                                                (case expr_89 
                                                    when 160348 then N'I belong to too many reward programs' 
                                                    when 160349 then N'Did not know [Walgreens/Duane Reade] had a Balance Rewards program' 
                                                    when 160345 then N'Process too difficult' 
                                                    when 160346 then N'Experienced technical difficulties' 
                                                    when 160350 then N'Another reason' 
                                                    when 160344 then N'Of no value to me' 
                                                end) as expr_89 ,
                                                (case expr_30 
                                                    when 176187 then N'2' 
                                                    when 176192 then N'7' 
                                                    when 176194 then N'9' 
                                                    when 176190 then N'5' 
                                                    when 176188 then N'3' 
                                                    when 176189 then N'4' 
                                                    when 176186 then N'1' 
                                                    when 176193 then N'8' 
                                                    when 176191 then N'6' 
                                                end) as expr_30 ,
                                                (case expr_47 
                                                    when 151037 then N'Inside the store' 
                                                    when 151038 then N'At the drive thru' 
                                                end) as expr_47 ,
                                                convert(varchar,
                                                SurveyResponse.beginTime,
                                                8) as expr_14 ,
                                                (case expr_62 
                                                    when 160270 then N'Over-the-counter medications and other health products' 
                                                    when 160274 then N'Baby products (diapers, food, formula, or other care items)' 
                                                    when 160273 then N'Products for your home (cleaners, decor, seasonal ' 
                                                    when 160275 then N'Other types of products' 
                                                    when 160272 then N'Stationery, toys, and greeting cards' 
                                                    when 160271 then N'Grocery or other food/drink items' 
                                                end) as expr_62 ,
                                                (case expr_26 
                                                    when 175648 then N'6' 
                                                    when 175643 then N'1' 
                                                    when 175647 then N'5' 
                                                    when 175644 then N'2' 
                                                    when 175649 then N'7' 
                                                    when 175650 then N'8' 
                                                    when 175651 then N'9' 
                                                    when 175646 then N'4' 
                                                    when 175645 then N'3' 
                                                end) as expr_26 ,
                                                expr_126 as expr_126 ,
                                                expr_130 as expr_130 ,
                                                (case expr_57 
                                                    when 175818 then N'No' 
                                                    when 175817 then N'Yes' 
                                                end) as expr_57 ,
                                                (case expr_137 
                                                    when 188399 then N'9' 
                                                    when 188396 then N'6' 
                                                    when 188391 then N'1' 
                                                    when 188394 then N'4' 
                                                    when 188398 then N'8' 
                                                    when 188395 then N'5' 
                                                    when 188392 then N'2' 
                                                    when 188393 then N'3' 
                                                    when 188397 then N'7' 
                                                end) as expr_137 ,
                                                expr_168 as expr_168 ,
                                                (case expr_86 
                                                    when 161073 then N'$50,000 to under $75,000' 
                                                    when 161072 then N'$35,000 to under $50,000' 
                                                    when 161070 then N'Under $25,000' 
                                                    when 161075 then N'$100,000 to under $150,000' 
                                                    when 161071 then N'$25,000 to under $35,000' 
                                                    when 161078 then N'Prefer not to answer' 
                                                    when 161077 then N'$150,000 or more' 
                                                    when 161074 then N'$75,000 to under $100,000' 
                                                end) as expr_86 ,
                                                SurveyResponse.IPAddress as expr_18 ,
                                                (case expr_79 
                                                    when 160327 then N'Yes' 
                                                    when 160328 then N'No' 
                                                end) as expr_79 ,
                                                (case expr_184 
                                                    when 212842 then N'4' 
                                                    when 212843 then N'5' 
                                                    when 212847 then N'9' 
                                                    when 212841 then N'3' 
                                                    when 212845 then N'7' 
                                                    when 212844 then N'6' 
                                                    when 212839 then N'1' 
                                                    when 212840 then N'2' 
                                                    when 212846 then N'8' 
                                                end) as expr_184 ,
                                                (case expr_84 
                                                    when 175896 then N'25 - 44' 
                                                    when 175897 then N'45 - 54' 
                                                    when 175899 then N'Over 65' 
                                                    when 175898 then N'55 - 64' 
                                                    when 175900 then N'Prefer not to answer' 
                                                    when 175895 then N'18-24' 
                                                    when 175894 then N'Under 18' 
                                                end) as expr_84 ,
                                                (case expr_58 
                                                    when 160256 then N'9' 
                                                    when 160251 then N'4' 
                                                    when 160248 then N'1' 
                                                    when 160252 then N'5' 
                                                    when 160250 then N'3' 
                                                    when 160249 then N'2' 
                                                    when 160254 then N'7' 
                                                    when 160255 then N'8' 
                                                    when 160253 then N'6' 
                                                end) as expr_58 ,
                                                expr_110 as expr_110 ,
                                                cat7932.locationCategoryName as expr_6 ,
                                                cat8970.locationCategoryObjectId as entityId_9 ,
                                                expr_165 as expr_165 ,
                                                (case expr_155 
                                                    when 212719 then N'5' 
                                                    when 212718 then N'4' 
                                                    when 212715 then N'1' 
                                                    when 212723 then N'9' 
                                                    when 212722 then N'8' 
                                                    when 212717 then N'3' 
                                                    when 212720 then N'6' 
                                                    when 212716 then N'2' 
                                                    when 213217 then N'NA' 
                                                    when 212721 then N'7' 
                                                end) as expr_155 ,
                                                (case expr_28 
                                                    when 160132 then N'2' 
                                                    when 160137 then N'7' 
                                                    when 160134 then N'4' 
                                                    when 160136 then N'6' 
                                                    when 160138 then N'8' 
                                                    when 160133 then N'3' 
                                                    when 160139 then N'9' 
                                                    when 160135 then N'5' 
                                                    when 160131 then N'1' 
                                                end) as expr_28 ,
                                                expr_170 as expr_170 ,
                                                (case expr_141 
                                                    when 151095 then N'9' 
                                                    when 151093 then N'7' 
                                                    when 151091 then N'5' 
                                                    when 151092 then N'6' 
                                                    when 151088 then N'2' 
                                                    when 151087 then N'1' 
                                                    when 151094 then N'8' 
                                                    when 151090 then N'4' 
                                                    when 151089 then N'3' 
                                                end) as expr_141 ,
                                                (case expr_46 
                                                    when 176218 then N'It was part of the auto refill program' 
                                                    when 176213 then N'Dropped off at the drive thru' 
                                                    when 176219 then N'Other/Don''t know' 
                                                    when 176214 then N'Ordered by phone' 
                                                    when 176216 then N'Had your doctor order the prescription' 
                                                    when 176212 then N'Dropped off inside the store' 
                                                    when 176215 then N'Ordered online at Walgreens.com or sent using the ' 
                                                end) as expr_46 ,
                                                (case expr_138 
                                                    when 189028 then N'4' 
                                                    when 189025 then N'1' 
                                                    when 189033 then N'9' 
                                                    when 189030 then N'6' 
                                                    when 189027 then N'3' 
                                                    when 189031 then N'7' 
                                                    when 189032 then N'8' 
                                                    when 189029 then N'5' 
                                                    when 189026 then N'2' 
                                                end) as expr_138
                                                
    	
                                            
                                         from       SurveyResponse 
                                            inner join
                                                Location 
                                                    on Location.objectId=SurveyResponse.locationObjectId 
                                            left outer join
                                                #cat7933 cat7933 
                                                    on cat7933.locationObjectId=SurveyResponse.locationObjectId 
                                            left outer join
                                                #cat7930 cat7930 
                                                    on cat7930.locationObjectId=SurveyResponse.locationObjectId 
                                            left outer join
                                                #cat7931 cat7931 
                                                    on cat7931.locationObjectId=SurveyResponse.locationObjectId 
                                            left outer join
                                                #cat7932 cat7932 
                                                    on cat7932.locationObjectId=SurveyResponse.locationObjectId 
                                            left outer join
                                                #cat8970 cat8970 
                                                    on cat8970.locationObjectId=SurveyResponse.locationObjectId 
                                            left outer join
                                                (
                                                    select
                                                        surveyResponseObjectId ,
                                                        max(case dataFieldObjectId 
                                                            when 59584 then sra.textValue 
                                                        end) expr_20 ,
                                                        max(case dataFieldObjectId 
                                                            when 59591 then sra.dataFieldOptionObjectId 
                                                        end) expr_21 ,
                                                        max(case dataFieldObjectId 
                                                            when 62201 then sra.dataFieldOptionObjectId 
                                                        end) expr_23 ,
                                                        max(case dataFieldObjectId 
                                                            when 59101 then sra.dataFieldOptionObjectId 
                                                        end) expr_24 ,
                                                        max(case dataFieldObjectId 
                                                            when 70840 then sra.dataFieldOptionObjectId 
                                                        end) expr_25 ,
                                                        max(case dataFieldObjectId 
                                                            when 70841 then sra.dataFieldOptionObjectId 
                                                        end) expr_26 ,
                                                        max(case dataFieldObjectId 
                                                            when 70843 then sra.dataFieldOptionObjectId 
                                                        end) expr_27 ,
                                                        max(case dataFieldObjectId 
                                                            when 64428 then sra.dataFieldOptionObjectId 
                                                        end) expr_28 ,
                                                        max(case dataFieldObjectId 
                                                            when 70844 then sra.dataFieldOptionObjectId 
                                                        end) expr_29 ,
                                                        max(case dataFieldObjectId 
                                                            when 72104 then sra.dataFieldOptionObjectId 
                                                        end) expr_30 ,
                                                        max(case dataFieldObjectId 
                                                            when 64432 then sra.dataFieldOptionObjectId 
                                                        end) expr_31 ,
                                                        max(case dataFieldObjectId 
                                                            when 64439 then sra.dataFieldOptionObjectId 
                                                        end) expr_32 ,
                                                        max(case dataFieldObjectId 
                                                            when 72123 then sra.dataFieldOptionObjectId 
                                                        end) expr_33 ,
                                                        max(case dataFieldObjectId 
                                                            when 70847 then sra.dataFieldOptionObjectId 
                                                        end) expr_34 ,
                                                        max(case dataFieldObjectId 
                                                            when 71351 then sra.dataFieldOptionObjectId 
                                                        end) expr_35 ,
                                                        max(case dataFieldObjectId 
                                                            when 59139 then sra.dataFieldOptionObjectId 
                                                        end) expr_36 ,
                                                        max(case dataFieldObjectId 
                                                            when 64445 then sra.dataFieldOptionObjectId 
                                                        end) expr_37 ,
                                                        max(case dataFieldObjectId 
                                                            when 70851 then sra.dataFieldOptionObjectId 
                                                        end) expr_38 ,
                                                        max(case dataFieldObjectId 
                                                            when 70852 then sra.dataFieldOptionObjectId 
                                                        end) expr_39 ,
                                                        max(case dataFieldObjectId 
                                                            when 70855 then sra.dataFieldOptionObjectId 
                                                        end) expr_40 ,
                                                        max(case dataFieldObjectId 
                                                            when 70856 then sra.dataFieldOptionObjectId 
                                                        end) expr_41 ,
                                                        max(case dataFieldObjectId 
                                                            when 70853 then sra.dataFieldOptionObjectId 
                                                        end) expr_42 ,
                                                        max(case dataFieldObjectId 
                                                            when 70857 then sra.dataFieldOptionObjectId 
                                                        end) expr_43 ,
                                                        max(case dataFieldObjectId 
                                                            when 70858 then sra.dataFieldOptionObjectId 
                                                        end) expr_44 ,
                                                        max(case dataFieldObjectId 
                                                            when 64448 then sra.dataFieldOptionObjectId 
                                                        end) expr_45 ,
                                                        max(case dataFieldObjectId 
                                                            when 72113 then sra.dataFieldOptionObjectId 
                                                        end) expr_46 ,
                                                        max(case dataFieldObjectId 
                                                            when 59141 then sra.dataFieldOptionObjectId 
                                                        end) expr_47 ,
                                                        max(case dataFieldObjectId 
                                                            when 64452 then sra.dataFieldOptionObjectId 
                                                        end) expr_48 ,
                                                        max(case dataFieldObjectId 
                                                            when 59121 then sra.dataFieldOptionObjectId 
                                                        end) expr_49 ,
                                                        max(case dataFieldObjectId 
                                                            when 70859 then sra.dataFieldOptionObjectId 
                                                        end) expr_50 ,
                                                        max(case dataFieldObjectId 
                                                            when 70860 then sra.dataFieldOptionObjectId 
                                                        end) expr_51 ,
                                                        max(case dataFieldObjectId 
                                                            when 70861 then sra.dataFieldOptionObjectId 
                                                        end) expr_52 ,
                                                        max(case dataFieldObjectId 
                                                            when 70862 then sra.dataFieldOptionObjectId 
                                                        end) expr_53 ,
                                                        max(case dataFieldObjectId 
                                                            when 59152 then sra.dataFieldOptionObjectId 
                                                        end) expr_54 ,
                                                        max(case dataFieldObjectId 
                                                            when 70864 then sra.dataFieldOptionObjectId 
                                                        end) expr_55 ,
                                                        max(case dataFieldObjectId 
                                                            when 70865 then sra.dataFieldOptionObjectId 
                                                        end) expr_56 ,
                                                        max(case dataFieldObjectId 
                                                            when 70866 then sra.dataFieldOptionObjectId 
                                                        end) expr_57 ,
                                                        max(case dataFieldObjectId 
                                                            when 64456 then sra.dataFieldOptionObjectId 
                                                        end) expr_58 ,
                                                        max(case dataFieldObjectId 
                                                            when 70867 then sra.dataFieldOptionObjectId 
                                                        end) expr_59 ,
                                                        max(case dataFieldObjectId 
                                                            when 70868 then sra.dataFieldOptionObjectId 
                                                        end) expr_60 ,
                                                        max(case dataFieldObjectId 
                                                            when 70869 then sra.dataFieldOptionObjectId 
                                                        end) expr_61 ,
                                                        max(case dataFieldObjectId 
                                                            when 64464 then sra.dataFieldOptionObjectId 
                                                        end) expr_62 ,
                                                        max(case dataFieldObjectId 
                                                            when 59161 then sra.dataFieldOptionObjectId 
                                                        end) expr_63 ,
                                                        max(case dataFieldObjectId 
                                                            when 72121 then sra.dataFieldOptionObjectId 
                                                        end) expr_64 ,
                                                        max(case dataFieldObjectId 
                                                            when 72126 then sra.dataFieldOptionObjectId 
                                                        end) expr_65 ,
                                                        max(case dataFieldObjectId 
                                                            when 64468 then sra.dataFieldOptionObjectId 
                                                        end) expr_66 ,
                                                        max(case dataFieldObjectId 
                                                            when 70872 then sra.dataFieldOptionObjectId 
                                                        end) expr_67 ,
                                                        max(case dataFieldObjectId 
                                                            when 71084 then sra.dataFieldOptionObjectId 
                                                        end) expr_68 ,
                                                        max(case dataFieldObjectId 
                                                            when 71350 then sra.dataFieldOptionObjectId 
                                                        end) expr_69 ,
                                                        max(case dataFieldObjectId 
                                                            when 64944 then sra.dataFieldOptionObjectId 
                                                        end) expr_70 ,
                                                        max(case dataFieldObjectId 
                                                            when 62205 then sra.dataFieldOptionObjectId 
                                                        end) expr_71 ,
                                                        max(case dataFieldObjectId 
                                                            when 62607 then sra.dataFieldOptionObjectId 
                                                        end) expr_72 ,
                                                        max(case dataFieldObjectId 
                                                            when 62616 then sra.dataFieldOptionObjectId 
                                                        end) expr_73 ,
                                                        max(case dataFieldObjectId 
                                                            when 62617 then sra.dataFieldOptionObjectId 
                                                        end) expr_74 ,
                                                        max(case dataFieldObjectId 
                                                            when 62619 then sra.dataFieldOptionObjectId 
                                                        end) expr_75 ,
                                                        max(case dataFieldObjectId 
                                                            when 64002 then sra.dataFieldOptionObjectId 
                                                        end) expr_76 ,
                                                        max(case dataFieldObjectId 
                                                            when 64003 then sra.dataFieldOptionObjectId 
                                                        end) expr_77 ,
                                                        max(case dataFieldObjectId 
                                                            when 69470 then sra.dataFieldOptionObjectId 
                                                        end) expr_78 ,
                                                        max(case dataFieldObjectId 
                                                            when 64477 then sra.dataFieldOptionObjectId 
                                                        end) expr_79 ,
                                                        max(case dataFieldObjectId 
                                                            when 64946 then sra.dataFieldOptionObjectId 
                                                        end) expr_80 ,
                                                        max(case dataFieldObjectId 
                                                            when 64481 then sra.dataFieldOptionObjectId 
                                                        end) expr_81 ,
                                                        max(case dataFieldObjectId 
                                                            when 64491 then sra.dataFieldOptionObjectId 
                                                        end) expr_82 ,
                                                        max(case dataFieldObjectId 
                                                            when 62208 then sra.dataFieldOptionObjectId 
                                                        end) expr_83 ,
                                                        max(case dataFieldObjectId 
                                                            when 71352 then sra.dataFieldOptionObjectId 
                                                        end) expr_84 ,
                                                        max(case dataFieldObjectId 
                                                            when 64972 then sra.dataFieldOptionObjectId 
                                                        end) expr_85 ,
                                                        max(case dataFieldObjectId 
                                                            when 64973 then sra.dataFieldOptionObjectId 
                                                        end) expr_86 ,
                                                        max(case dataFieldObjectId 
                                                            when 64493 then sra.dataFieldOptionObjectId 
                                                        end) expr_87 ,
                                                        max(case dataFieldObjectId 
                                                            when 64482 then sra.dataFieldOptionObjectId 
                                                        end) expr_88 ,
                                                        max(case dataFieldObjectId 
                                                            when 64483 then sra.dataFieldOptionObjectId 
                                                        end) expr_89 ,
                                                        max(case dataFieldObjectId 
                                                            when 64484 then sra.textValue 
                                                        end) expr_90 ,
                                                        max(case dataFieldObjectId 
                                                            when 64485 then sra.dataFieldOptionObjectId 
                                                        end) expr_91 ,
                                                        max(case dataFieldObjectId 
                                                            when 68261 then sra.dataFieldOptionObjectId 
                                                        end) expr_92 ,
                                                        max(case dataFieldObjectId 
                                                            when 64487 then sra.dataFieldOptionObjectId 
                                                        end) expr_93 ,
                                                        max(case dataFieldObjectId 
                                                            when 64486 then sra.dataFieldOptionObjectId 
                                                        end) expr_94 ,
                                                        max(case dataFieldObjectId 
                                                            when 66329 then sra.dataFieldOptionObjectId 
                                                        end) expr_95 ,
                                                        max(case dataFieldObjectId 
                                                            when 66330 then sra.dataFieldOptionObjectId 
                                                        end) expr_96 ,
                                                        max(case dataFieldObjectId 
                                                            when 66331 then sra.dataFieldOptionObjectId 
                                                        end) expr_97 ,
                                                        max(case dataFieldObjectId 
                                                            when 66332 then sra.dataFieldOptionObjectId 
                                                        end) expr_98 ,
                                                        max(case dataFieldObjectId 
                                                            when 66333 then sra.dataFieldOptionObjectId 
                                                        end) expr_99 ,
                                                        max(case dataFieldObjectId 
                                                            when 65118 then sra.dataFieldOptionObjectId 
                                                        end) expr_100 ,
                                                        max(case dataFieldObjectId 
                                                            when 64478 then c.objectId 
                                                        end) expr_101 ,
                                                        max(case dataFieldObjectId 
                                                            when 72122 then c.objectId 
                                                        end) expr_102 ,
                                                        max(case dataFieldObjectId 
                                                            when 59187 then sra.dataFieldOptionObjectId 
                                                        end) expr_103 ,
                                                        max(case dataFieldObjectId 
                                                            when 64479 then sra.dataFieldOptionObjectId 
                                                        end) expr_104 ,
                                                        max(case dataFieldObjectId 
                                                            when 64480 then sra.dataFieldOptionObjectId 
                                                        end) expr_105 ,
                                                        max(case dataFieldObjectId 
                                                            when 65127 then c.objectId 
                                                        end) expr_106 ,
                                                        max(case dataFieldObjectId 
                                                            when 59191 then sra.textValue 
                                                        end) expr_107 ,
                                                        max(case dataFieldObjectId 
                                                            when 59190 then sra.textValue 
                                                        end) expr_108 ,
                                                        max(case dataFieldObjectId 
                                                            when 59188 then sra.textValue 
                                                        end) expr_109 ,
                                                        max(case dataFieldObjectId 
                                                            when 59189 then sra.textValue 
                                                        end) expr_110 ,
                                                        max(case dataFieldObjectId 
                                                            when 59192 then sra.textValue 
                                                        end) expr_111 ,
                                                        max(case dataFieldObjectId 
                                                            when 59193 then sra.textValue 
                                                        end) expr_112 ,
                                                        max(case dataFieldObjectId 
                                                            when 59194 then sra.textValue 
                                                        end) expr_113 ,
                                                        max(case dataFieldObjectId 
                                                            when 59195 then sra.textValue 
                                                        end) expr_114 ,
                                                        max(case dataFieldObjectId 
                                                            when 59186 then sra.dataFieldOptionObjectId 
                                                        end) expr_115 ,
                                                        max(case dataFieldObjectId 
                                                            when 59655 then c.objectId 
                                                        end) expr_116 ,
                                                        max(case dataFieldObjectId 
                                                            when 59196 then sra.textValue 
                                                        end) expr_117 ,
                                                        max(case dataFieldObjectId 
                                                            when 59197 then sra.textValue 
                                                        end) expr_118 ,
                                                        max(case dataFieldObjectId 
                                                            when 59198 then sra.textValue 
                                                        end) expr_119 ,
                                                        max(case dataFieldObjectId 
                                                            when 59199 then sra.textValue 
                                                        end) expr_120 ,
                                                        max(case dataFieldObjectId 
                                                            when 59200 then sra.textValue 
                                                        end) expr_121 ,
                                                        max(case dataFieldObjectId 
                                                            when 59201 then sra.textValue 
                                                        end) expr_122 ,
                                                        max(case dataFieldObjectId 
                                                            when 92209 then sra.numericValue 
                                                        end) expr_123 ,
                                                        max(case dataFieldObjectId 
                                                            when 92210 then sra.numericValue 
                                                        end) expr_124 ,
                                                        max(case dataFieldObjectId 
                                                            when 92230 then sra.numericValue 
                                                        end) expr_125 ,
                                                        max(case dataFieldObjectId 
                                                            when 92766 then sra.numericValue 
                                                        end) expr_126 ,
                                                        max(case dataFieldObjectId 
                                                            when 92216 then sra.numericValue 
                                                        end) expr_127 ,
                                                        max(case dataFieldObjectId 
                                                            when 92217 then sra.numericValue 
                                                        end) expr_128 ,
                                                        max(case dataFieldObjectId 
                                                            when 92219 then sra.numericValue 
                                                        end) expr_129 ,
                                                        max(case dataFieldObjectId 
                                                            when 92220 then sra.numericValue 
                                                        end) expr_130 ,
                                                        max(case dataFieldObjectId 
                                                            when 92767 then sra.dataFieldOptionObjectId 
                                                        end) expr_131 ,
                                                        max(case dataFieldObjectId 
                                                            when 93518 then sra.dataFieldOptionObjectId 
                                                        end) expr_132 ,
                                                        max(case dataFieldObjectId 
                                                            when 93549 then sra.dataFieldOptionObjectId 
                                                        end) expr_133 ,
                                                        max(case dataFieldObjectId 
                                                            when 95006 then sra.dataFieldOptionObjectId 
                                                        end) expr_134 ,
                                                        max(case dataFieldObjectId 
                                                            when 95007 then sra.dataFieldOptionObjectId 
                                                        end) expr_135 ,
                                                        max(case dataFieldObjectId 
                                                            when 95293 then sra.dataFieldOptionObjectId 
                                                        end) expr_136 ,
                                                        max(case dataFieldObjectId 
                                                            when 95008 then sra.dataFieldOptionObjectId 
                                                        end) expr_137 ,
                                                        max(case dataFieldObjectId 
                                                            when 95241 then sra.dataFieldOptionObjectId 
                                                        end) expr_138 ,
                                                        max(case dataFieldObjectId 
                                                            when 95036 then sra.dataFieldOptionObjectId 
                                                        end) expr_139 ,
                                                        max(case dataFieldObjectId 
                                                            when 95294 then sra.dataFieldOptionObjectId 
                                                        end) expr_140 ,
                                                        max(case dataFieldObjectId 
                                                            when 59148 then sra.dataFieldOptionObjectId 
                                                        end) expr_141 ,
                                                        max(case dataFieldObjectId 
                                                            when 59143 then sra.dataFieldOptionObjectId 
                                                        end) expr_142 ,
                                                        max(case dataFieldObjectId 
                                                            when 59145 then sra.dataFieldOptionObjectId 
                                                        end) expr_143 ,
                                                        max(case dataFieldObjectId 
                                                            when 95062 then sra.dataFieldOptionObjectId 
                                                        end) expr_144 ,
                                                        max(case dataFieldObjectId 
                                                            when 95063 then sra.dataFieldOptionObjectId 
                                                        end) expr_145 ,
                                                        max(case dataFieldObjectId 
                                                            when 95064 then sra.dataFieldOptionObjectId 
                                                        end) expr_146 ,
                                                        max(case dataFieldObjectId 
                                                            when 70854 then sra.dataFieldOptionObjectId 
                                                        end) expr_147 ,
                                                        max(case dataFieldObjectId 
                                                            when 62204 then sra.dataFieldOptionObjectId 
                                                        end) expr_148 ,
                                                        max(case dataFieldObjectId 
                                                            when 98033 then sra.dataFieldOptionObjectId 
                                                        end) expr_149 ,
                                                        max(case dataFieldObjectId 
                                                            when 100760 then sra.dataFieldOptionObjectId 
                                                        end) expr_150 ,
                                                        max(case dataFieldObjectId 
                                                            when 101205 then sra.dataFieldOptionObjectId 
                                                        end) expr_151 ,
                                                        max(case dataFieldObjectId 
                                                            when 101204 then sra.dataFieldOptionObjectId 
                                                        end) expr_152 ,
                                                        max(case dataFieldObjectId 
                                                            when 101203 then sra.dataFieldOptionObjectId 
                                                        end) expr_153 ,
                                                        max(case dataFieldObjectId 
                                                            when 104888 then sra.dataFieldOptionObjectId 
                                                        end) expr_154 ,
                                                        max(case dataFieldObjectId 
                                                            when 104889 then sra.dataFieldOptionObjectId 
                                                        end) expr_155 ,
                                                        max(case dataFieldObjectId 
                                                            when 103596 then sra.dataFieldOptionObjectId 
                                                        end) expr_156 ,
                                                        max(case dataFieldObjectId 
                                                            when 103599 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_157 ,
                                                        max(case dataFieldObjectId 
                                                            when 103601 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_158 ,
                                                        max(case dataFieldObjectId 
                                                            when 103602 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_159 ,
                                                        max(case dataFieldObjectId 
                                                            when 103603 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_160 ,
                                                        max(case dataFieldObjectId 
                                                            when 103611 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_161 ,
                                                        max(case dataFieldObjectId 
                                                            when 103613 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_162 ,
                                                        max(case dataFieldObjectId 
                                                            when 103614 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_163 ,
                                                        max(case dataFieldObjectId 
                                                            when 103615 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_164 ,
                                                        max(case dataFieldObjectId 
                                                            when 103751 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_165 ,
                                                        max(case dataFieldObjectId 
                                                            when 103752 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_166 ,
                                                        max(case dataFieldObjectId 
                                                            when 103753 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_167 ,
                                                        max(case dataFieldObjectId 
                                                            when 103754 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_168 ,
                                                        max(case dataFieldObjectId 
                                                            when 104098 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_169 ,
                                                        max(case dataFieldObjectId 
                                                            when 103755 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_170 ,
                                                        max(case dataFieldObjectId 
                                                            when 103756 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_171 ,
                                                        max(case dataFieldObjectId 
                                                            when 103757 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_172 ,
                                                        max(case dataFieldObjectId 
                                                            when 103758 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_173 ,
                                                        max(case dataFieldObjectId 
                                                            when 103616 then sra.dataFieldOptionObjectId 
                                                        end) expr_174 ,
                                                        max(case dataFieldObjectId 
                                                            when 103620 then sra.dataFieldOptionObjectId 
                                                        end) expr_175 ,
                                                        max(case dataFieldObjectId 
                                                            when 103621 then sra.dataFieldOptionObjectId 
                                                        end) expr_176 ,
                                                        max(case dataFieldObjectId 
                                                            when 103641 then c.objectId 
                                                        end) expr_177 ,
                                                        max(case dataFieldObjectId 
                                                            when 104942 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_178 ,
                                                        max(case dataFieldObjectId 
                                                            when 104943 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_179 ,
                                                        max(case dataFieldObjectId 
                                                            when 104944 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_180 ,
                                                        max(case dataFieldObjectId 
                                                            when 104945 then CAST(sra.booleanValue AS TINYINT) 
                                                        end) expr_181 ,
                                                        max(case dataFieldObjectId 
                                                            when 104959 then sra.dataFieldOptionObjectId 
                                                        end) expr_182 ,
                                                        max(case dataFieldObjectId 
                                                            when 104962 then sra.dataFieldOptionObjectId 
                                                        end) expr_183 ,
                                                        max(case dataFieldObjectId 
                                                            when 104963 then sra.dataFieldOptionObjectId 
                                                        end) expr_184 ,
                                                        max(case dataFieldObjectId 
                                                            when 104961 then sra.dataFieldOptionObjectId 
                                                        end) expr_185 ,
                                                        max(case dataFieldObjectId 
                                                            when 59101 then sra.dataFieldOptionObjectId 
                                                        end) expr_189
                                                        
                                                  


                                                    from
                                                        SurveyResponseAnswer sra 
                                                    left outer join
                                                        Comment c 
                                                            on c.surveyResponseAnswerObjectId = sra.objectId 
                                                    group by
                                                        surveyResponseObjectId 
                                                ) as AnswerPivot 
                                                    on AnswerPivot.surveyResponseObjectId = SurveyResponse.objectId 
                                            inner join
                                                Offer 
                                                    on Offer.objectId=SurveyResponse.offerObjectId 
                                            inner join
                                                FeedbackChannel 
                                                    on FeedbackChannel.objectId=Offer.channelObjectId 
                                            where
                                                Location.hidden = 0 
                                                and SurveyResponse.complete = 1 
                                                and Location.organizationObjectId = 1030 
                                                and (
                                                    SurveyResponse.beginDate between @begindt and @enddt
                                                ) 
                                                and (
                                                    FeedbackChannel.objectId in (
                                                        970
                                                    ) 
                                                ) 
                                                and (
                                                    SurveyResponse.objectId in (
                                                        select
                                                            surveyResponseObjectId 
                                                        from
                                                            SurveyResponseAnswer 
                                                        where
                                                            dataFieldOptionObjectId in (
                                                                152002,152004,151999,151997,152000,152003,151998,152001,152005
                                                            )
                                                    ) 
                                                ) 
                                                and (
                                                    cat7930.locationCategoryObjectId in (
                                                        125821,
                                                        125820,
                                                        125819,
                                                        125818                 
                                                    ) 
                                                ) 
                                                                                              and SurveyResponse.exclusionReason = 0 
                                                
                                                                )as a 

                
                        select * from _WG_RawDataOKfiles --where deptRated=-1
                        select * from _WG_RawDataOKfiles where expr_2='EASTERN'
                                                select * from _WG_RawDataOKfiles where expr_2='SOUTHERN'
                                                select * from _WG_RawDataOKfiles where expr_2='MIDWEST'
                                                select * from _WG_RawDataOKfiles where expr_2='WESTERN'
   
    
  
                                            order by
                                                SurveyResponseobjectId ; ; if OBJECT_ID(N'tempdb..#cat7933',
                                                N'U') IS NOT NULL drop table #cat7933; ; if OBJECT_ID(N'tempdb..#cat7930',
                                                N'U') IS NOT NULL drop table #cat7930; ; if OBJECT_ID(N'tempdb..#cat7931',
                                                N'U') IS NOT NULL drop table #cat7931; ; if OBJECT_ID(N'tempdb..#cat7932',
                                                N'U') IS NOT NULL drop table #cat7932; ; if OBJECT_ID(N'tempdb..#cat8970',
                                                N'U') IS NOT NULL drop table #cat8970;
 /*
 select distinct expr_2 from  _WG_RawDataOKfiles                       
 select * from _WG_RawDataOKfiles where expr_2='eastern'
 select * from _WG_RawDataOKfiles where expr_2='southern'
 select * from _WG_RawDataOKfiles where expr_2='midwest'
 select * from _WG_RawDataOKfiles where expr_2='western'
*/
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
