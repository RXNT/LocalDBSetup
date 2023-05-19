SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	01-DEC-2022
-- Description:		Search Patient Procedure by detail
-- =============================================
CREATE   PROCEDURE [cqm2022].[SearchPatientProceduresByDetail]
  @PatientId			BIGINT,
  @CPTCode				VARCHAR(30),
  @DoctorId				BIGINT,
  @ReasonTypeCode		VARCHAR(30),
  @Type					VARCHAR(30),
  @DatePerformed		DATETIME=NULL,
  @DatePerformedTo		DATETIME=NULL,
  @Status				VARCHAR(50),
  @Description			VARCHAR(30)
AS
BEGIN
	DECLARE @ProcId AS BIGINT=0
	
	SELECT @ProcId=ISNULL(procedure_id,0) FROM patient_procedures
	WHERE pa_id=@PatientId AND code = @CPTCode AND dr_id=@DoctorId AND ISNULL(reason_type_code,'')=@ReasonTypeCode AND type=@Type AND
	CONVERT(VARCHAR(10), date_performed, 101)=CONVERT(VARCHAR(10), @DatePerformed, 101) AND CONVERT(VARCHAR(10), date_performed_to, 101) =CONVERT(VARCHAR(10), @DatePerformedTo, 101) AND status=@Status
	
	SELECT @ProcId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
