SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 17-October-2016
-- Description:	Save Michigan Referral
-- =============================================

CREATE PROCEDURE [ehr].[usp_SavePatientMachiganReferral]
	@ReferralId INT OUTPUT,
	@BOFFICE BIT,
	@BOUTPATIENT BIT,
	@BERUCC BIT,
	@BFACILITYNUMB VARCHAR(MAX),
	@BFACILITYNAME VARCHAR(MAX),
	@SERVICEDATE DATETIME,
	@BCONSULT BIT,
	@NUMBVISITS INT,
	@BDIAGLAB BIT,
	@BAUDIOLOGY BIT,
	@BOPTHAMALOGY BIT,
	@BRADIOLOGY BIT,
	@BCAST BIT,
	@BSURGERY BIT,
	@SURGERYCPT VARCHAR(MAX),
	@BDIAGSTUDY BIT,
	@BONCOLOGY BIT,
	@BINJECTION BIT,
	@BDIALYSIS BIT,
	@BPAIN BIT,
	@BALLERGY BIT,
	@BBOB BIT,
	@BTHERAPY BIT,
	@PHYCNT INT,
	@OCCCNT INT,
	@SPCHCNT INT,
	@CARCNT INT,
	@OTHER1 VARCHAR(MAX),
	@OTHER2 VARCHAR(MAX),
	@OTHER3 VARCHAR(MAX),
	@OTHER4 VARCHAR(MAX),
	@OTHER5 VARCHAR(MAX),
	@OTHER6 VARCHAR(MAX),
	@BWORKERCOMP BIT,
	@BAUTOACC BIT,
	@COMMENTS VARCHAR(MAX),
	@ICD9 VARCHAR(MAX),
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
	@INSTID INT
AS
BEGIN
	DECLARE @ref_det_id INT;

	 INSERT INTO [referral_michigan_det]([bProviderOffice],[bOutpatient],[bERUCC],[facility_numb],[facility_name],[service_date],[bConsult],[numb_visits],[bdiagnosticlab],[baudiology],[bopthamalogy],[bradiology],[bcast],[bsurgery],[surgery_cpt],[bdiagstudy],[boncology],[binjection],[bdialysis],[bpain],[ballergy],[bob],[btherapy],[phy_cnt],[occu_cnt],[speech_cnt],[cardaic_cnt],[other1],[other2],[other3],[other4],[other5],[other6],[bWorkerComp],[bautoacc],[icd9],[comments])
     VALUES(@BOFFICE, @BOUTPATIENT, @BERUCC, @BFACILITYNUMB, @BFACILITYNAME, @SERVICEDATE, @BCONSULT, @NUMBVISITS, @BDIAGLAB, @BAUDIOLOGY, @BOPTHAMALOGY, @BRADIOLOGY, @BCAST, @BSURGERY, @SURGERYCPT, @BDIAGSTUDY, @BONCOLOGY, @BINJECTION, @BDIALYSIS, @BPAIN, @BALLERGY, @BBOB, @BTHERAPY, @PHYCNT, @OCCCNT, @SPCHCNT, @CARCNT, @OTHER1, @OTHER2, @OTHER3, @OTHER4, @OTHER5, @OTHER6, @BWORKERCOMP, @BAUTOACC, @ICD9, @COMMENTS);
     
      SET @ref_det_id = SCOPE_IDENTITY()
   
   INSERT INTO [referral_main]([main_dr_id],[target_dr_id],[pa_id],[ref_det_xref_id],[ref_start_date],[ref_end_date],
   [carrier_xref_id],[pa_member_no],[ref_det_ident], [main_prv_id1], [main_prv_id2], [target_prv_id1], [target_prv_id2], 
   [inst_id])
   VALUES(@MAINDRID, @TARGETDRID, @PatientId, @ref_det_id,@ReferralDate, @ReferralEndDate, 
   @CarrierId, @MemberId, @REFDETIDENT, @MAINDRID1, @MAINDRID2, @TARDRID1, @TARDRID2,@INSTID); 
   
   SET @ReferralId = SCOPE_IDENTITY();
END	
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
