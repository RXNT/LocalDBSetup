SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 5/14/2015
-- Description:	Checkout the appointment
-- =============================================
CREATE PROCEDURE [sch].[usp_CheckoutAppointment]
	-- Add the parameters for the stored procedure here
	@PatientId BIGINT,
	@PatientName VARCHAR(100),
    @DoctorCompanyId BIGINT,
    @StartDateTime DATETIME2,
    @EndDateTime DATETIME2,
    @DoctorId BIGINT,
    @CheckoutTime DATETIME2,
    @ROOMNAME VARCHAR(50) =  NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @AppointmentId AS BIGINT
	
	DECLARE @TimeDifference AS BIGINT
	Set @TimeDifference=0
	
	select @TimeDifference=time_difference  from doctors where dr_id=@DoctorId
	if(@TimeDifference>0)
	Begin
		Set @StartDateTime=DATEADD(hh,@TimeDifference,@StartDateTime)
		Set @EndDateTime=DATEADD(hh,@TimeDifference,@EndDateTime)
		--Set @CheckoutTime=DATEADD(hh,@TimeDifference,@CheckoutTime)		
	End
	
	DECLARE @DoctorGroupId BIGINT
	DECLARE @RoomId BIGINT
	
	IF LEN(@RoomName)>0
	BEGIN
		IF @DoctorId>0
		BEGIN
			SELECT @DoctorGroupId=dg_id FROM doctors WITH(NOLOCK) WHERE dr_id=@DoctorId 
		END
		ELSE
		BEGIN
			SELECT @DoctorGroupId=dg_id FROM patients WITH(NOLOCK) WHERE pa_id=@PatientId 
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
        SET @AppointmentId = SCOPE_IDENTITY()

	END
	ELSE
	BEGIN
		UPDATE scheduler_main 
		SET [dtCheckedout] = @CheckoutTime,
			[status]	= 1
		WHERE event_start_date	= @StartDateTime AND 
				event_end_date	= @EndDateTime AND 
				dr_id			= @DoctorId	AND
				ext_link_id		= @PatientId
		
		SELECT TOP 1 @AppointmentId= event_id 
		FROM scheduler_main 
		WHERE event_start_date	= @StartDateTime AND 
				event_end_date	= @EndDateTime AND 
				dr_id			= @DoctorId	AND
				ext_link_id		= @PatientId
	END	
	
	UPDATE [patient_visit] 
	SET [dtEnd] = @CheckoutTime
	WHERE [appt_id] = @AppointmentId AND
		[pa_id] = @PatientId
		 
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
