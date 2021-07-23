SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE tmp_Add_LocalizedStringValue
@loc_value varchar(100),
@loc_key varchar(100),
@LSID int output

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into LocalizedString (version) values (0)
	select @LSID = @@identity
	if @LSID is not null
	insert into LocalizedStringValue  (localizedStringObjectId,localeKey,value) values (@LSID,@loc_key,@loc_value)

	return 0

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
