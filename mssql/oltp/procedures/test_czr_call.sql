SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc test_czr_call

as

select GETDATE() [ts], 'Tim' [name] into __czr_test_call 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
