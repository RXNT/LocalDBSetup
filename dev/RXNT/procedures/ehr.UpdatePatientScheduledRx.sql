SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Niyaz
Create date			: 10th-Sep-2018
Description			: 
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [ehr].[UpdatePatientScheduledRx]
	@ScheduledEventId	INT,
	@FirstFireDate DATETIME,
	@NextFireDate DATETIME,
	@ScheduledEventType BigInt,
	@EventText VARCHAR(100),
	@FireCount BIGINT,
	@RepeatUnit VARCHAR(20),
	@RepeatCount BIGINT,
	@RepeatInterval BIGINT,
	@ScheduledEventFlags BIGINT
	
	
AS 
BEGIN 	
	IF ISNULL(@ScheduledEventId,0) > 0
	BEGIN
		UPDATE scheduled_events 
			SET 
			first_fire_date = @FirstFireDate,
			next_fire_date = @NextFireDate,
			event_type = @ScheduledEventType,
			fire_count = @FireCount,
			repeat_unit = @RepeatUnit,
			repeat_interval = @RepeatInterval,
			repeat_count = @RepeatCount,
			event_flags = @ScheduledEventFlags 
			WHERE se_id = @ScheduledEventId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
