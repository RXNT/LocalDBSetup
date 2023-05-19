SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Rasheed
-- Create date: 	10-OCT-2018
-- Description:		Search Patient ClaimsHx from past 24 hrs
-- =============================================
CREATE PROCEDURE [dbo].[SearchPatientRxClaimsHx]
	@DoctorId			BIGINT,
	@PatientId			BIGINT,
	@RequestType		TINYINT=NULL
AS
BEGIN
 
  SELECT * FROM surescript_medHx_messages 
  WHERE patientid=@PatientId AND 
  DATEDIFF(HOUR,createddate,GETDATE()) <=24 AND
  request_type=@RequestType
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
