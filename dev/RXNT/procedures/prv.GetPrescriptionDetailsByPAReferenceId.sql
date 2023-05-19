SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 30-Nov-2021
-- Description:	Get the prescription id by the PAReferenceId & PatientId
-- =============================================
CREATE PROCEDURE [prv].[GetPrescriptionDetailsByPAReferenceId] 
	@PatientId bigint,
	@EpaInitiatorsProcessId varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT det.pres_id, det.pd_id FROM prescription_details det WITH(NOLOCK) 
	INNER JOIN prescriptions rx ON rx.pres_id = det.pres_id
	WHERE rx.pa_id = @PatientId
	AND PAReferenceId = @EpaInitiatorsProcessId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
