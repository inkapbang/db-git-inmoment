SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE trigger [etl].[updateTimes] on [etl].[semaphore] after insert, delete 
NOT FOR REPLICATION
as 
insert into etl.semaphoretimes
select Id, GETDATE() from inserted

delete from etl.semaphoretimes where id in (select id from deleted)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

ENABLE TRIGGER [etl].[updateTimes] ON [etl].[semaphore]
GO

GO
