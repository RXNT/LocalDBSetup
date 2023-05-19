SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 26/11/2022
-- Description:	To get the Patient Allergis
-- =============================================

CREATE   PROCEDURE [cqm2022].[usp_SearchPatientMedicationAllergies_CMS68v11_NQF0419]  
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
	 
		select DISTINCT a.rxnorm_code Code,vs.ValueSetOID,cs.CodeSystemOID,a.add_date PerformedFromDate,
		a.add_date AS PerformedToDate ,
		a.pa_allergy_id, a.allergy_id, a.status, a.allergy_type, a.add_date,
		a.reaction_string, a.comments, 
		case when (a.source_type = 'EXT' OR a.allergy_id < 1) 
		then a.allergy_description else  b.dam_concept_id_desc 
		end as dam_concept_id_desc, 
		a.record_source, a.source_type, 
		a.pa_id, a.severity_id, ATC.Description as severity_name,
		a.rxnorm_code
		from patient_new_allergies  a with(nolock) 
		left join rdamapm0 b with(nolock) on a.allergy_id = b.dam_concept_id and a.allergy_type = b.dam_concept_id_typ 
		left join ehr.ApplicationTableConstants ATC on ATC.ApplicationTableConstantId = a.severity_id
		INNER JOIN cqm2022.SysLookupCMS68v11_NQF0419 codes ON a.rxnorm_code = codes.Code 
		INNER JOIN cqm2022.SysLookupCodeSystem cs ON codes.CodeSystemId = cs.CodeSystemId
		INNER JOIN cqm2022.SysLookupCQMValueSet vs ON codes.ValueSetId = vs.ValueSetId AND vs.QDMCategoryId= 8 --Medication Allergy
		where 1=1 and a.pa_id = @PatientId 
		ORDER BY a.pa_allergy_id DESC

		 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
