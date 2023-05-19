SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Balaji
Create date			:	27-December-2016
Description			:	This procedure is used to get Patient last encounter
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetPatientEncounter] 
	@PatientId			BIGINT,
	@DoctorGroupId		BIGINT
	
AS
BEGIN
	DECLARE @Offset INT;

	SELECT TOP(1) @Offset = t.time_difference from (
	SELECT distinct time_difference from doctors where dg_id = @DoctorGroupId)t  
  
	SELECT top 1 A.ENC_ID, 
				 A.encounter_version, 
				 A.DR_ID,a.issigned, 
				 A.ADDED_BY_DR_ID,
				 a.type,
				 A.chief_complaint, 
				 dateadd(hh,-@offset, A.ENC_DATE) ENC_DATE, 
				 B.DR_FIRST_NAME, 
				 B.DR_LAST_NAME,
				 C.DR_FIRST_NAME PRIM_FIRST, 
				 C.DR_LAST_NAME PRIM_LAST, 
				 D.DR_FIRST_NAME MODIFIED_FIRST, 
				 D.DR_LAST_NAME MODIFIED_LAST, 
				 e.rxnt_encounter_id,
				 A.external_encounter_id,
				 A.InformationBlockingReasonId
	 FROM enchanced_encounter A WITH(NOLOCK)
	 INNER JOIN DOCTORS B WITH(NOLOCK) ON A.DR_ID = B.DR_ID 
	 INNER JOIN DOCTORS C WITH(NOLOCK) ON A.ADDED_BY_DR_ID  = C.DR_ID  
	 LEFT OUTER JOIN DOCTORS D WITH(NOLOCK) ON A.LAST_MODIFIED_BY = D.DR_ID 
	 LEFT OUTER JOIN RsynRxNTBillingEncounters e with(nolock) ON a.enc_id = e.rxnt_encounter_id 
	 WHERE A.PATIENT_ID = @PatientId AND B.DG_ID=@DoctorGroupId 
	 ORDER BY A.ENC_DATE DESC
  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
