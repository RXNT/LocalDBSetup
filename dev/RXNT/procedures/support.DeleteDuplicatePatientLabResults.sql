SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Nambi
-- Create date:  31-JAN-2017
-- Description:	 To Delete Duplicate Patient Lab Results
-- Modified By : JahabarYusuff
-- Description : Deleting lab_main with checking  lab_pat_details
-- =============================================
CREATE PROCEDURE [support].[DeleteDuplicatePatientLabResults]
(
	@PatientId BIGINT,
	@LabId BIGINT
)
AS
BEGIN
	DELETE O   FROM patient_lab_orders O Inner JOIN lab_pat_details D ON D.lab_id=O.lab_id
	WHERE D.pat_id=@PatientId AND D.lab_id=@LabId

	DELETE M  FROM patient_lab_orders_master M Inner JOIN lab_pat_details D ON D.lab_id=M.lab_id
	WHERE D.pat_id=@PatientId AND D.lab_id=@LabId

	DELETE R  FROM lab_result_details R  Inner join lab_result_info I ON R.lab_result_info_id=I.lab_result_info_id
	Inner JOIN lab_pat_details D ON D.lab_id=I.lab_id
	WHERE D.pat_id=@PatientId AND D.lab_id=@LabId

	DELETE S FROM lab_result_specimen S INNER JOIN lab_pat_details D ON S.lab_id=D.lab_id
	WHERE D.pat_id=@PatientId AND D.lab_id=@LabId

	DELETE S  FROM lab_result_place_srv  S INNER JOIN lab_result_info R ON S.lab_result_info_id=R.lab_result_info_id
	Inner JOIN  lab_pat_details D ON R.lab_id=D.lab_id 
	WHERE D.pat_id=@PatientId AND D.lab_id=@LabId

	DELETE R  FROM lab_result_info R
	Inner Join lab_pat_details D ON R.lab_id=D.lab_id
	WHERE D.pat_id=@PatientId AND R.lab_id=@LabId

	DELETE L  FROM lab_order_info L
	inner join lab_pat_details D ON L.lab_id=D.lab_id
	WHERE D.pat_id=@PatientId AND L.lab_id=@LabId

	DELETE  FROM lab_pat_details WHERE pat_id=@PatientId AND lab_id =@LabId

	DELETE M   FROM lab_main M 
	WHERE M.pat_id=@PatientId AND M.lab_id=@LabId

END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
