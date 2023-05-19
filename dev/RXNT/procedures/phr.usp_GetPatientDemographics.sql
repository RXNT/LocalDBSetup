SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vinoth
-- Create date: 6.09.2017
-- Description: Get Patient Demographics
-- =============================================
CREATE PROCEDURE  [phr].[usp_GetPatientDemographics]
 	@PatientId			BIGINT
AS
BEGIN
	select P.pa_id,PE.pref_phone,P.pa_phone,PE.work_phone,PE.cell_phone,PE.other_phone,
	P.pa_email,PE.comm_pref,PE.time_zone,PE.pref_start_time,PE.pref_end_time,P.pa_first,P.pa_last,
	P.pa_middle,P.pa_dob,P.pa_address1,P.pa_address2,P.pa_zip,pa_city,pa_state,pa_ssn,pa_sex,
	 PE.marital_status,PE.empl_status,pa_ethn_type,pref_lang,pa_race_type from patients P
	INNER JOIN patient_extended_details PE ON PE.pa_id = P.pa_id
	where P.pa_id = @PatientId 
		 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
