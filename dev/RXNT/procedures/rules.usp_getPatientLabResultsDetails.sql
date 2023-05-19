SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	23-March-2018
Description			:	This procedure is used to Get Lab Result for lab id
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rules].[usp_getPatientLabResultsDetails]	
	@PatientId BIGINT
AS
BEGIN
	
	
	select lrd.lab_result_id, lrd.lab_result_info_id,lrd.obs_text,lrd.obs_ident,lrd.obs_cod_sys,lrd.obs_value,lrd.coding_unit_ident,lrd.ref_range,
		lrd.abnormal_flags,lrd.obs_result_status,lrd.prod_id,lrd.notes,lrd.file_name from
		lab_main lm WITH(NOLOCK)  
		INNER JOIN patients P ON P.pa_id=lm.pat_id
	INNER JOIN lab_pat_details lpd ON lm.lab_id =lpd.lab_id	
	INNER JOIN lab_result_info lri WITH(NOLOCK) ON lm.lab_id =lri.lab_id
	INNER JOIN lab_result_details lrd WITH(NOLOCK)ON lri.lab_result_info_id=lrd.lab_result_info_id
	where P.pa_id = @PatientId
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
