SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Lab Test by detail
-- =============================================
CREATE    PROCEDURE [cqm2023].[SearchPatientLabTestByDetail]
  @PatientId			BIGINT,
  @LabTestNumber		VARCHAR(30),
  @DoctorId				BIGINT
AS
BEGIN
	DECLARE @LabId AS BIGINT=0
	
	SELECT @LabId=lm.lab_id FROM lab_main lm WITH(NOLOCK)
	INNER JOIN lab_result_info lri WITH(NOLOCK) ON lm.lab_id=lri.lab_id
	WHERE lm.pat_id=@PatientId AND lm.dr_id=@DoctorId AND lri.obs_bat_ident=@LabTestNumber
	
	SELECT @LabId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
