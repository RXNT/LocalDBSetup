SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 24/11/2022
-- Description:	To get the Patient Medication
-- =============================================

CREATE    PROCEDURE [cqm2023].[usp_SearchPatientAdministeredMedication_CMS68v12_NQF0419]  
	@PatientId BIGINT,	
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN
	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM cqm2023.[DoctorCQMCalculationRequest] R 
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		SELECT DISTINCT  pec.Code,vs.ValueSetOID,cs.CodeSystemOID,pec.PerformedFromDate,ISNULL(pec.PerformedToDate,pec.PerformedFromDate) AS PerformedToDate 
		FROM cqm2023.PatientMedicationCodes pec WITH(NOLOCK)
		INNER JOIN dbo.prescriptions pres WITH(NOLOCK) ON pec.PrescriptionId = pres.pres_id
		INNER JOIN prescription_details pd WITH(NOLOCK) ON pres.pres_id = pd.pres_id
		INNER JOIN cqm2023.SysLookupCMS68v12_NQF0419 codes ON pec.Code = codes.Code AND pec.CodeSystemId = codes.CodeSystemId
		INNER JOIN cqm2023.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2023.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId AND vs.QDMCategoryId= 5 --Medication
		where pec.PatientId = @PatientId AND pec.PerformedFromDate BETWEEN @StartDate AND @EndDate AND pd.compound=1
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
