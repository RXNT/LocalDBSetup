SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vinod
Create date			:	6-Nov-2017
Description			:	This procedure is used to get Search outbox Messages
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ext].[usp_SearchOutboxMessages] --11647,100,0

	@PatientId	BIGINT,
	@LookBackPeriod INT
AS
BEGIN
	SELECT [id],[from_id],[to_id],[msg_date],[message],[is_read],[is_complete],messagedigest , 
	dTo.dr_first_name + ' ' + dTo.dr_last_name as ToDrSource , pTo.pa_first + ' ' + pTo.pa_last as ToPatientSource 
	FROM [dbo].[doctor_patient_messages] 
	LEFT OUTER JOIN DOCTORS dTo ON dTo.dr_id = to_id 
	LEFT OUTER JOIN PATIENTS pTo ON pTo.pa_id = to_id 
	WHERE [from_deleted_id] IS NULL
	and [from_id] = @PatientId AND ISNULL(is_read,0) = 0  
	AND MSG_DATE > DATEADD(M, -@LookBackPeriod, GETDATE()) ORDER BY MSG_DATE DESC 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
