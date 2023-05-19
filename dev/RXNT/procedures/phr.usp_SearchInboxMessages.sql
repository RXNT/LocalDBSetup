SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Search Inbox Messages
-- =============================================
CREATE PROCEDURE  [phr].[usp_SearchInboxMessages]
	@PatientId	BIGINT,
	@LookBackPeriod INT,
	@MessageStatusType INT
AS
BEGIN

	SELECT [id],[from_id],[to_id],[msg_date],[message],[is_read],[is_complete],messagedigest ,
		dFrom.dr_first_name + ' ' + dFrom.dr_last_name as FromDrSource , 
		pFrom.pa_first + ' ' + pFrom.pa_last as FromPatientSource 
		FROM [dbo].[doctor_patient_messages]  
		LEFT OUTER JOIN DOCTORS dFrom ON dFrom.dr_id = from_id  
		LEFT OUTER JOIN PATIENTS pFrom ON pFrom.pa_id = from_id  
		WHERE [to_deleted_id] IS NULL and [to_id] = @PatientId 
		AND (@MessageStatusType = 1
			  OR (@MessageStatusType = 2 AND is_complete = 1)
		      OR (@MessageStatusType = 3 AND ISNULL(is_complete, 0) = 0)
			)
		AND ISNULL(is_read,0) = 0  AND MSG_DATE > DATEADD(M, -@LookBackPeriod, GETDATE())
		ORDER BY MSG_DATE DESC
  
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
