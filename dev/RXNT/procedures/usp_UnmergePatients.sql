SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Vidya
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_UnmergePatients]
(
	 @MergeRequestQueueId BIGINT,
	 @MergeRequestBatchId BIGINT,
	 @PatientUnmergeRequestId BIGINT,
	 @primary_id	INTEGER,
	 @secondary_id	INTEGER,
	 @CheckBatchId BIT
)
AS
BEGIN
	DECLARE @CreatedDate AS DATETIME2

	SELECT	@CreatedDate = BAT.Created_Date
	FROM	dbo.patient_merge_request_batch BAT WITH (NOLOCK)
	WHERE	pa_merge_batchid = @MergeRequestBatchId

	 /*DECLARE @CurrentId AS INTEGER
	 SET @CurrentId = @primary_id
		
	Select	QUE.*
	INTO	#TempQueue
	From	dbo.Patient_merge_request_queue QUE WITH (NOLOCK)
	WHERE	pa_merge_reqid in (
			Select	Max(QUE.pa_merge_reqid) As ReqId
			From	dbo.Patient_merge_request_queue QUE WITH (NOLOCK)
					INNER JOIN dbo.patient_merge_request_batch BAT WITH (nolock) ON BAT.pa_merge_batchid = QUE.pa_merge_batchid
			Where	QUE.pa_merge_reqid != @MergeRequestQueueId AND QUE.secondary_pa_id = @secondary_id)
			AND QUE.status = 2

	IF EXISTS(Select NULL From	#TempQueue)
	BEGIN
		Select	@CurrentId  = QUE.primary_pa_id
		From	#TempQueue QUE
	END

	  IF EXISTS(SELECT pa_id FROM dbo.patients WITH(NOLOCK) WHERE pa_id = @secondary_id and dg_id < 0) 
	  AND EXISTS(SELECT pa_id FROM patients WITH(NOLOCK) WHERE pa_id = @CurrentId and dg_id > 0)
	  BEGIN
	  */
	  BEGIN TRANSACTION
	  	  
	  BEGIN TRY

		--REVIEW
		--Remove the code for createddate
			UPDATE	patients  
			SET 
					pa_race_type = t.raceType,
					pa_ethn_type = t.ethnType,
					pref_lang = t.prefLang
			FROM	(SELECT top 1 BKP.pa_race_type AS raceType,
							BKP.pa_ethn_type AS ethnType,
							BKP.pref_lang AS prefLang
					FROM	[bk].[patients] BKP WITH (NOLOCK) 
					WHERE	BKP.pa_id = @primary_id  AND (BKP.pa_merge_reqid = @MergeRequestQueueId) AND BKP.Created_Date > @CreatedDate
					Order by created_date desc)AS t
			WHERE	pa_id = @primary_id
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.[patients] VIT WITH (NOLOCK)
			WHERE	 VIT.pa_id = @primary_id AND (VIT.pa_merge_reqid = @MergeRequestQueueId)  AND VIT.Created_Date > @CreatedDate

			--Update patient_vitals start
			
			SELECT	BKDRG.*
			INTO	#TempVitals
			FROM	bk.patient_vitals BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate
					
			UPDATE	VIT 
			SET		VIT.pa_id = @secondary_id,
					VIT.last_modified_date = GETDATE(),
					VIT.last_modified_by = 1 
			FROM	dbo.patient_vitals VIT WITH (NOLOCK)
					INNER JOIN #TempVitals BKVIT WITH (NOLOCK) ON BKVIT.pa_vt_id = VIT.pa_vt_id
			--WHERE	BKVIT.pa_id = @secondary_id 
			--		AND (BKVIT.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)-- AND VIT.pa_id = @CurrentId   //Review
			
			IF EXISTS (SELECT	NULL
			FROM	#TempVitals BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.pa_vt_id 
					FROM	dbo.patient_vitals DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pa_vt_id = DRG.pa_vt_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT dbo.patient_vitals ON

				INSERT INTO dbo.patient_vitals
				(
				pa_vt_id,
				pa_id,pa_wt,pa_ht,pa_pulse,pa_bp_sys,pa_bp_dys,pa_glucose,pa_resp_rate,pa_temp,pa_bmi,age,date_added,dg_id,added_by,added_for,record_date,pa_oxm,record_modified_date,pa_hc,pa_bp_location,pa_bp_sys_statnding,pa_bp_dys_statnding,pa_bp_location_statnding,pa_bp_sys_supine,pa_bp_dys_supine,pa_bp_location_supine,pa_temp_method,pa_pulse_rhythm,pa_pulse_standing,pa_pulse_rhythm_standing,pa_pulse_supine,pa_pulse_rhythm_supine,pa_heart_rate,pa_fio2,pa_flow,pa_resp_quality,pa_comment,active,last_modified_date,last_modified_by)
				SELECT	BKDRG.pa_vt_id,
						BKDRG.pa_id, BKDRG.pa_wt, BKDRG.pa_ht, BKDRG.pa_pulse, BKDRG.pa_bp_sys, BKDRG.pa_bp_dys, BKDRG.pa_glucose, 
						BKDRG.pa_resp_rate, BKDRG.pa_temp, BKDRG.pa_bmi, BKDRG.age, BKDRG.date_added, BKDRG.dg_id, BKDRG.added_by,
						BKDRG.added_for, BKDRG.record_date, BKDRG.pa_oxm, BKDRG.record_modified_date, BKDRG.pa_hc, BKDRG.pa_bp_location,
						BKDRG.pa_bp_sys_statnding, BKDRG.pa_bp_dys_statnding, BKDRG.pa_bp_location_statnding, BKDRG.pa_bp_sys_supine,
						BKDRG.pa_bp_dys_supine, BKDRG.pa_bp_location_supine, BKDRG.pa_temp_method, BKDRG.pa_pulse_rhythm, BKDRG.pa_pulse_standing,
						BKDRG.pa_pulse_rhythm_standing, BKDRG.pa_pulse_supine, BKDRG.pa_pulse_rhythm_supine, BKDRG.pa_heart_rate, BKDRG.pa_fio2,
						BKDRG.pa_flow, BKDRG.pa_resp_quality, BKDRG.pa_comment, BKDRG.active, BKDRG.last_modified_date, BKDRG.last_modified_by
				FROM	#TempVitals BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.pa_vt_id 
						FROM	dbo.patient_vitals DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pa_vt_id = DRG.pa_vt_id AND DRG.pa_id = @secondary_id)
						
				SET IDENTITY_INSERT dbo.patient_vitals OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_vitals VIT WITH (NOLOCK)
					INNER JOIN #TempVitals BKDRG WITH (NOLOCK) ON BKDRG.pa_vt_id = VIT.pa_vt_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate

			--Update patient_vitals end

			--Update patient_social_hx start
			
			SELECT	BKDRG.*
			INTO	#TempSocial
			FROM	bk.patient_social_hx BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pat_id = @secondary_id 
					AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	SCLHX
			SET		SCLHX.pat_id = @secondary_id,
					SCLHX.last_modified_on = GETDATE(),
					SCLHX.last_modified_by = 1 
			FROM	dbo.patient_social_hx SCLHX WITH (NOLOCK)
					INNER JOIN #TempSocial BKSCLHX WITH (NOLOCK) ON BKSCLHX.sochxid = SCLHX.sochxid 
			--WHERE	BKSCLHX.pat_id = @secondary_id --SCLHX.pat_id = @CurrentId AND 
			--		AND (BKSCLHX.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT	NULL
			FROM	#TempSocial BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.sochxid 
					FROM	dbo.patient_social_hx DRG  WITH (NOLOCK) 
					WHERE	BKDRG.sochxid = DRG.sochxid AND DRG.pat_id = @secondary_id))
			BEGIN		
				SET IDENTITY_INSERT dbo.patient_social_hx ON

				INSERT INTO dbo.patient_social_hx
				(
				sochxid,
				pat_id,emp_info,marital_status,other_marital_status,household_people_no,smoking_status,dr_id,added_by_dr_id,created_on,last_modified_on,last_modified_by,comments,enable,familyhx_other,medicalhx_other,surgeryhx_other,active)
				SELECT	BKDRG.sochxid,
						BKDRG.pat_id, BKDRG.emp_info, BKDRG.marital_status, BKDRG.other_marital_status, BKDRG.household_people_no,
						BKDRG.smoking_status, BKDRG.dr_id, BKDRG.added_by_dr_id, BKDRG.created_on, BKDRG.last_modified_on, BKDRG.last_modified_by,
						BKDRG.comments, BKDRG.enable, BKDRG.familyhx_other, BKDRG.medicalhx_other, BKDRG.surgeryhx_other, BKDRG.active
				FROM	#TempSocial BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.sochxid 
						FROM	dbo.patient_social_hx DRG  WITH (NOLOCK) 
						WHERE	BKDRG.sochxid = DRG.sochxid AND DRG.pat_id = @secondary_id)
					
				SET IDENTITY_INSERT dbo.patient_social_hx OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_social_hx VIT WITH (NOLOCK)
					INNER JOIN #TempSocial BKDRG WITH (NOLOCK) ON BKDRG.sochxid = VIT.sochxid AND BKDRG.pat_id = VIT.pat_id
			WHERE	VIT.pat_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					 AND VIT.Created_Date > @CreatedDate
			
			--Update patient_social_hx end

			--Update patient_registration start
			
			SELECT	BKDRG.*
			INTO	#TempReg
			FROM	bk.patient_registration BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	REG 
			SET		REG.pa_id =  @secondary_id,
					REG.last_modified_date = GETDATE(),
					REG.last_modified_by = 1 
			FROM	dbo.patient_registration REG WITH (NOLOCK)
					INNER JOIN #TempReg BKREG WITH (NOLOCK) on BKREG.pa_reg_id = REG.pa_reg_id 
			--WHERE	BKREG.pa_id = @secondary_id --REG.pa_id = @CurrentId AND 
			--		AND (BKREG.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
					
			IF EXISTS (SELECT	NULL
			FROM	#TempReg BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pa_reg_id 
					FROM	dbo.patient_registration DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pa_reg_id = DRG.pa_reg_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT dbo.patient_registration ON

				INSERT INTO [dbo].[patient_registration]
				(
					[pa_reg_id],
					[pa_id],[src_id],[pincode],[dr_id],[token],[reg_date],[exp_date],[last_update_date],[active],[last_modified_date],
					[last_modified_by])
			   SELECT	BKDRG.[pa_reg_id],
						BKDRG.[pa_id],BKDRG.[src_id],BKDRG.[pincode],BKDRG.[dr_id],[token],BKDRG.[reg_date],BKDRG.[exp_date],
						BKDRG.[last_update_date],BKDRG.[active],BKDRG.[last_modified_date],BKDRG.[last_modified_by]
				FROM	#TempReg BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pa_reg_id 
						FROM	dbo.patient_registration DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pa_reg_id = DRG.pa_reg_id AND DRG.pa_id = @secondary_id)
				
				SET IDENTITY_INSERT dbo.patient_registration OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_registration VIT WITH (NOLOCK)
					INNER JOIN #TempReg BKDRG WITH (NOLOCK) ON BKDRG.pa_reg_id = VIT.pa_reg_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	 VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempRegDb
			FROM	bk.patient_reg_db BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	REG
			SET		REG.pa_id = @secondary_id,
					REG.last_modified_date = GETDATE(),
					REG.last_modified_by = 1 
			FROM	dbo.patient_reg_db REG WITH (NOLOCK)
					INNER JOIN #TempRegDb BKREG WITH (NOLOCK) ON BKREG.pat_reg_id = REG.pat_reg_id 
			--WHERE	BKREG.pa_id = @secondary_id --REG.pa_id = @CurrentId AND 
			--		AND (BKREG.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT	NULL
			FROM	#TempRegDb BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pat_reg_id 
					FROM	dbo.patient_reg_db DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pat_reg_id = DRG.pat_reg_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_reg_db ON

				INSERT INTO [dbo].[patient_reg_db]
				   (
				   [pat_reg_id],
				   [dr_id],[pa_id],[pincode],[date_created],[src_type],[opt_out],[active],[last_modified_date],[last_modified_by])
				SELECT	 BKDRG.[pat_reg_id],
						BKDRG.[dr_id],BKDRG.[pa_id],BKDRG.[pincode],BKDRG.[date_created],BKDRG.[src_type],BKDRG.[opt_out],
						BKDRG.[active],BKDRG.[last_modified_date],BKDRG.[last_modified_by]
				FROM	#TempRegDb BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pat_reg_id 
						FROM	dbo.patient_reg_db DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pat_reg_id = DRG.pat_reg_id AND DRG.pa_id = @secondary_id)
				
				SET IDENTITY_INSERT patient_reg_db OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_reg_db VIT WITH (NOLOCK)
					INNER JOIN #TempRegDb BKDRG WITH (NOLOCK) ON BKDRG.pat_reg_id = VIT.pat_reg_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempProfile
			FROM	bk.patient_profile BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.patient_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	PRF 
			SET		PRF.patient_id =  @secondary_id,
					PRF.last_modified_date = GETDATE(),
					PRF.last_modified_by = 1 
			FROM	patient_profile PRF WITH (NOLOCK)
					INNER JOIN #TempProfile BKPRF WITH (NOLOCK) ON BKPRF.profile_id = PRF.profile_id 
			--WHERE	BKPRF.patient_id = @secondary_id --RF.patient_id = @CurrentId AND
			--		AND (BKPRF.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempProfile BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.profile_id 
					FROM	dbo.patient_profile DRG  WITH (NOLOCK) 
					WHERE	BKDRG.profile_id = DRG.profile_id AND DRG.patient_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_profile ON

				INSERT INTO [dbo].[patient_profile]
				(
					[profile_id],
					[patient_id], [added_by_dr_id], [entry_date], [last_update_date], [last_update_dr_id], [active],
					[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.[profile_id],
						BKDRG.[patient_id], BKDRG.[added_by_dr_id], BKDRG.[entry_date], BKDRG.[last_update_date], 
						BKDRG.[last_update_dr_id], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempProfile BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.profile_id 
						FROM	dbo.patient_profile DRG  WITH (NOLOCK) 
						WHERE	BKDRG.profile_id = DRG.profile_id AND DRG.patient_id = @secondary_id) 					
				
				SET IDENTITY_INSERT patient_profile OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_profile VIT WITH (NOLOCK)
					INNER JOIN #TempProfile BKDRG WITH (NOLOCK) ON BKDRG.profile_id = VIT.profile_id AND BKDRG.patient_id = VIT.patient_id
			WHERE	VIT.patient_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempProcedures
			FROM	bk.patient_procedures BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE  PRG 
			SET		PRG.pa_id =  @secondary_id,
					PRG.last_modified_date = GETDATE(),
					PRG.last_modified_by = 1 
			FROM	patient_procedures PRG WITH (NOLOCK)
					INNER JOIN #TempProcedures BKPRG WITH (NOLOCK) on BKPRG.procedure_id = PRG.procedure_id 
			--WHERE	BKPRG.pa_id = @secondary_id --PRG.pa_id = @CurrentId AND 
			--		AND (BKPRG.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT NULL
			FROM	#TempProcedures BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.procedure_id 
					FROM	dbo.patient_procedures DRG  WITH (NOLOCK) 
					WHERE	BKDRG.procedure_id = DRG.procedure_id AND DRG.pa_id = @secondary_id))
			BEGIN
			
				SET IDENTITY_INSERT patient_procedures ON

				INSERT INTO [dbo].[patient_procedures]
				(
					[procedure_id],
					[pa_id],[dr_id],[date_performed],[type],[status],[code],[description],[notes],[record_modified_date],[date_performed_to],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.[procedure_id],
						BKDRG.[pa_id], BKDRG.[dr_id], BKDRG.[date_performed], BKDRG.[type], BKDRG.[status], BKDRG.[code], BKDRG.[description],
						BKDRG.[notes], BKDRG.[record_modified_date], BKDRG.[date_performed_to], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempProcedures BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.procedure_id 
						FROM	dbo.patient_procedures DRG  WITH (NOLOCK) 
						WHERE	BKDRG.procedure_id = DRG.procedure_id AND DRG.pa_id = @secondary_id)  					

				SET IDENTITY_INSERT patient_procedures OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_procedures VIT WITH (NOLOCK)
					INNER JOIN #TempProcedures BKDRG WITH (NOLOCK) ON BKDRG.procedure_id = VIT.procedure_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempPatientPhr
			FROM	bk.patient_phr_access_log BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	PHR 
			SET		PHR.pa_id =  @secondary_id,
					PHR.last_modified_date = GETDATE(),
					PHR.last_modified_by = 1 
			FROM	patient_phr_access_log PHR WITH (NOLOCK)
					INNER JOIN #TempPatientPhr BKPHR WITH (NOLOCK) on BKPHR.phr_access_log_id = PHR.phr_access_log_id 
			--WHERE	BKPHR.pa_id = @secondary_id --PHR.pa_id = @CurrentId AND 
			--		AND (BKPHR.pa_merge_reqid = @MergeRequestQueueId  OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT	NULL
			FROM	#TempPatientPhr BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.phr_access_log_id 
					FROM	dbo.patient_phr_access_log DRG  WITH (NOLOCK) 
					WHERE	BKDRG.phr_access_log_id = DRG.phr_access_log_id AND DRG.pa_id = @secondary_id)  )
			BEGIN
				SET IDENTITY_INSERT patient_phr_access_log ON

				INSERT INTO [dbo].[patient_phr_access_log]
				(
					[phr_access_log_id],
					[pa_id],[phr_access_type],[phr_access_description],[phr_access_datetime],[phr_access_from_ip],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.[phr_access_log_id],
						BKDRG.[pa_id],BKDRG.[phr_access_type],BKDRG.[phr_access_description],BKDRG.[phr_access_datetime],
						BKDRG.[phr_access_from_ip],BKDRG.[active],BKDRG.[last_modified_date],BKDRG.[last_modified_by]
				FROM	#TempPatientPhr BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.phr_access_log_id 
						FROM	dbo.patient_phr_access_log DRG  WITH (NOLOCK) 
						WHERE	BKDRG.phr_access_log_id = DRG.phr_access_log_id AND DRG.pa_id = @secondary_id)  
				
				SET IDENTITY_INSERT patient_phr_access_log OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_phr_access_log VIT WITH (NOLOCK)
					INNER JOIN #TempPatientPhr BKDRG WITH (NOLOCK) ON BKDRG.phr_access_log_id = VIT.phr_access_log_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId )
					AND VIT.Created_Date > @CreatedDate 

			--REVIEW
			
			UPDATE	patient_next_of_kin 
			SET
					kin_relation_code=kin_relation_code,
					kin_first=kin.kinfirst,
					kin_middle=kin.kinmiddle,
					kin_last=kin.kinlast,
					kin_address1=kin.kinaddress1,
					kin_city=kin.kincity,
					kin_state=kin.kinstate,
					kin_zip=kin.kinzip,
					kin_country=kin.kincountry,
					kin_phone=kin.kinphone,
					kin_email=kin.kinemail,
					last_modified_date=GETDATE(),
					last_modified_by=1
			FROM	(SELECT		top 1 kin_relation_code AS relationcode,
								kin_first AS kinfirst,
								kin_middle AS kinmiddle,
								kin_last AS kinlast,
								kin_address1 AS kinaddress1,
								kin_city AS kincity,
								kin_state AS kinstate,
								kin_zip AS kinzip,
								kin_country AS kincountry,
								kin_phone AS kinphone,
								kin_email AS kinemail
					FROM	bk.patient_next_of_kin WITH (NOLOCK)
					WHERE	pa_id=@primary_id AND (pa_merge_reqid = @MergeRequestQueueId)
							AND Created_Date > @CreatedDate
					Order by created_date desc) AS kin
				WHERE pa_id=@primary_id

			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_next_of_kin VIT WITH (NOLOCK)
			WHERE	 VIT.pa_id = @primary_id AND (VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate
			
			SELECT	BKDRG.*
			INTO	#TempPatientAllergiesExt
			FROM	bk.patient_new_allergies_external BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pae_pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE  ALG 
			SET		ALG.pae_pa_id = @secondary_id,
					ALG.last_modified_date = GETDATE(),
					ALG.last_modified_by = 1 
			FROM	patient_new_allergies_external ALG WITH (NOLOCK)
					INNER JOIN #TempPatientAllergiesExt BKALG WITH (NOLOCK) ON BKALG.pae_pa_allergy_id = ALG.pae_pa_allergy_id 
			--WHERE	BKALG.pae_pa_id = @secondary_id --ALG.pae_pa_id = @CurrentId AND 
			--		AND (BKALG.pa_merge_reqid = @MergeRequestQueueId  OR @CheckBatchId = 0)			
			
			IF EXISTS (SELECT NULL
			FROM	#TempPatientAllergiesExt BKDRG wITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pae_pa_allergy_id 
					FROM	dbo.patient_new_allergies_external DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pae_pa_allergy_id = DRG.pae_pa_allergy_id AND DRG.pae_pa_id = @secondary_id) )
			BEGIn
				SET IDENTITY_INSERT patient_new_allergies_external ON

				INSERT INTO [dbo].[patient_new_allergies_external]
				(
					pae_pa_allergy_id,
					[pae_pa_id],[pae_source_name],[pae_allergy_id],[pae_allergy_description],[pae_allergy_type],[pae_add_date],[pae_comments],[pae_reaction_string],[pae_status],[pae_dr_modified_user],[pae_disable_date],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.pae_pa_allergy_id,
						BKDRG.[pae_pa_id], BKDRG.[pae_source_name], BKDRG.[pae_allergy_id], BKDRG.[pae_allergy_description],
						BKDRG.[pae_allergy_type],BKDRG.[pae_add_date],BKDRG.[pae_comments],BKDRG.[pae_reaction_string],BKDRG.[pae_status],
						BKDRG.[pae_dr_modified_user],BKDRG.[pae_disable_date],BKDRG.[active],BKDRG.[last_modified_date],BKDRG.[last_modified_by]
				FROM	#TempPatientAllergiesExt BKDRG wITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pae_pa_allergy_id 
						FROM	dbo.patient_new_allergies_external DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pae_pa_allergy_id = DRG.pae_pa_allergy_id AND DRG.pae_pa_id = @secondary_id) 
				
				SET IDENTITY_INSERT patient_new_allergies_external OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_new_allergies_external VIT WITH (NOLOCK)
					INNER JOIN #TempPatientAllergiesExt BKDRG WITH (NOLOCK) ON BKDRG.pae_pa_allergy_id = VIT.pae_pa_allergy_id AND BKDRG.pae_pa_id = VIT.pae_pa_id
			WHERE	VIT.pae_pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempPatientAllergies
			FROM	bk.patient_new_allergies BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE  ALG 
			SET		ALG.pa_id = @secondary_id,
					ALG.last_modified_date = GETDATE(),
					ALG.last_modified_by = 1 
			FROM	patient_new_allergies ALG WITH (NOLOCK)
					INNER JOIN #TempPatientAllergies BKALG WITH (NOLOCK) ON BKALG.pa_allergy_id = ALG.pa_allergy_id 
			WHERE	NOT EXISTS(SELECT pa_allergy_id 
					FROM patient_new_allergies WHERE pa_id = @secondary_id 
					AND allergy_id = ALG.allergy_id AND allergy_type = ALG.allergy_type)
						
			IF EXISTS(SELECT	NULL
			FROM	#TempPatientAllergies BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.pa_allergy_id 
					FROM	dbo.patient_new_allergies DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pa_allergy_id = DRG.pa_allergy_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_new_allergies ON
						
				INSERT INTO dbo.patient_new_allergies
				(
				pa_allergy_id,
				pa_id,allergy_id,allergy_type,add_date,comments,reaction_string,status,dr_modified_user,disable_date,source_type,allergy_description,record_source,active,last_modified_date,last_modified_by)
				SELECT	BKDRG.pa_allergy_id,
						BKDRG.pa_id, BKDRG.allergy_id, BKDRG.allergy_type, BKDRG.add_date, BKDRG.comments, BKDRG.reaction_string,BKDRG.status,
						BKDRG.dr_modified_user,BKDRG.disable_date,BKDRG.source_type,BKDRG.allergy_description,BKDRG.record_source,BKDRG.active,
						BKDRG.last_modified_date,BKDRG.last_modified_by
				FROM	#TempPatientAllergies BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.pa_allergy_id 
						FROM	dbo.patient_new_allergies DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pa_allergy_id = DRG.pa_allergy_id AND DRG.pa_id = @secondary_id AND DRG.allergy_type = BKDRG.allergy_type)

				SET IDENTITY_INSERT patient_new_allergies OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_new_allergies VIT WITH (NOLOCK)
					INNER JOIN #TempPatientAllergies BKDRG WITH (NOLOCK) ON BKDRG.pa_allergy_id = VIT.pa_allergy_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempPatientSch
			FROM	bk.scheduler_main BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.ext_link_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	SCH 
			SET		SCH.ext_link_id =  @secondary_id,
					SCH.last_modified_date = GETDATE(),
					SCH.last_modified_by = 1 
			FROM	scheduler_main SCH WITH (NOLOCK)
					INNER JOIN #TempPatientSch BKSCH WITH (NOLOCK) ON BKSCH.event_id = SCH.event_id 
			--where	BKSCH.ext_link_id = @secondary_id --SCH.ext_link_id = @CurrentId AND
			--		AND (BKSCH.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempPatientSch BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.event_id 
					FROM	dbo.scheduler_main DRG  WITH (NOLOCK) 
					WHERE	BKDRG.event_id = DRG.event_id AND DRG.ext_link_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT scheduler_main ON

				INSERT INTO [dbo].[scheduler_main]
				(
					event_id,
					[event_start_date],[dr_id],[type],[ext_link_id],[note],[detail_header],[event_end_date],[is_new_pat],[recurrence],[recurrence_parent],[status],[dtCheckIn],[dtCalled],[dtCheckedOut],[dtintake],[case_id],[room_id],[reason],[is_confirmed],[discharge_disposition_code],[is_delete_attempt],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.event_id,
						BKDRG.[event_start_date], BKDRG.[dr_id], BKDRG.[type], BKDRG.[ext_link_id], BKDRG.[note], BKDRG.[detail_header],
						BKDRG.[event_end_date], BKDRG.[is_new_pat], BKDRG.[recurrence], BKDRG.[recurrence_parent],BKDRG.[status],
						BKDRG.[dtCheckIn], BKDRG.[dtCalled], BKDRG.[dtCheckedOut], BKDRG.[dtintake], BKDRG.[case_id], BKDRG.[room_id],
						BKDRG.[reason], BKDRG.[is_confirmed], BKDRG.[discharge_disposition_code], BKDRG.[is_delete_attempt],
						BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempPatientSch BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.event_id 
						FROM	dbo.scheduler_main DRG  WITH (NOLOCK) 
						WHERE	BKDRG.event_id = DRG.event_id AND DRG.ext_link_id = @secondary_id)
						 
				SET IDENTITY_INSERT scheduler_main OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.scheduler_main VIT WITH (NOLOCK)
					INNER JOIN #TempPatientSch BKDRG WITH (NOLOCK) ON BKDRG.event_id = VIT.event_id AND BKDRG.ext_link_id = VIT.ext_link_id
			WHERE	VIT.ext_link_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId )
					AND VIT.Created_Date > @CreatedDate 
					

			SELECT	BKDRG.*
			INTO	#TempVacination
			FROM	bk.tblVaccinationRecord BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.vac_pat_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE  VAC 
			SET		VAC.vac_pat_id = @secondary_id,
					VAC.last_modified_date = GETDATE(),
					VAC.last_modified_by = 1 
			FROM	tblVaccinationRecord VAC WITH (NOLOCK) 
					INNER JOIN #TempVacination BKVAC WITH (NOLOCK) ON BKVAC.vac_rec_id = VAC.vac_rec_id 
			--WHERE	 BKVAC.vac_pat_id = @secondary_id		--VAC.vac_pat_id = @CurrentId	AND
			--		AND (BKVAC.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempVacination BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.vac_rec_id 
					FROM	dbo.tblVaccinationRecord DRG  WITH (NOLOCK) 
					WHERE	BKDRG.vac_rec_id = DRG.vac_rec_id AND DRG.vac_pat_id = @secondary_id) )
			BEGIN
				SET IDENTITY_INSERT tblVaccinationRecord ON

				INSERT INTO [dbo].[tblVaccinationRecord]
				(
					[vac_rec_id],
					[vac_id],[vac_pat_id],[vac_dt_admin],[vac_lot_no],[vac_site],[vac_dose],[vac_exp_date],[vac_dr_id],[vac_reaction],[vac_remarks],[vac_name],[vis_date],[vis_given_date],[record_modified_date],[vac_site_code],[vac_dose_unit_code],[vac_administered_code],[vac_administered_by],[vac_entered_by],[substance_refusal_reason_code],[disease_code],[active],[last_modified_date],[last_modified_by],
					[VFC_Eligibility_Status],
					[vfc_code]
				)
				SELECT	BKDRG.[vac_rec_id],
						BKDRG.[vac_id], BKDRG.[vac_pat_id], BKDRG.[vac_dt_admin], BKDRG.[vac_lot_no], BKDRG.[vac_site], BKDRG.[vac_dose],
						BKDRG.[vac_exp_date], BKDRG.[vac_dr_id], BKDRG.[vac_reaction], BKDRG.[vac_remarks], BKDRG.[vac_name], BKDRG.[vis_date],
						BKDRG.[vis_given_date], BKDRG.[record_modified_date], BKDRG.[vac_site_code], BKDRG.[vac_dose_unit_code],
						BKDRG.[vac_administered_code], BKDRG.[vac_administered_by], BKDRG.[vac_entered_by], BKDRG.[substance_refusal_reason_code],
						BKDRG.[disease_code], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by], 
						BKDRG.[VFC_Eligibility_Status], BKDRG.[vfc_code]
				FROM	#TempVacination BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.vac_rec_id 
						FROM	dbo.tblVaccinationRecord DRG  WITH (NOLOCK) 
						WHERE	BKDRG.vac_rec_id = DRG.vac_rec_id AND DRG.vac_pat_id = @secondary_id) 
				
				SET IDENTITY_INSERT tblVaccinationRecord OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.tblVaccinationRecord VIT WITH (NOLOCK)
					INNER JOIN #TempVacination BKDRG WITH (NOLOCK) ON BKDRG.vac_rec_id = VIT.vac_rec_id AND BKDRG.vac_pat_id = VIT.vac_pat_id
			WHERE	VIT.vac_pat_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempWarning
			FROM	bk.interaction_warning_log BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	WAR 
			SET		WAR.pa_id = @secondary_id,
					WAR.last_modified_date = GETDATE(),
					WAR.last_modified_by = 1 
			FROM	interaction_warning_log WAR WITH (NOLOCK)
					INNER JOIN #TempWarning BKWAR WITH (NOLOCK) ON BKWAR.int_warn_id = WAR.int_warn_id 
			--WHERE	BKWAR.pa_id = @secondary_id		 --WAR.pa_id = @CurrentId	AND 
			--		AND (BKWAR.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT NULL
			FROM	#TempWarning BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.int_warn_id 
					FROM	dbo.interaction_warning_log DRG  WITH (NOLOCK) 
					WHERE	BKDRG.int_warn_id = DRG.int_warn_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT interaction_warning_log ON

				INSERT INTO [dbo].[interaction_warning_log]
				(
					[int_warn_id],
					[dr_id],[pa_id],[drug_id],[response],[date],[warning_source],[reason],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.[int_warn_id],
						BKDRG.[dr_id], BKDRG.[pa_id], BKDRG.[drug_id], BKDRG.[response], BKDRG.[date], BKDRG.[warning_source],
						BKDRG.[reason], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempWarning BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.int_warn_id 
						FROM	dbo.interaction_warning_log DRG  WITH (NOLOCK) 
						WHERE	BKDRG.int_warn_id = DRG.int_warn_id AND DRG.pa_id = @secondary_id) 
						
				SET IDENTITY_INSERT interaction_warning_log OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.interaction_warning_log VIT WITH (NOLOCK)
					INNER JOIN #TempWarning BKDRG WITH (NOLOCK) ON BKDRG.int_warn_id = VIT.int_warn_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempFlag
			FROM	bk.patient_flag_details BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	FLG 
			SET		FLG.pa_id = @secondary_id,
					FLG.last_modified_date = GETDATE(),
					FLG.last_modified_by = 1 
			FROM	patient_flag_details FLG WITH (NOLOCK)
					INNER JOIN #TempFlag BKFLG WITH (NOLOCK) ON BKFLG.pa_flag_id = FLG.pa_flag_id 
			--WHERE	 BKFLG.pa_id = @secondary_id	--FLG.pa_id = @CurrentId		AND
			--		AND (BKFLG.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
				
			IF EXISTS(SELECT NULL
			FROM	#TempFlag BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.pa_flag_id 
					FROM	dbo.patient_flag_details DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pa_flag_id = DRG.pa_flag_id AND DRG.pa_id = @secondary_id) )
			BEGIN
				SET IDENTITY_INSERT patient_flag_details ON

				INSERT INTO dbo.patient_flag_details
				(
					pa_flag_id,
					pa_id,flag_id,flag_text,dr_id,date_added,active,last_modified_date,last_modified_by)
				SELECT  BKDRG.pa_flag_id,
						BKDRG.pa_id, BKDRG.flag_id, BKDRG.flag_text, BKDRG.dr_id, BKDRG.date_added, BKDRG.active, BKDRG.last_modified_date, BKDRG.last_modified_by
				FROM	#TempFlag BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.pa_flag_id 
						FROM	dbo.patient_flag_details DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pa_flag_id = DRG.pa_flag_id AND DRG.pa_id = @secondary_id) 
						 
				SET IDENTITY_INSERT patient_flag_details OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_flag_details VIT WITH (NOLOCK)
					INNER JOIN #TempFlag BKDRG WITH (NOLOCK) ON BKDRG.pa_flag_id = VIT.pa_flag_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND 
					(@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempFamilyHx
			FROM	bk.patient_family_hx BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pat_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	FAM
			SET		FAM.pat_id = @secondary_id,
					FAM.last_modified_date = GETDATE(),
					FAM.last_modified_by = 1 
			FROM	patient_family_hx FAM WITH (NOLOCK)
					INNER JOIN #TempFamilyHx BKFAM WITH (NOLOCK) ON BKFAM.fhxid = FAM.fhxid 
			--WHERE	BKFAm.pat_id = @secondary_id --FAM.pat_id = @CurrentId AND 
			--		AND (BKFAm.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
					
			IF EXISTS(SELECT NULL
			FROM	#TempFamilyHx BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.fhxid 
					FROM	dbo.patient_family_hx DRG  WITH (NOLOCK) 
					WHERE	BKDRG.fhxid = DRG.fhxid AND DRG.pat_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_family_hx ON

				INSERT INTO dbo.patient_family_hx
				(
				fhxid,
				pat_id,member_relation_id,problem,icd9,dr_id,added_by_dr_id,created_on,last_modified_on,last_modified_by,comments,enable,active,
				last_modified_date,icd10,icd9_description,icd10_description,snomed,snomed_description)
				SELECT  BKDRG.fhxid,
						BKDRG.pat_id, BKDRG.member_relation_id, BKDRG.problem, BKDRG.icd9, 
						BKDRG.dr_id, BKDRG.added_by_dr_id, BKDRG.created_on, BKDRG.last_modified_on, BKDRG.last_modified_by, BKDRG.comments,
						BKDRG.enable, BKDRG.active, BKDRG.last_modified_date
						, BKDRG.icd10, BKDRG.icd9_description,BKDRG.icd10_description, BKDRG.snomed,BKDRG.snomed_description
				FROM	#TempFamilyHx BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.fhxid 
						FROM	dbo.patient_family_hx DRG  WITH (NOLOCK) 
						WHERE	BKDRG.fhxid = DRG.fhxid AND DRG.pat_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_family_hx OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_family_hx VIT WITH (NOLOCK)
					INNER JOIN #TempFamilyHx BKDRG WITH (NOLOCK) ON BKDRG.fhxid = VIT.fhxid AND BKDRG.pat_id = VIT.pat_id
			WHERE	VIT.pat_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			UPDATE	PAT
			SET		PAT.pa_id = @secondary_id
			FROM	bk.patient_identifiers BKPAT WITH (NOLOCK)
					INNER JOIN dbo.patient_identifiers PAT WITH (NOLOCK) ON PAT.pik_id = BKPAT.pik_id AND PAT.pa_id = -1 * @secondary_id
			WHERE	BKPAT.pa_id = @secondary_id
					and PAT.pik_id not in (
						select pik_id from patient_identifiers WITH(NOLOCK) WHERE pa_id = @secondary_id
					)
					AND  (@CheckBatchId = 0 OR BKPAT.pa_merge_reqid = @MergeRequestQueueId)
					AND BKPAT.Created_Date > @CreatedDate

			UPDATE	PAT
			SET		PAT.pa_id = @secondary_id
			FROM	bk.patient_identifiers BKPAT WITH (NOLOCK)
					INNER JOIN dbo.patient_identifiers PAT WITH (NOLOCK) ON PAT.pik_id = BKPAT.pik_id AND PAT.pa_id = @primary_id
			WHERE	BKPAT.pa_id = @secondary_id
					and PAT.pik_id not in (
						select pik_id from patient_identifiers WITH(NOLOCK) WHERE pa_id = @secondary_id
					)
					AND  (@CheckBatchId = 0 OR BKPAT.pa_merge_reqid = @MergeRequestQueueId)
					AND BKPAT.Created_Date > @CreatedDate
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_identifiers VIT WITH (NOLOCK)
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate

			--Review
			
			UPDATE patient_extended_details  
			SET 
				pa_ext_ref=t.ref,
				pa_ref_name_details=t.details,
				pa_ref_date=t.ref_date,
				prim_dr_id=t.pdr_id,
				dr_id=t.drId,
				cell_phone=t.cellphone,
				marital_status=t.maritalstatus,
				empl_status=t.emplstatus,
				work_phone=t.workphone,
				other_phone=t.otherphone,
				comm_pref=t.commpref,
				pref_phone=t.prefphone,
				time_zone=t.timezone,
				pref_start_time=t.pstarttime,
				pref_end_time=t.pendtime,
				mother_first=t.motherfirst,
				mother_middle=t.mothermiddle,
				mother_last=t.motherlast,
				pa_death_date=t.padeathdate,
				emergency_contact_first=t.econtactfirst,
				emergency_contact_last=t.econtactlast,
				emergency_contact_address1=t.econtactaddress1,
				emergency_contact_address2=t.econtactaddress2,
				emergency_contact_city=t.econtactcity,
				emergency_contact_state=t.econtactstate,
				emergency_contact_zip=t.econtactzip,
				emergency_contact_phone=t.econtactphone,
				emergency_contact_release_documents=t.econtactreldoc,
				emergency_contact_relationship=t.econtactrelationship,
				last_modified_date=GETDATE(),
				last_modified_by=1
			FROM (SELECT top 1 p.pa_ext_ref AS ref,
				p.pa_ref_name_details AS details,
				pa_ref_date AS ref_date,
				prim_dr_id AS pdr_id,
				dr_id AS drId,
				cell_phone AS cellphone,
				marital_status AS maritalstatus,
				empl_status AS emplstatus,
				work_phone AS workphone,
				other_phone AS otherphone,
				comm_pref AS commpref,
				pref_phone AS prefphone,
				time_zone AS timezone,
				pref_start_time AS pstarttime,
				pref_end_time AS pendtime,
				mother_first AS motherfirst,
				mother_middle AS mothermiddle,
				mother_last AS motherlast,
				pa_death_date AS padeathdate,
				emergency_contact_first AS econtactfirst,
				emergency_contact_last AS econtactlast,
				emergency_contact_address1 AS econtactaddress1,
				emergency_contact_address2 AS econtactaddress2,
				emergency_contact_city AS econtactcity,
				emergency_contact_state AS econtactstate,
				emergency_contact_zip AS econtactzip,
				emergency_contact_phone AS econtactphone,
				emergency_contact_release_documents AS econtactreldoc,
				emergency_contact_relationship AS econtactrelationship
				FROM bk.patient_extended_details AS P WITH(NOLOCK) 
				WHERE	pa_id=@primary_id
						AND (P.pa_merge_reqid = @MergeRequestQueueId)
						AND P.Created_Date > @CreatedDate
				Order by created_date desc)AS t
				WHERE pa_id = @primary_id
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_extended_details VIT WITH (NOLOCK)
			WHERE	 VIT.pa_id = @primary_id AND (VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate
			
			SELECT	BKDRG.*
			INTO	#TempDoc
			FROM	bk.patient_documents BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pat_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	DOC
			SET		DOC.pat_id =  @secondary_id,
					DOc.last_modified_date = GETDATE(),
					DOC.last_modified_by = 1 
			FROM	patient_documents DOC WITH (NOLOCK)
					INNER JOIN #TempDoc BKDOC WITH (NOLOCK) ON BKDOC.document_id = DOC.document_id 
			--WHERE	BKDOC.pat_id = @secondary_id --DOC.pat_id = @CurrentId AND
			--		AND (BKDOC.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempDoc BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.document_id 
					FROM	dbo.patient_documents DRG  WITH (NOLOCK) 
					WHERE	BKDRG.document_id = DRG.document_id AND DRG.pat_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_documents ON

				INSERT INTO [dbo].[patient_documents]
				(
					[document_id],
					[pat_id],[src_dr_id],[upload_date],[title],[description],[filename],[cat_id],[owner_id],[owner_type],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	[document_id],
						BKDRG.[pat_id], BKDRG.[src_dr_id], BKDRG.[upload_date], BKDRG.[title], BKDRG.[description], BKDRG.[filename],
						BKDRG.[cat_id], BKDRG.[owner_id], BKDRG.[owner_type], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempDoc BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.document_id 
						FROM	dbo.patient_documents DRG  WITH (NOLOCK) 
						WHERE	BKDRG.document_id = DRG.document_id AND DRG.pat_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_documents OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_documents VIT WITH (NOLOCK)
					INNER JOIN #TempDoc BKDRG WITH (NOLOCK) ON BKDRG.document_id = VIT.document_id AND BKDRG.pat_id = VIT.pat_id
			WHERE	VIT.pat_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempApptReq
			FROM	bk.patient_appointment_request BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pat_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE  APP 
			SET		APP.pat_id =  @secondary_id, 
					APP.last_modified_date = GETDATE(),
					APP.last_modified_by = 1
			FROM	patient_appointment_request APP WITH (NOLOCK)
					INNER JOIN #TempApptReq BKAPP WITH (NOLOCK) ON BKAPP.pat_appt_req_id = APP.pat_appt_req_id 
			--WHERE	BKAPP.pat_id = @secondary_id --APP.pat_id = @CurrentId AND 
			--		AND (BKAPP.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempApptReq BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pat_appt_req_id 
					FROM	dbo.patient_appointment_request DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pat_appt_req_id = DRG.pat_appt_req_id AND DRG.pat_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_appointment_request ON

				INSERT INTO [dbo].[patient_appointment_request]
				(
					pat_appt_req_id,
					[pat_id],[dg_id],[req_appt_date],[req_appt_time],[primary_reason],[is_completed],[created_datetime],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.pat_appt_req_id,
						BKDRG.[pat_id], BKDRG.[dg_id], BKDRG.[req_appt_date], BKDRG.[req_appt_time], BKDRG.[primary_reason],
						BKDRG.[is_completed], BKDRG.[created_datetime], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempApptReq BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pat_appt_req_id 
						FROM	dbo.patient_appointment_request DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pat_appt_req_id = DRG.pat_appt_req_id AND DRG.pat_id = @secondary_id)
					
				SET IDENTITY_INSERT patient_appointment_request OFF
			END

			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_appointment_request VIT WITH (NOLOCK)
					INNER JOIN #TempApptReq BKDRG WITH (NOLOCK) ON BKDRG.pat_appt_req_id = VIT.pat_appt_req_id AND BKDRG.pat_id = VIT.pat_id
			WHERE	VIT.pat_id = @secondary_id
					AND (@CheckBatchId = 0 AND VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate
			
			SELECT	BKDRG.*
			INTO	#TempActMedExt
			FROM	bk.patient_active_meds_external BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pame_pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	ACT 
			SET		ACT.pame_pa_id =  @secondary_id,
					ACT.last_modified_date = GETDATE(),
					ACT.last_modified_by = 1 
			FROM	patient_active_meds_external ACT WITH (NOLOCK)
					INNER JOIN #TempActMedExt BKACT WITH (NOLOCK) ON BKACT.pame_id = ACT.pame_id 
			--WHERE	 BKACT.pame_pa_id = @secondary_id--ACT.pame_pa_id = @CurrentId AND
			--		AND (BKACT.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT	NULL
			FROM	#TempActMedExt BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pame_id 
					FROM	dbo.patient_active_meds_external DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pame_id = DRG.pame_id AND DRG.pame_pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_active_meds_external ON
				
				INSERT INTO [dbo].[patient_active_meds_external]
				(
					pame_id,
					[pame_pa_id],[pame_drug_id],[pame_date_added],[pame_compound],[pame_comments],[pame_status],[pame_drug_name],[pame_dosage],[pame_duration_amount],[pame_duration_unit],[pame_drug_comments],[pame_numb_refills],[pame_use_generic],[pame_days_supply],[pame_prn],[pame_prn_description],[pame_date_start],[pame_date_end],[pame_source_name],[active],[last_modified_date],[last_modified_by],[external_id]
				)
				SELECT	BKDRG.pame_id,
						BKDRG.[pame_pa_id], BKDRG.[pame_drug_id], BKDRG.[pame_date_added], BKDRG.[pame_compound], BKDRG.[pame_comments],
						BKDRG.[pame_status], BKDRG.[pame_drug_name], BKDRG.[pame_dosage], BKDRG.[pame_duration_amount],
						BKDRG.[pame_duration_unit], BKDRG.[pame_drug_comments], BKDRG.[pame_numb_refills], BKDRG.[pame_use_generic],
						BKDRG.[pame_days_supply], BKDRG.[pame_prn],BKDRG.[pame_prn_description], BKDRG.[pame_date_start],
						BKDRG.[pame_date_end], BKDRG.[pame_source_name], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by],
						BKDRG.[external_id]
				FROM	#TempActMedExt BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pame_id 
						FROM	dbo.patient_active_meds_external DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pame_id = DRG.pame_id AND DRG.pame_pa_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_active_meds_external OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_active_meds_external VIT WITH (NOLOCK)
					INNER JOIN #TempActMedExt BKDRG WITH (NOLOCK) ON BKDRG.pame_id = VIT.pame_id AND BKDRG.pame_pa_id = VIT.pame_pa_id
			WHERE	VIT.pame_pa_id = @secondary_id
					AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate
				
			SELECT	BKDRG.*
			INTO	#TempActMed
			FROM	bk.patient_active_meds BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	DRG  
			SET		DRG.pa_id = @secondary_id,
					DRG.last_modified_date = GETDATE(),
					DRG.last_modified_by = 1 
			FROM	patient_active_meds DRG WITH (NOLOCK)
					INNER JOIN #TempActMed BKDRG WITH (NOLOCK)ON BKDRG.pam_id = DRG.pam_id 
			--WHERE	BKDRG.pa_id = @secondary_id  --DRG.pa_id = @CurrentId AND 
			--		AND (BKDRG.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			WHERE	DRG.drug_id NOT IN (SELECT drug_id FROM patient_active_meds WHERE pa_id = @secondary_id)	
								
			IF EXISTS(SELECT  NULL
			FROM	#TempActMed BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.pam_id 
					FROM	dbo.patient_active_meds DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pam_id = DRG.pam_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_active_meds ON

				INSERT INTO dbo.patient_active_meds
				(
				pam_id,
				pa_id,drug_id,date_added,added_by_dr_id,from_pd_id,compound,comments,status,dt_status_change,change_dr_id,reason,drug_name,dosage,duration_amount,duration_unit,drug_comments,numb_refills,use_generic,days_supply,prn,prn_description,date_start,date_end,for_dr_id,source_type,record_source,active,last_modified_date,last_modified_by)
				SELECT  BKDRG.pam_id,
						BKDRG.pa_id, BKDRG.drug_id, BKDRG.date_added, BKDRG.added_by_dr_id, BKDRG.from_pd_id, BKDRG.compound, BKDRG.comments, BKDRG.status,
						BKDRG.dt_status_change, BKDRG.change_dr_id, BKDRG.reason,drug_name, BKDRG.dosage, BKDRG.duration_amount, BKDRG.duration_unit,
						BKDRG.drug_comments, BKDRG.numb_refills, BKDRG.use_generic, BKDRG.days_supply, BKDRG.prn, BKDRG.prn_description, BKDRG.date_start,
						BKDRG.date_end,BKDRG.for_dr_id,BKDRG.source_type,BKDRG.record_source,BKDRG.active,BKDRG.last_modified_date,BKDRG.last_modified_by
				FROM	#TempActMed BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.pam_id 
						FROM	dbo.patient_active_meds DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pam_id = DRG.pam_id AND DRG.pa_id = @secondary_id) 
						AND drug_id NOT IN(SELECT drug_id FROM dbo.patient_active_meds WHERE pa_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_active_meds OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_active_meds VIT WITH (NOLOCK)
					INNER JOIN #TempActMed BKDRG WITH (NOLOCK) ON BKDRG.pam_id = VIT.pam_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate
			
			SELECT	BKDRG.*
			INTO	#TempActDiagExt
			FROM	bk.patient_active_diagnosis_external BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pde_pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	DIG 
			SET		DIG.pde_pa_id =  @secondary_id,
					DIG.last_modified_date = GETDATE(),
					DIG.last_modified_by = 1 
			FROM	patient_active_diagnosis_external DIG WITH (NOLOCK)
					INNER JOIN #TempActDiagExt BKDIG WITH (NOLOCK) ON BKDIG.pde_id = DIG.pde_id 
			--WHERE	BKDIG.pde_pa_id = @secondary_id --DIG.pde_pa_id = @CurrentId AND 
			--		AND (BKDIG.pa_merge_reqid = @MergeRequestQueueId  OR @CheckBatchId = 0)
						
			IF EXISTS(SELECT NULL
			FROM	#TempActDiagExt BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pde_id 
					FROM	dbo.patient_active_diagnosis_external DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pde_id = DRG.pde_id AND DRG.pde_pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_active_diagnosis_external ON

				INSERT INTO [dbo].[patient_active_diagnosis_external]
				(
					pde_id, 
					[pde_pa_id],[pde_source_name],[pde_icd9],[pde_added_by_dr_id],[pde_date_added],[pde_icd9_description],[pde_enabled],[pde_onset],[pde_severity],[pde_status],[pde_type],[pde_record_modified_date],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.pde_id, 
						BKDRG.[pde_pa_id], BKDRG.[pde_source_name], BKDRG.[pde_icd9], BKDRG.[pde_added_by_dr_id], BKDRG.[pde_date_added],
						BKDRG.[pde_icd9_description], BKDRG.[pde_enabled], BKDRG.[pde_onset], BKDRG.[pde_severity], BKDRG.[pde_status],
						BKDRG.[pde_type], BKDRG.[pde_record_modified_date], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempActDiagExt BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pde_id 
						FROM	dbo.patient_active_diagnosis_external DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pde_id = DRG.pde_id AND DRG.pde_pa_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_active_diagnosis_external OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_active_diagnosis_external VIT WITH (NOLOCK)
					INNER JOIN #TempActDiagExt BKDRG WITH (NOLOCK) ON BKDRG.pde_id = VIT.pde_id AND BKDRG.pde_pa_id = VIT.pde_pa_id
			WHERE	VIT.pde_pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempActDiag
			FROM	bk.patient_active_diagnosis BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	DIG 
			SET		DIG.pa_id = @secondary_id,
					DIG.last_modified_date = GETDATE(),
					DIG.last_modified_by = 1 
			FROM	patient_active_diagnosis DIG WITH (NOLOCK)
					INNER JOIN #TempActDiag BKDIG WITH (NOLOCK) ON BKDIG.pad = DIG.pad 
			WHERE	DIG.icd9 NOT IN (SELECT icd9 FROM dbo.patient_active_diagnosis WHERE pa_id = @secondary_id)
			--WHERE	BKDIG.pa_id = @secondary_id --DIG.pa_id = @CurrentId AND 
			--		AND (BKDIG.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT NULL
			FROM	#TempActDiag BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pad 
					FROM	dbo.patient_active_diagnosis DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pad = DRG.pad AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_active_diagnosis ON

				INSERT INTO [dbo].[patient_active_diagnosis]
				(
					pad,
					[pa_id],[icd9],[added_by_dr_id],[date_added],[icd9_description],[enabled],[onset],[severity],[status],[type],[record_modified_date],[source_type],[record_source],[status_date],[code_type],[active],[last_modified_date],[last_modified_by],[icd9_desc],[icd10_desc],[icd10],[snomed_code],[snomed_desc],[diagnosis_sequence]
				)
				SELECT	BKDRG.pad,
						BKDRG.[pa_id], BKDRG.[icd9], BKDRG.[added_by_dr_id], BKDRG.[date_added], BKDRG.[icd9_description], BKDRG.[enabled],
						BKDRG.[onset], BKDRG.[severity], BKDRG.[status], BKDRG.[type], BKDRG.[record_modified_date], BKDRG.[source_type],
						BKDRG.[record_source], BKDRG.[status_date], BKDRG.[code_type], BKDRG.[active], BKDRG.[last_modified_date],
						BKDRG.[last_modified_by], BKDRG.[icd9_desc], BKDRG.[icd10_desc], BKDRG.[icd10], BKDRG.[snomed_code], 
						BKDRG.[snomed_desc], BKDRG.[diagnosis_sequence]
				FROM	#TempActDiag BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pad 
						FROM	dbo.patient_active_diagnosis DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pad = DRG.pad AND DRG.pa_id = @secondary_id)
						AND  icd9 NOT IN (SELECT icd9 FROM dbo.patient_active_diagnosis WHERE pa_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_active_diagnosis OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_active_diagnosis VIT WITH (NOLOCK)
					INNER JOIN #TempActDiag BKDRG WITH (NOLOCK) ON BKDRG.pad = VIT.pad AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate
			
			print 'patient_active_diagnosis end'
			
			SELECT	BKDRG.*
			INTO	#TempMUMe
			FROM	bk.MUMeasureCounts BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	MSR 
			SET		MSR.pa_id =  @secondary_id,
					MSR.last_modified_date = GETDATE(),
					MSR.last_modified_by = 1 
			FROM	MUMeasureCounts MSR WITH (NOLOCK)
					INNER JOIN #TempMUMe BKMSR WITH (NOLOCK) ON BKMSR.Id = MSR.Id 
			--WHERE	BKMSR.pa_id = @secondary_id --MSR.pa_id = @CurrentId AND
			--		AND (BKMSR.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT NULL
			FROM	#TempMUMe BKDRG WITH (NOLOCK) 
			WHERE	NOT EXISTS (Select DRG.Id 
					FROM	dbo.MUMeasureCounts DRG  WITH (NOLOCK) 
					WHERE	BKDRG.Id = DRG.Id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT MUMeasureCounts ON

				INSERT INTO [dbo].[MUMeasureCounts]
				(
					Id,
					[MUMeasuresId],[MeasureCode],[dc_id],[dg_id],[dr_id],[pa_id],[enc_id],[enc_date],[DateAdded],[IsNumerator],[IsDenominator],[RecordCreateUserId],[RecordCreateDateTime],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.Id,
						BKDRG.[MUMeasuresId], BKDRG.[MeasureCode], BKDRG.[dc_id], BKDRG.[dg_id], BKDRG.[dr_id], BKDRG.[pa_id], BKDRG.[enc_id],
						BKDRG.[enc_date], BKDRG.[DateAdded], BKDRG.[IsNumerator], BKDRG.[IsDenominator], BKDRG.[RecordCreateUserId],
						BKDRG.[RecordCreateDateTime], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempMUMe BKDRG WITH (NOLOCK) 
				WHERE	NOT EXISTS (Select DRG.Id 
						FROM	dbo.MUMeasureCounts DRG  WITH (NOLOCK) 
						WHERE	BKDRG.Id = DRG.Id AND DRG.pa_id = @secondary_id)
				
				SET IDENTITY_INSERT MUMeasureCounts OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.MUMeasureCounts VIT WITH (NOLOCK)
					INNER JOIN #TempMUMe BKDRG WITH (NOLOCK) ON BKDRG.Id = VIT.Id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempLabDet
			FROM	bk.lab_pat_details BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pat_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	LAB 
			SET		LAB.pat_id = @secondary_id,
					LAB.last_modified_date = GETDATE(),
					LAB.last_modified_by = 1
			FROM	lab_pat_details LAB WITH (NOLOCK)
					INNER JOIN #TempLabDet BKLAB WITH (NOLOCK) ON BKLAB.lab_id =  LAB.lab_id 
			--WHERE	BKLAB.pat_id = @secondary_id --LAB.pat_id = @CurrentId AND 
			--		AND (BKLAB.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempLabDet BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select BKDRG.lab_id 
					FROM	dbo.lab_pat_details DRG  WITH (NOLOCK) 
					WHERE	BKDRG.lab_id = DRG.lab_id AND DRG.pat_id = @secondary_id))
			BEGIN
				INSERT INTO [dbo].[lab_pat_details]
				(
					[lab_id],[pat_id],[ext_pat_id],[lab_pat_id],[alt_pat_id],[pa_first],[pa_last],[pa_middle],[pa_dob],[pa_sex],[pa_address1],[pa_city],[pa_state],[pa_zip],[pa_acctno],[spm_status],[fasting],[notes],[pa_suffix],[pa_race],[pa_alternate_race],[lab_patid_namespace_id],[lab_patid_type_code],[lab_pat_id_uid],[lab_pat_id_uid_type],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.[lab_id], BKDRG.[pat_id], BKDRG.[ext_pat_id], BKDRG.[lab_pat_id],BKDRG.[alt_pat_id], BKDRG.[pa_first],
						BKDRG.[pa_last], BKDRG.[pa_middle], BKDRG.[pa_dob], BKDRG.[pa_sex], BKDRG.[pa_address1], BKDRG.[pa_city],
						BKDRG.[pa_state], BKDRG.[pa_zip], BKDRG.[pa_acctno], BKDRG.[spm_status], BKDRG.[fasting], BKDRG.[notes],
						BKDRG.[pa_suffix], BKDRG.[pa_race], BKDRG.[pa_alternate_race], BKDRG.[lab_patid_namespace_id],
						BKDRG.[lab_patid_type_code], BKDRG.[lab_pat_id_uid], BKDRG.[lab_pat_id_uid_type],
						BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempLabDet BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select BKDRG.lab_id 
						FROM	dbo.lab_pat_details DRG  WITH (NOLOCK) 
						WHERE	BKDRG.lab_id = DRG.lab_id AND DRG.pat_id = @secondary_id)
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.lab_pat_details VIT WITH (NOLOCK)
					INNER JOIN #TempLabDet BKDRG WITH (NOLOCK) ON BKDRG.lab_id = VIT.lab_id AND BKDRG.pat_id = VIT.pat_id
			WHERE	VIT.pat_id = @secondary_id
					AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempPatMedHx
			FROM	bk.patient_medical_hx BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pat_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	MED 
			SET		MED.pat_id = @secondary_id,
					MED.last_modified_date = GETDATE(),
					MED.last_modified_by = 1
			FROM	patient_medical_hx MED WITH (NOLOCK)
					INNER JOIN #TempPatMedHx BKMED WITH (NOLOCK) ON BKMED.medhxid = MED.medhxid 
			--WHERE	BKMED.pat_id = @secondary_id --MED.pat_id = @CurrentId AND 
			--		AND (BKMED.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT NULL
			FROM	#TempPatMedHx BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.medhxid 
					FROM	dbo.patient_medical_hx DRG  WITH (NOLOCK) 
					WHERE	BKDRG.medhxid = DRG.medhxid AND DRG.pat_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_medical_hx ON

				INSERT INTO [dbo].[patient_medical_hx]
				(
					medhxid,
					[pat_id],[problem],[icd9],[dr_id],[added_by_dr_id],[created_on],[last_modified_on],[last_modified_by],[comments],[enable],[active],[last_modified_date],[icd9_description],[icd10],[icd10_description],[snomed],[snomed_description]
				)
				SELECT	BKDRG.medhxid,
						BKDRG.[pat_id], BKDRG.[problem], BKDRG.[icd9], BKDRG.[dr_id], BKDRG.[added_by_dr_id], BKDRG.[created_on],
						BKDRG.[last_modified_on], BKDRG.[last_modified_by], BKDRG.[comments], BKDRG.[enable], BKDRG.[active],
						BKDRG.[last_modified_date], BKDRG.[icd9_description], BKDRG.[icd10], BKDRG.[icd10_description],
						BKDRG.[snomed], BKDRG.[snomed_description]
				FROM	#TempPatMedHx BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.medhxid 
						FROM	dbo.patient_medical_hx DRG  WITH (NOLOCK) 
						WHERE	BKDRG.medhxid = DRG.medhxid AND DRG.pat_id = @secondary_id)
				
				SET IDENTITY_INSERT patient_medical_hx OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_medical_hx VIT WITH (NOLOCK)
					INNER JOIN #TempPatMedHx BKDRG WITH (NOLOCK) ON BKDRG.medhxid = VIT.medhxid AND BKDRG.pat_id = VIT.pat_id
			WHERE	VIT.pat_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempPatMsr
			FROM	bk.patient_measure_compliance BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	MSR 
			SET		MSR.pa_id = @secondary_id,
					MSR.last_modified_date = GETDATE(),
					MSR.last_modified_by = 1 
			FROM	patient_measure_compliance MSR WITH (NOLOCK)
					INNER JOIN #TempPatMsr BKMSR WITH (NOLOCK) ON BKMSR.rec_id = MSR.rec_id 
			--WHERE	BKMSR.pa_id = @secondary_id --MSR.pa_id = @CurrentId AND 
			--		AND (BKMSR.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempPatMsr BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.rec_id 
					FROM	dbo.patient_measure_compliance DRG  WITH (NOLOCK) 
					WHERE	BKDRG.rec_id = DRG.rec_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_measure_compliance ON

				INSERT INTO [dbo].[patient_measure_compliance]
				(
					rec_id,
					[pa_id],[dr_id],[src_dr_id],[rec_type],[rec_date],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.rec_id,
						BKDRG.[pa_id], BKDRG.[dr_id], BKDRG.[src_dr_id], BKDRG.[rec_type], BKDRG.[rec_date], BKDRG.[active], 
						BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempPatMsr BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.rec_id 
						FROM	dbo.patient_measure_compliance DRG  WITH (NOLOCK) 
						WHERE	BKDRG.rec_id = DRG.rec_id AND DRG.pa_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_measure_compliance OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_measure_compliance VIT WITH (NOLOCK)
					INNER JOIN #TempPatMsr BKDRG WITH (NOLOCK) ON BKDRG.rec_id = VIT.rec_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId ) 
					AND VIT.Created_Date > @CreatedDate
			
			SELECT	BKDRG.*
			INTO	#TempLabOrderMst
			FROM	bk.patient_lab_orders_master BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND ( @CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate
			
			UPDATE	LAB 
			SET		LAB.pa_id = @secondary_id,
					LAB.last_modified_date = GETDATE(),
					LAB.last_modified_by = 1 
			FROM	patient_lab_orders_master LAB WITH (NOLOCK)
					INNER JOIN #TempLabOrderMst BKLAB WITH (NOLOCK) ON BKLAB.lab_master_id = LAB.lab_master_id 
			--WHERE	BKLAB.pa_id = @secondary_id --LAB.pa_id = @CurrentId AND 
			--		AND (BKLAB.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT NULL
			FROM	#TempLabOrderMst BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.lab_master_id 
					FROM	dbo.patient_lab_orders_master DRG  WITH (NOLOCK) 
					WHERE	BKDRG.lab_master_id = DRG.lab_master_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_lab_orders_master ON

				INSERT INTO [dbo].[patient_lab_orders_master]
				(
					lab_master_id,
					[pa_id],[added_date],[added_by],[order_date],[order_status],[comments],[last_edit_by],[last_edit_date],[dr_id],[isActive],[external_lab_order_id],[doc_group_lab_xref_id],[abn_file_path],[requisition_file_path],[label_file_path],[lab_id],[order_sent_date],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.lab_master_id,
						BKDRG.[pa_id], BKDRG.[added_date], BKDRG.[added_by], BKDRG.[order_date], BKDRG.[order_status], BKDRG.[comments],
						BKDRG.[last_edit_by], BKDRG.[last_edit_date], BKDRG.[dr_id], BKDRG.[isActive], BKDRG.[external_lab_order_id],
						BKDRG.[doc_group_lab_xref_id], BKDRG.[abn_file_path], BKDRG.[requisition_file_path], BKDRG.[label_file_path],
						BKDRG.[lab_id], BKDRG.[order_sent_date], BKDRG.[active], BKDRG.[last_modified_date], BKDRG.[last_modified_by]
				FROM	#TempLabOrderMst BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.lab_master_id 
						FROM	dbo.patient_lab_orders_master DRG  WITH (NOLOCK) 
						WHERE	BKDRG.lab_master_id = DRG.lab_master_id AND DRG.pa_id = @secondary_id)

				SET IDENTITY_INSERT patient_lab_orders_master OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_lab_orders_master VIT WITH (NOLOCK)
					INNER JOIN #TempLabOrderMst BKDRG WITH (NOLOCK) ON BKDRG.lab_master_id = VIT.lab_master_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate
			
			SELECT	BKDRG.*
			INTO	#TempCustomMsg
			FROM	bk.dr_custom_messages BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.patid = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	MSG 
			SET		MSG.patid = @secondary_id,
					MSG.last_modified_date = GETDATE(),
					MSG.last_modified_by = 1 
			FROM	dr_custom_messages MSG WITH (NOLOCK)
					INNER JOIN #TempCustomMsg BKMSG WITH (NOLOCK) ON BKMSG.dr_cst_msg_id = MSG.dr_cst_msg_id 
			--WHERE	BKMSG.patid = @secondary_id --MSG.patid = @CurrentId AND 
			--		AND (BKMSG.pa_merge_reqid = @MergeRequestQueueId   OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT NULL
			FROM	#TempCustomMsg BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.dr_cst_msg_id 
					FROM	dbo.dr_custom_messages DRG  WITH (NOLOCK) 
					WHERE	BKDRG.dr_cst_msg_id = DRG.dr_cst_msg_id AND DRG.patid = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT dr_custom_messages ON

				INSERT INTO [dbo].[dr_custom_messages]
				(
					dr_cst_msg_id,
					[dr_src_id],[dr_dst_id],[msg_date],[message],[is_read],[is_complete],[patid],[message_typeid],[message_subtypeid],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.dr_cst_msg_id,
						BKDRG.[dr_src_id], BKDRG.[dr_dst_id], BKDRG.[msg_date], BKDRG.[message], BKDRG.[is_read], BKDRG.[is_complete],
						BKDRG.[patid],BKDRG.[message_typeid],BKDRG.[message_subtypeid],BKDRG.[active],BKDRG.[last_modified_date],BKDRG.[last_modified_by]
				FROM	#TempCustomMsg BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.dr_cst_msg_id 
						FROM	dbo.dr_custom_messages DRG  WITH (NOLOCK) 
						WHERE	BKDRG.dr_cst_msg_id = DRG.dr_cst_msg_id AND DRG.patid = @secondary_id)
						
				SET IDENTITY_INSERT dr_custom_messages OFF
			END
			
			print 'dr_custom_messages'
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.dr_custom_messages VIT WITH (NOLOCK)
					INNER JOIN #TempCustomMsg BKDRG WITH (NOLOCK) ON BKDRG.dr_cst_msg_id = VIT.dr_cst_msg_id AND BKDRG.patid = VIT.patid
			WHERE	VIT.patid = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId )
					AND VIT.Created_Date > @CreatedDate
				
			Update  FAV
			SET		FAV.pa_id = @secondary_id
			FROM	dbo.patients_fav_pharms FAV WITH (NOLOCK)
					INNER JOIN bk.patients_fav_pharms BKFAV WITH (NOLOCK)  ON BKFAV.pharm_id = FAV.pharm_id AND BKFAV.pa_id = -1 * FAV.pa_id
			WHERE	BKFAV.pa_id = @secondary_id AND FAV.pa_id = -1 * @secondary_id
					AND (@CheckBatchId = 0 OR BKFAV.pa_merge_reqid = @MergeRequestQueueId)
					AND BKFAV.Created_Date > @CreatedDate
					AND NOT EXISTS(SELECT FAV.pharm_id FROM dbo.patients_fav_pharms FAV 
					WHERE FAV.pa_id = @secondary_id 
					AND FAV.pharm_id = BKFAV.pharm_id)
			
			Update  FAV
			SET		FAV.pa_id = @secondary_id
			FROM	dbo.patients_fav_pharms FAV WITH (NOLOCK)
					INNER JOIN bk.patients_fav_pharms BKFAV WITH (NOLOCK)  ON BKFAV.pharm_id = FAV.pharm_id 
			WHERE	BKFAV.pa_id = @secondary_id AND FAV.pa_id = @primary_id
					AND (@CheckBatchId = 0 OR BKFAV.pa_merge_reqid = @MergeRequestQueueId)
					AND BKFAV.Created_Date > @CreatedDate
					AND NOT EXISTS(SELECT FAV.pharm_id FROM dbo.patients_fav_pharms FAV 
					WHERE FAV.pa_id = @secondary_id 
					AND FAV.pharm_id = BKFAV.pharm_id)

			--INSERT	INTO patients_fav_pharms
			--(pa_id, pharm_id, pharm_use_date)
			--SELECT  Distinct BKFAV.pa_id, BKFAV.pharm_id, BKFAV.pharm_use_date
			--FROM	bk.patients_fav_pharms BKFAV WITH (NOLOCK) 
			--WHERE	BKFAV.pa_id = @secondary_id
			--		AND (@CheckBatchId = 0 OR BKFAV.pa_merge_reqid = @MergeRequestQueueId )
			--		AND BKFAV.Created_Date > @CreatedDate
			--		AND NOT EXISTS(SELECT FAV.pharm_id FROM dbo.patients_fav_pharms FAV 
			--		WHERE FAV.pa_id = @secondary_id 
			--		AND FAV.pharm_id = BKFAV.pharm_id)
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patients_fav_pharms VIT WITH (NOLOCK)
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId ) 
					AND VIT.Created_Date > @CreatedDate
							
			SELECT	BKDRG.*
			INTO	#TempPresc
			FROM	bk.prescriptions BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	PRES 
			SET		PRES.pa_id = @secondary_id 
			FROM	prescriptions PRES WITH (NOLOCK)
					INNER JOIN #TempPresc BKPRES WITH (NOLOCK) on BKPRES.pres_id = PRES.pres_id 
			--WHERE	BKPRES.pa_id = @secondary_id --PRES.pa_id = @CurrentId AND 
			--		AND (BKPRES.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempPresc BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pres_id 
					FROM	dbo.prescriptions DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pres_id = DRG.pres_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT prescriptions ON

				INSERT INTO [dbo].[prescriptions]
				(
					pres_id,
					[dr_id],[dg_id],[pharm_id],[pa_id],[pres_entry_date],[pres_read_date],[only_faxed],[pharm_viewed],[off_dr_list],[opener_user_id],[pres_is_refill],[rx_number],[last_pharm_name],[last_pharm_address],[last_pharm_city],[last_pharm_state],[last_pharm_phone],[pharm_state_holder],[pharm_city_holder],[pharm_id_holder],[fax_conf_send_date],[fax_conf_numb_pages],[fax_conf_remote_fax_id],[fax_conf_error_string],[pres_delivery_method],[prim_dr_id],[print_count],[pda_written],[authorizing_dr_id],[sfi_is_sfi],[sfi_pres_id],[field_not_used1],[admin_notes],[pres_approved_date],[pres_void],[last_edit_date],[last_edit_dr_id],[pres_prescription_type],[pres_void_comments],[eligibility_checked],[eligibility_trans_id],[off_pharm_list],[DoPrintAfterPatHistory],[DoPrintAfterPatOrig],[DoPrintAfterPatCopy],[DoPrintAfterPatMonograph],[PatOrigPrintType],[PrintHistoryBackMonths],[DoPrintAfterScriptGuide],[approve_source],[pres_void_code],[send_count],[print_options],[writing_dr_id],[presc_src],[pres_start_date],[pres_end_date],[is_signed]
				)
				SELECT	BKDRG.pres_id,
						BKDRG.[dr_id], BKDRG.[dg_id], BKDRG.[pharm_id], BKDRG.[pa_id], BKDRG.[pres_entry_date], BKDRG.[pres_read_date],
						BKDRG.[only_faxed],BKDRG.[pharm_viewed],BKDRG.[off_dr_list],BKDRG.[opener_user_id],BKDRG.[pres_is_refill],
						BKDRG.[rx_number],BKDRG.[last_pharm_name],BKDRG.[last_pharm_address],BKDRG.[last_pharm_city],BKDRG.[last_pharm_state],
						BKDRG.[last_pharm_phone],BKDRG.[pharm_state_holder],BKDRG.[pharm_city_holder],BKDRG.[pharm_id_holder],
						BKDRG.[fax_conf_send_date],BKDRG.[fax_conf_numb_pages],BKDRG.[fax_conf_remote_fax_id],BKDRG.[fax_conf_error_string],
						BKDRG.[pres_delivery_method],BKDRG.[prim_dr_id],BKDRG.[print_count],BKDRG.[pda_written],BKDRG.[authorizing_dr_id],
						BKDRG.[sfi_is_sfi],BKDRG.[sfi_pres_id],BKDRG.[field_not_used1],BKDRG.[admin_notes],BKDRG.[pres_approved_date],
						BKDRG.[pres_void],BKDRG.[last_edit_date],BKDRG.[last_edit_dr_id],BKDRG.[pres_prescription_type],BKDRG.[pres_void_comments],
						BKDRG.[eligibility_checked],BKDRG.[eligibility_trans_id],BKDRG.[off_pharm_list],BKDRG.[DoPrintAfterPatHistory],
						BKDRG.[DoPrintAfterPatOrig],BKDRG.[DoPrintAfterPatCopy],BKDRG.[DoPrintAfterPatMonograph],BKDRG.[PatOrigPrintType],
						BKDRG.[PrintHistoryBackMonths],BKDRG.[DoPrintAfterScriptGuide],BKDRG.[approve_source],BKDRG.[pres_void_code],
						BKDRG.[send_count],BKDRG.[print_options],BKDRG.[writing_dr_id],BKDRG.[presc_src],BKDRG.[pres_start_date],
						BKDRG.[pres_end_date],BKDRG.[is_signed]
				FROM	#TempPresc BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pres_id 
						FROM	dbo.prescriptions DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pres_id = DRG.pres_id AND DRG.pa_id = @secondary_id)
					
				SET IDENTITY_INSERT prescriptions OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.prescriptions VIT WITH (NOLOCK)
					INNER JOIN #TempPresc BKDRG WITH (NOLOCK) ON BKDRG.pres_id = VIT.pres_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND ( @CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId) 
					AND VIT.Created_Date > @CreatedDate
			
			print 'prescriptions'
				
			SELECT	BKDRG.*
			INTO	#TempMedHx
			FROM	bk.patient_medications_hx BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	MED 
			SET		MED.pa_id = @secondary_id,
					MED.last_modified_date = GETDATE(),
					MED.last_modified_by = 1 
			FROM	patient_medications_hx MED WITH (NOLOCK)
					INNER JOIN #TempMedHx BKMED WITH (NOLOCK) ON BKMED.pam_id = med.pam_id 
			--WHERE	 BKMED.pa_id = @secondary_id  --MED.pa_id = @CurrentId AND 
			--		AND (BKMED.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS(SELECT	NULL
			FROM	#TempMedHx BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pam_id 
					FROM	dbo.patient_medications_hx DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pam_id = DRG.pam_id AND DRG.pa_id = @secondary_id))
			BEGIn
			
				SET IDENTITY_INSERT patient_medications_hx ON

				INSERT INTO [dbo].[patient_medications_hx]
				(
					pam_id,
					[pa_id],[drug_id],[date_added],[added_by_dr_id],[from_pd_id],[compound],[comments],[status],[dt_status_change],[change_dr_id],[reason],[drug_name],[dosage],[duration_amount],[duration_unit],[drug_comments],[numb_refills],[use_generic],[days_supply],[prn],[prn_description],[date_start],[date_end],[for_dr_id],[source_type],[record_source],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.pam_id,
						BKDRG.[pa_id], BKDRG.[drug_id], BKDRG.[date_added], BKDRG.[added_by_dr_id], BKDRG.[from_pd_id],
						BKDRG.[compound],BKDRG.[comments],BKDRG.[status],BKDRG.[dt_status_change],BKDRG.[change_dr_id],BKDRG.[reason],
						BKDRG.[drug_name],BKDRG.[dosage],BKDRG.[duration_amount],BKDRG.[duration_unit],BKDRG.[drug_comments],
						BKDRG.[numb_refills],BKDRG.[use_generic],BKDRG.[days_supply],BKDRG.[prn],BKDRG.[prn_description],BKDRG.[date_start],
						BKDRG.[date_end],BKDRG.[for_dr_id],BKDRG.[source_type],BKDRG.[record_source],BKDRG.[active],BKDRG.[last_modified_date],
						BKDRG.[last_modified_by]
				FROM	#TempMedHx BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pam_id 
						FROM	dbo.patient_medications_hx DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pam_id = DRG.pam_id AND DRG.pa_id = @secondary_id)
					
				SET IDENTITY_INSERT patient_medications_hx OFF
			END
			print 'patient_medications_hx completed'
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_medications_hx VIT WITH (NOLOCK)
					INNER JOIN #TempMedHx BKDRG WITH (NOLOCK) ON BKDRG.pam_id = VIT.pam_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId )
					AND VIT.Created_Date > @CreatedDate
			
			print 'patient_medications_hx'
		
			SELECT	BKDRG.*
			INTO	#TempNote
			FROM	bk.patient_notes BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	NTE 
			SET		NTE.pa_id = @secondary_id,
					NTE.last_modified_date = GETDATE(),
					NTE.last_modified_by = 1 
			FROM	patient_notes NTE WITH (NOLOCK)
					INNER JOIN #TempNote BKNTE WITH (NOLOCK) ON BKNTE.note_id = NTE.note_id 
			--WHERE	 BKNTE.pa_id = @secondary_id --NTE.pa_id = @CurrentId AND
			--		AND (BKNTE.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			
			IF EXISTS(
			SELECT	NULL
			FROM	#TempNote BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.note_id 
					FROM	dbo.patient_notes DRG  WITH (NOLOCK) 
					WHERE	BKDRG.note_id = DRG.note_id AND DRG.pa_id = @secondary_id)
			)
			BEGIN
				SET IDENTITY_INSERT patient_notes ON
				
				INSERT INTO [dbo].[patient_notes]
				(
					note_id,
					[pa_id],[note_date],[dr_id],[void],[note_text],[partner_id],[active],[last_modified_date],[last_modified_by],[note_html]
				)
				SELECT	BKDRG.note_id,
						BKDRG.[pa_id], BKDRG.[note_date], BKDRG.[dr_id], BKDRG.[void], BKDRG.[note_text], BKDRG.[partner_id], BKDRG.[active],
						BKDRG.[last_modified_date],BKDRG.[last_modified_by], BKDRG.[note_html]
				FROM	#TempNote BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.note_id 
						FROM	dbo.patient_notes DRG  WITH (NOLOCK) 
						WHERE	BKDRG.note_id = DRG.note_id AND DRG.pa_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_notes OFF
			END

			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_notes VIT WITH (NOLOCK)
					INNER JOIN #TempNote BKDRG WITH (NOLOCK) ON BKDRG.note_id = VIT.note_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate

			print 'patient_notes'
		
			SELECT	BKDRG.*
			INTO	#TempPatientLabOrder
			FROM	bk.patient_lab_orders BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	LAB 
			SET		LAB.pa_id = @secondary_id,
					LAB.last_modified_date = GETDATE(),
					LAB.last_modified_by = 1 
			FROM	patient_lab_orders LAB WITH (NOLOCK)
					INNER JOIN #TempPatientLabOrder BKLAB WITH (NOLOCK) ON BKlab.pa_lab_id = LAB.pa_lab_id 
			--WHERE	BKLAB.pa_id = @secondary_id --LAB.pa_id = @CurrentId AND 
			--		AND (BKLAB.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT NULL
			FROM	#TempPatientLabOrder BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.pa_lab_id 
					FROM	dbo.patient_lab_orders DRG  WITH (NOLOCK) 
					WHERE	BKDRG.pa_lab_id = DRG.pa_lab_id AND DRG.pa_id = @secondary_id))
			BEGIN
				
				SET IDENTITY_INSERT patient_lab_orders ON
		
				INSERT INTO [dbo].[patient_lab_orders]
				(
					pa_lab_id,
					[pa_id],[lab_test_id],[lab_test_name],[added_date],[added_by],[order_date],[order_status],[comments],[last_edit_by],[last_edit_date],[from_main_lab_id],[recurringinformation],[diagnosis],[urgency],[dr_id],[isActive],[sendElectronically],[external_lab_order_id],[doc_group_lab_xref_id],[abn_file_path],[requisition_file_path],[label_file_path],[enc_id],[lab_master_id],[lab_id],[lab_result_info_id],[specimen_time],[test_type],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.pa_lab_id,
						BKDRG.[pa_id], BKDRG.[lab_test_id], BKDRG.[lab_test_name],BKDRG.[added_date],BKDRG.[added_by],BKDRG.[order_date],
						BKDRG.[order_status],BKDRG.[comments],BKDRG.[last_edit_by],BKDRG.[last_edit_date],BKDRG.[from_main_lab_id],
						BKDRG.[recurringinformation],BKDRG.[diagnosis],BKDRG.[urgency],BKDRG.[dr_id],BKDRG.[isActive],BKDRG.[sendElectronically],
						BKDRG.[external_lab_order_id],BKDRG.[doc_group_lab_xref_id],BKDRG.[abn_file_path],BKDRG.[requisition_file_path],BKDRG.[label_file_path],
						BKDRG.[enc_id],BKDRG.[lab_master_id],BKDRG.[lab_id],BKDRG.[lab_result_info_id],BKDRG.[specimen_time],
						BKDRG.[test_type],BKDRG.[active],BKDRG.[last_modified_date],BKDRG.[last_modified_by]
				FROM	#TempPatientLabOrder BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.pa_lab_id 
						FROM	dbo.patient_lab_orders DRG  WITH (NOLOCK) 
						WHERE	BKDRG.pa_lab_id = DRG.pa_lab_id AND DRG.pa_id = @secondary_id)
					
				SET IDENTITY_INSERT patient_lab_orders OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_lab_orders VIT WITH (NOLOCK)
					INNER JOIN #TempPatientLabOrder BKDRG WITH (NOLOCK) ON BKDRG.pa_lab_id = VIT.pa_lab_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate

				print 'patient_lab_orders end'
				
				
			SELECT	BKDRG.*
			INTO	#TempLabMain
			FROM	bk.lab_main BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pat_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	LAB 
			SET		LAB.pat_id = @secondary_id,
					LAB.last_modified_date = GETDATE(),
					LAB.last_modified_by = 1
			FROM	lab_main LAB WITH (NOLOCK)
					INNER JOIN #TempLabMain BKLAB WITH (NOLOCK) ON  BKLAB.lab_id = LAB.lab_id 
			--WHERE	BKLAB.pat_id = @secondary_id --LAB.pat_id = @CurrentId AND  
			--		AND (BKLAB.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT	NULL
			FROM	#TempLabMain BKDRG WITH (nolock)
			WHERE	NOT EXISTS (Select DRG.lab_id 
					FROM	dbo.lab_main DRG  WITH (NOLOCK) 
					WHERE	BKDRG.lab_id = DRG.lab_id AND DRG.pat_id = @secondary_id))
			BEGIN
					
				SET IDENTITY_INSERT lab_main ON

				INSERT INTO [dbo].[lab_main]
				(	
					lab_id,
					[send_appl],[send_facility],[rcv_appl],[rcv_facility],[message_date],[message_type],[message_ctrl_id],[version],[component_sep],[subcomponent_sep],[escape_delim],[filename],[dr_id],[pat_id],[dg_id],[is_read],[read_by],[PROV_NAME],[comments],[result_file_path],[type],[lab_order_master_id],[active],[last_modified_date],[last_modified_by]
				)
				SELECT	BKDRG.lab_id,
						BKDRG.[send_appl],BKDRG.[send_facility],BKDRG.[rcv_appl],BKDRG.[rcv_facility],BKDRG.[message_date],
						BKDRG.[message_type],BKDRG.[message_ctrl_id],BKDRG.[version],BKDRG.[component_sep],BKDRG.[subcomponent_sep],
						BKDRG.[escape_delim],BKDRG.[filename],BKDRG.[dr_id],BKDRG.[pat_id],BKDRG.[dg_id],BKDRG.[is_read],BKDRG.[read_by],
						BKDRG.[PROV_NAME],BKDRG.[comments],BKDRG.[result_file_path],BKDRG.[type],BKDRG.[lab_order_master_id],BKDRG.[active],
						BKDRG.[last_modified_date],BKDRG.[last_modified_by]
				FROM	#TempLabMain BKDRG WITH (nolock)
				WHERE	NOT EXISTS (Select DRG.lab_id 
						FROM	dbo.lab_main DRG  WITH (NOLOCK) 
						WHERE	BKDRG.lab_id = DRG.lab_id AND DRG.pat_id = @secondary_id)	
				
				SET IDENTITY_INSERT lab_main OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.lab_main VIT WITH (NOLOCK)
					INNER JOIN #TempLabMain BKDRG WITH (NOLOCK) ON BKDRG.lab_id = VIT.lab_id AND BKDRG.pat_id = VIT.pat_id
			WHERE	VIT.pat_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId ) 
					AND VIT.Created_Date > @CreatedDate
			
			print 'lab_main'
			
			SELECT	BKDRG.*
			INTO	#TempReferralMain
			FROM	bk.referral_main BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	REF 
			SET		REF.pa_id = @secondary_id,
					REF.last_modified_date = GETDATE(),
					REF.last_modified_by = 1 
			FROM	referral_main REF WITH (NOLOCK)
					INNER JOIN #TempReferralMain BKREF WITH (NOLOCK) ON BKref.ref_id = REF.ref_id 
			--WHERE	 BKref.pa_id = @secondary_id --REF.pa_id = @CurrentId AND 
			--		AND (BKref.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
				
			IF EXISTS (SELECT NULL
			FROM	#TempReferralMain BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.ref_id 
					FROM	dbo.referral_main DRG  WITH (NOLOCK) 
					WHERE	BKDRG.ref_id = DRG.ref_id AND DRG.pa_id = @secondary_id))
			BEGIN
			
				SET IDENTITY_INSERT referral_main ON

				INSERT INTO [dbo].[referral_main]
				(
					ref_id,
					[main_dr_id],[target_dr_id],[pa_id],[ref_det_xref_id],[ref_start_date],[ref_end_date],[carrier_xref_id],[pa_member_no],[ref_det_ident],[main_prv_id1],[main_prv_id2],[target_prv_id1],[target_prv_id2],[inst_id],[active],[last_modified_date],[last_modified_by],[old_target_dr_id]
				)
				SELECT	BKDRG.ref_id,
						BKDRG.[main_dr_id], BKDRG.[target_dr_id], BKDRG.[pa_id], BKDRG.[ref_det_xref_id], BKDRG.[ref_start_date],
						BKDRG.[ref_end_date],BKDRG.[carrier_xref_id],BKDRG.[pa_member_no],BKDRG.[ref_det_ident],BKDRG.[main_prv_id1],
						BKDRG.[main_prv_id2],BKDRG.[target_prv_id1],BKDRG.[target_prv_id2],BKDRG.[inst_id],BKDRG.[active],
						BKDRG.[last_modified_date],BKDRG.[last_modified_by],BKDRG.[old_target_dr_id]
				FROM	#TempReferralMain BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.ref_id 
						FROM	dbo.referral_main DRG  WITH (NOLOCK) 
						WHERE	BKDRG.ref_id = DRG.ref_id AND DRG.pa_id = @secondary_id)	
					
				SET IDENTITY_INSERT referral_main OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.referral_main VIT WITH (NOLOCK)
					INNER JOIN #TempReferralMain BKDRG WITH (NOLOCK) ON BKDRG.ref_id = VIT.ref_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id aND ( @CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate
			
			print 'referral_main end'	
	
			SELECT	BKDRG.*
			INTO	#TempRefillRequest
			FROM	bk.refill_requests BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate
						
			UPDATE  REF
			SET		REF.pa_id = @secondary_id 
			FROM	refill_requests REF WITH (NOLOCK)
					INNER JOIN #TempRefillRequest BKREF WITH (NOLOCK) ON BKREF.refreq_id = REF.refreq_id 
			--WHERE	BKREF.pa_id = @secondary_id --REF.pa_id = @CurrentId AND 
			--		AND (BKref.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
				
			IF EXISTS (SELECT NULL
			FROM	#TempRefillRequest BKDRG WITH (NOLOCK)	
			WHERE	NOT EXISTS (Select DRG.refreq_id 
			FROM	dbo.refill_requests DRG  WITH (NOLOCK) 
			WHERE	BKDRG.refreq_id = DRG.refreq_id AND DRG.pa_id = @secondary_id)	)
			BEGIN
				SET IDENTITY_INSERT refill_requests ON
				
				INSERT INTO [dbo].[refill_requests]
				(
					refreq_id,
					[dg_id],[dr_id],[pa_id],[pharm_id],[pharm_ncpdp],[refreq_date],[trc_number],[ctrl_number],[recverVector],[senderVector],[pres_id],[response_type],[init_date],[msg_date],[response_id],[status_code],[status_code_qualifier],[status_msg],[response_conf_date],[error_string],[pres_fill_time],[msg_ref_number],[drug_name],[drug_ndc],[drug_form],[drug_strength],[drug_strength_units],[qty1],[qty1_units],[qty1_enum],[qty2],[qty2_units],[qty2_enum],[dosage1],[dosage2],[days_supply],[date1],[date1_enum],[date2],[date2_enum],[date3],[date3_enum],[substitution_code],[refills],[refills_enum],[void_comments],[void_code],[comments1],[comments2],[comments3],[disp_drug_info],[supervisor],[SupervisorSeg],[PharmSeg],[PatientSeg],[DoctorSeg],[DispDRUSeg],[PrescDRUSeg],[drug_strength_code],[drug_strength_source_code],[drug_form_code],[drug_form_source_code],[qty1_units_potency_code],[qty2_units_potency_code],[doc_info_text],[fullRequestMessage],[versionType],[has_miss_match],[miss_match_reson]
				)
				SELECT	BKDRG.refreq_id,
						BKDRG.[dg_id],BKDRG.[dr_id],BKDRG.[pa_id],BKDRG.[pharm_id],BKDRG.[pharm_ncpdp],BKDRG.[refreq_date],BKDRG.[trc_number],BKDRG.[ctrl_number],BKDRG.[recverVector],BKDRG.[senderVector],BKDRG.[pres_id],BKDRG.[response_type],BKDRG.[init_date],BKDRG.[msg_date],BKDRG.[response_id],BKDRG.[status_code],BKDRG.[status_code_qualifier],BKDRG.[status_msg],BKDRG.[response_conf_date],BKDRG.[error_string],BKDRG.[pres_fill_time],BKDRG.[msg_ref_number],BKDRG.[drug_name],BKDRG.[drug_ndc],BKDRG.[drug_form],BKDRG.[drug_strength],BKDRG.[drug_strength_units],BKDRG.[qty1],BKDRG.[qty1_units],BKDRG.[qty1_enum],BKDRG.[qty2],BKDRG.[qty2_units],BKDRG.[qty2_enum],BKDRG.[dosage1],BKDRG.[dosage2],BKDRG.[days_supply],BKDRG.[date1],BKDRG.[date1_enum],BKDRG.[date2],BKDRG.[date2_enum],BKDRG.[date3],BKDRG.[date3_enum],BKDRG.[substitution_code],BKDRG.[refills],BKDRG.[refills_enum],BKDRG.[void_comments],BKDRG.[void_code],BKDRG.[comments1],BKDRG.[comments2],BKDRG.[comments3],BKDRG.[disp_drug_info],BKDRG.[supervisor],BKDRG.[SupervisorSeg],BKDRG.[PharmSeg],BKDRG.[PatientSeg],BKDRG.[DoctorSeg],BKDRG.[DispDRUSeg],BKDRG.[PrescDRUSeg],BKDRG.[drug_strength_code],BKDRG.[drug_strength_source_code],BKDRG.[drug_form_code],BKDRG.[drug_form_source_code],BKDRG.[qty1_units_potency_code],BKDRG.[qty2_units_potency_code],BKDRG.[doc_info_text],BKDRG.[fullRequestMessage],BKDRG.[versionType],BKDRG.[has_miss_match],BKDRG.[miss_match_reson]
				FROM	#TempRefillRequest BKDRG WITH (NOLOCK)	
				WHERE	NOT EXISTS (Select DRG.refreq_id 
				FROM	dbo.refill_requests DRG  WITH (NOLOCK) 
				WHERE	BKDRG.refreq_id = DRG.refreq_id AND DRG.pa_id = @secondary_id)			
					
				SET IDENTITY_INSERT refill_requests OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.refill_requests VIT WITH (NOLOCK)
					INNER JOIN #TempRefillRequest BKDRG WITH (NOLOCK) ON BKDRG.refreq_id = VIT.refreq_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId  ) 
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempPatientVisit
			FROM	bk.patient_visit BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.pa_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId  )
					AND BKDRG.Created_Date > @CreatedDate

			UPDATE	PAT 
			SET		PAT.pa_id = @secondary_id,
					PAT.last_modified_date = GETDATE(),
					PAT.last_modified_by = 1 
			FROM	patient_visit PAT WITH (NOLOCK)
					INNER JOIN #TempPatientVisit BKPAT WITH (NOLOCK) on BKPAT.visit_id = PAT.visit_id 
			--WHERE	BKPAT.pa_id = @secondary_id --PAT.pa_id = @CurrentId AND 
			--		AND (BKPAT.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			
			IF EXISTS (SELECT	NULL
			FROM	#TempPatientVisit BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.visit_id 
					FROM	dbo.patient_visit DRG  WITH (NOLOCK) 
					WHERE	BKDRG.visit_id = DRG.visit_id AND DRG.pa_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT patient_visit ON 	
				
				INSERT INTO [dbo].[patient_visit]
				(
					visit_id,
					[appt_id],[pa_id],[dr_id],[dtCreate],[dtEnd],[enc_id],[chkout_notes],[vital_id],[reason],[active],[last_modified_date],[last_modified_by],[clinical_notes]
				)
				SELECT	BKDRG.visit_id,
						BKDRG.[appt_id],BKDRG.[pa_id],BKDRG.[dr_id],BKDRG.[dtCreate],BKDRG.[dtEnd],BKDRG.[enc_id],BKDRG.[chkout_notes],
						BKDRG.[vital_id],BKDRG.[reason],BKDRG.[active],BKDRG.[last_modified_date],BKDRG.[last_modified_by],BKDRG.[clinical_notes]
				FROM	#TempPatientVisit BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.visit_id 
						FROM	dbo.patient_visit DRG  WITH (NOLOCK) 
						WHERE	BKDRG.visit_id = DRG.visit_id AND DRG.pa_id = @secondary_id)
						
				SET IDENTITY_INSERT patient_visit OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.patient_visit VIT WITH (NOLOCK)
					INNER JOIN #TempPatientVisit BKDRG WITH (NOLOCK) ON BKDRG.visit_id = VIT.visit_id AND BKDRG.pa_id = VIT.pa_id
			WHERE	VIT.pa_id = @secondary_id AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId ) 
					AND VIT.Created_Date > @CreatedDate
				
			SELECT	BKDRG.*
			INTO	#TempEnc
			FROM	bk.enchanced_encounter BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.patient_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId )
					AND BKDRG.Created_Date > @CreatedDate
									
			--Update enchanced_encounter Starts 
			DECLARE @tempTable TABLE
			(
				[index] INT IDENTITY(1,1) ,
				[enc_id] INT
			)
			DECLARE @encId INT
			DECLARE @index INT
			DECLARE @rowCount INT	
			DECLARE @enctext VARCHAR(MAX)
			--fetch records for which new patiend id needs to be updated that are not signed.
			-- including signed ones as well based on user feedback
			INSERT INTO @tempTable 
			SELECT	ENC.[enc_id] 
			FROM	[dbo].[enchanced_encounter] ENC WITH(NOLOCK) 
					INNER JOIN #TempEnc BKENC WITH (NOLOCK) ON BKenc.enc_id = ENC.enc_id 
					--WHERE  BKENC.patient_id = @secondary_id --and ENC.patient_id= @CurrentId AND  issigned=0  
					--		AND (BKENC.pa_merge_reqid = @MergeRequestQueueId OR @CheckBatchId = 0)
			SET @rowCount=@@ROWCOUNT
			SET @index=1
			--loop through each encounter id
			WHILE(@index<=@rowCount)
			BEGIN	
				--fetch encounter id
				SELECT @encId=enc_id FROM @tempTable WHERE [index]=@index
				--fetch xml,patient id and type
				SELECT @enctext= [enc_text] FROM [dbo].[enchanced_encounter] WHERE enc_id=@encId	
				SET @enctext=REPLACE(@enctext,'<PatientId>'+CONVERT(VARCHAR(MAX),@primary_id)+'</PatientId>','<PatientId>'+CONVERT(VARCHAR(MAX),@secondary_id)+'</PatientId>')
				---Update encounder text and patientId with new patientId			
				UPDATE [dbo].[enchanced_encounter] SET [enc_text]=@enctext,patient_id=@secondary_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE enc_id=@encId	
				UPDATE [dbo].[enchanced_encounter_additional_info] SET patient_id=@secondary_id,last_modified_date=GETDATE(),last_modified_by=1 WHERE enc_id=@encId	
				--increment the index
				SET @index=@index+1
			END	
			
			IF EXISTS ( SELECT	NULL
			FROM	#TempEnc BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.enc_id 
			FROM	dbo.enchanced_encounter DRG  WITH (NOLOCK) 
			WHERE	BKDRG.enc_id = DRG.enc_id AND DRG.patient_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT enchanced_encounter ON

				INSERT INTO	[dbo].[enchanced_encounter]
				(
					enc_id,
					[patient_id],[dr_id],[added_by_dr_id],[enc_date],[enc_text],[chief_complaint],[type],[issigned],[dtsigned],[case_id],[loc_id],[last_modified_date],[last_modified_by],[datasets_selection],[type_of_visit],[clinical_summary_first_date],[active],[encounter_version]
				)
				SELECT	BKDRG.enc_id,
						BKDRG.[patient_id], BKDRG.[dr_id], BKDRG.[added_by_dr_id], BKDRG.[enc_date],BKDRG.[enc_text], BKDRG.[chief_complaint],
						BKDRG.[type], BKDRG.[issigned], BKDRG.[dtsigned], BKDRG.[case_id], BKDRG.[loc_id], BKDRG.[last_modified_date],
						BKDRG.[last_modified_by], BKDRG.[datasets_selection], BKDRG.[type_of_visit], BKDRG.[clinical_summary_first_date],
						BKDRG.[active], BKDRG.[encounter_version]
				FROM	#TempEnc BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.enc_id 
				FROM	dbo.enchanced_encounter DRG  WITH (NOLOCK) 
				WHERE	BKDRG.enc_id = DRG.enc_id AND DRG.patient_id = @secondary_id)			
				
				SET IDENTITY_INSERT enchanced_encounter OFF
			END
			
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.enchanced_encounter VIT WITH (NOLOCK)
					INNER JOIN #TempEnc BKDRG WITH (NOLOCK) ON BKDRG.enc_id = VIT.enc_id AND BKDRG.patient_id = VIT.patient_id
			WHERE	VIT.patient_id = @secondary_id	AND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId)
					AND VIT.Created_Date > @CreatedDate

			SELECT	BKDRG.*
			INTO	#TempEncAdd
			FROM	bk.[enchanced_encounter_additional_info] BKDRG WITH (NOLOCK) 
			WHERE	BKDRG.patient_id = @secondary_id AND (@CheckBatchId = 0 OR BKDRG.pa_merge_reqid = @MergeRequestQueueId)
					AND BKDRG.Created_Date > @CreatedDate
			
			IF EXISTS (SELECT	NULL
			FROM	#TempEncAdd BKDRG WITH (NOLOCK)
			WHERE	NOT EXISTS (Select DRG.enc_info_id 
					FROM	dbo.[enchanced_encounter_additional_info] DRG  WITH (NOLOCK) 
					WHERE	BKDRG.enc_info_id = DRG.enc_info_id AND DRG.patient_id = @secondary_id))
			BEGIN
				SET IDENTITY_INSERT [enchanced_encounter_additional_info] ON

				INSERT INTO [dbo].[enchanced_encounter_additional_info]
				(
					[enc_info_id], 
					[enc_id],[patient_id],[dr_id],[added_by_dr_id],[enc_date],[JSON],[chief_complaint],[type],[issigned],[dtsigned],[case_id],[loc_id],[last_modified_date],[last_modified_by],[datasets_selection],[type_of_visit],[clinical_summary_first_date],[active]
				)
				SELECT	BKDRG.[enc_info_id], 
						BKDRG.[enc_id], BKDRG.[patient_id], BKDRG.[dr_id], BKDRG.[added_by_dr_id], BKDRG.[enc_date], BKDRG.[JSON],
						BKDRG.[chief_complaint], BKDRG.[type], BKDRG.[issigned], BKDRG.[dtsigned], BKDRG.[case_id], BKDRG.[loc_id],
						BKDRG.[last_modified_date], BKDRG.[last_modified_by], BKDRG.[datasets_selection],
						BKDRG.[type_of_visit], BKDRG.[clinical_summary_first_date], BKDRG.[active]
				FROM	#TempEncAdd BKDRG WITH (NOLOCK)
				WHERE	NOT EXISTS (Select DRG.enc_info_id 
						FROM	dbo.[enchanced_encounter_additional_info] DRG  WITH (NOLOCK) 
						WHERE	BKDRG.enc_info_id = DRG.enc_info_id AND DRG.patient_id = @secondary_id)
				
				SET IDENTITY_INSERT [enchanced_encounter_additional_info] OFF
			END
		
			UPDATE	VIT
			SET		VIT.PatientUnmergeRequestId = @PatientUnmergeRequestId
			FROM	bk.[enchanced_encounter_additional_info] VIT WITH (NOLOCK)
					INNER JOIN #TempEncAdd BKDRG WITH (NOLOCK) ON BKDRG.enc_info_id = VIT.enc_info_id AND BKDRG.patient_id = VIT.patient_id
			WHERE	VIT.patient_id = @secondary_id aND (@CheckBatchId = 0 OR VIT.pa_merge_reqid = @MergeRequestQueueId )
					AND VIT.Created_Date > @CreatedDate
					
			--Update enchanced_encounter End
			
			-- Update secondray patient record to inactive
			UPDATE patients SET dg_id=ABS(dg_id),dr_id=ABS(dr_id),active=1,last_modified_date=GETDATE(),last_modified_by=1 WHERE pa_id=@secondary_id 
			 	
		COMMIT
	  
	END  TRY
	
	BEGIN CATCH
		ROLLBACK -- Rollback TRANSACTION
		
		DECLARE @ErrorMessage AS NVARCHAR(4000),@ErrorSeverity AS INT,@ErrorState AS INT;
		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();
		RAISERROR (@ErrorMessage, -- Message text.
				   @ErrorSeverity, -- Severity.
				   @ErrorState -- State.
				   );
		INSERT INTO db_Error_Log(error_code,error_desc,error_time,application,method,COMMENTS,errorline)
		VALUES(ERROR_NUMBER(),ERROR_MESSAGE(),GETDATE(),'EHR','unmergePatients','Primary PatientId:'+CONVERT(VARCHAR(500),@primary_id)+',Secondry PatientId:'+CONVERT(VARCHAR(500),@secondary_id),ERROR_LINE ())				   
	END CATCH
	--END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
