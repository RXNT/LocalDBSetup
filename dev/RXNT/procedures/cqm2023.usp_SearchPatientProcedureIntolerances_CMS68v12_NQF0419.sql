SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 26/11/2022
-- Description:	To get the Patient Procedure Intolerances
-- =============================================

CREATE    PROCEDURE [cqm2023].[usp_SearchPatientProcedureIntolerances_CMS68v12_NQF0419]  
	@PatientId BIGINT,	
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN

	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM  cqm2023.[DoctorCQMCalculationRequest] R 
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		SELECT DISTINCT  pec.Code,vs.ValueSetOID,cs.CodeSystemOID,pec.PerformedFromDate,
		ISNULL(pec.PerformedToDate,pec.PerformedFromDate) AS PerformedToDate,  pp.* 
		FROM cqm2023.PatientProcedureCodes pec WITH(NOLOCK)
		INNER JOIN patient_procedures pp WITH(NOLOCK) ON pec.PatientId = pp.pa_id AND pec.ProcedureId = pp.procedure_id
		INNER JOIN cqm2023.SysLookupCMS68v12_NQF0419 codes ON pec.Code = codes.Code 
		AND pec.CodeSystemId = codes.CodeSystemId
		INNER JOIN cqm2023.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2023.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId 
		AND vs.QDMCategoryId= 10 --Procedure
		where pec.PatientId = @PatientId  AND pp.type='Intolerance' AND pp.status != 'Not Done'
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
