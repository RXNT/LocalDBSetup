SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	04-DEC-2022
-- Description:		Save QRDA Patient Case Payer
-- =============================================
CREATE   PROCEDURE [cqm2022].[SavePatientCasePayer]
  @PatientId			BIGINT,
  @Code					VARCHAR(30),
  @StartDate			DATETIME=NULL,
  @EndDate				DATETIME=NULL
AS
BEGIN
	DECLARE @CaseId AS BIGINT=0
	INSERT INTO RxNTBilling.dbo.cases (pa_id,case_name,description,active,send_patient_statement,is_related_auto,is_related_employment,
	is_related_pregnancy,is_related_abuse,is_related_other,is_related_epsdt,is_related_family_planning,is_related_emergency,related_auto_state,
	guarantor_sbr_id,case_type_code,referring_provider_id,referring_provider_date,guarantor_relationship_code)
	VALUES (@PatientId, 'Defualt', 'Medicare', 1, 0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,0)
	
	SET @CaseId=SCOPE_IDENTITY()
	
	INSERT INTO RxNTBilling.dbo.case_payers (case_id,payer_id,policy_number,group_number,group_name,copay,deductible,effective_start_date,
	effective_end_date,priority,sbr_id,medicare_type_code,is_assignment_accepted,sbr_relationship_code)
	VALUES(@CaseId,0,0,0,'Medicare', 0.00,0.00, @StartDate, @EndDate,0,0,@Code,1,0)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
