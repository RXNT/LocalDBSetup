SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 31/10/2022
-- Description:	To get the Patient Medication
-- =============================================

CREATE    PROCEDURE [cqm2023].[usp_SearchPatientMedication_CMS68v12_NQF0419]  
	@PatientId BIGINT,	
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN

	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM  [cqm2023].[DoctorCQMCalculationRequest] R WITH(NOLOCK)
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		SELECT pec.Code,vs.ValueSetOID,cs.CodeSystemOID,pec.PerformedFromDate,ISNULL(pec.PerformedToDate,pec.PerformedFromDate) AS PerformedToDate 
		FROM cqm2023.PatientMedicationCodes pec WITH(NOLOCK)
		INNER JOIN cqm2023.SysLookupCMS68v12_NQF0419 codes WITH(NOLOCK) ON pec.Code = codes.Code AND pec.CodeSystemId = codes.CodeSystemId
		INNER JOIN cqm2023.SysLookupCodeSystem cs WITH(NOLOCK) ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2023.SysLookupCQMValueSet vs WITH(NOLOCK) ON codes.ValueSetId = vs.ValueSetId AND vs.QDMCategoryId= 4 --Medication
		where pec.PatientId = @PatientId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
