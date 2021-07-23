SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure sp_OrgId

	-- Requires input
	@orgName		varchar(255)

AS 


SELECT
		*
FROM
		Organization
WHERE
		name LIKE @orgName				
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
