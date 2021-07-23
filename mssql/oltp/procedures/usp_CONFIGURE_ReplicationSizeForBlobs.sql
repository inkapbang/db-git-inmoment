SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROC usp_CONFIGURE_ReplicationSizeForBlobs 

   @NewSize int = 100000000

/*
* Sets the 'max text repl size' instance wide configuration setting
* that governs the maximum size of an image, text, or ntext column
* in a replicated table.
*
* Example:
exec usp_CONFIGURE_ReplicationSizeForBlobs default
**********************************************************************/
AS 
    print 'Old size'
    exec sp_configure 'max text repl size' 
    
    print ' Setting new size'
    exec sp_configure 'max text repl size', @NewSize
    
    print 'Reconfiguring'
    RECONFIGURE WITH OVERRIDE
    
    print 'New size'
    exec sp_configure 'max text repl size' 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
