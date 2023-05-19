SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	12-OCT-2018
Description			:	This procedure is used to Invalidate Patient Registration Pins
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_InvalidatePatientRegistrationPins]	
	-- Add the parameters for the stored procedure here
	@PatientId	BIGINT
AS
BEGIN
	UPDATE	dbo.patient_reg_db
	SET		active=0,
			last_modified_date=GETDATE(),
			last_modified_by=1
	WHERE	pa_id=@PatientId
			AND ISNULL(active,0)=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
