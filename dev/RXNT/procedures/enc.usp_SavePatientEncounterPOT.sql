SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M	
-- Create date: 07-12-2022
-- Description:	to save the Patient's encounter Plan of treatment
-- =============================================
CREATE   PROCEDURE [enc].[usp_SavePatientEncounterPOT]
(
	@PatientId					BIGINT,
	@EncounterId				BIGINT,
 	@CreatedBy					BIGINT,
	@EffectiveDate				DATETIME,  
	@PlanOfTreatment				NVARCHAR(MAX)
)
AS
BEGIN		
	INSERT INTO PatientCarePlan( PatientId, EncounterId, EffectiveDate, Text,CreatedUserId)
	VALUES(@PatientId, @EncounterId, @EffectiveDate, @PlanOfTreatment, @CreatedBy)	        
END     

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
