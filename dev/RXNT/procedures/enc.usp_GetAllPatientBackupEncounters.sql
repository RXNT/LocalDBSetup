SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  Vidya    
-- Create date: 26/May/2017
-- Description: Procedure to get All Patient Encounters from Backup 
-- =============================================    
CREATE PROCEDURE [enc].[usp_GetAllPatientBackupEncounters]
(	
	@PrimaryPatientId INT,
	@SecondaryPatientId INT,
	@IncludeIsSigned BIT
)
AS
BEGIN
	SELECT	VIT.encounter_version, BKVIT.patient_id, VIT.issigned, BKVIT.type, BKVIT.enc_date, BKVIT.enc_id
	FROM	dbo.enchanced_encounter VIT WITH (NOLOCK)
			INNER JOIN bk.enchanced_encounter BKVIT WITH (NOLOCK) ON BKVIT.enc_id = VIT.enc_id 	
	WHERE	VIT.patient_id = @PrimaryPatientId AND BKVIT.patient_id = @SecondaryPatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
