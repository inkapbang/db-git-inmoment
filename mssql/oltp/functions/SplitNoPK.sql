SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[SplitNoPK](@string varchar(max), @delimiter char(1))
RETURNS @Results TABLE (token varchar(200))
AS
BEGIN
      DECLARE @len INT
      SET @len = LEN(@string)
      IF @len = 0
            RETURN

      DECLARE @leftIndex INT
      DECLARE @rightIndex INT
      DECLARE @token VARCHAR(max)

      SET @leftIndex = 1
      SET @rightIndex =CHARINDEX(@delimiter, @string, @leftIndex)

      IF (@rightIndex = 0) -- No delimiter at all
      BEGIN
            INSERT INTO @Results (token) VALUES (@string)
            RETURN
      END

      WHILE (@leftIndex <= @len)
      BEGIN
            SET @token = SUBSTRING(@string, @leftIndex, @rightIndex - @leftIndex)
            INSERT INTO @Results(token) VALUES (CASE  WHEN LEN(@token) > 0 THEN @token ELSE NULL END)

            SET @leftIndex = @rightIndex + 1

            SET @rightIndex = CHARINDEX(@delimiter, @string, @leftIndex)
            IF (@rightIndex = 0)
                  SET @rightIndex = @len+1
      END
      RETURN

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
