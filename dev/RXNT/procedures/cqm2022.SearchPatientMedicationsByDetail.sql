SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Medication by detail
-- =============================================
CREATE   PROCEDURE [cqm2022].[SearchPatientMedicationsByDetail]
  @PatientId			BIGINT,
  @DrugName				VARCHAR(500)=NULL,
  @DoctorId				BIGINT,
  @EntryDate			DATETIME=NULL,
  @ApprovedDate			DATETIME=NULL,
  @IsDispensed			BIT=0,
  @IsOrdered			BIT=0,
  @IsAdministered		BIT=0,
  @IsDischarged			BIT=0,
  @IsActiveMed			BIT=0
AS
BEGIN
	DECLARE @MedId AS BIGINT=0
	
	IF (@IsActiveMed = 0)
	BEGIN
	
		SELECT @MedId=ISNULL(pres.pres_id,0) FROM prescription_details pd WITH(NOLOCK)
		INNER JOIN prescriptions pres WITH(NOLOCK) ON pd.pres_id=pres.pres_id
		WHERE pres.pa_id=@PatientId AND pres.dr_id=@DoctorId AND pd.drug_name=@DrugName AND
		CONVERT(VARCHAR(10), pres_entry_date, 101)=CONVERT(VARCHAR(10), @EntryDate, 101) 
		AND CONVERT(VARCHAR(10), pres_approved_date, 101) =CONVERT(VARCHAR(10), @ApprovedDate, 101)
		AND (
		(@IsDispensed=1 AND pres.pres_approved_date IS NOT NULL AND pres.pres_void=0 AND pd.history_enabled=1 AND ISNULL(pd.is_dispensed,0)=1) OR
		(@IsAdministered = 1 AND pd.compound=1) OR 
		(@IsDischarged = 1 AND pd.history_enabled=0) OR
		(@IsOrdered = 1 AND pres.pres_approved_date IS NOT NULL AND pres.pres_void=0 AND pd.history_enabled=1 AND ISNULL(pd.is_dispensed,0)=0)
		)
		
	END
	ELSE
	BEGIN
	
		SELECT @MedId=ISNULL(pam_id,0) FROM patient_active_meds WITH(NOLOCK)
		WHERE pa_id=@PatientId AND added_by_dr_id=@DoctorId AND drug_name=@DrugName AND
		CONVERT(VARCHAR(10), date_added, 101)=CONVERT(VARCHAR(10), @EntryDate, 101)		
		
	END
	
	
	SELECT @MedId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
