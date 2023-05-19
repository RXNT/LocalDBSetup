SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 30-Mar-2022
-- Description:	Get current medications for patient in PHR.
-- =============================================
CREATE PROCEDURE [phr].[usp_GetCurrentMedicationsByPatient]
	@PatientId BIGINT,
	@IsInformationBlocking BIT = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT
		med.drug_id,
		CASE WHEN med.drug_id <= -1
			THEN med.drug_name
			ELSE r.med_medid_desc
		END drug_name,
		med.duration_amount as 'quantity',
		med.duration_unit as 'measurement',
		med.numb_refills,
		med.date_start,
		dr.dr_first_name,
		dr.dr_last_name,
		med.dosage
	FROM PATIENT_ACTIVE_MEDS med WITH(NOLOCK)
	LEFT JOIN doctors dr WITH(NOLOCK) ON dr.dr_id = med.added_by_dr_id
	LEFT JOIN rmiid1 r WITH(NOLOCK) ON r.medid = med.drug_id 
	WHERE 
	  ((@IsInformationBlocking =1) AND med.PA_ID = @PatientId  AND ISNULL(med.visibility_hidden_to_patient, 0) =0)
     OR (@IsInformationBlocking =0 AND med.PA_ID = @PatientId  )
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
