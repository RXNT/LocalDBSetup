SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod Kumar
Create date			:	11-17-2017
Description			:	This procedure is used to Get Selected Patient Race Items
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [dbo].[usp_GetSelectedListRaces]	
	@patid BIGINT

AS
BEGIN
		SELECT PA_RACE_ID, PA_ID, A.RACE_ID, RACE_TEXT, dr_id, date_added, 
		B.Description AS TITLE,B.Code
		 FROM patient_race_details A WITH(NOLOCK)
		INNER JOIN ehr.ApplicationTableConstants B WITH(NOLOCK) ON A.RACE_ID = B.ApplicationTableConstantId
		WHERE A.PA_ID = @patid 	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
