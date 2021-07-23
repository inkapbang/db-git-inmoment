SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[getFreemanGlobalOptOut] 
AS
-- Created: IW 
BEGIN

	SET NOCOUNT ON;
	
	
	Declare @OptOutfilename varchar(50)
	DECLARE @FileNameBulkInsertStatement	nvarchar(2000)
	DECLARE	@FileName	varchar(100),@contactInfo varchar(255)
	DECLARE @Total int,@campaignId int
	
	SELECT @OptOutfilename ='Global Opt-Out '+cast(datepart(mm,dateadd(dd,-1,GETDATE())) as varchar)+'-'+cast(datepart(dd,dateadd(dd,-1,GETDATE())) as varchar)+'-'+cast(substring(convert(varchar ,datepart(yy,dateadd(dd,-1,GETDATE()))),3,2) as varchar)
	+' - '+cast(datepart(mm,dateadd(dd,-1,GETDATE())) as varchar)+'-'+cast(datepart(dd,dateadd(dd,-1,GETDATE())) as varchar)+'-'+cast(substring(convert(varchar ,datepart(yy,dateadd(dd,-1,GETDATE()))),3,2) as varchar)
	+'.csv'

	select @OptOutfilename
	
	
	IF EXISTS(SELECT 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'_FreemanGlobalOptOut') AND type = (N'U'))    DROP TABLE _FreemanGlobalOptOut
	CREATE TABLE _FreemanGlobalOptOut
			(
				Column_1	varchar(50),
				Column_2	varchar(255))
				
	--set @FileName='Test2.csv'	
	set @FileName='Global Opt-Out 6-13-17 - 6-13-17.csv'
	
	select @FileName
	
            		
	SET		@FileNameBulkInsertStatement	= 'BULK INSERT _FreemanGlobalOptOut	FROM ''c:\data\FreemanGlobal\'+ @FileName + ''' WITH ( FIRSTROW = 3, FIELDTERMINATOR = '','' )'

	EXECUTE (@FileNameBulkInsertStatement)	
	
	--select * from _FreemanGlobalOptOut
	
	select @Total=COUNT(*) from _FreemanGlobalOptOut where Column_2 is not null
	
	if @Total>0
	  begin
		 update _FreemanGlobalOptOut
		 set Column_1=1926
		 
			declare rtCursor CURSOR FOR
	
			select cast(b.objectId as int) [campaignId],a.Column_2 as contactInfo
			from _FreemanGlobalOptOut a (nolock) join Campaign b (nolock)on (a.Column_1=b.organizationObjectId)
			where b.organizationObjectId=1926 and b.name not in ('Alford')
			and a.column_2 is not null 
			and a.column_2='jgarnett@board.com'
					
			open rtCursor
			fetch next from rtCursor into @campaignId,@contactInfo
			while @@FETCH_STATUS=0
			begin
					If not exists (select 1 from [_DBA4531_CampaignUnsubscribe] where campaignObjectId=@campaignId and contactInfo=@contactInfo)
					 begin				
					
						begin transaction Insert_CampaignUnsubscribe	
							
							INSERT INTO [_DBA4531_CampaignUnsubscribe]
						   ([campaignObjectId]
						   ,[version]
						   ,[contactInfo]
						   ,[unsubscribeType]
						   ,[dateAdded])
						 VALUES
							   (@campaignId,0,@contactInfo,	1,GETDATE())
								

							if @@ERROR <> 0 
							begin
								rollback transaction Insert_CampaignUnsubscribe
							end

						commit transaction Insert_CampaignUnsubscribe
						print 'Insert into _DBA4531_CampaignUnsubscribe: ' + @contactInfo
					  end			
					
					fetch next from rtCursor into @campaignId,@contactInfo
			end
			close rtCursor
			deallocate rtCursor	 
		 
	  end
	else 
	  Return  
	   		
	
End	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
