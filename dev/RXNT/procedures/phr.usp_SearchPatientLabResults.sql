SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	10-August-2017
Description			:	This procedure is used to Get Patient Lab Results
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_SearchPatientLabResults]	
	@PatientId			BIGINT,
	
	
	@MaxRows INT = 75
AS
BEGIN
	SELECT TOP(@MaxRows) lm.lab_id, lm.message_date, lm.pat_id, lm.is_read, lm.InformationBlockingReasonId, lm.visibility_hidden_to_patient
	FROM lab_main lm WITH(NOLOCK)
	WHERE lm.pat_id = @PatientId 
	--AND (lm.message_date >=@StartDate  OR @StartDate IS NULL) AND (lm.message_date <=@EndDate OR @EndDate IS NULL) 
	order by lm.message_date desc
	
	select lm.pat_id, lri.lab_id,lri.lab_result_info_id,lri.coll_vol, lri.lab_order_id,lri.spm_id,lri.filler_acc_id, lri.obs_bat_ident, lri.obs_ba_test,lri.obs_cod_sys,lri.obs_date,
		lri.obs_rel_dt, lri.rel_cl_info,lri.dt_spm_rcv, lri.notes,lri.ord_result_status,lri.prod_sec_id, lm.InformationBlockingReasonId, lm.visibility_hidden_to_patient
	from lab_main lm WITH(NOLOCK)  
	INNER JOIN lab_result_info lri WITH(NOLOCK) ON lm.lab_id =lri.lab_id
	where lm.pat_id = @PatientId	
END
 

 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
