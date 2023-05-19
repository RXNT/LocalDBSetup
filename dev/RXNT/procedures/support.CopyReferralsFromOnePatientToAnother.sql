SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Referrals From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyReferralsFromOnePatientToAnother]
  @FromPatientId			BIGINT,  
  @ToPatientId				BIGINT,
  @FromDoctorId				BIGINT,
  @ToDoctorId				BIGINT
AS
BEGIN
	DECLARE @CopyRef_Id AS BIGINT
	DECLARE @new_dg_id AS BIGINT
	DECLARE @new_dc_id AS BIGINT
	
	SELECT @new_dg_id = dg_id FROM doctors WHERE dr_id=@ToDoctorId				
	SELECT @new_dc_id = dc_id FROM doc_groups WHERE dg_id=@new_dg_id
	
	SELECT @CopyRef_Id = CopyRef_Id 
	FROM support.Patients_Copy_Ref coa WITH(NOLOCK) 
	WHERE coa.New_DCID = @new_dc_id  AND coa.Old_PatID = @FromPatientId

	DECLARE @old_ref_id BIGINT 
	DECLARE @old_target_dr_id BIGINT
	DECLARE @new_target_dr_id BIGINT 
	DECLARE @new_ref_id as BIGINT  	

	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientReferralsCopied = 1)
	BEGIN
		DECLARE @PatientReferralCursor CURSOR
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, rm.ref_id, 'Referrals', GETDATE(),0
		FROM referral_main rm WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND rm.ref_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Referrals'
		WHERE rm.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
	  
		 SET @PatientReferralCursor = CURSOR FAST_FORWARD  
		 FOR SELECT ref_id
					FROM referral_main
					WHERE pa_id=@FromPatientId AND main_dr_id= @FromDoctorId
				 
		 OPEN @PatientReferralCursor  
		 FETCH NEXT FROM @PatientReferralCursor  
		 INTO  @old_ref_id
		  
		 WHILE @@FETCH_STATUS = 0  
		 BEGIN    
		  IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref coa WITH(NOLOCK)   
		  WHERE coa.New_DCID = @new_dc_id  AND coa.Old_PatID = @old_ref_id)  
		  BEGIN     
		   -- SELECT [support].[GetTableColumnNames] ('patient_extended_details','pa_id');  
			 
			INSERT INTO referral_main 
					(main_dr_id,target_dr_id,pa_id,ref_det_xref_id,ref_start_date,ref_end_date,carrier_xref_id,pa_member_no,ref_det_ident,
					main_prv_id1,main_prv_id2,target_prv_id1,target_prv_id2,inst_id,active,last_modified_date,last_modified_by)
			SELECT 	CASE WHEN ISNULL(main_dr_id,0)>0 THEN @ToDoctorId ELSE main_dr_id END,target_dr_id,@ToPatientId,ref_det_xref_id,ref_start_date,ref_end_date,carrier_xref_id,pa_member_no,ref_det_ident,
					main_prv_id1,main_prv_id2,target_prv_id1,target_prv_id2,inst_id,active,last_modified_date,1
			FROM referral_main
			WHERE ref_id=@old_ref_id
			
			SELECT @new_ref_id=SCOPE_IDENTITY()			
			
			SELECT @old_target_dr_id=target_dr_id FROM referral_main WHERE ref_id=@old_ref_id
			
			
			IF NOT EXISTS(SELECT TOP 1 1 FROM referral_target_docs WHERE target_dr_id = @old_target_dr_id AND dc_id=@new_dc_id)
			BEGIN
				INSERT INTO referral_target_docs
					(first_name,last_name,middle_initial,GroupName,speciality,address1,city,
					state,zip,phone,fax,IsLocal,ext_doc_id,dc_id)
				SELECT 	first_name,last_name,middle_initial,GroupName,speciality,address1,city,
						state,zip,phone,fax,IsLocal,ext_doc_id,dc_id
				FROM referral_target_docs
				WHERE target_dr_id=@old_target_dr_id
				
				SELECT @new_target_dr_id=SCOPE_IDENTITY()
				
				UPDATE referral_main SET target_dr_id=@new_target_dr_id
				WHERE ref_id=@new_ref_id
			END			
		  END	  
		  
		  IF @new_ref_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_ref_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_ref_id AND Type like 'Referrals'
			END
				 
		 FETCH NEXT FROM @PatientReferralCursor INTO  @old_ref_id  
		 END  
		 CLOSE @PatientReferralCursor  
		 DEALLOCATE @PatientReferralCursor  
	END 
	UPDATE support.Patients_Copy_Ref_Extended 
	SET PatientReferralsCopied = 1, LastUpdatedOn = GETDATE()
	WHERE CopyRef_Id = @CopyRef_Id 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
