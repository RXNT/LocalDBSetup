SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Nambi
Create date			:	14-SEPTEMBER-2016
Description			:	This procedure is used to Get Patient Lab Results
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[usp_SearchPatientLabResults]
	@UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @PatientFirstName varchar(50)=NULL, @PatientLastName varchar(50)=NULL, @Page INT = NULL, @PageSize INT = NULL

AS
BEGIN
		SET @Page=ISNULL(@Page,1)
		SET @PageSize=ISNULL(@PageSize,10)
		SET @IsRestrictToPersonalRx=ISNULL(@IsRestrictToPersonalRx,0)
		  
		;WITH PageNumbers AS(
			select ROW_NUMBER() OVER(ORDER BY MESSAGE_DATE DESC) ID,
		lm.LAB_ID,lm.message_ctrl_id, lm.SEND_APPL, lm.SEND_FACILITY, lm.RCV_APPL, 
		lm.RCV_FACILITY, lm.MESSAGE_DATE, 
		lm.message_type,lm.type,lm.comments,lm.PROV_NAME,
		lpd.lab_id as lb1,lm.pat_id,lm.dg_id,lpd.lab_pat_id, lpd.pa_acctno, lpd.pa_first,lpd.pa_last,lpd.pa_dob,lpd.pa_sex,lm.lab_order_master_id,lm.result_file_path
		FROM lab_main lm WITH(NOLOCK) 
		INNER JOIN doctors dr WITH(NOLOCK) ON dr.dr_id =lm.dr_id and dr.dg_id = @DoctorGroupId
		INNER JOIN lab_pat_details lpd WITH(NOLOCK) ON lm.lab_id =lpd.lab_id
		WHERE (@IsRestrictToPersonalRx=0 OR lm.dr_id = @UserId) AND ISNULL(lm.is_read,0) = 0 AND (@PatientFirstName IS NULL OR lpd.pa_first LIKE @PatientFirstName+'%')
			AND (@PatientLastName IS NULL OR lpd.pa_last LIKE @PatientLastName+'%')
		)

		SELECT  A.*
		INTO #SearchedLabs
		FROM    PageNumbers A WITH(NOLOCK)
		WHERE   ID  BETWEEN ((@Page - 1) * @PageSize + 1) AND (@Page * @PageSize)

		SELECT  A.*,PE.pa_nick_name,
		PLOM.order_date, dgli.name AS Interface,
		pat.pa_phone, pe.cell_phone, pe.work_phone, pe.other_phone,pe.pref_phone 
		FROM    #SearchedLabs A WITH(NOLOCK)
		INNER JOIN PATIENTs pat WITH(NOLOCK) ON A.PAT_ID = pat.PA_ID
		LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS PE WITH(NOLOCK) ON PE.PA_ID = pat.PA_ID
		LEFT JOIN patient_lab_orders_master PLOM WITH(NOLOCK) ON PLOM.lab_master_id = A.lab_order_master_id		
		LEFT JOIN doc_groups_lab_info dgli WITH(NOLOCK) ON A.send_appl=dgli.dg_lab_id AND A.dg_id = dgli.dg_id
		WHERE   ID  BETWEEN ((@Page - 1) * @PageSize + 1) AND (@Page * @PageSize)

		SELECT PA_ID, FLAG_TITLE, ISNULL(B.hide_on_search,0) AS hide_on_search,CASE WHEN c.flag_id IS NULL THEN 1 ELSE 0 END IsInactiveFlag
		FROM PATIENT_FLAG_DETAILS A WITH(NOLOCK)
		INNER JOIN #SearchedLabs SL WITH(NOLOCK) ON A.pa_id=SL.pat_id
		INNER JOIN PATIENT_FLAGS B WITH(NOLOCK) ON A.FLAG_ID = B.FLAG_ID 
		LEFT OUTER JOIN patient_flag_inactiveindicator C WITH(NOLOCK) ON A.Flag_Id=C.Flag_Id 
		WHERE B.hide_on_search=1

		SELECT loi.lab_report_id,loi.lab_id, loi.lab_report_id,loi.spm_id,loi.filler_acc_id,loi.order_date,loi.ord_prv_id 
		FROM lab_main lm WITH(NOLOCK) 
		INNER JOIN #SearchedLabs SL WITH(NOLOCK) ON lm.lab_id=SL.lab_id
		INNER JOIN  lab_order_info loi WITH(NOLOCK) ON lm.lab_id =loi.lab_id
 
		SELECT lri.lab_id,lri.lab_result_info_id,lri.coll_vol, lri.lab_order_id,lri.spm_id,lri.filler_acc_id, lri.obs_bat_ident, lri.obs_ba_test,lri.obs_cod_sys,lri.obs_date,
		lri.obs_rel_dt, lri.rel_cl_info,lri.dt_spm_rcv, lri.notes,lri.ord_result_status,lri.prod_sec_id,lpd.notes as ordernotes
		FROM lab_main lm WITH(NOLOCK)  
		INNER JOIN #SearchedLabs SL WITH(NOLOCK) ON lm.lab_id=SL.lab_id
		INNER JOIN lab_result_info lri WITH(NOLOCK) ON lm.lab_id =lri.lab_id
		INNER JOIN lab_pat_details lpd WITH(NOLOCK) ON lm.lab_id =lpd.lab_id
		
		SELECT lrd.lab_result_id,lrd.file_name, lrd.lab_result_info_id,lrd.obs_text,lrd.obs_ident,lrd.obs_cod_sys,lrd.obs_value,lrd.coding_unit_ident,lrd.ref_range,
		lrd.abnormal_flags,lrd.obs_result_status,lrd.prod_id,lrd.notes FROM
		lab_main lm WITH(NOLOCK)  
		INNER JOIN #SearchedLabs SL WITH(NOLOCK) ON lm.lab_id=SL.lab_id
		INNER JOIN lab_result_info lri WITH(NOLOCK) ON lm.lab_id =lri.lab_id
		INNER JOIN lab_result_details lrd WITH(NOLOCK)ON lri.lab_result_info_id=lrd.lab_result_info_id

		DROP TABLE #SearchedLabs
			
		 
		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
