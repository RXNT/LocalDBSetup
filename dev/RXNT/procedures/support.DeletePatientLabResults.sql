SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		 Nambi
-- Create date:  29-JUNE-2017
-- Description:	 To Delete Patient Lab Results
-- =============================================
CREATE PROCEDURE [support].[DeletePatientLabResults]
(
	@PatientId BIGINT
)
AS
BEGIN
	DELETE O   FROM patient_lab_orders O Inner JOIN lab_pat_details D ON D.lab_id=O.lab_id
	WHERE D.pat_id=@PatientId

	DELETE M  FROM patient_lab_orders_master M Inner JOIN lab_pat_details D ON D.lab_id=M.lab_id
	WHERE D.pat_id=@PatientId

	DELETE R  FROM lab_result_details R  Inner join lab_result_info I ON R.lab_result_info_id=I.lab_result_info_id
	Inner JOIN lab_pat_details D ON D.lab_id=I.lab_id
	WHERE D.pat_id=@PatientId

	DELETE S FROM lab_result_specimen S INNER JOIN lab_pat_details D ON S.lab_id=D.lab_id
	WHERE D.pat_id=@PatientId

	DELETE S  FROM lab_result_place_srv  S INNER JOIN lab_result_info R ON S.lab_result_info_id=R.lab_result_info_id
	Inner JOIN  lab_pat_details D ON R.lab_id=D.lab_id 
	WHERE D.pat_id=@PatientId

	DELETE R  FROM lab_result_info R
	Inner Join lab_pat_details D ON R.lab_id=D.lab_id
	WHERE D.pat_id=@PatientId

	DELETE L  FROM lab_order_info L
	inner join lab_pat_details D ON L.lab_id=D.lab_id
	WHERE D.pat_id=@PatientId

	DELETE  FROM lab_pat_details WHERE pat_id=@PatientId

	DELETE M   FROM lab_main M	
	WHERE M.pat_id=@PatientId

END

RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
