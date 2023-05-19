SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	01-AUGUST-2016
Description			:	This procedure is used to Get Consensed Patient Profile Item Container List
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetCondensedPatientProfileitemContainerList]	
	@PatientId BIGINT

AS
BEGIN
		SELECT PH.HEADERID, PI.ITEM_ID, PH.HEADERTEXT, PI.ITEM_LABEL, PD.ITEM_TEXT, 
		D.DR_LAST_NAME + ', ' + D.DR_FIRST_NAME FULLNAME, P.LAST_UPDATE_DATE 
        FROM PATIENT_PROFILE P INNER JOIN PATIENT_PROFILE_DETAILS PD 
        ON P.PROFILE_ID = PD.PROFILE_ID INNER JOIN PATIENT_PROFILE_ITEMS PI ON 
        PD.ITEM_ID = PI.ITEM_ID INNER JOIN PATIENT_PROFILE_HEADERS PH ON
        PI.HEADER_ID = PH.HEADERID INNER JOIN DOCTORS D ON P.LAST_UPDATE_DR_ID = D.DR_ID 
        WHERE P.PATIENT_ID = @patientId ORDER BY PH.ORDERID, PI.ORDER_ID
END






		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
