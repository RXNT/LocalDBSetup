SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vinod
Create date			:	6-Nov-2017
Description			:	This procedure is used to get Search Inbox Messages
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ext].[usp_SearchInboxMessages] --11647,100,1

	@PatientId	BIGINT,
	@LookBackPeriod INT,
	@CompleteOrAll INT
AS
BEGIN

 IF @CompleteOrAll=1
  BEGIN 
	  SELECT [id],[from_id],[to_id],[msg_date],[message],[is_read],[is_complete],messagedigest ,
		dFrom.dr_first_name + ' ' + dFrom.dr_last_name as FromDrSource , 
		pFrom.pa_first + ' ' + pFrom.pa_last as FromPatientSource 
		FROM [dbo].[doctor_patient_messages]  
		LEFT OUTER JOIN DOCTORS dFrom ON dFrom.dr_id = from_id  
		LEFT OUTER JOIN PATIENTS pFrom ON pFrom.pa_id = from_id  
		WHERE [to_deleted_id] IS NULL and [to_id] = @PatientId 
		AND is_complete = 1 
		AND ISNULL(is_read,0) = 0  AND MSG_DATE > DATEADD(M, -@LookBackPeriod, GETDATE())
		ORDER BY MSG_DATE DESC 
  END 
 ELSE 
  BEGIN
		SELECT [id],[from_id],[to_id],[msg_date],[message],[is_read],[is_complete],messagedigest ,
		dFrom.dr_first_name + ' ' + dFrom.dr_last_name as FromDrSource , 
		pFrom.pa_first + ' ' + pFrom.pa_last as FromPatientSource 
		FROM [dbo].[doctor_patient_messages]  
		LEFT OUTER JOIN DOCTORS dFrom ON dFrom.dr_id = from_id  
		LEFT OUTER JOIN PATIENTS pFrom ON pFrom.pa_id = from_id  
		WHERE [to_deleted_id] IS NULL and [to_id] = @PatientId 
		AND is_complete IS NULL OR is_complete <>1
		AND ISNULL(is_read,0) = 0  AND MSG_DATE > DATEADD(M, -@LookBackPeriod, GETDATE())
		ORDER BY MSG_DATE DESC 
  END
  
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
