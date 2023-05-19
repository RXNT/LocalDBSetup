SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	08-SEP-2016
Description			:	This procedure is used to get Patient encounters
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_SearchPatientEncounters]	
	@DoctorId			BIGINT,
	@DoctorGroupId		BIGINT,
	@IsSigned			BIT = NULL,
	@PatientFirstName	VARCHAR(50) = NULL,
	@PatientLastName	VARCHAR(50) = NULL
AS
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
  SELECT A.ENC_ID, A.DR_ID,a.issigned, A.ADDED_BY_DR_ID,a.type,A.chief_complaint, A.ENC_DATE, B.DR_FIRST_NAME, B.DR_LAST_NAME, C.DR_FIRST_NAME PRIM_FIRST, C.DR_LAST_NAME PRIM_LAST, D.DR_FIRST_NAME MODIFIED_FIRST, D.DR_LAST_NAME MODIFIED_LAST, PAT.pa_first,PAT.pa_last,PAT.pa_id,PAT.pa_middle, e.rxnt_encounter_id,
  A.encounter_version,
  A.external_encounter_id
  FROM enchanced_encounter A 
  INNER JOIN DOCTORS B ON A.DR_ID = B.DR_ID 
  INNER JOIN DOCTORS C ON A.ADDED_BY_DR_ID  = C.DR_ID  
  LEFT OUTER JOIN DOCTORS D ON A.LAST_MODIFIED_BY  = D.DR_ID 
  INNER JOIN PATIENTS PAT on A.patient_id=PAT.pa_id 
  LEFT OUTER JOIN RxNTBilling..encounters e on a.enc_id = e.rxnt_encounter_id 
  WHERE A.DR_ID = @DoctorId AND B.DG_ID=@DoctorGroupId AND (@IsSigned IS NULL OR A.ISSIGNED = @IsSigned)
  AND (@PatientFirstName IS NULL OR PAT.pa_first LIKE '%'+@PatientFirstName+'%')
  AND (@PatientLastName IS NULL OR PAT.pa_last LIKE '%'+@PatientLastName+'%')
  ORDER BY DATEADD(dd, DATEDIFF(dd, 0, A.ENC_DATE), 0) DESC, A.ENC_ID DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
