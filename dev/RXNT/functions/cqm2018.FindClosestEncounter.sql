SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [cqm2018].[FindClosestEncounter] 
	(@Date AS DATETIME,@PatientID AS INT, @DoctorId AS INT)
RETURNS INT
AS
BEGIN
	SET @Date = DATEADD(DAY,1,CAST(CONVERT(VARCHAR(20),@Date,101) AS DATETIME))
	-- Declare variables
	DECLARE @EnounterId AS INT = 0
	
	SELECT TOP 1 @EnounterId =  enc_id
	FROM enchanced_encounter ee WITH(NOLOCK)
	WHERE ee.enc_date <= @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
	ORDER BY ee.enc_date DESC,ee.enc_id DESC
	-- Return the new converted datetime
	IF @EnounterId IS NULL
	BEGIN
		SELECT TOP 1 @EnounterId =  enc_id
		FROM enchanced_encounter ee WITH(NOLOCK)
		WHERE ee.enc_date > @Date AND ee.dr_id = @DoctorId AND ee.patient_id = @PatientID
		ORDER BY ee.enc_date DESC,ee.enc_id DESC
	END
	
	RETURN @EnounterId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
