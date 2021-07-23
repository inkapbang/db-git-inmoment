SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
May 13 , 2019 - Modified by Isa referring DBA-7280
*/


CREATE proc [dbo].[GatewayDetailsReport]

as 

set nocount on



  select distinct 
  sg.objectId  --Isa
  ,sg.forceHttpsOnVanityUrl --Isa
  ,sgvu.certExists  --Isa
  ,o.name 'Organization'
  , o.enabled 
  , case when o.enabled = 1 then 'Enabled' when o.enabled = 0 then 'Disabled' else '' end 'Org Status'
  , dnis 'Phone Number (DNIS)'
  , case when gatewayType = 1 then 'Voice' 
  when gatewayType = 2 then 'Web'
  when gatewayType = 3 then 'Pooled Voice'
  when gatewayType = 4 then 'Web Service Voice'
  when gatewayType = 5 then 'Web Service Web'
  when gatewayType = 6 then 'Web Service Outbound'
  end 'Type'
  , case when appType = 0 then 'unassigned' 
  when appType = 1 then 'voice survey' 
  when appType = 2 then 'voice message retrieval' 
  when appType = 3 then 'web survey' 
  when appType = 4 then 'custom' end 'Application Type'
  , alias
  , sg.name 'Gateway Name'
  , sg.description
  , au.name 'Default Dialect'
  , p.name 'Failure Prompt'
  , oc.offerCode 'default Offer Code'
  , crc.name 'Contest Rules'
  , s.name 'Disabled Survey'
  , wss.name 'Web Survey Style'
  , case when webSurveyPresentationOption = 0 then 'Web Survey Themes' else 'Web Survey Styles' end 'Web Presentation'
  , case when appType = 0 then ''
  when appType = 1 then '/voicesurvey/app?service=external&page=VoiceSurveyBegin=' + dnis 
  when appType = 2 then '/voicesurvey/app?service=external&page=MessageHome' + dnis 
  when appType = 3 then '/websurvey/app?gateway=' + alias end 'Application URL'
  , c.name 'Campaign'
  , c2.name 'Campaign Type'
  , case when sgc.sequence = 0 then 'Primary' when c2.campaignType = 1 then 'Secondary' else null end 'Primary/Secondary'
  -- Isa - 20190513 - DBA-7280
  , sg.forceHttpsOnVanityUrl [forceHttps]
  --,sg.vanityUrl 
  , case when len(sg.vanityUrl)>0 then sg.vanityUrl else sgvu.url end vanityUrl
  -- TAR - 20180409 - added next lines - DBA-5967
  , case when sg.extendSurveyTimeout = 0 then 'Yes' else 'No' end as [Extend Survey Timeout]
  , case when sg.captchaType = 0 then 'None'
  when sg.captchaType = 0 then 'ReCAPTCHA'
  when sg.captchaType = 0 then 'BOTDETECT' end as [Capcha Type]
  , sg.objectid as [Gateway Database ID]
  , cast(null as varchar(10)) as [Disable IFrames (DENY)]
  , cast(null as varchar(10)) as [Force SSL]
  , cast(null as varchar(10)) as [Prevent Drive by Downloading]
  , cast(null as varchar(10)) as [Prevent X Site Download]
  -- TAR - 20180409 - added temp table
  into #output
  from SurveyGateway sg (nolock)
  left join Organization o (nolock) on sg.organizationObjectId = o.objectId
  left join audioOption au (nolock) on sg.audioOptionObjectId = au.objectId
  left join OfferCode oc (nolock) on sg.defaultOfferCodeObjectId = oc.objectId
  left join survey s (nolock) on sg.disabledLocationSurveyObjectId = s.objectId
  left join prompt p (nolock) on sg.failurePromptObjectId = p.objectId
  left join contestRulesConfig crc (nolock) on sg.contestRulesConfigObjectId = crc.objectId
  left join WebSurveyStyle wss (nolock) on wss.objectId = sg.webSurveyStyleObjectId
  left join Campaign c (nolock) on sg.campaignObjectId = c.objectId
  left join SurveyGatewayCampaign sgc (nolock) on sgc.surveyGatewayObjectId = sg.objectId
  left join Campaign c2 (nolock) on sgc.campaignObjectId = c2.objectId
  left join SurveyGatewayVanityUrl sgvu (nolock) on (sg.objectId=sgvu.surveyGatewayObjectId)
  where 1=1 -- sg.organizationObjectId = 176 and sg.alias = 'multicampaign'
  order by o.name --sg.objectId, sgc.sequence

  -- TAR - 20180409 - added this to determine advanced security options - DBA-5967
  select t.[Gateway Database Id]
  , max(t.[Disable IFrames (DENY)]) as [Disable IFrames (DENY)]
  , max(t.[Force SSL]) as [Force SSL]
  , max(t.[Prevent Drive by Downloading]) as [Prevent Drive by Downloading]
  , max(t.[Prevent X Site Download]) as [Prevent X Site Download]
  into #advancedSecurity
  from (
	  select o.[Gateway Database Id]
	  , case when agsi.advancedGatewaySecurity = 0 then 'Yes' end as [Disable IFrames (DENY)]
	  , case when agsi.advancedGatewaySecurity = 1 then 'Yes' end as [Force SSL]
	  , case when agsi.advancedGatewaySecurity = 2 then 'Yes' end as [Prevent Drive by Downloading]
	  , case when agsi.advancedGatewaySecurity = 3 then 'Yes' end as [Prevent X Site Download]
	  from #output o
	  inner join AdvancedGatewaySecurityIdentifier (nolock) agsi on agsi.gatewayobjectid = o.[Gateway Database ID]
  ) t
  group by t.[Gateway Database ID]

  update o
  set [Disable IFrames (DENY)] = isnull(a.[Disable IFrames (DENY)], '')
  , [Force SSL] = isnull(a.[Force SSL], '')
  , [Prevent Drive by Downloading] = isnull(a.[Prevent Drive by Downloading], '')
  , [Prevent X Site Download] = isnull(a.[Prevent X Site Download], '')
  from #output o
  inner join #advancedSecurity a on a.[Gateway Database ID] = o.[Gateway Database ID]
  
  --Added by Isa
  update o
  set [Force SSL]=certExists
  from #output o
  where certExists=1
  ----
  
  
  select [Organization],
	[enabled],
	[Org Status],
	[Phone Number (DNIS)],
	[Type],
	[Application Type],
	[alias],
	[Gateway Name],
	[description],
	[Default Dialect],
	[Failure Prompt],
	[default Offer Code],
	[Contest Rules],
	[Disabled Survey],
	[Web Survey Style],
	[Web Presentation],
	[Application URL],
	[Campaign],
	[Campaign Type],
	[Primary/Secondary],
	[vanityUrl],
	[forceHttps],
	[Extend Survey Timeout],
	[Capcha Type],
	[Gateway Database ID],
	[Disable IFrames (DENY)],
	[Force SSL],
	[Prevent Drive by Downloading],
	[Prevent X Site Download]
	from #output o
	--where o.Organization like 'Audi%'
  order by o.[Organization]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
