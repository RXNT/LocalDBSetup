SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed 
-- Create date: 30-OCT-2022
-- Description:	To search Patient Communication for Measure CMS68v11_NQF0419
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SearchPatientCommunication_CMS68v11_NQF0419]  
	@PatientId BIGINT,	
	@DoctorId BIGINT,	
	@StartDate Date,
	@EndDate Date	
AS
BEGIN

	 DECLARE @RequestId BIGINT
	 SELECT @RequestId = MAX(RequestId) FROM  [cqm2022].[DoctorCQMCalculationRequest] R 
	 WHERE R.DoctorId=@DoctorId AND R.StartDate=@StartDate AND R.EndDate=@EndDate AND R.StatusId=2  AND R.Active=1
	 IF @RequestId>0
	 BEGIN
		SELECT pec.Code,vs.ValueSetOID,cs.CodeSystemOID,pec.PerformedFromDate,ISNULL(pec.PerformedToDate,pec.PerformedFromDate) AS PerformedToDate 
		FROM cqm2022.PatientCommunicationCodes pec WITH(NOLOCK)
		INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 codes ON pec.Code = codes.Code AND pec.CodeSystemId = codes.CodeSystemId
		INNER JOIN cqm2022.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2022.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId AND vs.QDMCategoryId= 10 --Communication
		where pec.PatientId = @PatientId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
