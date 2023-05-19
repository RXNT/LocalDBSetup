SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Singaravelan    
-- Create date: 07/DEC/2016
-- Description: Update Patient Encounter Json   
-- ============================================= 
CREATE PROCEDURE [enc].[usp_UpdateMergePatientEncounter]
(	
	@EncounterId BIGINT,
	@Json VARCHAR(MAX)
)
AS
BEGIN
	UPDATE enchanced_encounter_additional_info
	SET JSON = @Json
	WHERE enc_id = @EncounterId
END   
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
