SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinod
-- Create date: 10-June-2019
-- Description:	To save the patient visit clinical Summary
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SavePatientVisitClinicalSummary]
	@PatientId BIGINT,
	@VisitId BIGINT,
	@ClinicalSummary VARCHAR(MAX)=NULL
AS

BEGIN
	SET NOCOUNT ON;
	UPDATE patient_visit
	SET clinical_notes = ISNULL(@ClinicalSummary,'')
	WHERE pa_id=@PatientId AND visit_id = @VisitId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
