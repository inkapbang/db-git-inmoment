SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
 
CREATE PROCEDURE [dbo].[usp_maint_CleanupMetadataJobResults](@daysToKeep int)
AS
BEGIN
	  -- Initial Parameter to be set at 7 as per conversation with Scott dated 12.13.2013.
 
      -- Determine the threshold date/time for keeping the items
      DECLARE @thresholdDate DATETIME;
      SET @thresholdDate = DATEADD(DAY, -@daysToKeep, GETUTCDATE());
 
      -- Build a table of the delivery queue item IDs and the delivery file IDs to be deleted
      DECLARE @ids TABLE(
            deliveryQueueObjectId INT NOT NULL,
            deliveryFileObjectId INT NOT NULL
      );
      INSERT INTO 
            @ids
      SELECT 
            dq.objectId,
            df.objectId 
      FROM 
            [Logging].[dbo].[MetadataJobLogEntry] m
            inner join [oltp].[dbo].[DeliveryQueue] dq
                  on dq.objectId = m.resultEmailId
            inner join [oltp].[dbo].[DeliveryFile] df
                  on dq.fileObjectId = df.objectId
      WHERE
            m.startTime < @thresholdDate;
            
      
      
      -- Testing      
      --SELECT *	FROM @ids
            
            
      -- Delete the emails from the delivery queue
      DELETE 
            [oltp].[dbo].[DeliveryQueue]
      FROM
            [oltp].[dbo].[DeliveryQueue] dq
            INNER JOIN @ids ids
                  on dq.objectId = ids.deliveryQueueObjectId;
 
      -- Delete the email attachments
      DELETE 
            [oltp].[dbo].[DeliveryFile]
      FROM
            [oltp].[dbo].[DeliveryFile] df
            INNER JOIN @ids ids
                  on df.objectId = ids.deliveryFileObjectId;
                  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
