SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Samip Neupane
-- Create date: 12/14/2022
-- Description:	Search patient Family Hx Details using Family Hx Id
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientFamilyHxItemDetails] 
	@PatientId BIGINT,
	@FamilyHxId BIGINT
AS
BEGIN
	SELECT fhx.fhxid,
		fhx.pat_id,
		ISNULL(fhx.member_relation_id, 0) member_relation_id,
		fhx.problem,
		fhx.dr_id,
		fhx.added_by_dr_id,
		fhx.created_on,
		fhx.last_modified_on,
		fhx.last_modified_by,
		fhx.enable,
		fhx.icd10,
		fhx.icd10_description,
		fhx.snomed,
		fhx.snomed_description,
		fhx.LivingStatus
	FROM patient_family_hx fhx WITH (NOLOCK)
	WHERE fhx.pat_id = @PatientId
	AND fhx.fhxid = @FamilyHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
