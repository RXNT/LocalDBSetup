SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Singaravelan
Create date			:	04-JULY-2016
Description			:	This procedure is used to get Patient encounters
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetAllEncounterForPatient]	
	@PatientId			BIGINT,
	@DoctorGroupId		BIGINT
AS
BEGIN
  DECLARE @Offset INT;

  SELECT TOP(1) @Offset = t.time_difference from (
  SELECT distinct time_difference from doctors where dg_id = @DoctorGroupId)t  
	
  SELECT A.ENC_ID, A.encounter_version ,A.DR_ID,a.issigned, A.ADDED_BY_DR_ID,a.type,A.chief_complaint, dateadd(hh,-@offset, A.ENC_DATE) ENC_DATE, B.DR_FIRST_NAME, B.DR_LAST_NAME,
         C.DR_FIRST_NAME PRIM_FIRST, C.DR_LAST_NAME PRIM_LAST, D.DR_FIRST_NAME MODIFIED_FIRST, D.DR_LAST_NAME MODIFIED_LAST, e.rxnt_encounter_id 
         FROM enchanced_encounter A with(nolock)
         INNER JOIN DOCTORS B with(nolock) ON A.DR_ID = B.DR_ID 
         INNER JOIN DOCTORS C with(nolock) ON A.ADDED_BY_DR_ID  = C.DR_ID  
         LEFT OUTER JOIN DOCTORS D with(nolock) ON A.LAST_MODIFIED_BY  = D.DR_ID 
         left outer join RsynRxNTBillingEncounters e with(nolock)
         on a.enc_id = e.rxnt_encounter_id 
         WHERE A.PATIENT_ID = @PatientId  ORDER BY A.ENC_DATE DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
