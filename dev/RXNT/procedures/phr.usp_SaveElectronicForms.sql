SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Kalimuthu S
Create date			:	22-JANUARY-2020
Description			:	This procedure is used to save signed elctronic forms
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_SaveConsentForms]	
    @ElectronicFormId  BIGINT OUTPUT,
	@UploadDate		DATETIME = NULL,	
	@Title		VARCHAR(80) = NULL,
	@Description	VARCHAR(255) = NULL,
	@PatientId		BIGINT = NULL,
	@SourceDoctorId	BIGINT = NULL,
	@FileName		VARCHAR(225) = NULL,
	@Type           INT      
	
	
AS
BEGIN
IF ISNULL(@ElectronicFormId,0) = 0
BEGIN
INSERT INTO [patient_electronic_forms] ([pat_id],[src_dr_id],[upload_date],[title],[filename], [type]) 
          VALUES (@PatientId, @SourceDoctorId, @UploadDate, @title, @filename, @Type) 
SELECT @ElectronicFormId=SCOPE_IDENTITY();          
END
ELSE
BEGIN                                 

	  UPDATE PATIENT_ELECTRONIC_FORMS SET description = @Description WHERE ELECTRONIC_FORM_ID = @ElectronicFormId
END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
