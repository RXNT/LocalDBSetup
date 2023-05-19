SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author		: Thomas K
-- Create date	: 2017/28/October
-- Description	: Fetch the patient CML for one time sync
-- =============================================
CREATE PROCEDURE [dbo].[SelectVitasPatientCMLOneTimeSync]
	@pa_id int
AS
BEGIN
	SELECT DISTINCT PAT.PA_SSN, PRES.pres_id PAM_ID, PD.ddid AS DRUG_ID, R.MED_REF_DEA_CD drug_class,
	CASE WHEN PD.ddid <= -1 THEN PD.drug_name ELSE R.MED_MEDID_DESC END  DRUG_NAME, 
	PRES.pres_entry_date DATE_ADDED, COMPOUND, COMMENTS, PD.pd_id pd_id,
	MDR.DR_FIRST_NAME, MDR.DR_LAST_NAME,MDR.dr_address1,
	MDR.dr_city,MDR.dr_state,MDR.dr_zip,MDR.NPI,
	PD.dosage, duration_amount, 
	duration_unit, PD.comments AS drug_comments, numb_refills, use_generic, 
	days_supply, prn, PD.prn_description, PRES.pres_approved_date AS date_start, NULL AS date_end,
	hdr.hospice_drug_relatedness_id,hdr.Code,hdr.Description,R.GCN_STRING GCN_SEQNO, PD.discharge_date,
	PRES.dr_id,
	--PDR.approved_by,
	--PD.
	PD.history_enabled,
	PD.discharge_date,
	PD.discharge_dr_id,
	psd.sig_qty,
	PSD.sig_action,
	PSD.sig_form,
	PSD.sig_route,
	PSD.sig_time_option
	FROM prescriptions PRES  WITH(NOLOCK)
	INNER JOIN prescription_details PD WITH(NOLOCK) ON	PRES.pres_id = PD.pres_id
	inner join doctors MDR with(nolock) on PRES.dr_id = MDR.dr_id
	INNER JOIN PATIENTS PAT WITH(NOLOCK) ON PRES.PA_ID = PAT.PA_ID
	--LEFT OUTER JOIN 
	--	(
	--		select max(PDR.* from prescriptions PR with(nolock)
	--		inner join prescription_discharge_requests PDR with(nolock) 
	--			on PR.pres_id = PDR.pres_id and PDR.is_active=1
	--		group by PR.pres_id
	--	)PDR
	INNER JOIN RMIID1 R WITH(NOLOCK) ON			PD.ddid = R.MEDID 
	--LEFT OUTER JOIN vwMedGCN vwGCN WITH(NOLOCK) ON		R.MEDID = vwGCN.MEDID
	--LEFT OUTER JOIN DOCTORS DR ON						PRES.prim_dr_id = DR.DR_ID
	LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON 
		PD.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id
	LEFT OUTER JOIN 
		(
			select psd.pd_id,max(psd.pd_sig_id) pd_sig_id
			from prescriptions PR with(nolock)
			inner join prescription_details PD with(nolock) on PR.pres_id = PD.pres_id
			inner join prescription_sig_details psd WITH(NOLOCK) ON PD.pd_id = PSD.pd_id
			where PR.pa_id =@pa_id
			group by psd.pd_id
		) psd1 on PD.pd_id = psd1.pd_id
	LEFT OUTER JOIN prescription_sig_details psd with(nolock) on 
		psd.pd_sig_id = psd1.pd_sig_id
	WHERE PRES.PA_ID = @pa_id
			AND PRES.pres_approved_date is not null
			--AND PD.history_enabled = 1 
			--AND PD.discharge_date is null
			AND (PRES.pres_void = 0 or PRES.pres_void is null)
	ORDER BY DRUG_NAME DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
