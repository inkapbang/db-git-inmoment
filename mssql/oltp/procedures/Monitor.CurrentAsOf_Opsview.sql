SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE procedure [Monitor].[CurrentAsOf_Opsview]
(@warning int, @critical int)
AS
--warning and critical are the number of minutes SQL can be behind before we are alerted
DECLARE @diff int
select @diff = DATEDIFF(minute,(select top 1 CurrentAsOf from CurrentAsOf),getdate())

IF (@diff > @warning and @diff < @critical)
Select 'Replication delay: '+ cast(@diff as varchar)+' |  ''replication delay''='+ cast(@diff as varchar) as output, 1 as stateValue

IF (@diff > @critical)
Select 'Replication delay: '+ cast(@diff as varchar)+' | ''replication delay''='+ cast(@diff as varchar) as output, 2 as stateValue

IF (@diff < @warning)
Select 'Replication delay: '+ cast(@diff as varchar)+' | ''replication delay''='+ cast(@diff as varchar) as output, 0 as stateValue
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
