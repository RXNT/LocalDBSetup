SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 14-October-2016
-- Description:	Save Maryland Referral
-- =============================================

CREATE PROCEDURE [ehr].[usp_SavePatientMarylandReferral]
	@ReferralId INT OUTPUT,
	@ReferralReason VARCHAR(MAX),
	@BriefHistoryText VARCHAR(MAX),
	@BINITCONSULT BIT,
	@BCONSULTANDTREAT BIT,
	@BDIAGTEST BIT,
	@BSPECIFICCONSULT BIT,
	@BSPECIFICCONSULTTEXT VARCHAR(MAX),
	@BSPECIFICTREATEMENT BIT,
	@SPECIFICTREATEMENTTEXT VARCHAR(MAX),
	@BGLOBALOB BIT,
	@GLOBALOBTEXT VARCHAR(MAX),
	@BOTHER BIT,
	@OTHERTEXT VARCHAR(MAX),
	@VISITNUMB INT,
	@AUTHID VARCHAR(MAX),
	@BOFFICE BIT,
	@BALLSITES BIT,
	@BOUTPATIENT BIT,
	@BRADIOLOGY BIT,
	@BLAB BIT,
	@BINPATIENT BIT,
	@BEXTCARE BIT,
	@BOTHERSERVICEPLACE BIT,
	@OTHERPLACETEXT VARCHAR(MAX),
	@DIAGTEXT VARCHAR(MAX),
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
	@ReferralVersion  VARCHAR(10)= NULL
	
AS
BEGIN
	DECLARE @ref_det_id INT;

   INSERT INTO [referral_maryland_details]([referral_reason],[brief_history_text],[bInitConsult],[bConsultAndTreat],
   [bDiagnosticTest],[bSpecificConsult],[specific_consult_text],[bSpecificTreatement],[specific_treatement_text],
   [bGlobalOB],[global_ob_text],[bOther],[other_text],[visit_numb],[auth_id],[bOfficeService],[bAllSites],
   [bOutpatientCenter],[bRadiology],[bLab],[bInpatientHospital],[bExtendedCare],[bOtherServicePlace],[other_place_text], 
   [diag_text])
   VALUES(@ReferralReason, @BriefHistoryText, @BINITCONSULT, @BCONSULTANDTREAT, 
   @BDIAGTEST, @BSPECIFICCONSULT,@BSPECIFICCONSULTTEXT, @BSPECIFICTREATEMENT, @SPECIFICTREATEMENTTEXT, 
   @BGLOBALOB, @GLOBALOBTEXT, @BOTHER, @OTHERTEXT, @VISITNUMB, @AUTHID, @BOFFICE, @BALLSITES,
   @BOUTPATIENT, @BRADIOLOGY, @BLAB, @BINPATIENT, @BEXTCARE, @BOTHERSERVICEPLACE, @OTHERPLACETEXT, 
   @DIAGTEXT);
   
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
