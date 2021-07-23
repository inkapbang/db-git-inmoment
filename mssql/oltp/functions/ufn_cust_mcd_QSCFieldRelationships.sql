SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ufn_cust_mcd_QSCFieldRelationships] ()
RETURNS @qscGroupFields TABLE (qscFieldObjectId INT, booleanGroupFieldObjectId INT, scoreFieldObjectId INT)
AS
BEGIN
	INSERT INTO @qscGroupFields VALUES (12040,13364,13003)  -- quality
	INSERT INTO @qscGroupFields VALUES (12532,13366,13005)  -- employees
	INSERT INTO @qscGroupFields VALUES (12042,13367,13004)  -- speed of service
	INSERT INTO @qscGroupFields VALUES (12043,13363,13007)  -- cleanliness
	INSERT INTO @qscGroupFields VALUES (12046,13362,13006)  -- order correct, accuracy
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
