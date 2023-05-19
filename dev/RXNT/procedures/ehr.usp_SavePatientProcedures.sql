SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	15-JULY-2016
Description			:	This procedure is used to Save Patient Procedures
Last Modified By	:   JahabarYusuff(to save the Reason)
Last Modifed Date	:	27-Nov-2017
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SavePatientProcedures]	
	
	@ProcedureId		INT OUTPUT,
	@PatientId			INT,
    @DoctorId			INT,
	@DatePerformed		DATETIME,
	@DatePerformedTo	DATETIME,
	@Type				VARCHAR(50),
	@Status				VARCHAR(50),
	@CPTCode			NVARCHAR(50),	
	@Description		NVARCHAR(225),
	@Reason		VARCHAR(50),
	@ReasonType		VARCHAR(50),
	@ReasonTypeCode			NVARCHAR(20)
	
AS
BEGIN
IF ISNULL(@ProcedureId,0) = 0
BEGIN
	INSERT INTO [patient_procedures] ([pa_id],[dr_id],[date_performed],[date_performed_to],[type],[status],[code],[description],reason, reason_type, reason_type_code ) 
	VALUES (@PatientId, @DoctorId, @DatePerformed, @DatePerformedTo, @Type, @Status, @CPTCode, @Description,@Reason, @ReasonType, @ReasonTypeCode)
	SET @ProcedureId = SCOPE_IDENTITY();
END
ELSE
BEGIN
	UPDATE [patient_procedures] SET [pa_id] = @PatientId,[dr_id] = @DoctorId,
	[date_performed] = @DatePerformed,[date_performed_to] = @DatePerformedTo,
	[type] = @TYPE,[status] = @Status,[code] = @CPTCode,[description] = @Description, [reason] = @Reason, [reason_type] = @ReasonType, [reason_type_code] = @ReasonTypeCode WHERE PROCEDURE_ID =@ProcedureId
END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
