SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 18-Jul-2016
-- Description:	Corrects Owner Of An Encounter
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [support].[CorrectOwnerOfEncounter]
	@EncounterId BIGINT,
	@PatientId BIGINT	
AS
BEGIN
	DECLARE @OwnerDoctorId BIGINT
	
	SELECT TOP 1 @OwnerDoctorId =  enc_log.dr_id
	FROM enchanced_encounter_log  enc_log with(nolock) 
	WHERE enc_log.enc_id=@EncounterId AND enc_log.patient_id = @PatientId
	ORDER BY enc_log.transaction_id ASC
	
	UPDATE enchanced_encounter 
	SET dr_id = @OwnerDoctorId
	WHERE enc_id=@EncounterId AND patient_id = @PatientId  
END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
