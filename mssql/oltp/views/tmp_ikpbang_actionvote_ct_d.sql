SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view tmp_ikpbang_actionvote_ct_d as
select objectId from tmp_ikpbang_actionvote_ct t 
where	t.SYS_CHANGE_OPERATION = 'D';
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
