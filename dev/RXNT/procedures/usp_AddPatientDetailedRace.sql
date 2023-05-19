SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	23-OCT-2018
Description			:	This procedure is used to Add Patient Detailed Race
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_AddPatientDetailedRace]	
	@PatientId			BIGINT,
	@DoctorId			BIGINT,
	@RaceDetailId		BIGINT

AS
BEGIN
	IF NOT EXISTS(SELECT TOP 1 1 FROM [dbo].[patient_race_details] WITH(NOLOCK) WHERE race_id=@RaceDetailId AND pa_id=@PatientId)
	BEGIN
		INSERT INTO [dbo].[patient_race_details]
		([pa_id],[race_id],[dr_id])
		VALUES (@PatientId, @RaceDetailId, @DoctorId)
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
