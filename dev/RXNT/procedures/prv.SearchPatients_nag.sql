SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Balaji
-- Create date: 02-Sept2016
-- Description:	Search Patints
-- =============================================
CREATE PROCEDURE [prv].[SearchPatients_nag]
	-- Add the parameters for the stored procedure here
	@DoctorCompanyId int,
	@FirstName varchar(50)=NULL,
	@LastName varchar(50)=NULL,
	@ZIP varchar(50)=NULL,
	@ChartNo varchar(50)=NULL,
	@ExtChartNo varchar(50)=NULL,
	@DOB datetime=NULL,
	@PrefPhoneNo	varchar(50)=NULL,
	@PatientIdentifiersXML XML=NULL
AS
BEGIN	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @PatientIdentifiers AS TABLE (Id BIGINT, Name VARCHAR(50), Value VARCHAR(1000))
	DECLARE @V2DoctorCompanyId BIGINT
	SELECT @V2DoctorCompanyId = CompanyId 
	FROM dbo.RsynRxNTMasterCompanyExternalAppMapsTable WITH(NOLOCK) 
	WHERE ExternalAppId=1 AND ExternalCompanyId=@DoctorCompanyId
	
	IF @PatientIdentifiersXML IS NOT NULL
	BEGIN
		INSERT INTO @PatientIdentifiers (Id, Name, Value)
		SELECT  A.S.value('(Id)[1]', 'BIGINT') AS 'Id',
				A.S.value('(Name)[1]', 'VARCHAR(50)') AS 'Name',
				A.S.value('(Value)[1]', 'VARCHAR(1000)') AS 'Value'
		FROM @PatientIdentifiersXML.nodes('ArrayOfPatientIdentifier/PatientIdentifier') A(S);
	END
	SET NOCOUNT ON;
	
	
	
	IF @FirstName IS NULL 
	AND @LastName IS NULL AND @ZIP IS NULL 
	and @ChartNo IS NULL and @ExtChartNo IS NULL AND @DOB IS NULL 
	AND @PrefPhoneNo IS NULL
	BEGIN
		WITH PatientsTemp AS (
			SELECT TOP 100 P.PA_ID, P.DR_ID, 
			P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, P.PA_SSN, 
			P.PA_ZIP, P.PA_DOB, P.PA_ADDRESS1,pa_ext_ssn_no, P.PA_ADDRESS2, 
			P.PA_CITY, P.PA_SEX, P.PA_STATE,P.PA_PHONE
			FROM PATIENTS P with(nolock) 
			INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON DG.dg_id = p.dg_id 
			WHERE DG.dc_id =  @DoctorCompanyId
			AND NOT EXISTS (SELECT TOP 1 pa_flags.pa_id from PATIENT_FLAG_DETAILS pa_flags WITH(NOLOCK) 
								INNER JOIN patient_flags flags WITH(NOLOCK) ON pa_flags.flag_id=flags.flag_id 
							WHERE pa_flags.pa_id = P.PA_ID AND ISNULL(flags.hide_on_search,0)=1)
			AND(@PatientIdentifiersXML IS NULL OR EXISTS(SELECT TOP 1 PIK.Id FROM  patient_identifiers PI WITH(NOLOCK) 
				INNER JOIN @PatientIdentifiers AS PIK ON PI.pik_id=PIK.Id 
				WHERE PI.pa_id=P.pa_id AND PIK.Value IS NOT NULL AND PIK.Value != '' AND PI.value = PIK.Value))
			ORDER BY P.PA_LAST ASC --, P.PA_FIRST ASC
		)
		SELECT DISTINCT P.PA_ID, P.DR_ID, 
		P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, P.PA_SSN, 
		P.PA_ZIP, P.PA_DOB, P.PA_ADDRESS1,pa_ext_ssn_no, P.PA_ADDRESS2, 
		P.PA_CITY, P.PA_SEX, P.PA_STATE,P.PA_PHONE,PE.CELL_PHONE,PE.work_phone,PE.other_phone,PE.pref_phone,
		PQ.primary_pa_id,
		1 HasCompleteProfile
		--ISNULL(MP.HasCompleteProfile,1) AS HasCompleteProfile
		FROM PatientsTemp p WITH(NOLOCK)
		LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS PE WITH(NOLOCK) ON P.PA_ID = PE.PA_ID 
		LEFT OUTER JOIN Patient_merge_request_queue PQ WITH(NOLOCK) ON PQ.primary_pa_id=P.PA_ID
		LEFT OUTER JOIN [dbo].[RsynMasterPatientExternalAppMaps] MPE WITH(NOLOCK) ON MPE.ExternalAppId=1 AND MPE.CompanyId=@V2DoctorCompanyId AND MPE.ExternalPatientId=P.pa_id
		LEFT OUTER  JOIN [dbo].[RsynMasterPatients] MP WITH(NOLOCK) ON MPE.PatientId=MP.PatientId AND MP.CompanyId=@V2DoctorCompanyId 
		ORDER BY P.PA_LAST ASC, P.PA_FIRST ASC
	END
	ELSE
	BEGIN
		WITH PatientsTemp AS (
			SELECT TOP 100 P.PA_ID,P.dg_id, P.DR_ID, 
		P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, 
		P.PA_SSN, 
		P.PA_ZIP, P.PA_DOB, 
		P.PA_ADDRESS1,pa_ext_ssn_no, P.PA_ADDRESS2, P.PA_CITY, 
		P.PA_SEX, P.PA_STATE,P.PA_PHONE,PE.CELL_PHONE,PE.work_phone,PE.other_phone,PE.pref_phone
		FROM PATIENTS P with(nolock)
		INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON DG.dg_id = p.dg_id
		LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS PE WITH(NOLOCK) ON P.PA_ID = PE.PA_ID 
		WHERE 
		DG.dc_id  =  @DoctorCompanyId
		AND (@FirstName IS NULL OR P.PA_FIRST LIKE @FirstName+'%') 
		AND (@LastName IS NULL OR P.PA_LAST LIKE @LastName+'%')
		AND (@ZIP IS NULL OR P.PA_ZIP LIKE @ZIP+'%') 
		AND ( @ChartNo IS NULL OR P.pa_ssn LIKE @ChartNo+'%')  
		AND (@ExtChartNo IS NULL OR P.pa_ext_ssn_no LIKE @ExtChartNo+'%')
		AND (@DOB IS NULL OR P.PA_DOB = @DOB)
		AND NOT EXISTS (SELECT TOP 1 pa_flags.pa_id from PATIENT_FLAG_DETAILS pa_flags WITH(NOLOCK) INNER JOIN patient_flags flags  WITH(NOLOCK) ON pa_flags.flag_id=flags.flag_id WHERE pa_flags.pa_id = P.PA_ID AND ISNULL(flags.hide_on_search,0)=1)
		AND(@PatientIdentifiersXML IS NULL OR EXISTS(SELECT TOP 1 PIK.Id FROM patient_identifiers PI WITH(NOLOCK) 
			INNER JOIN @PatientIdentifiers AS PIK  ON PI.pik_id=PIK.Id 
			WHERE PI.pa_id=P.pa_id AND PIK.Value IS NOT NULL AND PIK.Value != '' AND PI.value = PIK.Value))
		AND (@PrefPhoneNo IS NULL 
			OR (pe.pref_phone = 1 AND p.pa_phone LIKE @PrefPhoneNo+'%')
			OR (pe.pref_phone = 2 AND pe.cell_phone LIKE @PrefPhoneNo+'%')
			OR (pe.pref_phone = 3 AND pe.work_phone LIKE @PrefPhoneNo+'%')
			OR (pe.pref_phone = 4 AND pe.other_phone LIKE @PrefPhoneNo+'%')
		)
		ORDER BY P.PA_LAST ASC, P.PA_FIRST ASC	
		)
		SELECT DISTINCT P.PA_ID, P.DR_ID, 
		P.PA_PREFIX, P.PA_SUFFIX, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, 
		P.PA_SSN, 
		P.PA_ZIP, P.PA_DOB, 
		P.PA_ADDRESS1,pa_ext_ssn_no, P.PA_ADDRESS2, P.PA_CITY, 
		P.PA_SEX, P.PA_STATE,P.PA_PHONE,PE.CELL_PHONE,PE.work_phone,PE.other_phone,PE.pref_phone,
		PQ.primary_pa_id,
		1  HasCompleteProfile
		--ISNULL(MP.HasCompleteProfile,1) AS HasCompleteProfile
		FROM PatientsTemp p with(nolock)
		LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS PE WITH(NOLOCK) ON P.PA_ID = PE.PA_ID 
		LEFT OUTER JOIN Patient_merge_request_queue PQ WITH(NOLOCK) ON PQ.primary_pa_id=P.PA_ID 
		LEFT OUTER JOIN patient_identifiers PI WITH(NOLOCK) ON PI.pa_id=P.pa_id
		LEFT OUTER JOIN [dbo].[RsynMasterPatientExternalAppMaps] MPE WITH(NOLOCK) ON MPE.ExternalAppId=1 AND MPE.CompanyId=@V2DoctorCompanyId AND MPE.ExternalPatientId=P.pa_id
		LEFT OUTER JOIN [dbo].[RsynMasterPatients] MP WITH(NOLOCK) ON MPE.PatientId=MP.PatientId AND MP.CompanyId=@V2DoctorCompanyId 
		ORDER BY P.PA_LAST ASC, P.PA_FIRST ASC	
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
