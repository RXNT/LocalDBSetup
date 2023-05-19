SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Prabhash H
Create date			:	13-October-2017
Description			:	Sync new prescriptions into prescription external info 
						and retrive pending prescription external info for vitas sync.
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [dbo].[ListPendingPrescriptionExternalInfo]
	@DoctorCompanyId	BIGINT
AS
BEGIN
	
	--Insert new prescriptions into prescription esternal table  for vitas sync
	INSERT INTO [dbo].[prescription_external_info]  
		([pres_id], [pd_id], [external_order_id], [active], [created_date], [created_by], [dc_id],[dg_id],[last_modified_by],[last_modified_date])
        SELECT pres.pres_id,pd.pd_id,'',1,GETDATE(),pres.prim_dr_id,dg.dc_id,dg.dg_id,last_edit_dr_id, ISNULL(pres.last_edit_date, GETDATE()) 
        FROM prescriptions pres WITH(NOLOCK)
            INNER JOIN prescription_details pd  WITH(NOLOCK) ON pd.pres_id = pres.pres_id
            INNER JOIN doc_groups dg WITH(NOLOCK) ON pres.dg_id = dg.dg_id
            INNER JOIN 
            ( 
                SELECT DISTINCT TOP 10 pre.pa_id 
				FROM prescriptions pre  WITH(NOLOCK)
					INNER JOIN doc_groups dg WITH(NOLOCK) ON pre.dg_id = dg.dg_id 
					LEFT OUTER JOIN[prescription_external_info] peii WITH(NOLOCK) ON pre.pres_id = peii.pres_id 
                WHERE dg.dc_id = @DoctorCompanyId  AND pre.pres_approved_date IS NOT NULL
					AND pre.pres_approved_date > GETDATE() - 1 
					AND(peii.pres_external_info_id IS NULL) 
                GROUP BY pre.pa_id
			) PT ON pres.pa_id = PT.pa_id 
			LEFT OUTER JOIN [dbo].[prescription_external_info] pei WITH(NOLOCK) ON pres.pres_id = pei.pres_id
        WHERE dg.dc_id = @DoctorCompanyId AND pres.pres_approved_date IS NOT NULL
			AND pres.pres_approved_date > GETDATE() - 1 
			AND(pei.pres_external_info_id IS NULL) 
        ORDER BY pres.pres_id DESC

	--Retrive pending prescriptions for vitas sync
	SELECT pei.pres_external_info_id,pres.pa_id 
	FROM PRESCRIPTION_EXTERNAL_INFO pei WITH(NOLOCK)
		INNER JOIN prescriptions pres  WITH(NOLOCK) ON pei.pres_id = pres.pres_id
		INNER JOIN 
		( 
			SELECT DISTINCT TOP 10 pre.pa_id 
			FROM prescriptions pre  WITH(NOLOCK) 
				INNER JOIN [prescription_external_info] peii WITH(NOLOCK) ON pre.pres_id = peii.pres_id
			WHERE (batch_id IS NULL or response_status = 'Failed' Or external_source_syncdate IS NULL) 
				AND not(pres_approved_date IS NULL) 
				AND(pre.pres_void = 0 or pre.pres_void IS NULL) 
				AND peii.dc_id = @DoctorCompanyId 
			GROUP BY pre.pa_id 
		) PT ON pres.pa_id = PT.pa_id 
	WHERE (batch_id IS NULL or response_status = 'Failed' Or external_source_syncdate IS NULL)
		AND not(pres_approved_date IS NULL)
		AND (pres.pres_void = 0 or pres.pres_void IS NULL) 
		AND pei.dc_id = @DoctorCompanyId

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
