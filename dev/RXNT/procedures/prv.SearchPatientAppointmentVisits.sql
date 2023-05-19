SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 01-Apr-2019
-- Description:	Search patient appointment details by externalinfo
-- =============================================
CREATE PROCEDURE  [prv].[SearchPatientAppointmentVisits]
	-- Add the parameters for the stored procedure here
	@DoctorCompanyId BIGINT,
	@MasterCompanyId BIGINT,
	@AppointmentInfoXML XML=NULL
AS
BEGIN	-- SET NOCOUNT ON added to prevent extra result sets from
	CREATE TABLE #Appointments (SlNo BIGINT,MasterPatientId BIGINT, AppointmentId BIGINT)
	 
	
	IF @AppointmentInfoXML IS NOT NULL
	BEGIN
		INSERT INTO #Appointments (SlNo,MasterPatientId, AppointmentId)
	 
		SELECT  A.S.value('(SlNo)[1]', 'BIGINT') AS 'SlNo',
				A.S.value('(MasterPatientId)[1]', 'BIGINT') AS 'MasterPatientId',
				A.S.value('(AppointmentId)[1]', 'VARCHAR(50)') AS 'AppointmentId' 
		FROM @AppointmentInfoXML.nodes('ArrayOfAppointmentInfo/AppointmentInfo') A(S);
	END
	
SELECT PEM.ExternalPatientId PatientId,vis.visit_id VisitId,E.enc_date VisitDate,vis.enc_id EncounterId ,E.issigned,
	E.encounter_version,E.external_encounter_id,E.type,
		 (select COUNT (1) FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = PEM.ExternalPatientId AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '' )
						 ) AS patient_details_missing
	FROM #Appointments APT  
	INNER JOIN dbo.RsynMasterPatients PAT WITH(NOLOCK) ON APT.MasterPatientId = PAT.PatientId
	INNER JOIN dbo.RsynMasterPatientExternalAppMaps PEM WITH(NOLOCK) ON PEM.PatientId = PAT.PatientId 
	LEFT OUTER JOIN patient_visit_appointment_detail vis_det WITH(NOLOCK) ON vis_det.MasterPatientId = APT.MasterPatientId AND  vis_det.AppointmentId = APT.AppointmentId
	LEFT OUTER JOIN patient_visit vis WITH(NOLOCK) ON vis.visit_id = vis_det.visit_id 
	LEFT OUTER JOIN enchanced_encounter E WITH(NOLOCK) ON E.enc_id = vis.enc_id 
	ORDER BY SlNo

DROP TABLE #Appointments	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
