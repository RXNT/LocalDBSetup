SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/13/2022
-- Description:	Get Surgical History info from Surgical Hx Id
-- =============================================


CREATE   PROCEDURE [ehr].[usp_GetPatientSurgicalHxItemDetails] 
	@PatientId BIGINT,
	@SurgicalHxId BIGINT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT surhx.surghxid,
		surhx.pat_id,
		surhx.problem,
		surhx.dr_id,
		surhx.added_by_dr_id,
		surhx.created_on,
		surhx.last_modified_on,
		surhx.last_modified_by,
		surhx.enable,
		surhx.icd10,
		surhx.icd10_description,
		surhx.snomed,
		surhx.snomed_description,
		surhx.source
	FROM patient_surgery_hx surhx WITH (NOLOCK)
	WHERE surhx.pat_id = @PatientId
		AND surhx.surghxid = @SurgicalHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
