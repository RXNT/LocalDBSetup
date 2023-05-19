SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 14-Jul-2016
-- Description:	GET patient Family Hx
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientFamilyHx]
	@FamilyHxId BIGINT
AS

BEGIN
	SELECT fhx.fhxid, fhx.pat_id,fhx.member_relation_id,fhx.problem,fhx.icd9,fhx.dr_id,fhx.added_by_dr_id,fhx.created_on,fhx.last_modified_on,fhx.last_modified_by,fhx.enable,
	fhx.icd9_description, fhx.icd10, fhx.icd10_description, fhx.snomed, fhx.snomed_description
	FROM patient_family_hx fhx with(nolock)
	WHERE fhx.fhxid = @FamilyHxId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
