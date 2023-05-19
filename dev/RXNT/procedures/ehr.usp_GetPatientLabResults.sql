SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rama Krishna
Create date			:	14-SEPTEMBER-2016
Description			:	This procedure is used to Get Patient Lab Results
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_GetPatientLabResults]	
	@PatientId BIGINT

AS
BEGIN

		select lm.LAB_ID,lm.message_ctrl_id,lm.lab_order_master_id, lm.SEND_APPL, lm.SEND_FACILITY, lm.RCV_APPL, lm.RCV_FACILITY, lm.MESSAGE_DATE, lm.message_type,lm.type,lm.comments,lm.PROV_NAME,lm.result_file_path,
		lpd.lab_id,lpd.lab_pat_id, lpd.pa_acctno, lpd.pa_first,lpd.pa_last,lpd.pa_dob,lpd.pa_sex,dgli.name AS Interface,lm.result_file_path
		from lab_main lm WITH(NOLOCK) 
		INNER JOIN lab_pat_details lpd ON lm.lab_id =lpd.lab_id
		LEFT join patient_lab_orders_master PLOM on LM.lab_order_master_id=PLOM.lab_master_id 
		LEFT join doc_groups_lab_info dgli on PLOM.doc_group_lab_xref_id=dgli.doc_group_lab_xref_id
		LEFT join patient_lab_orders pl on pl.lab_master_id = PLOM.lab_master_id
		where lm.pat_id=@PatientId 

		select loi.lab_report_id,loi.lab_id, loi.lab_report_id,loi.spm_id,loi.filler_acc_id,loi.order_date,loi.ord_prv_id 
		from lab_main lm WITH(NOLOCK) 
		INNER JOIN  lab_order_info loi WITH(NOLOCK) ON lm.lab_id =loi.lab_id
		where lm.pat_id=@PatientId
 
		select lri.lab_id,lri.lab_result_info_id,lri.coll_vol, lri.lab_order_id,lri.spm_id,lri.filler_acc_id, lri.obs_bat_ident, lri.obs_ba_test,lri.obs_cod_sys,lri.obs_date,
		lri.obs_rel_dt, lri.rel_cl_info,lri.dt_spm_rcv, lri.notes,lri.ord_result_status,lri.prod_sec_id
		from lab_main lm WITH(NOLOCK)  
		INNER JOIN lab_result_info lri WITH(NOLOCK) ON lm.lab_id =lri.lab_id
		where  lm.pat_id=@PatientId
		
		select lrd.lab_result_id, lrd.lab_result_info_id,lrd.obs_text,lrd.obs_ident,lrd.obs_cod_sys,lrd.obs_value,lrd.coding_unit_ident,lrd.ref_range,
		lrd.abnormal_flags,lrd.obs_result_status,lrd.prod_id,lrd.notes,lrd.file_name from
		lab_main lm WITH(NOLOCK)  
		INNER JOIN lab_result_info lri WITH(NOLOCK) ON lm.lab_id =lri.lab_id
		INNER JOIN lab_result_details lrd WITH(NOLOCK)ON lri.lab_result_info_id=lrd.lab_result_info_id
		where  lm.pat_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
