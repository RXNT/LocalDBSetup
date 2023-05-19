SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CreateCCDRequestForPatientsWithMedications]
	@DoctorCompanyId		INT,
	@CreatedBy	INT
AS
BEGIN
	DECLARE		@batchname	VARCHAR(500)
	DECLARE		@dr_first	VARCHAR(50) 
	DECLARE		@dr_last 	VARCHAR(50)
	DECLARE		@batchid	INT
	
	SELECT @dr_first = dr_first_name, @dr_last = dr_last_name FROM doctors WHERE dr_id=@CreatedBy
	SET @batchname = (CONVERT(VARCHAR(10),GETDATE(),101)+' '+CONVERT(VARCHAR(8), GETDATE(), 108)
						 + ' ' + RIGHT(CONVERT(VARCHAR(30), GETDATE(), 9), 2)  +' '+@dr_first+' '+@dr_last)
	INSERT INTO Patient_CCD_request_batch
	(
		dc_id,
		created_by,
		created_date,
		batch_name,
		active,
		status
	)
	VALUES(@DoctorCompanyId,@CreatedBy,GETDATE(),@batchname,1,1)
	SET @batchid = SCOPE_IDENTITY();
	
	INSERT INTO Patient_CCD_request_queue
	(	
		batchid,
		pa_id,
		created_date,
		created_by,
		active,
		status
	)	
	SELECT DISTINCT @batchid,  pat.pa_id, GETDATE(),@CreatedBy,1,1 
	FROM patients pat WITH(NOLOCK) 
	INNER JOIN patient_active_meds pam WITH(NOLOCK) ON pam.pa_id = pat.pa_id
	INNER  JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	LEFT OUTER JOIN Patient_CCD_request_queue pcrq WITH(NOLOCK) ON  pat.pa_id = pcrq.pa_id AND pcrq.batchid = @batchid
	WHERE dg.dc_id=@DoctorCompanyId AND pcrq.reqid IS NULL

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
