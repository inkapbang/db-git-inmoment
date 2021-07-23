SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create view tmp_ikpbang_actionvote_ct_i as
select a.objectId,a.vote,a.actionObjectId,a.unitObjectId,a.version,a.userAccountObjectId,a.createdDateTime from ActionVote a inner join tmp_ikpbang_actionvote_ct t on a.objectId = t.objectId 
where	t.SYS_CHANGE_OPERATION = 'I';
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
