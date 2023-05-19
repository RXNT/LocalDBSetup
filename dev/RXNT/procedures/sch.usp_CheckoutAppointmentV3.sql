SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		VINOD
-- Create date: 4/2/2019
-- Description:	Checkout the appointment
-- =============================================
CREATE PROCEDURE [sch].[usp_CheckoutAppointmentV3]
	-- Add the parameters for the stored procedure here
	@PatientId BIGINT,
	@PatientName VARCHAR(100),
    @DoctorCompanyId BIGINT,
    @StartDateTime DATETIME2,
    @EndDateTime DATETIME2,
    @CheckoutTime DATETIME2,
    @ROOMNAME VARCHAR(50) =  NULL,
    @DoctorGroupId BIGINT =  NULL,
    @DoctorFirstName VARCHAR(50) =  NULL,
    @DoctorLastName VARCHAR(50) =  NULL,
	@PersonResourceId BIGINT,
	@MasterCompanyId BIGINT,
	@MasterLoginId BIGINT,
	@MasterPatientId BIGINT,
	@AppointmentId BIGINT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @DoctorId  BIGINT = 0;
	DECLARE @VisitId AS BIGINT	
	DECLARE @OldAppointmentId AS BIGINT
	
	DECLARE @TimeDifference AS BIGINT
	Set @TimeDifference=0
	
	SELECT TOP 1 @DoctorId=dr_id FROM doctors WHERE 
	dg_id = @DoctorGroupId AND dr_first_name=@DoctorFirstName
	AND dr_last_name = @DoctorLastName AND dr_enabled=1
	
	select @TimeDifference=time_difference  from doctors where dr_id=@DoctorId
	if(@TimeDifference>0)
	Begin
		Set @StartDateTime=DATEADD(hh,@TimeDifference,@StartDateTime)
		Set @EndDateTime=DATEADD(hh,@TimeDifference,@EndDateTime)
		--Set @CheckoutTime=DATEADD(hh,@TimeDifference,@CheckoutTime)		
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
           ,[dtCheckedout]
           ,[is_confirmed]
           ,[is_delete_attempt])
     VALUES
           (@StartDateTime
           ,@DoctorId
           ,0
           ,@PatientId
           ,''
           ,@RoomId
           ,@PatientName
           ,@EndDateTime
           ,0
           ,1
           ,@CheckoutTime
           ,0
           ,0)
             SET @OldAppointmentId = SCOPE_IDENTITY()

	END
	ELSE
	BEGIN
		UPDATE scheduler_main 
		SET [dtCheckedout] = @CheckoutTime,
			[status]	= 1,
			room_id=ISNULL(@RoomId,room_id)
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
	
	

	IF NOT EXISTS(SELECT * FROM [dbo].[patient_visit_appointment_detail] 
		WHERE AppointmentId	= @AppointmentId )
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
		,@CheckoutTime
		,CAST('1901-01-01 00:00:00' AS DATETIME)
		,0
		,''
		,'')
		 SET @VisitId = SCOPE_IDENTITY()

		INSERT INTO [dbo].[patient_visit_appointment_detail]
           ([visit_id],
		   [AppointmentId]
           ,[MasterPatientId]
           ,[MasterCompanyId]
           ,[MasterLoginId]
           ,[PersonResourceID]
           ,[CreatedDate]
           ,[CreatedBy])
     
     VALUES
           (@VisitId,@AppointmentId,@MasterPatientId,@MasterCompanyId,
		   @MasterLoginId,@PersonResourceId,GETDATE(),1)
	END
	ELSE
	BEGIN
		UPDATE [patient_visit] 
		SET [dtEnd] = @CheckoutTime
		WHERE [appt_id] = @OldAppointmentId AND
			[pa_id] = @PatientId

	END
		 
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
