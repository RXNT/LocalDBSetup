SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 27-Jan-2016
-- Description:	To get the patient information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_GetEncounterPatientInfo]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	 SELECT p.pa_id,
        p.pa_last+', '+p.pa_first+ CASE WHEN LEN(p.pa_middle)>0 THEN  ' '+p.pa_middle+'.'  ELSE '' END AS pa_name,
        p.pa_sex,
        p.pa_address1,
        p.pa_address2,
        p.pa_city,
        p.pa_state,
        p.pa_zip,
        p.pa_dob,
        p.pa_phone,
        pa_ssn AS pa_chart,
        pa_id
    FROM patients p
    WHERE p.pa_id = @PatientId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
