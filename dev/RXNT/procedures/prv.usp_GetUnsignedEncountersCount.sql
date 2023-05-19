SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	30-MAY-2017
Description			:	This procedure is used to get pending Patient encounters count
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_GetUnsignedEncountersCount]	
	@DoctorId			BIGINT,
	@DoctorGroupId		BIGINT
	
AS
BEGIN

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;  
  
  DECLARE @PreferredPrescriberId BIGINT = 0;
	
	SELECT @PreferredPrescriberId=di.staff_preferred_prescriber 
	FROM dbo.doctor_info di WITH(NOLOCK)
	WHERE di.dr_id=@DoctorId 

	IF(@PreferredPrescriberId>0)
	BEGIN
		SET @DoctorId = @PreferredPrescriberId;
	END
  Declare @Count as int
  
  SELECT @Count=COUNT(1)
  FROM enchanced_encounter A WITH(NOLOCK)
  INNER JOIN DOCTORS B WITH(NOLOCK) ON A.DR_ID = B.DR_ID 
  INNER JOIN DOCTORS C WITH(NOLOCK) ON A.ADDED_BY_DR_ID  = C.DR_ID  
  INNER JOIN PATIENTS PAT WITH(NOLOCK) on A.patient_id=PAT.pa_id 
  WHERE A.DR_ID = @DoctorId AND B.DG_ID=@DoctorGroupId   AND A.ISSIGNED=0
  
	Select @Count as EncountersCount	
  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
