SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Singaravelan    
-- Create date: 02/DEC/2016
-- Description: Procedure to get All Patient Encounters    
-- =============================================    
CREATE PROCEDURE [enc].[usp_GetAllPatientEncounters]
(	
	@PatientId INT,
	@IncludeIsSigned BIT
)
AS
BEGIN
	SELECT encounter_version, patient_id, issigned, type, enc_date, enc_id
	FROM enchanced_encounter WITH(NOLOCK)
	WHERE patient_id = @PatientId AND (issigned = @IncludeIsSigned OR @IncludeIsSigned IS NULL)
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
