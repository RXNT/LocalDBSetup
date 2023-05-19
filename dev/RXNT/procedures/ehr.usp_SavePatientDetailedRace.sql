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

CREATE PROCEDURE [ehr].[usp_SavePatientDetailedRace]	
	@Code			VARCHAR(50)	,
	@PatientId		bigint,
	@DoctorId		bigint,
	@Raceid			bigint = NULL
AS
BEGIN
	
select @Raceid = ATC.ApplicationTableConstantId from ehr.ApplicationTables AT
INNER JOIN ehr.ApplicationTableConstants ATC ON ATC.ApplicationTableId =AT.ApplicationTableId
INNER JOIN ehr.SysLookupCodes SLC ON SLC.ApplicationTableConstantCode = ATC.Code
where AT.Code='PARCE' and SLC.Code = @Code

		INSERT INTO [dbo].[patient_race_details] ([pa_id],[race_id],[dr_id]) VALUES (@PatientId, @Raceid, @DoctorId)



END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
