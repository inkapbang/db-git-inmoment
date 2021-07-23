SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*  
  
USE warehouse  
  
*/  

--ALTER Procedure sp_BackFillOptionsAutoDeliver_CsvPortion
  
CREATE PROCEDURE sp_BackFillOptionsAutoDeliver_CsvPortion

AS  
   
DECLARE @dataFieldId01		bigInt
		,  @dataFieldId02	bigInt
		,  @dataFieldId03	bigInt
		,  @dataFieldId04	bigInt
		,  @dataFieldId05	bigInt

SET		@dataFieldId01	= ( SELECT value	FROM ##dataFieldId01 )
SET		@dataFieldId02	= ( SELECT value	FROM ##dataFieldId02 )  
SET		@dataFieldId03	= ( SELECT value	FROM ##dataFieldId03 )  
SET		@dataFieldId04	= ( SELECT value	FROM ##dataFieldId04 )
SET		@dataFieldId05	= ( SELECT value	FROM ##dataFieldId05 )


     
SELECT 
		REPLACE( t01.name, ',', ' ')					AS [DataField Name]
		, t01.objectId									AS [DataField Id]
		, t02.objectId									AS [DataFieldOption Id] 
		, REPLACE( t02.name, ',', ' ')					AS [DataFieldOption Name] 
		, t02.Sequence  
		, t02.ScorePoints
		, t02.Version  
		, t02.LabelObjectId			
		, t02.OrdinalLevel	
		 
FROM  
		DataField				t01		WITH (NOLOCK)
	JOIN	
		DataFieldOption			t02		WITH (NOLOCK)		
			ON t01.objectId = t02.dataFieldObjectId
		  
WHERE  
		dataFieldObjectId IN ( @dataFieldId01, @dataFieldId02, @dataFieldId03, @dataFieldId04, @dataFieldId05 ) 

ORDER BY 
		dataFieldObjectId 	 
		, sequence
		


		      
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
