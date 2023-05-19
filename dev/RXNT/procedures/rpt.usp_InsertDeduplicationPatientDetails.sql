SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vidya
Create date			:	15-Feb-2017
Description			:	This procedure is used to insert Patients Deduplications
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [rpt].[usp_InsertDeduplicationPatientDetails]
(
	@CompanyId BIGINT,
	@DoctorCompanyDeduplicateRequestId BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @errorMsg NVARCHAR(4000),
			@errorSeverity INT,
			@errorState INT;
	BEGIN TRY
		BEGIN TRAN
	
	DECLARE @ProcessPendingStatusId AS BIGINT
	DECLARE @CreatedDate AS DATETIME
	DECLARE @CreatedBy AS BIGINT

	SET @CreatedBy = 1
	SET @CreatedDate = GETDATE()
	
	SELECT	@ProcessPendingStatusId = ProcessStatusTypeId
	FROM	rpt.ProcessStatusTypes PST WITH (NOLOCK)
	WHERE	PST.Code = 'PENDG'

	DECLARE @PatientId As BIGINT
	DECLARE @MaxWeightage As INT
	DECLARE @MaxWeightagePrimaryPatientId AS BIGINT
	DECLARE @MaxWeightageSecondaryPatientId AS BIGINT
	DECLARE @MaxWeightagePrimaryWeightage AS BIGINT
	DECLARE @MaxWeightageSecondaryWeightage AS BIGINT
	DECLARE @DeduplicationPatientGroupId AS BIGINT
	DECLARE @DuplicationTypeId AS BIGINT
	DECLARE @DuplicationText AS VARCHAR(5000)

	SELECT  DPT.DoctorCompanyDeduplicationTransitionId, DPT.PatientId, DPT.DoctorCompanyDeduplicationPatientTransitionId,
			DDT.DoctorCompanyDeduplicateRequestId, DDT.DuplicationText, DDT.DuplicationTypeId, DT.Weightage,
			DDT.CompanyId, DPT.DoctorGroupId
	INTO	#TempDeduplicationTransition		
	FROM	rpt.DoctorCompanyDeduplicationPatientTransition DPT WITH (NOLOCK)
			INNER JOIN rpt.DoctorCompanyDeduplicationTransition DDT WITH (NOLOCK) on DDT.DoctorCompanyDeduplicationTransitionId = DPT.DoctorCompanyDeduplicationTransitionId
			INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) ON DT.DuplicationTypeId = DDT.DuplicationTypeId
	WHERE	DDT.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
			AND DPT.ProcessStatusTypeId = @ProcessPendingStatusId
			AND DDT.ProcessStatusTypeId = @ProcessPendingStatusId
			AND DPT.Active = 1 AND DDT.Active = 1 

	Select	PPT.PatientId, PPCT.Weightage
	INTO	#TempDeduplicationPrimaryCriteria
	From	rpt.DeduplicationPrimaryPatientTransition PPT WITH (NOLOCK)
			INNER JOIN rpt.PrimaryPatientCriteriaTypes PPCT WITH (NOLOCK) on PPCT.PrimaryPatientCriteriaTypeId = PPT.PrimaryPatientCriteriaTypeId				
	WHERE	PPT.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId 
			AND PPT.CompanyId = @CompanyId
			AND PPT.ProcessStatusTypeId = @ProcessPendingStatusId
			AND PPT.Active = 1 
	
	DECLARE @TMPPrimaryPatient As TABLE (PatientId BIGINT, Weightage INT NULL)
	INSERT INTO  @TMPPrimaryPatient
	(PatientId, Weightage)
	Select	PatientId, MAX(Weightage) As MaxWeightage
	From	#TempDeduplicationTransition
	Group By PatientId 

	DECLARE @TMPSubPatientTransition AS TABLE(DoctorCompanyDeduplicationTransitionId BIGINT)
	DECLARE @TMPSecondaryPatient As TABLE (PrimaryPatientId BIGINT, PatientId BIGINT NULL, DuplicationTypeId BIGINT NULL, DuplicationText VARCHAR(5000) NULL, Weightage INT NULL)

	--Get Distinct PatientId along with max weightage
	DECLARE patcursor CURSOR LOCAL FAST_FORWARD FOR
		SELECT PatientId, Weightage FROM @TMPPrimaryPatient
		Order By Weightage desc, PatientId asc
	OPEN patcursor
	FETCH NEXT FROM patcursor into @PatientId, @MaxWeightage
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS (SELECT TMP.PatientId From rpt.DeduplicationPatients TMP 
					WHERE TMP.PatientId = @PatientId AND TMP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
					AND TMP.ProcessStatusTypeId = @ProcessPendingStatusId)
		BEGIN
			--Get All the Groups for that Particular Patient
			DELETE FROM @TMPSubPatientTransition
			DELETE FROM @TMPSecondaryPatient
		
			INSERT INTO @TMPSubPatientTransition
			(DoctorCompanyDeduplicationTransitionId)
			SELECT  DPT.DoctorCompanyDeduplicationTransitionId
			FROM	#TempDeduplicationTransition DPT
			WHERE	DPT.PatientId = @PatientId

			--Get All Patients for the related groups
			INSERT INTO @TMPSecondaryPatient
			(PrimaryPatientId, PatientId, DuplicationTypeId, DuplicationText, Weightage)
			SELECT  Distinct @PatientId, DDT.PatientId, DDT.DuplicationTypeId, DDT.DuplicationText, DDT.Weightage
			From	@TMPSubPatientTransition SPT 
					INNER JOIN #TempDeduplicationTransition DDT WITH (NOLOCK) on DDT.DoctorCompanyDeduplicationTransitionId = SPT.DoctorCompanyDeduplicationTransitionId
					INNER JOIN (SELECT	DDT.PatientId, Max(DDT.DoctorCompanyDeduplicationTransitionId) AS DoctorCompanyDeduplicationTransitionId
								FROM	#TempDeduplicationTransition DDT WITH (NOLOCK)
										INNER JOIN @TMPSubPatientTransition SP on SP.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
										INNER JOIN (Select  DDT.PatientId, MAX(Weightage) As MaxWeightage
													From	@TMPSubPatientTransition SPT 
															INNER JOIN #TempDeduplicationTransition DDT WITH (NOLOCK) ON DDT.DoctorCompanyDeduplicationTransitionId = SPT.DoctorCompanyDeduplicationTransitionId
													Where	DDT.PatientId != @PatientId 
													Group By DDT.PatientId) MER ON MER.PatientId = DDT.PatientId 
																				AND MER.MaxWeightage = DDT.Weightage
								Group by DDT.PatientId) MW ON MW.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
															AND MW.PatientId = DDT.PatientId
			AND NOT EXISTS (SELECT TMP.PatientId From rpt.DeduplicationPatients TMP 
					WHERE TMP.PatientId = DDT.PatientId AND TMP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
					AND TMP.ProcessStatusTypeId = @ProcessPendingStatusId)
			--Group By  DPTS.PatientId
		
			SET @MaxWeightagePrimaryPatientId = 0 --Duplicate PatientId fix
			SET @MaxWeightagePrimaryWeightage = 0

			Select	Top 1 @MaxWeightagePrimaryPatientId  = PPT.PatientId, @MaxWeightagePrimaryWeightage = Sum(PPT.Weightage)
			From	#TempDeduplicationPrimaryCriteria PPT
			WHERE	PPT.PatientId = @PatientId
			Group By 	PPT.PatientId
			Order By SUM(PPT.Weightage) DESC					
				
			SET @MaxWeightageSecondaryPatientId = 0 --Duplicate PatientId fix
			SET @MaxWeightageSecondaryWeightage = 0

			Select	Top 1 @MaxWeightageSecondaryPatientId  = PAT.PatientId, @MaxWeightageSecondaryWeightage = Sum(PPT.Weightage)
			From	@TMPSecondaryPatient PAT
					INNER JOIN #TempDeduplicationPrimaryCriteria PPT WITH (NOLOCK) ON PPT.PatientId = PAT.PatientId
			Group By 	PAT.PatientId
			Order By SUM(PPT.Weightage) DESC
					
			SET @DeduplicationPatientGroupId = 0
			DECLARE @PrimaryPatientId As BIGINT
			DECLARE @IsWarningPatient AS BIT
			DECLARE @PatientName AS VARCHAR(200)

			IF ISNULL(@MaxWeightageSecondaryWeightage, 0) > ISNULL(@MaxWeightagePrimaryWeightage, 0) AND ISNULL(@MaxWeightageSecondaryPatientId, 0) > 0 --PatientId 0 ISsue fix
			BEGIN
			
				SET @PrimaryPatientId = @MaxWeightageSecondaryPatientId

				IF NOT EXISTS (
					SELECT	NULL 
					FROM	rpt.DeduplicationExcludePatients DEP WITH (NOLOCK)
					WHERE	DEP.CompanyId = @CompanyId  
							AND DEP.ProcessStatusTypeId = @ProcessPendingStatusId
							AND ((DEP.PrimaryPatientId = @MaxWeightageSecondaryPatientId 
							AND DEP.SecondaryPatientId = @PatientId) OR
							(DEP.PrimaryPatientId =  @PatientId
							AND DEP.SecondaryPatientId =@MaxWeightageSecondaryPatientId ))
							AND DEP.Active = 1)
				BEGIN
					SET @PatientName = ''

					Select		@PatientName =  ISNULL(pat.pa_last, '') + ', ' + ISNULL(pat.pa_first, '')
					From		dbo.Patients pat WITH (NOLOCK)
								INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
					WHERE		dg.dc_id = @CompanyId AND pat.pa_id = @MaxWeightageSecondaryPatientId

					INSERT INTO rpt.DeduplicationPatientGroups
					(DoctorCompanyDeduplicateRequestId, CompanyId, GroupName, SuggestedPrimaryPatientId, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludeForMerge)
					VALUES
					(@DoctorCompanyDeduplicateRequestId, @CompanyId, @PatientName + '-' + CONVERT(VARCHAR(50), @MaxWeightageSecondaryPatientId), @MaxWeightageSecondaryPatientId, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, 0)
			
					SELECT @DeduplicationPatientGroupId = SCOPE_IDENTITY();
					
					SET @DuplicationTypeId = 0 --Duplicate PatientId fix
					SET @DuplicationText = ''

					Select  TOP 1 @DuplicationTypeId = DDT.DuplicationTypeId, @DuplicationText = DDT.DuplicationText
					From	#TempDeduplicationTransition DDT WITH (NOLOCK)
							INNER JOIN @TMPSubPatientTransition SP on SP.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
					Where	DDT.PatientId = @MaxWeightageSecondaryPatientId
					Order By DDT.Weightage DESC, DDT.DoctorCompanyDeduplicationPatientTransitionId DESC

					SET @IsWarningPatient = 0

					SELECT	@IsWarningPatient = IsWarning
					FROM	rpt.DuplicationTypes WITH (NOLOCK)
					WHERE	DuplicationTypeId = @DuplicationTypeId

					INSERT INTO rpt.DeduplicationPatients
					(DeduplicationPatientGroupId, DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, DuplicationTypeId, DuplicationText, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludeWarningPatient, IncludePatientForMerge, [Level])
					VALUES
					(@DeduplicationPatientGroupId, @DoctorCompanyDeduplicateRequestId, @CompanyId, @MaxWeightageSecondaryPatientId, @DuplicationTypeId, @DuplicationText, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, 1, 1, 1)

			
					SET @DuplicationTypeId = 0 --Duplicate PatientId fix
					SET @DuplicationText = ''

					Select  TOP 1 @DuplicationTypeId = DDT.DuplicationTypeId, @DuplicationText = DDT.DuplicationText
					From	#TempDeduplicationTransition DDT WITH (NOLOCK)
							INNER JOIN @TMPSubPatientTransition SP on SP.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
					Where	DDT.PatientId = @PatientId AND DDT.Weightage = @MaxWeightage
					Order By DDT.DoctorCompanyDeduplicationPatientTransitionId DESC
					
					SET @IsWarningPatient = 0

					SELECT	@IsWarningPatient = IsWarning
					FROM	rpt.DuplicationTypes WITH (NOLOCK)
					WHERE	DuplicationTypeId = @DuplicationTypeId

					INSERT INTO rpt.DeduplicationPatients
					(DeduplicationPatientGroupId, DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, DuplicationTypeId, DuplicationText, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludePatientForMerge, [Level])
					VALUES
					(@DeduplicationPatientGroupId, @DoctorCompanyDeduplicateRequestId, @CompanyId, @PatientId, @DuplicationTypeId, @DuplicationText, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, CASE WHEN @IsWarningPatient = 1 THEN 0 ELSE 1 END, 2)

				END
				ELSE IF (EXISTS (SELECT 1 FROM @TMPSecondaryPatient SP 
										WHERE NOT EXISTS (SELECT	NULL 
										FROM	rpt.DeduplicationExcludePatients DEP WITH (NOLOCK)
										WHERE	DEP.CompanyId = @CompanyId
												AND DEP.ProcessStatusTypeId = @ProcessPendingStatusId
												AND DEP.Active = 1
												AND ((DEP.PrimaryPatientId = @PrimaryPatientId 
												AND DEP.SecondaryPatientId = SP.PatientId) OR
												(DEP.PrimaryPatientId = SP.PatientId
												AND DEP.SecondaryPatientId = @PrimaryPatientId) OR 
												(DEP.PrimaryPatientId = SP.PrimaryPatientId
												AND DEP.SecondaryPatientId = @PrimaryPatientId) OR
												(DEP.PrimaryPatientId = @PrimaryPatientId
												AND DEP.SecondaryPatientId = SP.PrimaryPatientId)))))
				BEGIN
					SET @PatientName = ''

					Select		@PatientName =  ISNULL(pat.pa_last, '') + ', ' + ISNULL(pat.pa_first, '')
					From		dbo.Patients pat WITH (NOLOCK)
								INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
					WHERE		dg.dc_id = @CompanyId AND pat.pa_id = @MaxWeightageSecondaryPatientId

					INSERT INTO rpt.DeduplicationPatientGroups
					(DoctorCompanyDeduplicateRequestId, CompanyId, GroupName, SuggestedPrimaryPatientId, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludeForMerge)
					VALUES
					(@DoctorCompanyDeduplicateRequestId, @CompanyId, @PatientName + '-' + CONVERT(VARCHAR(50), @MaxWeightageSecondaryPatientId), @MaxWeightageSecondaryPatientId, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, 0)
			
					SELECT @DeduplicationPatientGroupId = SCOPE_IDENTITY();

					SET @DuplicationTypeId = 0 --Duplicate PatientId fix
					SET @DuplicationText = ''
					SET @IsWarningPatient = 0

					Select  TOP 1 @DuplicationTypeId = DDT.DuplicationTypeId, @DuplicationText = DDT.DuplicationText
					From	#TempDeduplicationTransition DDT WITH (NOLOCK)
							INNER JOIN @TMPSubPatientTransition SP on SP.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
					Where	DDT.PatientId = @MaxWeightageSecondaryPatientId
					Order By DDT.Weightage DESC, DDT.DoctorCompanyDeduplicationPatientTransitionId DESC
					
					SET @IsWarningPatient = 0

					SELECT	@IsWarningPatient = IsWarning
					FROM	rpt.DuplicationTypes WITH (NOLOCK)
					WHERE	DuplicationTypeId = @DuplicationTypeId

					INSERT INTO rpt.DeduplicationPatients
					(DeduplicationPatientGroupId, DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, DuplicationTypeId, DuplicationText, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludeWarningPatient, IncludePatientForMerge, [Level])
					VALUES
					(@DeduplicationPatientGroupId, @DoctorCompanyDeduplicateRequestId, @CompanyId, @MaxWeightageSecondaryPatientId, @DuplicationTypeId, @DuplicationText, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, 1, 1, 1)
				END
			END
			ELSE
			BEGIN
				SET @MaxWeightageSecondaryPatientId = 0

				SET @PrimaryPatientId = @PatientId
				
				IF EXISTS (SELECT 1 FROM @TMPSecondaryPatient SP 
										WHERE NOT EXISTS (SELECT	NULL 
										FROM	rpt.DeduplicationExcludePatients DEP WITH (NOLOCK)
										WHERE	DEP.CompanyId = @CompanyId
												AND DEP.ProcessStatusTypeId = @ProcessPendingStatusId
												AND DEP.Active = 1
												AND ((DEP.PrimaryPatientId = @PrimaryPatientId 
												AND DEP.SecondaryPatientId = SP.PatientId) OR
												(DEP.PrimaryPatientId =  SP.PatientId
												AND DEP.SecondaryPatientId = @PrimaryPatientId))))
				BEGIN
					SET @PatientName = ''

					Select		@PatientName =  ISNULL(pat.pa_last, '') + ', ' + ISNULL(pat.pa_first, '')
					From		dbo.Patients pat WITH (NOLOCK)
								INNER JOIN dbo.doc_groups DG WITH (NOLOCK) on DG.dg_id = pat.dg_id
					WHERE		dg.dc_id = @CompanyId AND pat.pa_id = @PatientId

					INSERT INTO rpt.DeduplicationPatientGroups
					(DoctorCompanyDeduplicateRequestId, CompanyId, GroupName, SuggestedPrimaryPatientId, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludeForMerge)
					VALUES
					(@DoctorCompanyDeduplicateRequestId, @CompanyId, @PatientName + '-' + CONVERT(VARCHAR(50), @PatientId), @PatientId, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, 0)
			
					SELECT @DeduplicationPatientGroupId = SCOPE_IDENTITY();

					SET @DuplicationTypeId = 0 --Duplicate PatientId fix
					SET @DuplicationText = ''

					Select  TOP 1 @DuplicationTypeId = DDT.DuplicationTypeId, @DuplicationText = DDT.DuplicationText
					From	#TempDeduplicationTransition DDT WITH (NOLOCK)
							INNER JOIN @TMPSubPatientTransition SP on SP.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
					Where	DDT.PatientId = @PatientId
					Order By DDT.Weightage DESC, DDT.DoctorCompanyDeduplicationPatientTransitionId DESC
					
					SET @IsWarningPatient = 0

					SELECT	@IsWarningPatient = IsWarning
					FROM	rpt.DuplicationTypes WITH (NOLOCK)
					WHERE	DuplicationTypeId = @DuplicationTypeId

					INSERT INTO rpt.DeduplicationPatients
					(DeduplicationPatientGroupId, DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, DuplicationTypeId, DuplicationText, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludeWarningPatient, IncludePatientForMerge, [Level])
					VALUES
					(@DeduplicationPatientGroupId, @DoctorCompanyDeduplicateRequestId, @CompanyId, @PatientId, @DuplicationTypeId, @DuplicationText, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, 1, 1, 1)
				END
			END
		
			IF @DeduplicationPatientGroupId > 0
			BEGIN
				INSERT INTO rpt.DeduplicationPatients
				(DeduplicationPatientGroupId, DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, DuplicationTypeId, DuplicationText, Active, Createdby, CreatedDate, ProcessStatusTypeId, IncludePatientForMerge, [Level])
				SELECT @DeduplicationPatientGroupId, @DoctorCompanyDeduplicateRequestId, @CompanyId, PatientId, SP.DuplicationTypeId, DuplicationText, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, Case WHEN DT.IsWarning = 1 THEN 0 ELSE 1 END, 2
				FROM	@TMPSecondaryPatient SP
						INNER JOIN rpt.DuplicationTypes DT WITH (NOLOCK) on DT.DuplicationTypeId = SP.DuplicationTypeId
				WHERE	PatientId != @MaxWeightageSecondaryPatientId
						AND NOT EXISTS (SELECT	NULL 
										FROM	rpt.DeduplicationExcludePatients DEP WITH (NOLOCK)
										WHERE	DEP.CompanyId = @CompanyId
												AND DEP.ProcessStatusTypeId = @ProcessPendingStatusId
												AND DEP.Active = 1
												AND ((DEP.PrimaryPatientId = @PrimaryPatientId 
												AND DEP.SecondaryPatientId = SP.PatientId) OR
												(DEP.PrimaryPatientId = SP.PatientId  
												AND DEP.SecondaryPatientId = @PrimaryPatientId)))
			END
			
			IF NOT EXISTS (SELECT 1 FROM @TMPSecondaryPatient) AND ISNULL(@DeduplicationPatientGroupId, 0) <= 0
			BEGIN			
				DELETE FROM @TMPSecondaryPatient
		
				--Get All Patients for the related groups
				INSERT INTO @TMPSecondaryPatient
				(PrimaryPatientId, PatientId, DuplicationTypeId, DuplicationText, Weightage)
				SELECT  Top 1 @PatientId, DDT.PatientId, DDT.DuplicationTypeId, DDT.DuplicationText, DDT.Weightage
				From	@TMPSubPatientTransition SPT 
						INNER JOIN #TempDeduplicationTransition DDT WITH (NOLOCK) on DDT.DoctorCompanyDeduplicationTransitionId = SPT.DoctorCompanyDeduplicationTransitionId
						INNER JOIN (SELECT	DDT.PatientId, Max(DDT.DoctorCompanyDeduplicationTransitionId) AS DoctorCompanyDeduplicationTransitionId
									FROM	#TempDeduplicationTransition DDT WITH (NOLOCK)
											INNER JOIN @TMPSubPatientTransition SP on SP.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
											INNER JOIN (Select  DDT.PatientId, MAX(Weightage) As MaxWeightage
														From	@TMPSubPatientTransition SPT 
																INNER JOIN #TempDeduplicationTransition DDT WITH (NOLOCK) ON DDT.DoctorCompanyDeduplicationTransitionId = SPT.DoctorCompanyDeduplicationTransitionId
														Where	DDT.PatientId != @PatientId 
														Group By DDT.PatientId) MER ON MER.PatientId = DDT.PatientId 
																					AND MER.MaxWeightage = DDT.Weightage
									Group by DDT.PatientId
									) MW ON MW.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
																AND MW.PatientId = DDT.PatientId
				Order by DDT.Weightage desc
			
				SET @DeduplicationPatientGroupId = 0
			
				SELECT	TOP 1 @MaxWeightageSecondaryPatientId = PatientId
				FROM	@TMPSecondaryPatient
			
				SET @PrimaryPatientId  = 0
				DECLARE @IndirectComments AS VARCHAR(500)
				DECLARE @IsIndirectMapping AS BIT

				IF NOT EXISTS (SELECT NULL From rpt.DeduplicationPatientGroups TMP 
					WHERE TMP.SuggestedPrimaryPatientId = @MaxWeightageSecondaryPatientId AND TMP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
					AND TMP.ProcessStatusTypeId = @ProcessPendingStatusId)
				BEGIN

					SELECT top 1 @PrimaryPatientId = t2.SuggestedPrimaryPatientId
					from	rpt.DeduplicationPatients t1 WITH (NOLOCK)
							INNER JOIN rpt.DeduplicationPatientGroups t2 WITH (NOLOCK) on t2.DeduplicationPatientGroupId = t1.DeduplicationPatientGroupId
					where	t1.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
							AND t1.ProcessStatusTypeId = @ProcessPendingStatusId
							AND t1.Active = 1
							AND t2.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
							AND t2.ProcessStatusTypeId = @ProcessPendingStatusId
							AND t2.Active = 1
							and t1.PatientId = @MaxWeightageSecondaryPatientId

					SET @IndirectComments = 'Mapped to the Patient # ' + CONVERT(VARCHAR(50),@MaxWeightageSecondaryPatientId)
					SET @IsIndirectMapping = 1
				END
				ELSE
				BEGIN
					SET @PrimaryPatientId = @MaxWeightageSecondaryPatientId
					SET @IndirectComments = ''
					SET @IsIndirectMapping = 0
				END
			
				SELECT @DeduplicationPatientGroupId = DeduplicationPatientGroupId From rpt.DeduplicationPatientGroups TMP 
				WHERE TMP.SuggestedPrimaryPatientId = @PrimaryPatientId AND TMP.DoctorCompanyDeduplicateRequestId = @DoctorCompanyDeduplicateRequestId
				AND TMP.ProcessStatusTypeId = @ProcessPendingStatusId
						
				SET @DuplicationTypeId = 0 --Duplicate PatientId fix
				SET @DuplicationText = ''

				Select  TOP 1 @DuplicationTypeId = DDT.DuplicationTypeId, @DuplicationText = DDT.DuplicationText
				From	#TempDeduplicationTransition DDT WITH (NOLOCK)
						INNER JOIN @TMPSubPatientTransition SP on SP.DoctorCompanyDeduplicationTransitionId = DDT.DoctorCompanyDeduplicationTransitionId
				Where	DDT.PatientId = @PatientId AND DDT.Weightage = @MaxWeightage
				Order By DDT.DoctorCompanyDeduplicationPatientTransitionId DESC
				
				IF @DeduplicationPatientGroupId > 0 AND NOT EXISTS (
					SELECT	NULL 
					FROM	rpt.DeduplicationExcludePatients DEP WITH (NOLOCK)
					WHERE	DEP.CompanyId = @CompanyId
							AND DEP.ProcessStatusTypeId = @ProcessPendingStatusId
							AND DEP.Active = 1
							AND ((DEP.PrimaryPatientId = @PrimaryPatientId 
							AND DEP.SecondaryPatientId = @PatientId) OR
							(DEP.PrimaryPatientId =  @PatientId
							AND DEP.SecondaryPatientId = @PrimaryPatientId)))
				BEGIN
					
					SET @IsWarningPatient = 0

					SELECT	@IsWarningPatient = IsWarning
					FROM	rpt.DuplicationTypes WITH (NOLOCK)
					WHERE	DuplicationTypeId = @DuplicationTypeId

					INSERT INTO rpt.DeduplicationPatients
					(DeduplicationPatientGroupId, DoctorCompanyDeduplicateRequestId, CompanyId, PatientId, DuplicationTypeId, DuplicationText, Active, Createdby, CreatedDate, ProcessStatusTypeId, IsIndirectMapping, IndirectMappingComments, IncludePatientForMerge, [Level])
					VALUES
						(@DeduplicationPatientGroupId, @DoctorCompanyDeduplicateRequestId, @CompanyId, @PatientId, @DuplicationTypeId, @DuplicationText, 1, @CreatedBy, @CreatedDate, @ProcessPendingStatusId, @IsIndirectMapping, @IndirectComments, Case WHEN @IsWarningPatient = 1 THEN 0 ELSE 1 END, 2)
				END
			END
		
		
		END
	FETCH NEXT FROM patcursor into @PatientId, @MaxWeightage
	END
	CLOSE patcursor
	DEALLOCATE patcursor
	

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SET @errorMsg =  'Error Procedure:' + ERROR_PROCEDURE() + ',  ' 
		+ 'Error Line:' + CAST(ERROR_LINE() AS VARCHAR(50)) + ',  '
		+ 'Error Message:' + ERROR_MESSAGE()
		SET @errorSeverity = ERROR_SEVERITY();
		SET @errorState = ERROR_STATE();
		RAISERROR (@errorMsg, @errorSeverity, @errorState);
		ROLLBACK TRAN
	END CATCH
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
