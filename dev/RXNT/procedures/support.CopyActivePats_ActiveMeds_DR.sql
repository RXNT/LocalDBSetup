SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CopyActivePats_ActiveMeds_DR]
(@FromDG_ID bigint,	@FromDr_ID bigint,	@ToDG_Id bigint, @ToDR_ID bigint)
AS
BEGIN
	DECLARE 
		@OPAID int,
		@NPAID int

	SELECT
		@FromDG_ID = 27209,
		@FromDr_ID = 82359,
		@ToDG_Id = 28225,
		@ToDR_ID = 89924

	DECLARE @Tb_olPAID table (OPa_ID int)

	INSERT INTO @Tb_olPAID
	SELECT 
		DISTINCT p.pa_id
	FROM 
		patients p
	INNER JOIN 
		prescriptions ps (nolock) 
		ON ps.pa_id = p.pa_id
	WHERE ps.dg_id = @FromDG_ID  and ps.dr_id = @FromDr_ID

	DECLARE paid_Cur CURSOR FOR   
	SELECT OPa_ID
	FROM @Tb_olPAID

	OPEN paid_Cur  
	  
	FETCH NEXT FROM paid_Cur   
	INTO @OPAID  
	  
	WHILE @@FETCH_STATUS = 0  
	BEGIN 

		INSERT INTO patients
		SELECT 
		DISTINCT p.pa_field_not_used1,@ToDG_Id,@ToDR_ID,p.pa_first,p.pa_middle,p.pa_last,
		p.pa_ssn,p.pa_dob,p.pa_address1,p.pa_address2,p.pa_city,p.pa_state,p.pa_zip,p.pa_phone,p.pa_wgt,p.pa_sex,
		p.ic_id,p.ic_group_numb,p.card_holder_id,p.card_holder_first,p.card_holder_mi,p.card_holder_last,p.ic_plan_numb,
		p.ins_relate_code,p.ins_person_code,p.formulary_id,p.alternative_id,p.pa_bin,p.primary_pharm_id,p.pa_notes,
		p.ph_drugs,p.pa_email,p.pa_ext,p.rxhub_pbm_id,p.pbm_member_id,p.def_ins_id,p.last_check_date,p.check_eligibility,
		p.sfi_is_sfi,p.sfi_patid,p.pa_ht,p.pa_upd_stat,p.pa_flag,p.pa_ext_id,p.access_date,p.access_user,p.pa_ins_type,
		p.pa_race_type,p.pa_ethn_type,p.pref_lang,p.add_date,p.add_by_user,p.record_modified_date,
		p.pa_ext_ssn_no,p.pa_prefix,p.pa_suffix,p.active,p.last_modified_date,p.last_modified_by,p.OwnerType,p.pa_birthName,p.InformationBlockingReasonId
		FROM patients p
		WHERE p.pa_id = @OPAID

		SELECT @NPAID = SCOPE_IDENTITY();

		INSERT INTO patient_active_meds
		SELECT 
		@NPAID,pa.drug_id,pa.date_added,pa.added_by_dr_id,pa.from_pd_id,pa.compound,
		pa.comments,pa.status,pa.dt_status_change,pa.change_dr_id,pa.reason,pa.drug_name,pa.dosage,
		pa.duration_amount,pa.duration_unit,pa.drug_comments,pa.numb_refills,pa.use_generic,pa.days_supply,
		pa.prn,pa.prn_description,pa.date_start,pa.date_end,pa.for_dr_id,pa.source_type,pa.record_source,
		pa.active,pa.last_modified_date,pa.last_modified_by, '', pa.rxnorm_code
		From 
		patient_active_meds pa
		where pa.pa_id = @OPAID


		FETCH NEXT FROM paid_Cur   
		INTO @OPAID
	END
	CLOSE paid_Cur;  
	DEALLOCATE paid_Cur;  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
