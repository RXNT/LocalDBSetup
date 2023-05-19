SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 2nd-November-2022
-- Description:	To populate QDM tables for the measure CMS68v12_NQF0419_Procedure
-- =============================================
CREATE    PROCEDURE [cqm2023].[usp_SaveQDMCMS68v12_NQF0419_Procedures]
	@RequestId BIGINT
AS
BEGIN
	DECLARE @MaxRowsCount BIGINT
	SET @MaxRowsCount = 100
	DECLARE @DoctorId BIGINT
	DECLARE @StartDate DATE 
	DECLARE @EndDate DATE
	DECLARE @DefaultEncCode VARCHAR(MAX) = '99201';
	DECLARE @AffectedRows BIGINT = 0;
	DECLARE @tempRowCount INT = 0;
	
	SELECT @DoctorId = DoctorId,@StartDate = StartDate, @EndDate = EndDate
	FROM [cqm2023].[DoctorCQMCalculationRequest] WITH(NOLOCK) 
	WHERE RequestId = @RequestId
	
	 
	INSERT INTO cqm2023.PatientProcedureCodes	
	(PatientId, EncounterId, DoctorId, ProcedureId, Code, CodeSystemId, PerformedFromDate, Status, ReasonTypeCode)
    SELECT TOP(@MaxRowsCount) proce.pa_id, 0,proce.dr_id, proce.procedure_id, proce.code, '3', proce.date_performed, proce.Status, proce.reason_type_code
	FROM patient_procedures proce WITH(NOLOCK)
	INNER JOIN patients pat WITH(NOLOCK) ON proce.pa_id=pat.pa_id
	INNER JOIN doctors dr WITH(NOLOCK) ON dr.dg_id=pat.dg_id AND proce.dr_id=dr.dr_id
	LEFT JOIN cqm2023.PatientProcedureCodes pec WITH(NOLOCK) ON pat.pa_id=pec.PatientId AND pec.Code = proce.code AND pec.PerformedFromDate = proce.date_performed
	WHERE proce.dr_id = @DoctorId AND-- issigned = 1 AND
	proce.date_performed between @StartDate AND @EndDate AND proce.CODE='428191000124101'  AND type='Procedure'  
	AND pec.ProcedureCodeId IS NULL
	
	SET @tempRowCount = @@ROWCOUNT;
	IF @tempRowCount > @AffectedRows
	BEGIN 
		SET @AffectedRows = @tempRowCount;
	END

	SELECT @AffectedRows;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
