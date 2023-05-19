SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	16-MAR-2017
-- Description:		Copy Immunizations From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyImmunizationsFromOnePatientToAnother]
  @FromPatientId			BIGINT,
  @ToPatientId				BIGINT,
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
	IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientImmunizationsCopied = 1)
	BEGIN
		--Loop Through Every Patients And Export them to ToDoctorId
		
		DECLARE @old_vac_rec_id INT,
				@vac_id	INT,
				@vac_pat_id	INT,
				@vac_dt_admin	DATETIME,
				@vac_lot_no	NVARCHAR(100),
				@vac_site	NVARCHAR(200),
				@vac_dose	NVARCHAR(400),
				@vac_exp_date	DATETIME,
				@vac_dr_id	INT,
				@vac_reaction	NVARCHAR(1024),
				@vac_remarks	NVARCHAR(1024),
				@vac_name	VARCHAR(150),
				@vis_date	SMALLDATETIME,
				@vis_given_date	SMALLDATETIME,
				@record_modified_date	DATETIME,
				@vac_site_code	VARCHAR(10),
				@vac_dose_unit_code	VARCHAR(20),
				@vac_administered_code	VARCHAR(2),
				@vac_administered_by	BIGINT,
				@vac_entered_by	BIGINT,
				@substance_refusal_reason_code	VARCHAR(2),
				@disease_code	VARCHAR(10),
				@active	BIT,
				@last_modified_date	DATETIME,
				@last_modified_by	INT,
				@VFC_Eligibility_Status	VARCHAR(10),
				@vfc_code	VARCHAR(3)

		/* ------------- User Local Veriables ------------- */	
		
		DECLARE @PatientImmunizationsCursor CURSOR
		DECLARE @NewVacRecordId as BIGINT
		DECLARE @NewVaccineId as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, tvr.vac_rec_id, 'Immunizations', GETDATE(),0
		FROM tblVaccinationRecord tvr WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND tvr.vac_rec_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Referrals'
		WHERE tvr.vac_pat_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL

		SET @PatientImmunizationsCursor = CURSOR FAST_FORWARD
				FOR SELECT 	vac_rec_id,vac_id,@ToPatientId,vac_dt_admin,vac_lot_no,vac_site,vac_dose,vac_exp_date,@ToDoctorId,vac_reaction,vac_remarks,vac_name,vis_date,
							vis_given_date,record_modified_date,vac_site_code,vac_dose_unit_code,vac_administered_code,CASE WHEN ISNULL(vac_administered_by,0)>0 THEN @ToDoctorId ELSE vac_administered_by END,
							1,substance_refusal_reason_code,disease_code,active,last_modified_date,1,VFC_Eligibility_Status,vfc_code
					FROM tblVaccinationRecord
					WHERE vac_pat_id=@FromPatientId

		OPEN @PatientImmunizationsCursor
				FETCH NEXT FROM @PatientImmunizationsCursor
				INTO 	@old_vac_rec_id,@vac_id,@vac_pat_id,@vac_dt_admin,@vac_lot_no,@vac_site,@vac_dose,@vac_exp_date,@vac_dr_id,@vac_reaction,@vac_remarks,@vac_name,@vis_date,
						@vis_given_date,@record_modified_date,@vac_site_code,@vac_dose_unit_code,@vac_administered_code,@vac_administered_by,@vac_entered_by,
						@substance_refusal_reason_code,@disease_code,@active,@last_modified_date,@last_modified_by,@VFC_Eligibility_Status,@vfc_code
				
		WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO tblVaccinationRecord 
					(vac_id,vac_pat_id,vac_dt_admin,vac_lot_no,vac_site,vac_dose,vac_exp_date,vac_dr_id,vac_reaction,vac_remarks,vac_name,vis_date,
					vis_given_date,record_modified_date,vac_site_code,vac_dose_unit_code,vac_administered_code,vac_administered_by,vac_entered_by,
					substance_refusal_reason_code,disease_code,active,last_modified_date,last_modified_by,VFC_Eligibility_Status,vfc_code)
			VALUES 
					(@vac_id,@vac_pat_id,@vac_dt_admin,@vac_lot_no,@vac_site,@vac_dose,@vac_exp_date,@vac_dr_id,@vac_reaction,@vac_remarks,@vac_name,@vis_date,
					@vis_given_date,@record_modified_date,@vac_site_code,@vac_dose_unit_code,@vac_administered_code,@vac_administered_by,@vac_entered_by,
					@substance_refusal_reason_code,@disease_code,@active,@last_modified_date,@last_modified_by,@VFC_Eligibility_Status,@vfc_code)
					
			SELECT @NewVacRecordId = SCOPE_IDENTITY()
			
			IF NOT EXISTS(SELECT TOP 1 1 FROM tblVaccines WHERE vac_id = @vac_id AND dc_id=@new_dc_id)
			BEGIN
				INSERT INTO tblVaccines
				(vac_name,vac_base_name,manufacturer,type,comments,route,info_link,dc_id,vac_exp_code,vis_link,CVX_CODE,mvx_code,route_code,eligibility_category_code,Expiration_Date)
				SELECT vac_name,vac_base_name,manufacturer,type,comments,route,info_link,@new_dc_id,vac_exp_code,vis_link,CVX_CODE,mvx_code,route_code,eligibility_category_code,Expiration_Date
				FROM tblVaccines
				WHERE vac_id=@vac_id
				
				SELECT @NewVaccineId = SCOPE_IDENTITY()
				
				UPDATE tblVaccinationRecord SET vac_id=@NewVaccineId 
				WHERE vac_rec_id=@NewVacRecordId
			END
			
			IF @NewVacRecordId>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@NewVacRecordId, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_vac_rec_id AND Type like 'Immunizations'
			END
			
			FETCH NEXT FROM @PatientImmunizationsCursor
			INTO 	@old_vac_rec_id,@vac_id,@vac_pat_id,@vac_dt_admin,@vac_lot_no,@vac_site,@vac_dose,@vac_exp_date,@vac_dr_id,@vac_reaction,@vac_remarks,@vac_name,@vis_date,
					@vis_given_date,@record_modified_date,@vac_site_code,@vac_dose_unit_code,@vac_administered_code,@vac_administered_by,@vac_entered_by,
					@substance_refusal_reason_code,@disease_code,@active,@last_modified_date,@last_modified_by,@VFC_Eligibility_Status,@vfc_code
		END

		CLOSE @PatientImmunizationsCursor
		DEALLOCATE @PatientImmunizationsCursor
		
		UPDATE support.Patients_Copy_Ref_Extended 
		SET PatientImmunizationsCopied = 1, LastUpdatedOn = GETDATE()
		WHERE CopyRef_Id = @CopyRef_Id 
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
