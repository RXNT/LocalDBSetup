SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	13-JULY-2016
Description			:	This procedure is used to Search Patient Procedures
Last Modified By	:   JahabarYusuff(to get the procedure with Reason)
Last Modifed Date	:	27-Nov-2017
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SearchPatientProcedures]	 
   @PatientId			BIGINT,
   @DoctorGroupId		INT
	
		
AS
BEGIN
	SELECT PROCEDURE_ID, PA_ID, PP.DR_ID, DATE_PERFORMED,DATE_PERFORMED_TO,
	TYPE,notes, STATUS,C.CODE, C.DESCRIPTION, C.LONG_DESC LDESC,DR_FIRST_NAME, DR_LAST_NAME
	,reason_type ,reason ,reason_type_code, PP.visibility_hidden_to_patient
	FROM PATIENT_PROCEDURES PP 
	INNER JOIN CPT_CODES C 	ON PP.CODE = C.CODE  
	INNER JOIN DOCTORS DR ON PP.DR_ID=DR.DR_ID	
	WHERE PP.PA_ID = @PatientId AND DR.DG_ID = @DoctorGroupId ORDER BY PP.DATE_PERFORMED
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
