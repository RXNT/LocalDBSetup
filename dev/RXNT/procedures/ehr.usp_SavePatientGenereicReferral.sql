SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 10-October-2016
-- Description:	Save Generic Referral
-- =============================================

CREATE PROCEDURE [ehr].[usp_SavePatientGenereicReferral]
	@ReferralId INT OUTPUT,
	@ReferralReason VARCHAR(MAX),
	@Description VARCHAR(MAX),
	@NumberofVisits INT,
	@ICD9 VARCHAR(MAX),
	@DiagnosisName VARCHAR(MAX),
	@ICD10 VARCHAR(MAX),
	@MAINDRID INT,
	@TARGETDRID INT,
	@PatientId INT,
	@ReferralDate DATETIME,
	@ReferralEndDate DATETIME,
	@CarrierId INT,
	@MemberId VARCHAR(MAX),
	@REFDETIDENT VARCHAR(MAX),
	@MAINDRID1 VARCHAR(MAX),
	@MAINDRID2 VARCHAR(MAX),
	@TARDRID1 VARCHAR(MAX),
	@TARDRID2 VARCHAR(MAX),
	@INSTID INT,
	@CaseId INT,
	@GroupID VARCHAR(MAX),
	@Payer VARCHAR(MAX),
	@PolicyID VARCHAR(MAX),
	@InsuranceStartDate VARCHAR(MAX),
	@InsuranceEndDate VARCHAR(MAX),
	@ReferralVersion VARCHAR(10) = NULL
AS
BEGIN
	DECLARE @ref_det_id INT;

   INSERT INTO [referral_generic_det]([ref_reason],[ref_description],[numb_visits], [icd9], [description],[icd10])
   VALUES(@ReferralReason, @Description, @NumberofVisits, @ICD9, @DiagnosisName,@ICD10); 
   SET @ref_det_id = SCOPE_IDENTITY()
 
   INSERT INTO [referral_main]([main_dr_id],[target_dr_id],[pa_id],[ref_det_xref_id],[ref_start_date],[ref_end_date],
   [carrier_xref_id],[pa_member_no],[ref_det_ident], [main_prv_id1], [main_prv_id2], [target_prv_id1], [target_prv_id2], 
[inst_id],[case_id],[group_number],[payer_name],[policy_number],[insurance_start_date],[insurance_end_date],[referral_version])
   VALUES(@MAINDRID, @TARGETDRID, @PatientId, @ref_det_id,@ReferralDate, @ReferralEndDate, 
   @CarrierId, @MemberId, @REFDETIDENT, @MAINDRID1, @MAINDRID2, @TARDRID1, @TARDRID2,@INSTID,@CaseId,@GroupID,@Payer,@PolicyID,@InsuranceStartDate,@InsuranceEndDate,@ReferralVersion); 
   SET @ReferralId = SCOPE_IDENTITY();
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
