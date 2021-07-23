SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create proc ConvertSurveyResponse
as
begin

		-- define our ranges
		declare @spr1999 datetime
		declare @aut1999 datetime
		declare @spr2000 datetime
		declare @aut2000 datetime	
		declare @spr2001 datetime
		declare @aut2001 datetime
		declare @spr2002 datetime
		declare @aut2002 datetime	
		declare @spr2003 datetime
		declare @aut2003 datetime
		declare @spr2004 datetime
		declare @aut2004 datetime	
		declare @spr2005 datetime
		declare @aut2005 datetime
		declare @spr2006 datetime
		declare @aut2006 datetime	
		declare @spr2007 datetime
		declare @aut2007 datetime
		declare @spr2008 datetime
		declare @aut2008 datetime	

		set @spr1999 = 'Apr 4, 1999 3:00:00 AM'
		set @aut1999 = 'Oct 31, 1999 2:00:00 AM'
		set @spr2000 = 'Apr 2, 2000 3:00:00 AM'
		set @aut2000 = 'Oct 29, 2000 2:00:00 AM'	
		set @spr2001 = 'Apr 1, 2001 3:00:00 AM'
		set @aut2001 = 'Oct 28, 2001 2:00:00 AM'
		set @spr2002 = 'Apr 7, 2002 3:00:00 AM'
		set @aut2002 = 'Oct 27, 2002 2:00:00 AM'	
		set @spr2003 = 'Apr 6, 2003 3:00:00 AM'
		set @aut2003 = 'Oct 26, 2003 2:00:00 AM'
		set @spr2004 = 'Apr 4, 2004 3:00:00 AM'
		set @aut2004 = 'Oct 31, 2004 2:00:00 AM'	
		set @spr2005 = 'Apr 3, 2005 3:00:00 AM'
		set @aut2005 = 'Oct 30, 2005 2:00:00 AM'
		set @spr2006 = 'Mar 11, 2006 3:00:00 AM'
		set @aut2006 = 'Oct 29, 2006 2:00:00 AM'	
		set @spr2007 = 'Mar 9, 2007 3:00:00 AM'
		set @aut2007 = 'Nov 4, 2007 2:00:00 AM'
		set @spr2008 = 'Mar 8, 2008 3:00:00 AM'
		set @aut2008 = 'Nov 1, 2009 2:00:00 AM'	

		update SurveyResponse
			set beginDateUTC = case when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr1999 and @aut1999 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2000 and @aut2000 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2001 and @aut2001 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2002 and @aut2002 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2003 and @aut2003 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2004 and @aut2004 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2005 and @aut2005 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2006 and @aut2006 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2007 and @aut2007 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              when (dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))) between @spr2008 and @aut2008 then dateadd(hh,6,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
								              else dateadd(hh,7,(dateadd(dd,0, datediff(dd,0,beginDate)) + (isnull(beginTime,beginDate)-dateadd(dd,0, datediff(dd,0,isnull(beginTime,beginDate))))))
							         		end;

end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
