SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
==========================================================================================
Author:		Sheik
Create date: 22-Jan-2020
Description: to fetch all get all Person Resource Appointment Schedule
==========================================================================================
*/

CREATE PROCEDURE [sch].[usp_GetAllPersonResourceAppointmentSchedule] 
(
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@StartDateTime DATETIME2(7) = NULL,
	@EndDateTime DATETIME2(7) = NULL
)
AS
BEGIN
	
	EXEC	[sch].[usp_ValidateLoggedInUserDoctorCompany]
			@LoggedInUserId = @LoggedInUserId, 
			@DoctorCompanyId = @DoctorCompanyId
    IF @@ERROR > 0 RETURN;
		
	DECLARE @PatientNotes Table(DoctorCompanyId BIGINT, PatientId BIGINT, AppointmentNotesCount BIGINT, AppointmentId BIGINT)
	DECLARE @AppNotes Table(DoctorCompanyId BIGINT, AppointmentNotesCount BIGINT, AppointmentId BIGINT)

	DECLARE @CKCId BIGINT
	SELECT @CKCId = ApplicationTableConstantId FROM   [dbo].[RsynSchedulerV2ApplicationTableConstants] STS WITH (NOLOCK) WHERE STS.Code = 'CKC';
	DECLARE @CMPId BIGINT
	SELECT @CMPId = ApplicationTableConstantId FROM   [dbo].[RsynSchedulerV2ApplicationTableConstants] STS WITH (NOLOCK) WHERE STS.Code = 'CMP';

	SELECT * INTO #tempPerAppSchedule FROM(
		SELECT PAS.PersonResourceAppointmentScheduleId,
			   PAS.PersonResourceId,
			   PAS.DoctorGroupId,
			   DG.Name As DoctorGroupName,
			   PAI.CurrentPatientId AS PatientId,
			   PAS.DurationMinutes,
			   PAS.StartDateTime,
			   PAS.EndDateTime,
			   PAS.AppointmentId,
			   PAS.Active,
			   PR.Name,
			   PR.ShortName,		   
			   APP.CompanyAppointmentTypeId,
			   APP.AppointmentStatusTypeId,
			   CAT.Name AS 'AppointmentTemplateName',
			   ATCS.Description AS 'AppointmentStatus',
			   APP.CreatedDate,
			   ISNULL(PER.LastName,'')	+ ', ' + ISNULL(PER.FirstName,'') As 'PatientName',
			   PER.NickName,
			   MR.Name AS PrimaryMaterialResource,
			   MR.TelehealthUrl,
				(Select top 1 AN.NoteText FROM [dbo].[RsynSchedulerV2AppointmentNotes] AN WITH (NOLOCK) WHERE AN.AppointmentsId = APP.AppointmentId AND Active= 1 ORDER BY AN.NoteId DESC) AS AppointmentNotes,
			   ISNULL((select top 1 WF.StatusModifiedDate FROM [dbo].[RsynSchedulerV2AppointmentStatusWorkflow] WF WITH (NOLOCK) WHERE WF.AppointmentId = APP.AppointmentId AND WF.AppointmentStatusTypeId = @CKCId AND WF.Active = 1 ORDER BY WF.CreatedDate DESC), APP.CheckInTime) AS CheckInTime,
			   ISNULL((select top 1 WF.StatusModifiedDate FROM [dbo].[RsynSchedulerV2AppointmentStatusWorkflow] WF WITH (NOLOCK) WHERE WF.AppointmentId = APP.AppointmentId AND WF.AppointmentStatusTypeId = @CMPId AND WF.Active = 1 ORDER BY WF.CreatedDate DESC), APP.CheckOutTime) AS CompletedTime,
			   PEM.ExternalPatientId EHRPatientId,vis.visit_id VisitId,E.enc_date VisitDate,vis.enc_id EncounterId ,E.issigned,
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
		FROM	[dbo].[RsynSchedulerV2PersonResourceAppointmentSchedules] PAS WITH (NOLOCK)
				INNER JOIN [dbo].[RsynSchedulerV2Appointments] APP WITH (NOLOCK) ON APP.AppointmentId = PAS.AppointmentId AND APP.Active = 1
				INNER JOIN [dbo].[RsynSchedulerV2PersonResources] PR WITH (NOLOCK) ON PAS.PersonResourceId = PR.PersonResourceId AND PR.Active = 1
				INNER JOIN [dbo].[RsynSchedulerV2ApplicationTableConstants] ATCS WITH (NOLOCK) ON ATCS.ApplicationTableConstantId = APP.AppointmentStatusTypeId
				INNER JOIN [dbo].[RsynSchedulerV2CompanyAppointmentTemplates] CAT WITH(NOLOCK) ON CAT.CompanyAppointmentTemplateId = APP.CompanyAppointmentTemplateId
				INNER JOIN [dbo].[RsynSchedulerV2vwDoctorGroups] DG WITH(NOLOCK) ON PAS.DoctorGroupId = DG.DoctorGroupId
				LEFT JOIN [dbo].[RsynSchedulerV2MaterialResources] MR WITH (NOLOCK) ON APP.PrimaryMaterialResourceId  = MR.MaterialResourceId
				LEFT JOIN [dbo].[RsynSchedulerV2vwPatientIndexes] PAI WITH (NOLOCK) ON  PAI.PatientIndexId = PAS.PatientIndexId
				LEFT JOIN [dbo].[RsynSchedulerV2vwPatients] PAT WITH (NOLOCK) ON PAT.PatientId = PAI.CurrentPatientId
				LEFT JOIN [dbo].[RsynSchedulerV2vwPersons] PER WITH (NOLOCK) ON PER.PersonId = PAT.PersonId
				INNER JOIN dbo.RsynMasterPatients MPAT WITH(NOLOCK) ON PAI.CurrentPatientId = MPAT.PatientId
				INNER JOIN dbo.RsynMasterPatientExternalAppMaps PEM WITH(NOLOCK) ON PEM.PatientId = MPAT.PatientId 
				LEFT OUTER JOIN patient_visit_appointment_detail vis_det WITH(NOLOCK) ON vis_det.MasterPatientId = PAI.CurrentPatientId AND  vis_det.AppointmentId = APP.AppointmentId
				LEFT OUTER JOIN patient_visit vis WITH(NOLOCK) ON vis.visit_id = vis_det.visit_id 
				LEFT OUTER JOIN enchanced_encounter E WITH(NOLOCK) ON E.enc_id = vis.enc_id

		WHERE ((PAS.StartDateTime BETWEEN @StartDateTime AND @EndDateTime)
			OR (PAS.EndDateTime BETWEEN @StartDateTime AND @EndDateTime))
			AND PAS.DoctorCompanyId = @DoctorCompanyId
			AND PAS.Active = 1
			AND APP.AppointmentStatusTypeId Not In (286)
	)t
		SELECT *, ISNULL(datediff(minute,CheckInTime,CompletedTime), 0) AS AppointmentDurationMinutes	    FROM #tempPerAppSchedule

 
	DROP TABLE #tempPerAppSchedule
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
