SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Niyaz
-- Create date: 27th July 2018
-- Description:	Checkin the appointment V2
-- =============================================
CREATE PROCEDURE [sch].[usp_CheckinAppointmentV2]
	-- Add the parameters for the stored procedure here
	@PatientId BIGINT,
	@PatientName VARCHAR(100),
    @DoctorCompanyId BIGINT,
    @StartDateTime DATETIME2,
    @EndDateTime DATETIME2,
    @CheckInTime DATETIME2,
    @RoomName VARCHAR(50) =  NULL,
    @DoctorGroupId BIGINT =  NULL,
    @DoctorFirstName VARCHAR(50) =  NULL,
    @DoctorLastName VARCHAR(50) =  NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @DoctorId  BIGINT = 0;
	DECLARE @VisitId AS BIGINT
	DECLARE @OldAppointmentId AS BIGINT
	DECLARE @NewAppointmentId AS BIGINT
	DECLARE @TimeDifference AS BIGINT
	Set @TimeDifference=0
	
	SELECT TOP 1 @DoctorId=dr_id FROM doctors WHERE 
	dg_id = @DoctorGroupId AND dr_first_name=@DoctorFirstName
	AND dr_last_name = @DoctorLastName AND dr_enabled=1
	
	DECLARE @MasterPatientId AS BIGINT
	DECLARE @MasterCompanyId AS BIGINT
	DECLARE @MasterLoginId AS BIGINT
	DECLARE @PersonResourceId AS BIGINT
	
	SELECT @MasterCompanyId = CompanyId 
	FROM dbo.RsynMasterCompanyExternalAppMaps WITH(NOLOCK)
	WHERE ExternalCompanyId = @DoctorCompanyId AND ExternalAppId=1 AND Active=1
	
	SELECT @MasterPatientId = PatientId 
	FROM dbo.RsynMasterPatientExternalAppMaps WITH(NOLOCK)
	WHERE CompanyId=@MasterCompanyId AND ExternalPatientId=@PatientId AND ExternalDoctorCompanyId = @DoctorCompanyId AND ExternalAppId=1 AND Active=1
	
	SELECT @MasterLoginId = LoginId 
	FROM dbo.RsynRxNTMasterLoginExternalAppMaps WITH(NOLOCK)
	WHERE CompanyId=@MasterCompanyId AND ExternalLoginId=@PatientId AND ExternalCompanyId = @DoctorCompanyId AND ExternalAppId=1 AND Active=1
	
	SELECT TOP 1 @PersonResourceId =  PersonResourceId FROM [dbo].[RsynSchedulerV2PersonResources] PR WITH(NOLOCK)
	INNER JOIN dbo.RsynRxNTMasterLogins ML  WITH(NOLOCK) ON PR.AppLoginId= ML.LoginId AND ML.FirstName=@DoctorFirstName AND ML.LastName=@DoctorLastName AND PR.Active=1
	WHERE PR.AppLoginId = @MasterLoginId  
	
	SELECT TOP 1 @NewAppointmentId=AppointmentId 
	FROM [dbo].[RsynSchedulerV2Appointments]  WITH(NOLOCK) 
	WHERE PatientId=@MasterPatientId AND StartDateTime= @StartDateTime AND EndDateTime	= @EndDateTime AND PrimaryPersonResourceId	= @PersonResourceId	AND Active=1 
	
	SELECT @TimeDifference=time_difference  from doctors where dr_id=@DoctorId
	if(@TimeDifference>0)
	Begin
		Set @StartDateTime=DATEADD(hh,@TimeDifference,@StartDateTime)
		Set @EndDateTime=DATEADD(hh,@TimeDifference,@EndDateTime)
		--Set @CheckInTime=DATEADD(hh,@TimeDifference,@CheckInTime)		
	End
	
	DECLARE @RoomId BIGINT
	
	IF LEN(@RoomName)>0 
	BEGIN
		IF ISNULL(@DoctorGroupId,0)<=0
		BEGIN
			IF @DoctorId>0
			BEGIN
				SELECT @DoctorGroupId=dg_id FROM doctors WITH(NOLOCK) WHERE dr_id=@DoctorId 
			END
			ELSE
			BEGIN
				SELECT @DoctorGroupId=dg_id FROM patients WITH(NOLOCK) WHERE pa_id=@PatientId 
			END
		END
		
		EXEC [dbo].[GetSchedulerRoomNameId]@DoctorGroupId=@DoctorGroupId,@RoomName=@RoomName,@RoomId=@RoomId OUTPUT
	END
	
	IF NOT EXISTS(SELECT * FROM scheduler_main 
		WHERE event_start_date	= @StartDateTime AND 
				event_end_date	= @EndDateTime AND 
				dr_id			= @DoctorId	AND
				ext_link_id		= @PatientId)
	BEGIN
		INSERT INTO [dbo].[scheduler_main]
           ([event_start_date]
           ,[dr_id]
           ,[type]
           ,[ext_link_id]
           ,[note]
           ,room_id
           ,[detail_header]
           ,[event_end_date]
           ,[is_new_pat]
           ,[status]
           ,[dtCheckIn]
           ,[is_confirmed]
           ,[is_delete_attempt])
     VALUES
           (@StartDateTime
           ,@DoctorId
           ,0
           ,@PatientId
           ,''
           --,ISNULL(CASE WHEN LEN(@RoomName)>1 THEN 'Room Name: '+@RoomName ELSE '' END,'')
           ,@RoomId
           ,@PatientName
           ,@EndDateTime
           ,0
           ,2
           ,@CheckInTime
           ,0
           ,0)
        SET @OldAppointmentId = SCOPE_IDENTITY()

	END
	ELSE
	BEGIN
		UPDATE scheduler_main 
		SET [dtCheckIn] = @CheckInTime,
			[status]	= 2,
			--[note] = ISNULL(CASE WHEN LEN([note])>1 THEN [note] ELSE 'Room Name: '+@RoomName END,'')
			room_id		= ISNULL(@RoomId,room_id)
		WHERE event_start_date	= @StartDateTime AND 
				event_end_date	= @EndDateTime AND 
				dr_id			= @DoctorId	AND
				ext_link_id		= @PatientId
				
		SELECT TOP 1 @OldAppointmentId= event_id 
		FROM scheduler_main 
		WHERE event_start_date	= @StartDateTime AND 
				event_end_date	= @EndDateTime AND 
				dr_id			= @DoctorId	AND
				ext_link_id		= @PatientId
	END	
	IF @OldAppointmentId>0
	BEGIN
		INSERT INTO [patient_visit] 
		([appt_id]
		,[pa_id]
		,[dr_id]
		,[vital_id]
		,[dtCreate]
		,[dtEnd]
		,[enc_id]
		,[reason]
		, [chkout_notes]) 
		VALUES
		(@OldAppointmentId
		,@PatientId
		,@DoctorId
		,0
		,@CheckInTime
		,CAST('1901-01-01 00:00:00' AS DATETIME)
		,0
		,''
		,'');
		
		SET @VisitId=SCOPE_IDENTITY();
		
		INSERT INTO [dbo].[patient_visit_appointment_detail]
           (visit_id,
           [AppointmentId]
           ,[MasterPatientId]
           ,[MasterCompanyId]
           ,[MasterLoginId]
           ,[PersonResourceID]
           ,[CreatedDate]
           ,[CreatedBy])
     
     VALUES
           (@VisitId,@NewAppointmentId,@MasterPatientId,@MasterCompanyId,
		   @MasterLoginId,@PersonResourceId,GETDATE(),1)
		
	END
	
    --select event_id, b.room_name, ext_link_id, detail_header, dr_last_name + ' , ' + dr_first_name dr_name, dateadd(hh,-@offset, event_start_date) event_start_date, case when dtCalled is not null and dtCalled > '1/1/1901' then DATEADD(hh, -@offset, dtCalled) else null end dtCalled, case when (dtCheckIn is not null and dtCheckIn > '1/1/1901') then DATEADD(hh, -@offset, dtCheckIn) else null end dtCheckIn,case when (dtintake is not null and dtintake > '1/1/1901') then DATEADD(hh, -@offset, dtintake) else null end dtintake, case when dtCheckedOut is not null and dtCheckedOut > '1/1/1901' then DATEADD(hh, -@offset, dtCheckedOut) else null end dtCheckedout, case when (dtCheckIn is null or dtCheckIn <= '1/1/1901' or dtCalled is null or dtCalled <= '1/1/1901') then 0 else datediff(n, dtCheckin, dtCalled) end waiting_room_wait, case when dtCalled IS NULL or dtCalled <= '1/1/1901' or dtCheckedOut <= '1/1/1901'  or dtCheckedOut is null then 0 else datediff(n, dtCalled, dtCheckedout) end exam_wait  from scheduler_main a inner join doctors dr on a.dr_id=dr.dr_id left outer join scheduler_rooms b on a.room_id = b.room_id where event_start_date >  DATEADD(hh, -datepart(hh, getdate()), GETDATE()) and event_end_date <= DATEADD(hh, -datepart(hh, getdate()+1),  GETDATE() + 1) and dr.dg_id = @dgid order by event_start_date"
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
