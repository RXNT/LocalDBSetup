SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vinod
Create date			:	6-Nov-2017
Description			:	This procedure is used to get Save Doctor Patient Messages
=======================================================================================
*/


CREATE PROCEDURE [ext].[usp_SaveDoctorPatientMessages] 
	@PatientId bigint,
	@ToId      bigint,
	@Message   VARCHAR(500),
	@MessageDate DATETIME,
	@MessageDigestion VARCHAR(500)
	
AS
BEGIN	
	INSERT INTO doctor_patient_messages
		(from_id, to_id, msg_date, message, messagedigest)
	VALUES (@PatientId, @ToId, @MessageDate, @Message, @MessageDigestion)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
