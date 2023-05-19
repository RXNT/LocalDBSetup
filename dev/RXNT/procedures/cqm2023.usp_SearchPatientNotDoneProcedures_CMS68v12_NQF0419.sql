SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 31/10/2022
-- Description:	To get the Not Done Patient Procedures
-- =============================================

CREATE    PROCEDURE [cqm2023].[usp_SearchPatientNotDoneProcedures_CMS68v12_NQF0419]  
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
		SELECT DISTINCT  vs.ValueSetOID,cs.CodeSystemOID,pp.date_performed AS PerformedFromDate,ISNULL(pp.date_performed_to,pp.date_performed) AS PerformedToDate,  pp.*  
		
		FROM patient_procedures pp WITH(NOLOCK) 
		INNER JOIN cqm2023.SysLookupCMS68v12_NQF0419 codes ON pp.reason_type_code = codes.Code
		INNER JOIN cqm2023.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2023.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId
		where pp.pa_id = @PatientId  AND pp.status='Not Done'
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
