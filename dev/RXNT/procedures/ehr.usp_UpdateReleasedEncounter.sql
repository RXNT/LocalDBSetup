SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	02-JUNE-2017
Description			:	This procedure is used to update released flag for encounter
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_UpdateReleasedEncounter]	
	@DoctorId			BIGINT,	
	@EncounterId		BIGINT
	
AS
BEGIN
	UPDATE enchanced_encounter SET is_released=1
	WHERE enc_id=@EncounterId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
