SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[SetOfficeHours]  
@dgid BIGINT,  
@start TIME,
@end TIME,
@userId VARCHAR(500),
@modifiedDate DATETIME  
AS  
BEGIN  

  IF NOT EXISTS(SELECT 1 FROM Scheduler_OfficeHours WHERE DG_ID = @dgid)
        BEGIN
			Insert into Scheduler_OfficeHours(DG_ID,START_TIME,END_TIME,LAST_MDFD_USER,LAST_MDFD_DATE)
            values (@dgid,@start,@end,@userId,@modifiedDate)
        END
  ELSE
	BEGIN
		UPDATE Scheduler_OfficeHours
		SET START_TIME = @start,END_TIME = @end,LAST_MDFD_USER = @userId,
			LAST_MDFD_DATE = @modifiedDate
		WHERE DG_ID = @dgid
	END            
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
