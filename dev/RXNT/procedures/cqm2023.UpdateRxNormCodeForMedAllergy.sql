SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	26-NOV-2022
-- Description:		Update RxNormCode for MedAllergy
-- =============================================
CREATE    PROCEDURE [cqm2023].[UpdateRxNormCodeForMedAllergy]
  @AllergyId			BIGINT,
  @RxNormCode			VARCHAR(30)=NULL
AS
BEGIN
	
	UPDATE patient_new_allergies SET rxnorm_code = @RxNormCode
	WHERE pa_allergy_id=@AllergyId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
