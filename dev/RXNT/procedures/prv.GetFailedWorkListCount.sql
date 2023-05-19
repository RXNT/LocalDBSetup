SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[GetFailedWorkListCount]
	 @DoctorId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT COUNT(spo_ir_id)
	FROM   [spe].[SPEMessages] spe_mess WITH(nolock) 
    INNER JOIN prescriptions ON prescriptions.pres_id = spe_mess.pres_id
	WHERE  prescriptions.dr_id = @DoctorId AND spe_mess.is_success=0
	Return 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
