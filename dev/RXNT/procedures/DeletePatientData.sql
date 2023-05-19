SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 2010-03-17
-- Description:	Deletes the patient record
-- =============================================
CREATE PROCEDURE [dbo].[DeletePatientData]
	@PATID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	

	DELETE FROM PATIENTS WHERE PA_ID = @PATID
	
	-- DELETE THE RX DATA
	DELETE FROM PRESCRIPTIONS WHERE PA_ID = @PATID;
	
	
	-- DELETE THE ALLERGIES
	
	DELETE FROM PATIENT_NEW_ALLERGIES WHERE PA_ID = @PATID;
	
	
	-- DELETE ENCOUNTERS
	DELETE FROM enchanced_encounter WHERE patient_id = @PATID;
	
	-- delete the vitals
	DELETE FROM patient_vitals WHERE pa_id = @PATID;
	
	
	-- Active Meds
	DELETE FROM patient_active_meds WHERE pa_id =@PATID;
	
	-- DELETE THE PROBLEMS	
	DELETE FROM PATIENT_ACTIVE_DIAGNOSIS WHERE PA_ID = @PATID
	
	 -- lABS
	 DELETE FROM lab_main WHERE pat_id = @PATID;
	 
	 -- dOCUMENTS
	 DELETE FROM patient_documents WHERE pat_id=@PATID;   
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
