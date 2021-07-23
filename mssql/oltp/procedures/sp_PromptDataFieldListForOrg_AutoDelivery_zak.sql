SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
	


CREATE Procedure [dbo].[sp_PromptDataFieldListForOrg_AutoDelivery_zak]
 @orgId	int

		
AS

/************** Prompt and Corresponding DataField Change  **************

	Provides a list of Prompts, PromptTypes, and their corresponding
	DataFields.
	
	Executed against OLTP and any Warehouse

	Note: Executing these SP without any parameters will
	print out requirements.
	
	sp_PromptDataFieldListForOrg_AutoDelivery	@OrgId	= ''''
	
************************************************************************/

SET NOCOUNT ON 

-- Lists all Prompts and DataFields for a given Org.
SELECT
		  REPLACE(t20.name, ',', '' )				AS DataFieldName
		, t20.objectId								AS DataFieldId
		
		, t20.FieldType
		, t20.SystemField							AS SystemFieldValue
		
		, REPLACE(t10.name, ',', '' )				AS PromptName		
		, t10.objectId							AS PromptId
		
		, CASE	WHEN t10.promptType = 0		THEN 'Read Only Prompt'
				WHEN t10.promptType = 1		THEN 'Numeric Prompt'
				WHEN t10.promptType = 2		THEN 'Text Prompt'
				WHEN t10.promptType = 3		THEN 'Date Prompt'
				WHEN t10.promptType = 4		THEN 'Rating Prompt'
				WHEN t10.promptType = 5		THEN 'Comment Prompt'
				WHEN t10.promptType = 6		THEN 'Composite Text Prompt'
				WHEN t10.promptType = 7		THEN 'Logic Prompt'
				WHEN t10.promptType = 8		THEN 'Transfer Prompt'
				WHEN t10.promptType = 9		THEN 'Rating Group Prompt'
				WHEN t10.promptType = 10	THEN 'OfferCode Search Prompt'
				WHEN t10.promptType = 11	THEN 'Employee Selector Prompt'
				WHEN t10.promptType = 12	THEN '(unused) Prompt'
				WHEN t10.promptType = 13	THEN 'Time Prompt'
				WHEN t10.promptType = 14	THEN 'Boolean Prompt'
				WHEN t10.promptType = 15	THEN 'Boolean Group Prompt'
				WHEN t10.promptType = 16	THEN 'Multiple Choice Prompt'
				WHEN t10.promptType = 17	THEN 'Multiple Choice Group Prompt'
				WHEN t10.promptType = 18 THEN 'GoRecommendShareOpenTellPrompt'
				WHEN t10.promptType = 19 THEN 'CombinedTextPrompt'
				WHEN t10.promptType = 20 THEN 'ScrambledTextPrompt'
				WHEN t10.promptType = 21 THEN 'SweepstakesInstantWinPrompt'
				WHEN t10.promptType = 22 THEN '(unused)'
				WHEN t10.promptType = 23 THEN 'LocationPickerPrompt'
				WHEN t10.promptType = 24 THEN 'GoRecommendConnectPrompt'
				WHEN t10.promptType = 25 THEN 'GoRecommendShareIncentivePrompt'
				WHEN t10.promptType = 26 THEN 'CustomerInstantEmailPrompt'
				WHEN t10.promptType = 27 THEN 'ResponseSourcePrompt'
				
				
			END										AS PromptTypeDescription
		
		
		, t10.PromptType							AS PromptType
		
		
		
FROM
		Prompt		t10
	RIGHT JOIN
		DataField	t20
			ON t10.dataFieldObjectId = t20.objectId

WHERE
		t10.organizationObjectId = @OrgId
	OR
		t20.organizationObjectId = @OrgId
		
		
ORDER BY
		t10.objectId					
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
