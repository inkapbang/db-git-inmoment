SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[_LastLogin_cap67] @orgId int 
	-- Add the parameters for the stored procedure here

AS
BEGIN

	IF exists (select * from sys.tables where name = '_lastLogin')
		truncate TABLE oltp.[dbo].[_lastLogin]
	ELSE
		CREATE TABLE oltp.[dbo].[_lastLogin]
		(		
			[objectId] [int] NOT NULL,
			[email] [varchar](100) NOT NULL,
			[lastname] [nvarchar](50) NOT NULL,
			[firstname] [nvarchar](50) NOT NULL,
			[Enabled] [varchar](3) NOT NULL,
			[InMoment Employee] [varchar](3) NOT NULL,
			[lastLogin] [datetime] NULL,
			[lastLogin2] [datetime] NULL,
			[orgId] [int] NOT NULL
		)


	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert oltp.[dbo].[_lastLogin]
	select ua.objectId, ua.email, ua.lastname, ua.firstname
	, case when ua.enabled = 1 then 'Yes' else 'No' end as [Enabled]
	, case when ua.mindshareemployee = 1 then 'Yes' else 'No' end as [InMoment Employee]
	, ua.lastLogin
	, null as lastLogin2
	, @orgId as orgId
	from useraccount (nolock) ua
	inner join organizationuseraccount (nolock) oua on oua.useraccountobjectid = ua.objectid
	where oua.organizationobjectid = @orgId
	and ua.enabled = 1
	union
	select ua.objectId, ua.email, ua.lastname, ua.firstname
	, case when ua.enabled = 1 then 'Yes' else 'No' end as [Enabled]
	, case when ua.mindshareemployee = 1 then 'Yes' else 'No' end as [InMoment Employee]
	, ua.lastLogin
	, null as lastLogin2
	, @orgId as orgId
	from useraccount (nolock) ua
	inner join useraccountlocationcategory (nolock) ualc on ualc.useraccountobjectid = ua.objectid
	inner join locationcategory (nolock) lc on lc.objectid = ualc.locationcategoryobjectid
	where lc.organizationobjectid = @orgId
	and ua.enabled = 1
	union
	select ua.objectId, ua.email, ua.lastname, ua.firstname
	, case when ua.enabled = 1 then 'Yes' else 'No' end as [Enabled]
	, case when ua.mindshareemployee = 1 then 'Yes' else 'No' end as [InMoment Employee]
	, ua.lastLogin
	, null as lastLogin2
	, @orgId as orgId
	from useraccount (nolock) ua
	inner join useraccountlocation (nolock) ual on ual.useraccountobjectid = ua.objectid
	inner join location (nolock) l on l.objectid = ual.locationobjectid
	where l.organizationobjectid = @orgId
	and ua.enabled = 1
	
	
	
	select a.objectId,MAX(b.timestamp) as lastLogin
	into #accessLog
	from oltp.[dbo].[_lastLogin] a join AccessEventLog b (nolock) on (a.objectId=b.userAccountObjectId)
	group by a.objectId
	
	
	update a
	set a.lastLogin2=b.lastLogin
	from oltp.[dbo].[_lastLogin] a inner join #accessLog b (nolock) on (a.objectId=b.objectId)
			
	
	--select * from oltp.[dbo].[_lastLogin]
	
	
	select orgId as organizationobjectId
	,firstName	
	,lastName
	,convert(varchar, max(lastLogin2), 102) as lastLoginDate
	from oltp.[dbo].[_lastLogin]
	where [InMoment Employee]='No'
	group by orgId 
	,firstName	
	,lastName
	order by 3
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
