SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION dbo.ufn_nike_timeTextToDate(@textValue varchar(2000))  
RETURNS datetime   
AS   
BEGIN  
    DECLARE @ret datetime;

    DECLARE @textValueCleaned varchar(2000);
    SET @textValueCleaned = left(replace(rtrim(ltrim(replace(@textValue, ':',''))),' ', ''),2) + ':' + right(replace(rtrim(ltrim(replace(@textValue, ':',''))),' ', ''), len(replace(rtrim(ltrim(replace(@textValue, ':',''))),' ', ''))-2);

    IF (ISDATE(@textValueCleaned) = 1)
        SET @ret = CAST(@textValueCleaned as datetime)
    RETURN @ret;  
END; 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
