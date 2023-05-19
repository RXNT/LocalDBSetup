SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the patient extended information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadPatientExtendedDetails]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT PA_ID, pa_ext_ref, pa_ref_name_details,pa_ref_date, prim_dr_id, dr_id, cell_phone,work_phone,other_phone, 
	marital_status, pa_death_date, empl_status, comm_pref, pref_phone, time_zone, pref_start_time, pref_end_time, 
	mother_first, mother_middle, mother_last, emergency_contact_first, emergency_contact_last, emergency_contact_address1, 
	emergency_contact_address2, emergency_contact_city, emergency_contact_state, emergency_contact_zip, emergency_contact_phone, 
	emergency_contact_relationship, emergency_contact_release_documents, restricted_access FROM PATIENT_EXTENDED_DETAILS WHERE PA_ID =@PatientId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
