SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Nambi
Create date			:	27-JAN-2020
Description			:	This procedure is used to get EPCS enabled doctors
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE PROCEDURE [adm].[usp_GetEPCSEnabledDoctors]
	@DoctorIds VARCHAR(8000)=NULL
AS
BEGIN
	SET NOCOUNT ON;
	SELECT			dr_id as DoctorId,
					epcs_enabled AS EPCSEnabled
	FROM			dbo.doctors WITH(NOLOCK)
	WHERE			dr_enabled=1 AND
					epcs_enabled=1 AND
					dr_id IN (SELECT * FROM dbo.SplitString(@DoctorIds, ','))
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
