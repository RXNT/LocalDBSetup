SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	06-JUNE-2016
Description			:	This procedure is used to Get Patient Race Code
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [ehr].[usp_SavePatientDetailedEthnicity]	
	@Code			bigint	,
	@PatientId		bigint,
	@DoctorId		bigint,
	@Raceid			bigint = NULL
AS
BEGIN
	

	INSERT INTO [dbo].[patient_ethnicity_details] ([pa_id],[ethnicity_id],[dr_id]) VALUES (@PatientId, @Code, @DoctorId)



END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
