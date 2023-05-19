SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Sheik
Create date			:	24-JAN-2020
Description			:	To search appointments
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [sch].[usp_SearchAppointment] --'02/1/2020','02/12/2020',462,6782

	@StartDate DateTime = NULL,
	@EndDate DateTime = NULL,
	@DoctorCompanyId BIGINT,
	@LoggedInUserId BIGINT,
	@CreatedDate DateTime = NULL


AS
BEGIN

	EXEC	[sch].[usp_ValidateLoggedInUserDoctorCompany]
			@LoggedInUserId = @LoggedInUserId, 
			@DoctorCompanyId = @DoctorCompanyId
    IF @@ERROR > 0 RETURN;
    
		SELECT * INTO #tempPerResAppSchedule FROM(
			Select * from [dbo].[RsynSchedulerV2PersonResourceAppointmentSchedules] PAS
			where PAS.Active = 1
				AND PAS.DoctorCompanyId = @DoctorCompanyId
				AND( DATEADD(D, 0, DATEDIFF(D, 0, PAS.StartDateTime)) BETWEEN @StartDate AND @EndDate OR @StartDate IS NULL OR @EndDate IS NULL)
				AND (CONVERT(varchar(10),PAS.CreatedDate, 101) = CONVERT(varchar(10),@CreatedDate,101) OR @CreatedDate IS NULL)) temp;
		
		DECLARE @CKCId BIGINT
		SELECT @CKCId = ApplicationTableConstantId FROM   [dbo].[RsynSchedulerV2ApplicationTableConstants] STS WITH (NOLOCK) WHERE STS.Code = 'CKC';
		DECLARE @CLDINId BIGINT
		SELECT @CLDINId = ApplicationTableConstantId FROM   [dbo].[RsynSchedulerV2ApplicationTableConstants] STS WITH (NOLOCK) WHERE STS.Code = 'CLDIN';
		DECLARE @CMPId BIGINT
		SELECT @CMPId = ApplicationTableConstantId FROM   [dbo].[RsynSchedulerV2ApplicationTableConstants] STS WITH (NOLOCK) WHERE STS.Code = 'CMP';
		DECLARE @INTKCId BIGINT 
		SELECT @INTKCId = ApplicationTableConstantId FROM   [dbo].[RsynSchedulerV2ApplicationTableConstants] STS WITH (NOLOCK) WHERE STS.Code = 'INTKC';
		SELECT * INTO #tempPerAppSchedule FROM(
		SELECT PAS.PersonResourceAppointmentScheduleId As AppointmentScheduleId,
			   PAS.PersonResourceId As ResourceId,
			   PAS.DoctorCompanyId,
			   PAS.DoctorGroupId,
			   PAI.CurrentPatientId AS PatientId,
			   DG.Name As DoctorGroupName,
			   ISNULL(PER.LastName,'')  + ',' + ISNULL(' ' + PER.FirstName,'') + COALESCE(' ' + PER.MiddleInitial, '') As FullName,
			   PR.Name As ResourceName,
			   MR.Name As MaterialResourceName,	
			   APP.AppointmentSeriesId,
			   APP.CompanyServiceTypeId,
			   APP.CompanyAppointmentTypeId,
			   APP.CompanyAppointmentReasonId,
			   APP.SeriesIndexNumber,
			   APP.AppointmentStatusTypeId,
			   ATC.Description As AppointmentStatus,
			   CAT.Name AS AppointmentType,
			   ATC.Code,
			   PAS.DayOfWeek,
			   PAS.Month,
			   PAS.Quarter,
			   PAS.Year,
			   PAS.DurationMinutes,
			   PAS.StartDateTime,
			   PAS.EndDateTime,
			   PAS.AppointmentId,
			   PAS.Active,
			   PAS.CreatedDate,
			   PAS.CreatedBy,
			   PAS.Concurrency,
			   1 As IsAppointment,
			   0 As IsPerson,
			   PAT.ChartNumber,
			   ISNULL((select top 1 WF.StatusModifiedDate FROM [dbo].[RsynSchedulerV2AppointmentStatusWorkflow] WF WITH (NOLOCK) WHERE WF.AppointmentId = APP.AppointmentId AND WF.AppointmentStatusTypeId = @CKCId AND WF.Active = 1 ORDER BY WF.CreatedDate DESC), APP.CheckInTime) AS CheckInTime,
			   ISNULL((select top 1 WF.StatusModifiedDate FROM [dbo].[RsynSchedulerV2AppointmentStatusWorkflow] WF WITH (NOLOCK) WHERE WF.AppointmentId = APP.AppointmentId AND WF.AppointmentStatusTypeId = @CLDINId AND WF.Active = 1 ORDER BY WF.CreatedDate DESC), APP.CallInTime) AS CallInTime	,
			   ISNULL((select top 1 WF.StatusModifiedDate FROM [dbo].[RsynSchedulerV2AppointmentStatusWorkflow] WF WITH (NOLOCK) WHERE WF.AppointmentId = APP.AppointmentId AND WF.AppointmentStatusTypeId = @CMPId AND WF.Active = 1 ORDER BY WF.CreatedDate DESC), APP.CheckOutTime) AS CompletedTime		   	   ,
			   (select top 1 WF.StatusModifiedDate FROM [dbo].[RsynSchedulerV2AppointmentStatusWorkflow] WF WITH (NOLOCK) WHERE WF.AppointmentId = APP.AppointmentId AND WF.AppointmentStatusTypeId = @INTKCId AND WF.Active = 1 ORDER BY WF.CreatedDate DESC) AS InTakeCompletedTime,
			   (Select top 1 AN.NoteText FROM [dbo].[RsynSchedulerV2AppointmentNotes] AN WITH (NOLOCK) WHERE AN.AppointmentsId = APP.AppointmentId AND Active= 1 ORDER BY AN.NoteId DESC) AS AppointmentNotes,
			   PEM.ExternalPatientId EHRPatientId,vis.visit_id VisitId,E.enc_date VisitDate,vis.enc_id EncounterId ,E.issigned,E.is_amended,
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
							 ) AS patient_details_missing,
		PMV2.ExternalEncounterId,PMV2.StatusTypeId,STATC.[Description] As StatusTypeDescription
		FROM #tempPerResAppSchedule PAS WITH (NOLOCK)
		INNER JOIN [dbo].[RsynSchedulerV2Appointments] APP WITH (NOLOCK) ON APP.AppointmentId = PAS.AppointmentId AND APP.Active = 1
		INNER JOIN [dbo].[RsynSchedulerV2PersonResources] PR WITH (NOLOCK) ON PAS.PersonResourceId = PR.PersonResourceId AND PR.Active = 1
		INNER JOIN [dbo].[RsynSchedulerV2CompanyAppointmentTemplates] CAT WITH (NOLOCK) ON CAT.CompanyAppointmentTemplateId = APP.CompanyAppointmentTemplateId
		INNER JOIN [dbo].[RsynSchedulerV2ApplicationTableConstants] ATC WITH (NOLOCK) ON ATC.ApplicationTableConstantId = APP.AppointmentStatusTypeId
		INNER JOIN [dbo].[RsynSchedulerV2vwDoctorGroups] DG WITH(NOLOCK) ON PAS.DoctorGroupId = DG.DoctorGroupId
		INNER JOIN [dbo].[RsynSchedulerV2vwPatientIndexes] PAI WITH (NOLOCK) ON PAI.PAtientIndexId = PAS.PatientIndexId
		INNER JOIN [dbo].[RsynSchedulerV2vwPatients] PAT WITH(NOLOCK) ON PAT.PatientId = PAI.CurrentPatientId
		INNER JOIN [dbo].[RsynSchedulerV2vwPersons] PER WITH(NOLOCK) ON PER.PersonId = PAT.PersonId
		LEFT JOIN [dbo].[RsynSchedulerV2MaterialResources] MR WITH (NOLOCK) ON MR.MaterialResourceId = APP.PrimaryMaterialResourceId AND MR.Active = 1
		INNER JOIN dbo.RsynMasterPatients MPAT WITH(NOLOCK) ON PAI.CurrentPatientId = MPAT.PatientId AND MPAT.CompanyId = @DoctorCompanyId
		INNER JOIN dbo.RsynMasterPatientExternalAppMaps PEM WITH(NOLOCK) ON PEM.PatientId = MPAT.PatientId 
		LEFT OUTER JOIN patient_visit_appointment_detail vis_det WITH(NOLOCK) ON vis_det.MasterPatientId = PAI.CurrentPatientId AND  vis_det.AppointmentId = APP.AppointmentId
		LEFT OUTER JOIN patient_visit vis WITH(NOLOCK) ON vis.visit_id = vis_det.visit_id 
		LEFT OUTER JOIN enchanced_encounter E WITH(NOLOCK) ON E.enc_id = vis.enc_id
		LEFT OUTER JOIN [dbo].[RsynPMV2Encounters] PMV2 WITH(NOLOCK) ON CAST(PMV2.ExternalEncounterId AS BIGINT) = E.enc_id AND PMV2.DoctorCompanyId = @DoctorCompanyId
		LEFT OUTER JOIN [dbo].[RsynPMV2ApplicationTableConstants]  STATC WITH (NOLOCK) ON STATC.ApplicationTableConstantId = PMV2.StatusTypeId
		WHERE  PAS.DoctorCompanyId = @DoctorCompanyId AND APP.AppointmentStatusTypeId Not In (286)) t;
		SELECT *, ISNULL(datediff(minute,CheckInTime,CompletedTime), 0) AS AppointmentDurationMinutes FROM #tempPerAppSchedule
		   
DROP TABLE #tempPerResAppSchedule
DROP TABLE #tempPerAppSchedule
		   

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
