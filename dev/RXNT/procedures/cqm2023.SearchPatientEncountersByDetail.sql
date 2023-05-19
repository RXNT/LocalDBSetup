SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Encounter by detail
-- =============================================
CREATE    PROCEDURE [cqm2023].[SearchPatientEncountersByDetail]
  @PatientId			BIGINT,
  @DoctorId				BIGINT,
  @EncounterDate		DATETIME=NULL,
  @SignedDate			DATETIME=NULL
AS
BEGIN
	DECLARE @EncId AS BIGINT=0
	
	SELECT @EncId=ISNULL(enc_id,0) FROM enchanced_encounter
	WHERE patient_id=@PatientId AND dr_id=@DoctorId AND
	enc_date=@EncounterDate AND dtsigned =@SignedDate AND issigned=1 AND type_of_visit='OFICE'
	
	SELECT @EncId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
