SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Search Outbox Messages
-- =============================================
CREATE PROCEDURE  [phr].[usp_SearchOutboxMessages]
	@PatientId	BIGINT,
	@LookBackPeriod INT
AS
BEGIN
	SELECT DPM.[id],DPM.[from_id],DPM.[to_id],
	DPM.[msg_date],DPM.[message],DPM.[is_read],DPM.[is_complete],
	DPM.messagedigest , 
	dTo.dr_first_name + ' ' + dTo.dr_last_name as ToDrSource , pTo.pa_first + ' ' + pTo.pa_last as ToPatientSource,
	PR.FirstName AS 'RepresentativeFirstName',
	PR.LastName AS 'RepresentativeLastName',
	PR.MiddleInitial  AS 'RepresentativeMiddleInitial',
	PR.PatientRepresentativeId
	FROM [dbo].[doctor_patient_messages] DPM
	LEFT JOIN phr.PatientRepresentatives PR WITH(NOLOCK) ON DPM.PatientRepresentativeId = PR.PatientRepresentativeId
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
