SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Proc [dbo].[usp_cust_mcd_RestraurantSurveyReport3_master] as
set ansi_warnings off
declare @alertMessage VARCHAR(2000), @delim char(1)
	SET @delim = CHAR(9)
SET @alertMessage =
		'MCD Restraurant Survey Report yesterday'
		
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Alert', 
		@recipients = 'bluther@mshare.net;apark@mshare.net',
		@subject = 'RestraurantSurveyReport for yesterday',
		@body = 'The attached file contains RestraurantSurveyReport',
		@query = 'exec dbo.usp_cust_mcd_RestaurantSurveyReport3',
		@query_result_width = 32767,
		@exclude_query_output = 1,
		@execute_query_database = 'mindshare',
		@attach_query_result_as_file = 1,
		@query_result_separator = @delim,
		@query_attachment_filename = 'RestraurantSurveyReport.csv',
		@importance = 'Normal'

--exec [dbo].[usp_cust_mcd_RestraurantSurveyReport3_master]

--------
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
