SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Vitals by detail
-- =============================================
CREATE   PROCEDURE [cqm2022].[SearchPatientVitalsByDetail]
	@PatientId 			INT,
	@EntryDate 			DATETIME=NULL,
	@RecordDate 		DATETIME=NULL,
	@DoctorId 			INT,
	@Height				FLOAT=NULL,
	@Weight				FLOAT=NULL,
	@BMI				FLOAT=NULL
AS
BEGIN
	DECLARE @VitalsId AS BIGINT=0
	
	SELECT @VitalsId=ISNULL(pa_vt_id,0) FROM [dbo].[patient_vitals]
	WHERE CONVERT(VARCHAR(10), [record_date], 101) = CONVERT(VARCHAR(10), @RecordDate, 101) 
		AND pa_id=@PatientId AND added_for=@DoctorId AND CONVERT(VARCHAR(10), date_added, 101)=CONVERT(VARCHAR(10), @EntryDate, 101)
		AND pa_wt=@Weight AND pa_ht=@Height AND pa_bmi=@BMI
	
	SELECT @VitalsId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
