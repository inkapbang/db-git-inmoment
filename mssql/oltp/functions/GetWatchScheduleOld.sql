SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[GetWatchScheduleOld] (@beginDate DATETIME, @endDate DATETIME)
RETURNS @watchSchedule TABLE (
		weekBegin DATETIME NOT NULL PRIMARY KEY,
		primaryUserAccountObjectId INT NOT NULL,
		primaryEmail VARCHAR(100) NOT NULL,
		secondaryUserAccountObjectId INT NOT NULL,
		secondaryEmail VARCHAR(100) NOT NULL)
AS
BEGIN 
	-- TODO: Replace the watch users table variable with an actual table or a role
	DECLARE @watchUsers TABLE (
		userAccountObjectId INT NOT NULL PRIMARY KEY,
		email varchar(100) NOT NULL,
		sequence INT NOT NULL)
	INSERT INTO @watchUsers VALUES (127, 'kwilliams@mshare.net', 0)

	INSERT INTO @watchUsers VALUES (6014, 'dnewbold@mshare.net', 1)
	INSERT INTO @watchUsers VALUES (68194, 'gmcclellan@mshare.net', 2)
	INSERT INTO @watchUsers VALUES (362, 'rwalker@mshare.net', 3)
	INSERT INTO @watchUsers VALUES (1119, 'jsperry@mshare.net', 4)
	INSERT INTO @watchUsers VALUES (58355, 'drobinson@mshare.net', 5)
--	INSERT INTO @watchUsers VALUES (70891, 'shart@mshare.net', 6)

	DECLARE @watchCount INT
	SELECT @watchCount = count(*) from @watchUsers

	DECLARE @weekBegin DATETIME
	SET @weekBegin = dbo.Date_WeekBegin(@beginDate, 2)
	WHILE @weekBegin <= @endDate
	BEGIN
		DECLARE @primarySequence INT, @secondarySequence INT
		--SET @primarySequence = (DATEPART(week, @weekBegin) -1) % @watchCount
		SET @primarySequence = DATEDIFF(week, '1/1/2007', @weekBegin) % @watchCount
		SET @secondarySequence = (@primarySequence + 1) % @watchCount

		INSERT INTO @watchSchedule (weekBegin, primaryUserAccountObjectId, primaryEmail, secondaryUserAccountObjectId, secondaryEmail)
			SELECT weekBegin, max(primaryUserId), max(primaryEmail), max(secondaryUserId), max(secondaryEmail)
				FROM 
					(SELECT				
						@weekBegin weekBegin,
						CASE WHEN sequence = @primarySequence THEN userAccountObjectId ELSE NULL END primaryUserId,
						CASE WHEN sequence = @primarySequence THEN email ELSE NULL END primaryEmail,
						CASE WHEN sequence = @secondarySequence THEN userAccountObjectId ELSE NULL END secondaryUserId,
						CASE WHEN sequence = @secondarySequence THEN email ELSE NULL END secondaryEmail
					FROM @watchUsers
					WHERE
						sequence IN (@primarySequence, @secondarySequence)
					) pivotTable
			GROUP BY weekBegin
		SET @weekBegin = DATEADD(week, 1, @weekBegin)
	END

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
