SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	21-SEPT-2018
Description			:	This procedure is used to Get Active Patient Portal Registration Pin
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [dbo].[usp_GetPatientRegistrationPin]
	@PatientId				BIGINT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT TOP 1 pincode
	FROM [patient_reg_db]
	WHERE pa_id=@PatientId AND ISNULL(active,0)=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
