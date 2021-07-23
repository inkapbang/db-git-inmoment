SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[caesars_import_AF_data]


as

/*

	usage:

	exec caesars_import_AF_data

*/

set nocount on


begin 


/*
	drop index _Caesars_SurveyResponse.idx

	drop index _Caesars_SurveyResponseAnswer.idxx

	create clustered index idx on _Caesars_SurveyResponse(objectId)

	create clustered index idxx on [_Caesars_SurveyResponseAnswer](surveyResponseObjectId)
*/



declare @responseid int, @surveyResponseObjectId int, @maxId int, @cnt int, @ReplDiff int

set @cnt = 1
select @responseid = MIN(objectId), @maxId = max(objectId) from dbo._Caesars_SurveyResponse --where NewResponseObjectId is null 



while (@responseid <= @maxId)


		begin
 
  
			begin tran Caesars_responses
 
 
			insert SurveyResponse([surveyGatewayObjectId], [ani], [beginDate], [complete], [surveyObjectId], [dateOfService], [redemptionCode], [employeeCode], [oldEmployeeCode], [beginTime], [minutes], [instantAlertSent], [version], [modeType], [loyaltyNumber], [cookieUID], [externalId], [externalCallRecordingId], [IPAddress], [assignedUserAccountObjectId], [isRead], [beginDateUTC], [exclusionReason], [locationObjectId], [offerObjectId], [offerCode], [lastModTime], [reviewOptIn], [uuid], [fingerprint], [deviceType], [deviceTypeValue], [redemptionCodeVal], [language], [responseSourceObjectId], [contactId]) 
			select [surveyGatewayObjectId], [ani], [beginDate], [complete], [surveyObjectId], [dateOfService], [redemptionCode], [employeeCode], [oldEmployeeCode], [beginTime], [minutes], [instantAlertSent], [version], [modeType], [loyaltyNumber], [cookieUID], [externalId], [externalCallRecordingId], [IPAddress], [assignedUserAccountObjectId], [isRead], [beginDateUTC], [exclusionReason], [locationObjectId], [offerObjectId], [offerCode], [lastModTime], [reviewOptIn], [uuid], [fingerprint], [deviceType], [deviceTypeValue], [redemptionCodeVal], [language], [responseSourceObjectId], [contactId]
			from dbo._Caesars_SurveyResponse where objectid = @responseId



			if (@@ERROR <> 0)
			begin

				print 'error... rollback'
				rollback tran Caesars_responses
    
			end
  
			select @surveyResponseObjectId = SCOPE_IDENTITY()
  
			INSERT SurveyResponseAnswer([surveyResponseObjectId], [binaryContentObjectId], [sequence], [numericValue], [textValue], [dateValue], [booleanValue], [version], [dataFieldObjectId], [dataFieldOptionObjectId], [encrypted], [encryptiontype]) 
			select @surveyResponseObjectId, [binaryContentObjectId], [sequence], [numericValue], [textValue], [dateValue], [booleanValue], [version], [dataFieldObjectId], [dataFieldOptionObjectId], [encrypted], [encryptiontype]
			from dbo.[_Caesars_SurveyResponseAnswer] where [surveyResponseObjectId] = @responseId
  

			if (@@ERROR <> 0)
			begin

				print 'error... rollback'
				rollback tran Caesars_responses
    
			end
    
			update dbo._Caesars_SurveyResponse
			set NewResponseObjectId = @surveyResponseObjectId
			where objectid = @responseid
  

			if (@@ERROR <> 0)
			begin

				print 'error... rollback'
				rollback tran Caesars_responses
    
			end
  
  
			commit tran Caesars_responses
  
			print @cnt

			----SELECT @ReplDiff = max(DATEDIFF(SECOND,CurrentAsOf,GETDATE())) FROM PutWh01.JobServerDb.dbo.ProductionDetailsCurrentAsOf with (nolock) WHERE ReportingEnabled = 1 and Eligible = 1
	
			----print @ReplDiff

			----while @ReplDiff > 120
			----begin
			----	print 'Waiting'
			----	waitfor delay '00:0:01'
			----	SELECT @ReplDiff = max(DATEDIFF(SECOND,CurrentAsOf,GETDATE())) FROM PutWh01.JobServerDb.dbo.ProductionDetailsCurrentAsOf with (nolock) WHERE ReportingEnabled = 1 and Eligible = 1
			----end

  
			if (@cnt%1000 = 0) 
			begin
				print 'Pause'
				waitfor delay '00:05:00'

			end
  
			select @responseid = MIN(objectId) from _Caesars_SurveyResponse where objectid > @responseid
			set @cnt = @cnt+1


  
		end 


end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
