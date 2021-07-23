SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION PadLeft
(
  @PadChar char(1),
  @PadToLen int,
  @BaseString varchar(100)
)
RETURNS varchar(1000)
AS
/* ****************************************************
  Description:    
    Pads @BaseString to an exact length (@PadToLen) using the
    specified character (@PadChar).  Base string will not be 
    trimmed. Implicit type conversion should allow caller to 
    pass a numeric T-SQL value for @BaseString.
    
***************************************************** */
BEGIN
  DECLARE @Padded varchar(1000)
  DECLARE @BaseLen int
  
  SET @BaseLen = LEN(@BaseString)
  
  IF @BaseLen >= @PadToLen
    BEGIN
      SET @Padded = @BaseString
    END
  ELSE
    BEGIN
      SET @Padded = REPLICATE(@PadChar, @PadToLen - @BaseLen) + @BaseString
    END  

  RETURN @Padded
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
