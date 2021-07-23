SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc usp_admin_deleteAnswer @surveyResponseAnswerId int
as
begin
   declare @srId int
   declare @srSequence int
   select @srId = sra.surveyResponseObjectId, @srSequence=sra.sequence from SurveyResponseAnswer sra where sra.objectId=@surveyResponseAnswerId

   if @srId is not null and @srSequence is not null
   begin
      begin tran
      delete SurveyResponseAnswer where objectId=@surveyResponseAnswerId
      if @@rowcount=1
      begin
         commit tran
         update SurveyResponseAnswer set sequence=sequence-1 where surveyResponseObjectId=@srId and sequence>@srSequence
      end
      else
         rollback tran 
   end
   else
      select 'Could not find survey response answer id ' + cast(@surveyResponseAnswerId as varchar) [Error]
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
