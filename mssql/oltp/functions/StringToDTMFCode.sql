SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
create  function StringToDTMFCode(@str varchar(1000))
returns varchar(1000)
as
begin
	declare @dtmf varchar(1000);
	declare @pos int
	declare @ascii int
	declare @ch char(1)
	set @dtmf = ''
	set @pos = 1
	set @str = lower(@str)
	while @pos <= len(@str)
	begin
		set @ch = substring(@str, @pos, 1)
		set @ascii = ascii(@ch)
		if (@ascii > 32)
		begin
			set @dtmf = @dtmf +
				case 
					when @ascii between 48 and 57 then @ch
					when @ascii between 97 and 99 then '2'
					when @ascii between 100 and 102 then '3'
					when @ascii between 103 and 105 then '4'
					when @ascii between 106 and 108 then '5'
					when @ascii between 109 and 111 then '6'
					when @ascii between 112 and 115 then '7'
					when @ascii between 116 and 118 then '8'
					when @ascii between 119 and 122 then '9'
					else '*'
				end
		end
		set @pos = @pos + 1
	end
	return (@dtmf)
end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
