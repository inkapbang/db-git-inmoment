SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE Procedure dbo.usp_maint_reindexBinarycontentOnline 
as
alter index Pk_binarycontent on binarycontent reorganize; 
alter index IX_binarycontent_transcription_contenttype_ID on binarycontent rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_binarycontent_Length on binarycontent rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_binarycontent_contenttype on binarycontent rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
alter index IX_binarycontent_by_transcription on binarycontent rebuild with (sort_in_tempdb=on,online=on,maxDOP=10);
update statistics binarycontent with fullscan;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
