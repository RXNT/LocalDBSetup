SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Active Patients From one Doctor to another Doctor
-- =============================================
CREATE PROCEDURE [support].[CopyDataFromOneAccountToAnother]  
  @FromDoctorId    BIGINT,  
  @ToDoctorId    BIGINT  
AS  
BEGIN  
   
 DECLARE @CopyRef_Id AS BIGINT  
 DECLARE @new_dg_id AS BIGINT  
 DECLARE @new_dc_id AS BIGINT  
 DECLARE @old_dg_id AS BIGINT  
 DECLARE @old_dc_id AS BIGINT  
  
 SELECT @new_dg_id = dg_id FROM doctors WHERE dr_id=@ToDoctorId      
 SELECT @new_dc_id = dc_id FROM doc_groups WHERE dg_id=@new_dg_id   
  
 SELECT @old_dg_id = dg_id FROM doctors WHERE dr_id=@FromDoctorId      
 SELECT @old_dc_id = dc_id FROM doc_groups WHERE dg_id=@old_dg_id   
 --Loop Through Every Patients And Export them to ToDoctorId  
   
 DECLARE @old_pa_id BIGINT  
 DECLARE @new_pa_id as BIGINT

 EXEC [support].[CopyFavouritePharmsFromOneAccountToAnother] @FromDoctorId = @FromDoctorId, @ToDoctorId = @ToDoctorId
 EXEC [support].[CopyDocumentCategoriesFromOneGroupToAnother] @FromDoctorGroupId = @old_dg_id, @ToDoctorGroupId = @new_dg_id
 /* ------------- User Local Veriables ------------- */   
   
 DECLARE @PatientExportCursor CURSOR  
  
 SET @PatientExportCursor = CURSOR FAST_FORWARD  
 FOR SELECT pat.pa_id  
 FROM patients pat WITH(NOLOCK)
 INNER JOIN doc_groups dg_pat WITH(NOLOCK) ON pat.dg_id=dg_pat.dg_id 
 LEFT OUTER JOIN prescriptions pres WITH(NOLOCK) ON pat.pa_id=pres.pa_id AND pres.dr_id=@FromDoctorId  
 LEFT OUTER JOIN enchanced_encounter enc WITH(NOLOCK) ON pat.pa_id=enc.patient_id AND enc.dr_id=@FromDoctorId  
 INNER JOIN doctors doc WITH(NOLOCK) ON doc.dr_id=@FromDoctorId
 INNER JOIN doc_groups dg WITH(NOLOCK) ON doc.dg_id=dg.dg_id
 WHERE (pres.pres_id IS NOT NULL OR enc.enc_id IS NOT NULL)  AND dg.dc_id=@old_dc_id AND dg_pat.dc_id=@old_dc_id
 GROUP BY pat.pa_id  
         
 OPEN @PatientExportCursor  
 FETCH NEXT FROM @PatientExportCursor  
 INTO  @old_pa_id  
  
 WHILE @@FETCH_STATUS = 0  
 BEGIN    
  IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref coa WITH(NOLOCK)   
  WHERE coa.New_DCID = @new_dc_id  AND coa.Old_PatID = @old_pa_id)  
  BEGIN     
   -- SELECT [support].[GetTableColumnNames] ('patient_extended_details','pa_id');  
     
   INSERT INTO dbo.patients   
   (pa_field_not_used1, dg_id, dr_id, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, pa_address1, pa_address2, pa_city, pa_state, pa_zip, pa_phone, pa_wgt, pa_sex, ic_id, ic_group_numb, card_holder_id, card_holder_first, card_holder_mi, card_holder_last, ic_plan_numb, ins_relate_code, ins_person_code, formulary_id, alternative_id, pa_bin, primary_pharm_id, pa_notes, ph_drugs, pa_email, pa_ext, rxhub_pbm_id, pbm_member_id, def_ins_id, last_check_date, check_eligibility, sfi_is_sfi, sfi_patid, pa_ht, pa_upd_stat, pa_flag, pa_ext_id, access_date, access_user, pa_ins_type, pa_race_type, pa_ethn_type, pref_lang, add_date, add_by_user, record_modified_date, pa_ext_ssn_no, pa_prefix, pa_suffix, active, last_modified_date, last_modified_by, OwnerType)  
   SELECT pa_field_not_used1, @new_dg_id,CASE WHEN ISNULL(dr_id,0)>0 THEN @ToDoctorId ELSE dr_id END, pa_first, pa_middle, pa_last, pa_ssn, pa_dob, pa_address1, pa_address2, pa_city, pa_state, pa_zip, pa_phone, pa_wgt, pa_sex, ic_id, ic_group_numb, card_holder_id, card_holder_first, card_holder_mi, card_holder_last, ic_plan_numb, ins_relate_code, ins_person_code, formulary_id, alternative_id, pa_bin, primary_pharm_id, pa_notes, ph_drugs, pa_email, pa_ext, rxhub_pbm_id, pbm_member_id, def_ins_id, last_check_date, check_eligibility, sfi_is_sfi, sfi_patid, pa_ht, pa_upd_stat, pa_flag, pa_ext_id, access_date, access_user, pa_ins_type, pa_race_type, pa_ethn_type, pref_lang, add_date,NULL, record_modified_date, pa_ext_ssn_no, pa_prefix, pa_suffix, active, last_modified_date, 1, OwnerType   
   FROM patients WITH(NOLOCK)   
   WHERE pa_id = @old_pa_id  
   SET @new_pa_id = SCOPE_IDENTITY();  
          
   INSERT INTO [support].[Patients_Copy_Ref]  
   ([Old_PatID],[New_PatID],[Old_DGID],[New_DGID],[Old_DCID],[New_DCID],[CreatedOn], [Old_DRID],[New_DRID])  
   VALUES (@old_pa_id, @new_pa_id, @old_dg_id,@new_dg_id, @old_dc_id,@new_dc_id,GETDATE(), @FromDoctorId, @ToDoctorId)  
  
   SET @CopyRef_Id = SCOPE_IDENTITY();  
             
   INSERT INTO patient_extended_details  
   (pa_id,pa_ext_ref, pa_ref_name_details, pa_ref_date, prim_dr_id, dr_id, cell_phone, marital_status, empl_status, work_phone, other_phone, comm_pref, pref_phone, time_zone, pref_start_time, pref_end_time, mother_first, mother_middle, mother_last, pa_death_date, emergency_contact_first, emergency_contact_last, emergency_contact_address1, emergency_contact_address2, emergency_contact_city, emergency_contact_state, emergency_contact_zip, emergency_contact_phone, emergency_contact_release_documents, emergency_contact_relationship, active, last_modified_date, last_modified_by, pa_phone_ctry_code, cell_phone_ctry_code, work_phone_ctry_code, other_phone_ctry_code, pa_phone_dial_code, cell_phone_dial_code, work_phone_dial_code, other_phone_dial_code, pa_phone_full, cell_phone_full, work_phone_full, other_phone_full, created_by_system, restricted_access)  
   SELECT  @new_pa_id,pa_ext_ref, pa_ref_name_details, pa_ref_date, CASE WHEN ISNULL(prim_dr_id,0)>0 THEN @ToDoctorId ELSE prim_dr_id END, CASE WHEN ISNULL(dr_id,0)>0 THEN @ToDoctorId ELSE dr_id END, cell_phone, marital_status, empl_status, work_phone, other_phone, comm_pref, pref_phone, time_zone, pref_start_time, pref_end_time, mother_first, mother_middle, mother_last, pa_death_date, emergency_contact_first, emergency_contact_last, emergency_contact_address1, emergency_contact_address2, emergency_contact_city, emergency_contact_state, emergency_contact_zip, emergency_contact_phone, emergency_contact_release_documents, emergency_contact_relationship, active, last_modified_date, last_modified_by, pa_phone_ctry_code, cell_phone_ctry_code, work_phone_ctry_code, other_phone_ctry_code, pa_phone_dial_code, cell_phone_dial_code, work_phone_dial_code, other_phone_dial_code, pa_phone_full, cell_phone_full, work_phone_full, other_phone_full, 'Patient Data Export App', restricted_access  
   FROM patient_extended_details patext  
   WHERE patext.pa_id=@old_pa_id and patext.pa_id IS NOT NULL  
     
   INSERT INTO support.Patients_Copy_Ref_Extended  
   (CopyRef_Id,PatientExtendedDetailsCopied, CreatedOn)  
   VALUES(@CopyRef_Id, 1, GETDATE())  
  END  
  ELSE
  BEGIN
	SELECT @new_pa_id = New_PatID 
	FROM [support].[Patients_Copy_Ref] p_ref WITH(NOLOCK)
	WHERE  Old_DCID = @old_dc_id AND New_DCID = @new_dc_id AND Old_PatID = @old_pa_id
	IF(@new_pa_id > 0 AND EXISTS(SELECT TOP 1 1 FROM patients WHERE pa_id=@new_pa_id))
		BEGIN
			UPDATE panew SET pa_field_not_used1=panew.pa_field_not_used1, dg_id=panew.dg_id, dr_id=panew.dr_id, pa_first=panew.pa_first,
			pa_middle=panew.pa_middle, pa_last=panew.pa_last, pa_ssn=panew.pa_ssn, pa_dob=panew.pa_dob, pa_address1=panew.pa_address1,
			pa_address2=panew.pa_address1, pa_city=panew.pa_city, pa_state=panew.pa_state, pa_zip=panew.pa_zip, pa_phone=panew.pa_phone,
			pa_wgt=panew.pa_wgt, pa_sex=panew.pa_sex, ic_id=panew.ic_id, ic_group_numb=panew.ic_group_numb, card_holder_id=panew.card_holder_id,
			card_holder_first=panew.card_holder_first, card_holder_mi=panew.card_holder_first, card_holder_last=panew.card_holder_last, ic_plan_numb=panew.ic_plan_numb,
			ins_relate_code=panew.ins_relate_code, ins_person_code=panew.ins_person_code, formulary_id=panew.formulary_id, alternative_id=panew.alternative_id,
			pa_bin=panew.pa_bin, primary_pharm_id=panew.primary_pharm_id, pa_notes=panew.pa_notes, ph_drugs=panew.ph_drugs, pa_email=panew.pa_email,
			pa_ext=panew.pa_ext, rxhub_pbm_id=panew.rxhub_pbm_id, pbm_member_id=panew.pbm_member_id, def_ins_id=panew.def_ins_id, last_check_date=panew.last_check_date,
			check_eligibility=panew.check_eligibility, sfi_is_sfi=panew.sfi_is_sfi, sfi_patid=panew.sfi_patid, pa_ht=panew.pa_ht, pa_upd_stat=panew.pa_upd_stat,
			pa_flag=panew.pa_flag, pa_ext_id=panew.pa_ext_id, access_date=panew.access_date, access_user=panew.access_user, pa_ins_type=panew.pa_ins_type,
			pa_race_type=panew.pa_race_type, pa_ethn_type=panew.pa_ethn_type, pref_lang=panew.pref_lang, add_date=panew.add_date, add_by_user=panew.add_by_user,
			record_modified_date=panew.record_modified_date, pa_ext_ssn_no=panew.pa_ext_ssn_no, pa_prefix=panew.pa_prefix, pa_suffix=panew.pa_suffix, active=panew.active,
			last_modified_date=panew.last_modified_date, last_modified_by=panew.last_modified_by, OwnerType=panew.OwnerType
			FROM patients panew WITH(NOLOCK)
			INNER JOIN support.Patients_Copy_Ref PCR WITH(NOLOCK) ON PCR.New_PatID=panew.pa_id
			INNER JOIN patients paold WITH(NOLOCK) ON paold.pa_id=PCR.Old_PatID
			WHERE panew.pa_id=@new_pa_id AND PCR.New_PatID=@new_pa_id AND PCR.Old_PatID=@old_pa_id
			
			IF EXISTS (SELECT TOP 1 1 FROM patient_extended_details WHERE pa_id=@new_pa_id)
			BEGIN
				UPDATE panew SET pa_ext_ref=paold.pa_ext_ref, pa_ref_name_details=paold.pa_ref_name_details, pa_ref_date=paold.pa_ref_date, prim_dr_id=paold.prim_dr_id, dr_id=paold.dr_id,
				cell_phone=paold.cell_phone, marital_status=paold.marital_status, empl_status=paold.empl_status, work_phone=paold.work_phone, other_phone=paold.other_phone, comm_pref=paold.comm_pref,
				pref_phone=paold.pref_phone, time_zone=paold.time_zone, pref_start_time=paold.pref_start_time, pref_end_time=paold.pref_end_time, mother_first=paold.mother_first, mother_middle=paold.mother_middle,
				mother_last=paold.mother_last, pa_death_date=paold.pa_death_date, emergency_contact_first=paold.emergency_contact_first, emergency_contact_last=paold.emergency_contact_last, emergency_contact_address1=paold.emergency_contact_address1,
				emergency_contact_address2=paold.emergency_contact_address2, emergency_contact_city=paold.emergency_contact_city, emergency_contact_state=paold.emergency_contact_state, emergency_contact_zip=paold.emergency_contact_zip, emergency_contact_phone=paold.emergency_contact_phone,
				emergency_contact_release_documents=paold.emergency_contact_release_documents, emergency_contact_relationship=paold.emergency_contact_relationship, active=paold.active, last_modified_date=paold.last_modified_date, last_modified_by=paold.last_modified_by,
				pa_phone_ctry_code=paold.pa_phone_ctry_code, cell_phone_ctry_code=paold.cell_phone_ctry_code, work_phone_ctry_code=paold.work_phone_ctry_code, other_phone_ctry_code=paold.other_phone_ctry_code, pa_phone_dial_code=paold.pa_phone_dial_code,
				cell_phone_dial_code=paold.cell_phone_dial_code, work_phone_dial_code=paold.work_phone_dial_code, other_phone_dial_code=paold.other_phone_dial_code, pa_phone_full=paold.pa_phone_full, cell_phone_full=paold.cell_phone_full,
				work_phone_full=paold.work_phone_full, other_phone_full=paold.other_phone_full, created_by_system=paold.created_by_system, restricted_access=paold.restricted_access
				FROM patient_extended_details panew WITH(NOLOCK)
				INNER JOIN support.Patients_Copy_Ref PCR WITH(NOLOCK) ON PCR.New_PatID=panew.pa_id
				INNER JOIN patient_extended_details paold WITH(NOLOCK) ON paold.pa_id=PCR.Old_PatID
				WHERE panew.pa_id=@new_pa_id AND PCR.New_PatID=@new_pa_id AND PCR.Old_PatID=@old_pa_id
			END
			ELSE IF EXISTS(SELECT TOP 1 1 FROM patient_extended_details WHERE pa_id=@old_pa_id) AND NOT EXISTS (SELECT TOP 1 1 FROM patient_extended_details WHERE pa_id=@new_pa_id)
			BEGIN
				INSERT INTO patient_extended_details  
			   (pa_id,pa_ext_ref, pa_ref_name_details, pa_ref_date, prim_dr_id, dr_id, cell_phone, marital_status, empl_status, work_phone, other_phone, comm_pref, pref_phone, time_zone, pref_start_time, pref_end_time, mother_first, mother_middle, mother_last, pa_death_date, emergency_contact_first, emergency_contact_last, emergency_contact_address1, emergency_contact_address2, emergency_contact_city, emergency_contact_state, emergency_contact_zip, emergency_contact_phone, emergency_contact_release_documents, emergency_contact_relationship, active, last_modified_date, last_modified_by, pa_phone_ctry_code, cell_phone_ctry_code, work_phone_ctry_code, other_phone_ctry_code, pa_phone_dial_code, cell_phone_dial_code, work_phone_dial_code, other_phone_dial_code, pa_phone_full, cell_phone_full, work_phone_full, other_phone_full, created_by_system, restricted_access)  
			   SELECT  @new_pa_id,pa_ext_ref, pa_ref_name_details, pa_ref_date, CASE WHEN ISNULL(prim_dr_id,0)>0 THEN @ToDoctorId ELSE prim_dr_id END, CASE WHEN ISNULL(dr_id,0)>0 THEN @ToDoctorId ELSE dr_id END, cell_phone, marital_status, empl_status, work_phone, other_phone, comm_pref, pref_phone, time_zone, pref_start_time, pref_end_time, mother_first, mother_middle, mother_last, pa_death_date, emergency_contact_first, emergency_contact_last, emergency_contact_address1, emergency_contact_address2, emergency_contact_city, emergency_contact_state, emergency_contact_zip, emergency_contact_phone, emergency_contact_release_documents, emergency_contact_relationship, active, last_modified_date, last_modified_by, pa_phone_ctry_code, cell_phone_ctry_code, work_phone_ctry_code, other_phone_ctry_code, pa_phone_dial_code, cell_phone_dial_code, work_phone_dial_code, other_phone_dial_code, pa_phone_full, cell_phone_full, work_phone_full, other_phone_full, 'Patient Data Export App', restricted_access  
			   FROM patient_extended_details patext  
			   WHERE patext.pa_id=@old_pa_id AND patext.pa_id IS NOT NULL
			END
		END	
  END
       
  EXEC [support].[CopyActiveMedsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyActiveDiagnosisFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyAllergiesFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyHistoryFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyImmunizationsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyProceduresFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyReferralsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @FromDoctorId= @FromDoctorId, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyVitalsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id,@ToDoctorId= @ToDoctorId 
  EXEC [support].[CopyFavouritePharmsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyPatientNotesFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId
  EXEC [support].[CopyPrescriptionsArchiveFromOnePatientToAnother] @FromPatientId=@old_pa_id,@ToPatientId=@new_pa_id,@ToDoctorId=@ToDoctorId
  EXEC [support].[CopyPrescriptionsFromOnePatientToAnother] @FromPatientId=@old_pa_id,@ToPatientId=@new_pa_id,@ToDoctorId=@ToDoctorId
  EXEC [support].[CopyMedHistoryFromOnePatientToAnother] @FromPatientId=@old_pa_id,@ToPatientId=@new_pa_id,@ToDoctorId=@ToDoctorId
  EXEC [support].[CopyFormularyFromOnePatientToAnother]   @FromPatientId=@old_pa_id,@ToPatientId=@new_pa_id,@ToDoctorId=@ToDoctorId
  EXEC [support].[CopyExternalFormularyFromOnePatientToAnother]  @FromPatientId=@old_pa_id,@ToPatientId=@new_pa_id,@ToDoctorId=@ToDoctorId
 FETCH NEXT FROM @PatientExportCursor INTO  @old_pa_id  
 END  
 CLOSE @PatientExportCursor  
 DEALLOCATE @PatientExportCursor  
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
