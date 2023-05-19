SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  RAJARAM GANJIKUNTA    
-- Create date: 22/FEB/2018
-- Description: Procedure to get doctor
-- =============================================    
CREATE PROCEDURE [enc].[usp_GetDoctor]
(	
	@DoctorGroupId BIGINT,
	@DoctorId BIGINT
)
AS
BEGIN
	SELECT D.dr_sig_file
    FROM DOCTORS D WITH(NOLOCK)
    INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON D.DG_ID = DG.DG_ID
    WHERE D.dr_id=@DoctorId AND D.DG_ID = @DoctorGroupId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
