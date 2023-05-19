SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE ScheduledEventDeletion  
(  
 @drId int,  
 @reason varchar(1000),  
 @eventId int  
)  
AS  
 
BEGIN  

 UPDATE scheduler_main  
 SET is_delete_attempt = 1 
 where event_id = @eventId
 and recurrence = ''
   
 INSERT INTO scheduler_deletion_log(dr_id,deletion_date,reason,event_id)  
 VALUES(@drId,GETDATE(),@reason,@eventId)   

END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
