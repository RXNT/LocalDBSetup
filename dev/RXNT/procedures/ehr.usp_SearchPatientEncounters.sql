SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	04-JULY-2016
Description			:	This procedure is used to get Patient encounters
Modified By         :   PRADEEP P
Modified date		:	01-Jun-2021
Description         :	Added smart_form_id

*/
CREATE PROCEDURE [ehr].[usp_SearchPatientEncounters] 
	@PatientId			BIGINT,
	@DoctorGroupId		BIGINT,
	@FetchAll BIT = 1 ,
	@DoctorId BIGINT=NULL

AS
BEGIN
  DECLARE @Offset INT;
  
  DECLARE @PatientIdV2 BIGINT
  DECLARE @EnableV2EncounterTemplate BIT
  DECLARE @CompanyIdV2 BIGINT
  
  SELECT TOP 1 @PatientIdV2=PatientId,@CompanyIdV2=CompanyId 
  FROM  dbo.RsynMasterPatientExternalAppMaps MPEM with(nolock) 
  WHERE MPEM.ExternalPatientId = @PatientId AND MPEM.ExternalAppId=1
   
  SELECT @EnableV2EncounterTemplate =dc.EnableV2EncounterTemplate 
  FROM doc_companies dc WITH(NOLOCK) 
  INNER JOIN doc_groups dg WITH(NOLOCK) ON dc.dc_id = dg.dc_id
  WHERE dg.dg_id=@DoctorGroupId
  
  SELECT TOP(1) @Offset = t.time_difference from (
  SELECT distinct time_difference from doctors where dg_id = @DoctorGroupId)t  
  IF @FetchAll = 1
  BEGIN
	  WITH EncountersTemp AS (
		  SELECT A.ENC_ID, 
				 A.encounter_version, 
				 A.external_encounter_id,
				 A.is_released, 
				 A.DR_ID,
				 a.issigned,
				 A.dtsigned, 
				 A.ADDED_BY_DR_ID,
				 a.type,
				 A.chief_complaint, 
				 A.is_amended, 
				 A.enc_name, 
				 A.smart_form_id, 
				 A.ENC_DATE, 
				 B.DR_FIRST_NAME, 
				 B.DR_LAST_NAME,
				 B.dg_id,
				 C.DR_FIRST_NAME PRIM_FIRST, 
				 C.DR_LAST_NAME PRIM_LAST,  
				 NULL rxnt_encounter_id,
				 A.LAST_MODIFIED_BY,
				 CASE 
					WHEN a.encounter_version='v2.0' OR NOT(@EnableV2EncounterTemplate=1) THEN 1 
					ELSE (SELECT TOP 1 1 
						  FROM [encounter_form_settings] efs WITH(NOLOCK)
						  WHERE efs.dr_id=@DoctorId  AND efs.type=ISNULL(eead.type,a.type)) 
				 END CanCopy, 
				 A.is_inreview,  
				 A.is_multisignature,
				 A.InformationBlockingReasonId,
				 A.[EncounterNoteTypeId],
				 A.visibility_hidden_to_patient
		 FROM enchanced_encounter A with(nolock)
		 LEFT OUTER JOIN enchanced_encounter_additional_info eead WITH(NOLOCK) ON A.enc_id=eead.enc_id
		 INNER JOIN DOCTORS B with(nolock) ON A.DR_ID = B.DR_ID 
		 INNER JOIN DOCTORS C with(nolock) ON A.ADDED_BY_DR_ID  = C.DR_ID  
		 WHERE A.PATIENT_ID = @PatientId 
	  )
	 SELECT A.ENC_ID, 
			A.encounter_version, 
			A.external_encounter_id, 
			A.DR_ID,
			A.dg_id,
			a.issigned,
			A.dtsigned, 
			A.ADDED_BY_DR_ID,
			a.type,
			A.chief_complaint, 
			A.is_amended, 
			A.enc_name, 
			A.smart_form_id, 
			A.ENC_DATE,
			A.DR_FIRST_NAME, 
			A.DR_LAST_NAME,
			A.PRIM_FIRST, 
			A.PRIM_LAST, 
			D.DR_FIRST_NAME MODIFIED_FIRST, 
			D.DR_LAST_NAME MODIFIED_LAST, 
			NULL rxnt_encounter_id,
			STATC.[Description] As StatusTypeDescription,
			CASE 
				WHEN A.is_released=1 THEN 1  
				WHEN LEN(STATC.[Description])>1 THEN 1 
				ELSE 0 
			END IsReleased,
			A.CanCopy,
			A.is_inreview,  
			A.is_multisignature,
			A.InformationBlockingReasonId,
			A.[EncounterNoteTypeId],
			A.visibility_hidden_to_patient
     FROM EncountersTemp A with(nolock)
     LEFT OUTER JOIN DOCTORS D with(nolock) ON A.LAST_MODIFIED_BY = D.DR_ID 
	 OUTER APPLY (
		SELECT TOP 1 P2E.StatusTypeId as StatusTypeId 
		FROM [dbo].[RsynPMV2Encounters] P2E WITH(NOLOCK) 
		WHERE P2E.PatientId = @PatientIdV2 
		AND P2E.DoctorCompanyId = @CompanyIdV2 
		AND P2E.ExternalEncounterId = A.enc_id 
		AND P2E.ExternalAppId = 1
		ORDER BY P2E.EncounterId DESC
	 ) PMV2
	 LEFT OUTER JOIN [dbo].[RsynPMV2ApplicationTableConstants]  STATC WITH (NOLOCK) ON STATC.ApplicationTableConstantId = PMV2.[StatusTypeId]
	 ORDER BY A.ENC_DATE  DESC, A.ENC_ID DESC
  END
  ELSE
  BEGIN     
	  WITH EncountersTemp AS (
		SELECT A.ENC_ID, 
			   A.encounter_version, 
			   A.external_encounter_id,
			   A.is_released, 
			   A.DR_ID,a.issigned,
			   A.dtsigned, 
			   A.ADDED_BY_DR_ID,
			   a.type,
			   A.chief_complaint, A.is_amended, 
			   A.enc_name,
			   A.smart_form_id, 
			   A.ENC_DATE ENC_DATE, 
			   B.DR_FIRST_NAME, 
			   B.DR_LAST_NAME,B.dg_id,
			   C.DR_FIRST_NAME PRIM_FIRST, 
			   C.DR_LAST_NAME PRIM_LAST,  
			   NULL rxnt_encounter_id ,
			   A.LAST_MODIFIED_BY,
			   CASE 
				    WHEN a.encounter_version='v2.0' OR NOT(@EnableV2EncounterTemplate=1) THEN 1 
				    ELSE (SELECT TOP 1 1 FROM [encounter_form_settings] efs WITH(NOLOCK) WHERE efs.dr_id=@DoctorId AND efs.type=ISNULL(eead.type,a.type)) 
			   END CanCopy, 
			   A.is_inreview,  
			   A.is_multisignature,
			   A.InformationBlockingReasonId,
			   A.[EncounterNoteTypeId],
				 A.visibility_hidden_to_patient
		 FROM enchanced_encounter A with(nolock)
		 LEFT OUTER JOIN enchanced_encounter_additional_info eead WITH(NOLOCK) ON A.enc_id=eead.enc_id
		 INNER JOIN DOCTORS B with(nolock) ON A.DR_ID = B.DR_ID 
		 INNER JOIN DOCTORS C with(nolock) ON A.ADDED_BY_DR_ID  = C.DR_ID  
		 WHERE A.PATIENT_ID = @PatientId AND B.DG_ID=@DoctorGroupId 
	  )   
     SELECT A.ENC_ID, 
			A.encounter_version, 
			A.external_encounter_id, 
			A.DR_ID,
			A.dg_id,
			a.issigned,
			A.dtsigned, 
			A.ADDED_BY_DR_ID,
			a.type,
			A.chief_complaint, 
			A.is_amended, 
			A.enc_name,
			A.smart_form_id, 
			A.ENC_DATE,
			A.DR_FIRST_NAME, 
			A.DR_LAST_NAME,
			A.PRIM_FIRST, 
			A.PRIM_LAST, 
			D.DR_FIRST_NAME MODIFIED_FIRST, 
			D.DR_LAST_NAME MODIFIED_LAST, 
			NULL rxnt_encounter_id,
			STATC.[Description] As StatusTypeDescription,
			CASE 
				WHEN A.is_released=1 THEN 1 
				WHEN LEN(STATC.[Description])>1 THEN 1 
				ELSE 0 
			END IsReleased,
			A.CanCopy,
			A.is_inreview,  
			A.is_multisignature,
			A.InformationBlockingReasonId,
			A.[EncounterNoteTypeId],
				 A.visibility_hidden_to_patient
     FROM EncountersTemp A with(nolock)
     LEFT OUTER JOIN DOCTORS D with(nolock) ON A.LAST_MODIFIED_BY  = D.DR_ID 
	 OUTER APPLY (
		SELECT TOP 1 P2E.StatusTypeId as StatusTypeId FROM [dbo].[RsynPMV2Encounters] P2E  
		WITH(NOLOCK) WHERE P2E.PatientId = @PatientIdV2 
		AND P2E.DoctorCompanyId = @CompanyIdV2 AND P2E.ExternalEncounterId = A.enc_id 
		AND P2E.ExternalAppId = 1
		ORDER BY P2E.EncounterId DESC
	 )  PMV2
	 LEFT OUTER JOIN [dbo].[RsynPMV2ApplicationTableConstants]  STATC WITH (NOLOCK) ON STATC.ApplicationTableConstantId = PMV2.[StatusTypeId]
     ORDER BY A.ENC_DATE DESC, A.ENC_ID DESC
  END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
