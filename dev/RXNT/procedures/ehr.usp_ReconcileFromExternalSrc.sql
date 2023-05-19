SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 8-Aug-2016
-- Description:	To Search Patient External Active Mes
-- Mod1ified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_ReconcileFromExternalSrc]
  @PatientId INT,
  @DoctorId INT,
  @Measure VARCHAR(3)
AS
BEGIN
	IF @Measure = 'MED'
		BEGIN
			update patient_external_ccd_reconciliation_info
			set is_medication_reconciled = 1
			where pa_id = @PatientId AND dr_id = @DoctorId AND is_medication_reconciled IS NULL
		END
	ELSE IF @Measure = 'ALG' 
		BEGIN
			update patient_external_ccd_reconciliation_info
			set is_allergy_reconciled = 1
			where pa_id = @PatientId AND dr_id = @DoctorId AND is_allergy_reconciled IS NULL
		END
	ELSE IF @Measure = 'PRB'
		BEGIN
			update patient_external_ccd_reconciliation_info
			set is_problem_reconciled = 1
			where pa_id = @PatientId AND dr_id = @DoctorId AND is_problem_reconciled IS NULL	
		END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
