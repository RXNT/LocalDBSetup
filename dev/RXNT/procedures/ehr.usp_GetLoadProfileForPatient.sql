SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	29-JULY-2016
Description			:	This procedure is used to Get Load Profile For Patient
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetLoadProfileForPatient]	
	@PatientId BIGINT

AS
BEGIN
		SELECT P.PROFILE_ID, P.PATIENT_ID, P.ADDED_BY_DR_ID, P.ENTRY_DATE, P.LAST_UPDATE_DATE,
		P.LAST_UPDATE_DR_ID, PD.ITEM_ID, PD.ITEM_TEXT FROM PATIENT_PROFILE P 
		INNER JOIN PATIENT_PROFILE_DETAILS PD ON P.PROFILE_ID = PD.PROFILE_ID 
		INNER JOIN PATIENT_PROFILE_ITEMS PPI ON PD.ITEM_ID = PPI.ITEM_ID  
		WHERE P.PATIENT_ID = @PatientId ORDER BY PPI.ORDER_ID 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
