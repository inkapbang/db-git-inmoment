SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [dbo].[ResequenceColumns] (@pageId as int) as
BEGIN
        declare seqCursor cursor local for
                select
                        objectId,
                        row_number() over(order by sequence) - 1 as rowNum
                from ReportColumn with (nolock)
                where pageObjectId = @pageId;

        declare @columnId int;
        declare @sequence int;

        open seqCursor;
        fetch next from seqCursor into @columnId, @sequence;

        while @@fetch_status = 0
        begin
                update ReportColumn with (rowlock)
                set sequence = @sequence
                where objectId = @columnId;

                fetch next from seqCursor into @columnId, @sequence;
        end;

        close seqCursor;
        deallocate seqCursor;
END;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
