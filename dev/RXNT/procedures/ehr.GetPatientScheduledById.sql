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
CREATE PROCEDURE [ehr].[GetPatientScheduledById]
	@ScheduledEventId	INT
AS 
BEGIN 	
	SELECT * FROM scheduled_events WITH(NOLOCK) WHERE se_id=@ScheduledEventId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
