SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	23-OCT-2018
Description			:	This procedure is used to Clear Patient Detailed Race
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_ClearPatientDetailedRaces]	
	@PatientId			BIGINT

AS
BEGIN
	DELETE FROM [dbo].[patient_race_details] WHERE pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
