SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Balaji
Create date			:	09-SEP-2016
Description			:	This procedure is used to get Patient encounters count
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_GetEncountersCount]	
	@DoctorId			BIGINT,
	@DoctorGroupId		BIGINT
	
AS
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
  Declare @Count as int
  
  SELECT @Count=COUNT(1)
  FROM enchanced_encounter A 
  INNER JOIN DOCTORS B ON A.DR_ID = B.DR_ID 
  INNER JOIN DOCTORS C ON A.ADDED_BY_DR_ID  = C.DR_ID  
  LEFT OUTER JOIN DOCTORS D ON A.LAST_MODIFIED_BY  = D.DR_ID 
  INNER JOIN PATIENTS PAT on A.patient_id=PAT.pa_id 
  LEFT OUTER JOIN RxNTBilling..encounters e on a.enc_id = e.rxnt_encounter_id 
  WHERE A.DR_ID = @DoctorId AND B.DG_ID=@DoctorGroupId   AND A.ISSIGNED=0
  
	Select @Count as EncountersCount	
  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
