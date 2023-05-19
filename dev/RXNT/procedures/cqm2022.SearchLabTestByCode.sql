SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Lab Test by LOINC Code
-- =============================================
CREATE   PROCEDURE [cqm2022].[SearchLabTestByCode]
	@Code VARCHAR(20),
	@Description VARCHAR(500)
AS
BEGIN
	DECLARE @LabTestId AS BIGINT=0
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM lab_test_lists WHERE loinc_code=@Code AND active=1)
	BEGIN
	
		INSERT INTO lab_test_lists (loinc_code,active,CODE_TYPE, lab_test_name, lab_test_name_long)
		VALUES(@Code, 1, 'LOINC',@Description, @Description)
		
	END
	
	SELECT @LabTestId=ISNULL(lab_test_id,0) FROM lab_test_lists
	WHERE loinc_code=@Code AND active=1
	
	SELECT @LabTestId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
