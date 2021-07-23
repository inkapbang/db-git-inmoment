SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE TRIGGER TRIG_CANT_CHANGE_ACTIVATION_DATE 
ON RedemptionCodeCustom
FOR UPDATE
AS 
BEGIN
	DECLARE @nOldValue datetime,@nNewValue datetime, @code varchar(50), @market varchar(50)
	
	SELECT @nOldValue=deleted.activationDate, @nNewValue=inserted.activationDate, @code=inserted.redemptionCode, @market=inserted.market -- Get the Old and New values
	FROM inserted, deleted
	
	IF @nOldValue IS NOT NULL AND @nNewValue<>@nOldValue
	BEGIN
		RAISERROR('Cannot change activation date after it has already been set for %s - %s', 16,1,@market,@code);
		ROLLBACK TRAN	-- Roll Back the transaction if condition is not satisfied
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

DISABLE TRIGGER [dbo].[TRIG_CANT_CHANGE_ACTIVATION_DATE] ON [dbo].[RedemptionCodeCustom]
GO

GO
