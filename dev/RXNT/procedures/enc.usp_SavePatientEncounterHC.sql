SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M	
-- Create date: 07-12-2022
-- Description:	to save the Patient's encounter HealthConcern
-- =============================================
CREATE   PROCEDURE [enc].[usp_SavePatientEncounterHC]
(
	@PatientId					BIGINT,
	@EncounterId				BIGINT,
 	@CreatedBy					BIGINT,
	@EffectiveDate				DATETIME,  
	@HealthConcern			NVARCHAR(MAX)
)
AS
BEGIN		
	INSERT INTO PatientHealthConcerns( PatientId, EncounterId, EffectiveDate, Text,CreatedUserId)
	VALUES(@PatientId, @EncounterId, @EffectiveDate, @HealthConcern, @CreatedBy)	        
END     

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
