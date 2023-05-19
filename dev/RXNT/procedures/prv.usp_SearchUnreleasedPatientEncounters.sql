SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	25-MAY-2017
Description			:	This procedure is used to get Patient encounters which are not released
Last Modified By	:	Ayja Weems
Last Modifed Date	:	19-JAN-2021
Last Modification	:	Include chart number & encounter "is_inreview" status fields in select statement
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_SearchUnreleasedPatientEncounters]	
	@DoctorId			BIGINT,
	@DoctorGroupId		BIGINT,
	@PatientFirstName	VARCHAR(50) = NULL,
	@PatientLastName	VARCHAR(50) = NULL,
	@StartDate	DATETIME=NULL,
	@EndDate	DATETIME=NULL,
	@PageSize			INT,
	@CurrentPageIndex	INT,
	@DoctorCompanyId	BIGINT,
	@FetchAllGroups		BIT = NULL
AS
BEGIN
	
   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
  DECLARE @StartRowNumber AS INT
  DECLARE @EndRowNumber AS INT
  
  
  DECLARE @PreferredPrescriberId BIGINT = 0;
  SELECT @PreferredPrescriberId=di.staff_preferred_prescriber 
  FROM dbo.doctor_info di WITH(NOLOCK)
  WHERE di.dr_id=@DoctorId 

  IF(@PreferredPrescriberId>0)
  BEGIN
	SET @DoctorId = @PreferredPrescriberId;
  END

  IF(@FetchAllGroups = 0)
  BEGIN
	SET @FetchAllGroups = NULL
  END
  
  SET @EndDate = DATEADD(DAY,+1,ISNULL(@EndDate,GETDATE()))
  
  select MPEM.ExternalPatientId,MPEM.CompanyId , PMV2.ExternalEncounterId, MPEM.PatientId 
INTO #PtExtAppMaps from 
dbo.RsynMasterPatientExternalAppMaps MPEM with(nolock) 
  LEFT OUTER JOIN [dbo].[RsynPMV2Encounters] PMV2  WITH(NOLOCK) 
  ON PMV2.PatientId = MPEM.PatientId AND PMV2.DoctorCompanyId = @DoctorCompanyId AND   PMV2.ExternalAppId = 1
  where MPEM.CompanyId = @DoctorCompanyId AND MPEM.ExternalAppId=1

  SET @StartRowNumber = @CurrentPageIndex
  SET @EndRowNumber = @CurrentPageIndex + @PageSize
  SELECT * FROM (
	SELECT ROW_NUMBER() OVER(ORDER BY A.ENC_ID DESC) AS RowNum,
	A.ENC_ID, 
	A.DR_ID,
	a.issigned, 
	A.dtsigned, 
	A.ADDED_BY_DR_ID,
	a.type,
	A.chief_complaint, 
	A.ENC_DATE, 
	B.DR_FIRST_NAME, 
	B.DR_LAST_NAME, 
	B.dg_id, 
	C.DR_FIRST_NAME PRIM_FIRST, 
	C.DR_LAST_NAME PRIM_LAST, 
	D.DR_FIRST_NAME MODIFIED_FIRST, 
	D.DR_LAST_NAME MODIFIED_LAST, 
	PAT.pa_first,
	PAT.pa_last,
	PAT.pa_id,
	PAT.pa_middle,
	PAT.pa_ssn,
	isnull(A.is_released, 0) as is_released,
	A.is_inreview,
	A.encounter_version,
	A.external_encounter_id SmartFormEncounterId, 
	DG.dg_name,
	PE.pa_nick_name,
	(select COUNT (1)  FROM dbo.patients WITH (NOLOCK)
		WHERE pa_id = A.patient_id AND ( 
		pa_first IS NULL OR pa_first = '' OR
		pa_last IS NULL OR pa_last = '' OR
		pa_dob IS NULL OR pa_dob = '' OR
		pa_sex IS NULL OR pa_sex = '' OR
		pa_address1 IS NULL OR pa_address1 = '' OR
		pa_zip IS NULL OR pa_zip = '' OR
		pa_state IS NULL OR pa_state = '' )
	) AS patient_details_missing 
  FROM enchanced_encounter A  WITH(NOLOCK)
  INNER JOIN DOCTORS B  WITH(NOLOCK) ON A.DR_ID = B.DR_ID 
  INNER JOIN DOCTORS C WITH(NOLOCK) ON A.ADDED_BY_DR_ID  = C.DR_ID  
  LEFT OUTER JOIN DOCTORS D WITH(NOLOCK) ON A.LAST_MODIFIED_BY  = D.DR_ID 
  INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON DG.dg_id = B.dg_id
  INNER JOIN PATIENTS PAT WITH(NOLOCK) on A.patient_id=PAT.pa_id 
  LEFT OUTER JOIN [patient_extended_details] PE WITH(NOLOCK) ON PE.pa_id = PAT.pa_id 
  LEFT OUTER JOIN #PtExtAppMaps MPEM with(nolock) ON MPEM.ExternalPatientId = A.patient_id 
  
  WHERE ((@FetchAllGroups IS NULL AND A.DR_ID = @DoctorId AND B.DG_ID=@DoctorGroupId) OR 
  (@FetchAllGroups IS NOT NULL AND DG.dc_id = @DoctorCompanyId))
  AND (@PatientFirstName IS NULL OR PAT.pa_first LIKE '%'+@PatientFirstName+'%')
  AND (@PatientLastName IS NULL OR PAT.pa_last LIKE '%'+@PatientLastName+'%')
  AND (A.is_released=0 OR A.is_released is NULL) 
  AND (@StartDate IS NUll OR A.enc_date BETWEEN @StartDate AND @EndDate)
  AND MPEM.ExternalEncounterId IS NULL 
  ) AS enc
  --WHERE RowNum >= @StartRowNumber AND RowNum < @EndRowNumber
  ORDER BY enc.ENC_DATE DESC
  
  SELECT COUNT(enc_id) AS TotalNoOfRecords
  FROM enchanced_encounter A  WITH(NOLOCK) 
  INNER JOIN DOCTORS B  WITH(NOLOCK) ON A.DR_ID = B.DR_ID 
  INNER JOIN DOCTORS C WITH(NOLOCK) ON A.ADDED_BY_DR_ID  = C.DR_ID  
  LEFT OUTER JOIN DOCTORS D WITH(NOLOCK) ON A.LAST_MODIFIED_BY  = D.DR_ID
    INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON DG.dg_id = B.dg_id 
  INNER JOIN PATIENTS PAT WITH(NOLOCK) on A.patient_id=PAT.pa_id 
  LEFT OUTER JOIN #PtExtAppMaps MPEM with(nolock) ON MPEM.ExternalPatientId = A.patient_id
  WHERE ((@FetchAllGroups IS NULL AND A.DR_ID = @DoctorId AND B.DG_ID=@DoctorGroupId) OR 
  (@FetchAllGroups IS NOT NULL AND DG.dc_id = @DoctorCompanyId))
  AND (@PatientFirstName IS NULL OR PAT.pa_first LIKE '%'+@PatientFirstName+'%')
  AND (@PatientLastName IS NULL OR PAT.pa_last LIKE '%'+@PatientLastName+'%')
  AND (A.is_released=0 OR A.is_released IS NULL)
  AND (@StartDate IS NUll OR A.enc_date BETWEEN @StartDate AND @EndDate)
  AND MPEM.ExternalEncounterId IS NULL 
  
  
    drop table #PtExtAppMaps
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
