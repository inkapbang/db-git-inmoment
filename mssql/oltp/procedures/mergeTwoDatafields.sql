SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE proc [dbo].[mergeTwoDatafields]( @orgId int, @sourceDatafieldId int, @destDatafieldId int )
as begin
   -- orgId is required as a 'guarantee' that we will affect only one org
   declare @checkCount int, @oldPromptCount int, @newPromptCount int
   select @checkCount = count(*) from DataField df where df.organizationObjectId=@orgId and df.objectid in (@sourceDatafieldId, @destDatafieldId)
   select @oldPromptCount = count(dfo.objectId) from DataField df inner join DataFieldOption dfo on df.objectId=dfo.dataFieldObjectId where df.organizationObjectId=@orgId and df.objectId=@sourceDatafieldId    
   select @newPromptCount = count(dfo.objectId) from DataField df inner join DataFieldOption dfo on df.objectId=dfo.dataFieldObjectId where df.organizationObjectId=@orgId and df.objectId=@destDatafieldId    

   if 2 = @checkCount and @oldPromptCount=@newPromptCount
   begin
      -- build a dynamic sql statement to merge the fields
      declare @sql varchar(2000)
      declare @s varchar(100)
      set @sql = 'update SurveyResponseAnswer with (ROWLOCK) set datafieldobjectid = ' + convert(varchar,@destDatafieldId) + ', dataFieldOptionObjectId = case dataFieldOptionObjectId '
      declare moresql cursor for 
         select 'when ' + convert(varchar,dfo.objectid) + ' then ' + convert(varchar,(select dfo2.objectId from DataField df inner join DataFieldOption dfo2 on df.objectId = dfo2.dataFieldObjectId where df.organizationObjectId=@orgId and dfo2.dataFieldObjectId=@destDatafieldId and dfo2.sequence=dfo.sequence and dfo2.scorePoints=dfo.scorePoints)) + ' '
         from DataField f
         inner join DataFieldOption dfo on dfo.dataFieldObjectId = f.objectid
         where f.objectid=@sourceDatafieldId
         order by dfo.objectid
      open moresql
      fetch next from moresql into @s
      while @@fetch_status <>-1
      begin
         select @sql = @sql + @s
         fetch next from moresql into @s
      end
      close moresql
      deallocate moresql
      select @sql = @sql + ' end where dataFieldObjectId = ' + convert(varchar,@sourceDatafieldId)

      -- execute the dynamic sql
      --begin tran
      --begin try
          exec( @sql )
         --commit tran
         --select @sql sql
      --end try
      --begin catch
         --rollback tran
         --select 'Error when attempting to merge these datafields. No data changes occured.' result
         --select 'SQL that didn''t work: ' + @sql
      --end catch
   end
   else
   begin
      select 'These datafields are not correct for this org. No data changes occured.' result
   end
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
