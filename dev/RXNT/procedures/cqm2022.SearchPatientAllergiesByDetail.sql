SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Allergy by detail
-- =============================================
CREATE   PROCEDURE [cqm2022].[SearchPatientAllergiesByDetail]
	@PatientId			BIGINT,	
	@AllergyId			BIGINT,
	@AllergyType		INT,
	@DateAdded			DATETIME=NULL
AS
BEGIN
	DECLARE @AlrgyId AS BIGINT=0
	
	SELECT @AlrgyId=ISNULL(pa_allergy_id,0) FROM patient_new_allergies
	WHERE pa_id=@PatientId AND allergy_id = @AllergyId AND allergy_type=@AllergyType AND CONVERT(VARCHAR(10), add_date, 101)=@DateAdded
	
	SELECT @AlrgyId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
