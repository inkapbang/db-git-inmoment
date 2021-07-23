SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[FixRefIntegVios] as
BEGIN
		create table #Vios (
				rId int not null,
				rcId int not null,
				labelId int not null,
				rccId int not null
		);

		insert into #Vios
				select rId, rcId, labelId, rccId from (
						select
								rc.pageObjectId rId,
								rc.objectid rcId,
								rc.labelObjectId labelId,
								rcc.objectid rccId,
								rc1.objectid rc1Id,
								rc2.objectid rc2Id
						from ReportColumnComputation rcc
						join ReportColumn rc on rc.columnComputationObjectId = rcc.objectId
						left outer join ReportColumn rc1 on rcc.colAColumnObjectId = rc1.objectid
						left outer join ReportColumn rc2 on rcc.colBColumnObjectId = rc2.objectid
				) as dt
				where rc1Id is null or rc2Id is null;

		declare vioCursor cursor local for
				select rId, rcId, labelId, rccId from #Vios;

		declare @rId int;
		declare @rcId int;
		declare @labelId int;
		declare @rccId int;

		open vioCursor
		fetch next from vioCursor into @rid, @rcId, @labelid, @rccId;

		while @@fetch_status = 0
		begin
				update ReportColumn with (rowlock)
				set columnComputationObjectId = null
				where objectId = @rcId;

				delete from ReportColumnComputation with (rowlock)
				where objectId = @rccId;

				delete from ReportColumn with (rowlock)
				where objectId = @rcId;

				delete from LocalizedStringValue with (rowlock)
				where localizedStringObjectId = @labelId;

				delete from LocalizedString with (rowlock)
				where objectId = @labelId;

				exec ResequenceColumns @rId;

				fetch next from vioCursor into @rid, @rcId, @labelid, @rccId;
		end

		close vioCursor;
		deallocate vioCursor;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
