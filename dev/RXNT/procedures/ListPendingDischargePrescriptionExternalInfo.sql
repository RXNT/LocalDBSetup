SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	13-October-2017
Description			:	Sync new prescription discharges into prescription external info 
						and retrive pending prescription discharges external info for vitas sync.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [dbo].[ListPendingDischargePrescriptionExternalInfo]
	@DoctorCompanyId	BIGINT
AS
BEGIN
	
	--Insert new prescription discharges into prescription esternal discharge table  for vitas sync
	INSERT INTO [dbo].[prescription_discharge_external_info]
        ([pres_id],[pd_id],[discharge_request_id],[last_modified_by],[last_modified_date])
        SELECT DISTINCT TOP 10 pres.pres_id, pd.pd_id, pdr.discharge_request_id,last_edit_dr_id,ISNULL(pres.last_edit_date,GETDATE()) 
		FROM prescription_discharge_requests pdr
			INNER JOIN prescriptions pres  WITH(NOLOCK) ON pdr.pres_id = pres.pres_id 
			INNER JOIN prescription_details pd WITH(NOLOCK) ON pd.pres_id = pres.pres_id 
			INNER JOIN doctors dr WITH(NOLOCK) ON pres.dr_id = dr.dr_id
			INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id = dg.dg_id 
			LEFT OUTER JOIN  [dbo].[prescription_discharge_external_info] pdei WITH(NOLOCK) ON pres.pres_id = pdei.pres_id
        WHERE pdr.approved_by>0 
			AND pdr.is_active=1 
			AND pdr.approved_on > GETDATE()-1
            AND pdr.approved_on IS NOT NULL 
			AND dg.dc_id = @DoctorCompanyId
			AND (pdei.pdei_id IS NULL)


	--Retrive pending prescription discharges for vitas sync	
    SELECT TOP 10 pdei.pdei_id,pres.pa_id 
	FROM prescription_discharge_external_info pdei WITH(NOLOCK) 
        INNER JOIN prescriptions pres  WITH(NOLOCK) ON pdei.pres_id = pres.pres_id
		INNER JOIN doctors dr WITH(NOLOCK) ON pres.dr_id = dr.dr_id
        INNER JOIN doc_groups dg WITH(NOLOCK) ON dr.dg_id = dg.dg_id
    WHERE (batch_id IS NULL or response_status = 'Failed' or external_source_syncdate is null) 
		AND dg.dc_id = @DoctorCompanyId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
