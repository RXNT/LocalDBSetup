SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	15-JULY-2016
Description			:	This procedure is used to Delete Patient Procedures
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_DeletePatientProcedures]	
   @ProcedureId			BIGINT,
   @PatientId			BIGINT
	
	
	
AS
BEGIN
	DELETE FROM PATIENT_PROCEDURES WHERE PROCEDURE_ID=@ProcedureId AND PA_ID=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
