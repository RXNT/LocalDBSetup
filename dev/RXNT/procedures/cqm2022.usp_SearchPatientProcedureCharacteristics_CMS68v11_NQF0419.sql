SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 26/11/2022
-- Description:	To get the Patient Procedure Characteristics
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SearchPatientProcedureCharacteristics_CMS68v11_NQF0419]  
	@PatientId BIGINT,	
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN

	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM  cqm2022.[DoctorCQMCalculationRequest] R 
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		SELECT DISTINCT  pec.Code,vs.ValueSetOID,cs.CodeSystemOID,pec.PerformedFromDate,
		ISNULL(pec.PerformedToDate,pec.PerformedFromDate) AS PerformedToDate, pp.* 
		FROM cqm2022.PatientProcedureCodes pec WITH(NOLOCK)
		INNER JOIN patient_procedures pp WITH(NOLOCK) ON pec.PatientId = pp.pa_id AND pec.ProcedureId = pp.procedure_id
		INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 codes ON pec.Code = codes.Code 
		AND pec.CodeSystemId = codes.CodeSystemId
		INNER JOIN cqm2022.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2022.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId  AND vs.QDMCategoryId= 3 --Patient Characteristics
		where pec.PatientId = @PatientId  AND pp.type='Patient Characteristics' AND pp.status != 'Not Done'
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
