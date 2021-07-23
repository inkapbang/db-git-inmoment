SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[usp_temp_CreateOrUpdateSurveyMessage] 
	@localeKey varchar(50),
	@key varchar(255),
	@value nvarchar(max)
as
BEGIN
	IF NOT EXISTS (select [value] from [dbo].[SurveyMessage] where [locale]=@localeKey and [key]=@key)
		BEGIN
			INSERT INTO [dbo].[SurveyMessage]
					   ([version]
					   ,[key]
					   ,[locale]
					   ,[value])
				 VALUES
					   (0
					   ,@key
					   ,@localeKey
					   ,@value);
		END
	ELSE
		BEGIN
			UPDATE [dbo].[SurveyMessage]
			SET
				[version] = [version] + 1
				,[value] = @value
			WHERE
				[locale]=@localeKey 
				and [key]=@key
		END
END

EXEC [dbo].[usp_temp_CreateOrUpdateSurveyMessage] 'en', 'ws2.errorPage.expired.contactUs', N'<div class="ib">If you feel this is a mistake, please contact us at:</div><div class="circle"><span aria-hidden="true" data-icon="&#xeba5;" class="down-arrow"></span></div><a href="mailto:support@inmoment.com">support@inmoment.com<a>';	
EXEC [dbo].[usp_temp_CreateOrUpdateSurveyMessage] 'en', 'ws2.errorPage.taken.contactUs', N'<div class="ib">If you feel we''re mistaken, please contact us at:</div><div class="circle"><span aria-hidden="true" data-icon="&#xeba5;" class="down-arrow"></span></div><a href="support@inmoment.com">support@inmoment.com<a>';	
EXEC [dbo].[usp_temp_CreateOrUpdateSurveyMessage] 'en', 'ws2.errorPage.gateway.contactUs', N'<div class="ib">If the problem persists, please contact us at</div><div class="circle"><span aria-hidden="true" data-icon="&#xeba5;" class="down-arrow"></span></div><a href="mailto:support@inmoment.com">support@inmoment.com<a>';	
EXEC [dbo].[usp_temp_CreateOrUpdateSurveyMessage] 'en', 'ws2.errorPage.inProgress.contactUs', N'<div class="ib">If you feel we''re mistaken, please contact us at:</div><div class="circle"><span aria-hidden="true" data-icon="&#xeba5;" class="down-arrow"></span></div><a href="support@inmoment.com">support@inmoment.com<a>';	
EXEC [dbo].[usp_temp_CreateOrUpdateSurveyMessage] 'sr', 'ws2.errorPage.inProgress.contactUs', N'<div class="ib"> Ako smatrate da grešimo, kontaktirajte nas na: </div><div class="circle"><span aria-hidden="true" data-icon="" class="down-arrow"></span></div> <a href="support@inmoment.com">support@inmoment.com</a>';	


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_temp_CreateOrUpdateSurveyMessage]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp_temp_CreateOrUpdateSurveyMessage]
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
