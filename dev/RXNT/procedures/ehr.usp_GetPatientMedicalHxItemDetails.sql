SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/13/2022
-- Description:	Get Patient Medical Details from patient id and MedicalHxId
-- =============================================
CREATE   PROCEDURE [ehr].[usp_GetPatientMedicalHxItemDetails]
	-- Add the parameters for the stored procedure here
	@PatientId BIGINT,
	@MedicalHxId BIGINT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		medhx.medhxid,
		medhx.pat_id,
		medhx.problem,
		medhx.dr_id,
		medhx.added_by_dr_id,
		medhx.created_on,
		medhx.last_modified_on,
		medhx.last_modified_by,
		medhx.enable,
		medhx.icd10,
		medhx.icd10_description,
		medhx.snomed,
		medhx.snomed_description,
		medhx.source
	FROM patient_medical_hx medhx WITH (NOLOCK)
	WHERE medhx.pat_id = @PatientId AND
		medhx.medhxid = @MedicalHxId 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
