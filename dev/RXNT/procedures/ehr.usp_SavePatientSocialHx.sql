SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 20-Jul-2016
-- Description:	To Save Patient Social Hx
-- Modified By: Niyaz
-- Modified Date:  26th Oct 2017
-- ===================================patient_social_hx==========

CREATE PROCEDURE [ehr].[usp_SavePatientSocialHx]
	@SocialHxId BIGINT OUTPUT,
	@PatientId BIGINT,
	@DocotorId BIGINT,
	@AddedByDrID BIGINT,
	@IsEnable BIT,
	@EmploymentInfo VARCHAR(MAX),
	@NumberOfHouseholdPeople VARCHAR(50),
	@Comments VARCHAR(MAX),
	@SmokingStatusCode VARCHAR(50),
	@FinancialResourceStrainCode VARCHAR(50),
	@EducationStatusCode VARCHAR(50),
	@StressStatusCode VARCHAR(50),
	@AlcoholIntervalMonthCode VARCHAR(50),
	@AlcoholIntervalDayCode VARCHAR(50),
	@AlcoholIntervalOccasionCode VARCHAR(50),
	@MaritalStatusCode VARCHAR(50),
	@ClubOrgMemberStatusCode VARCHAR(50),
	@EmotionallyAbusedStatusCode VARCHAR(50),
	@AfraidStatusCode VARCHAR(50),
	@SexualHarrasmentStatusCode VARCHAR(50),
	@KHSHurtStatusCode VARCHAR(50),
    @StrenousDays VARCHAR(50),
    @StrenousDaysND BIT,
    @StrenousMinutes VARCHAR(50),
    @StrenousMinutesND BIT,
    @WeeklyPhoneTalkCount VARCHAR(50),
    @WeeklyPhoneTalkCountND BIT,
    @FriendFamilyGetTogetherCount VARCHAR(50),
    @FriendFamilyGetTogetherCountND BIT,
    @MultipleBirthIndicatorCode VARCHAR(50) = NULL,
    @ChurchAttendCount VARCHAR(50),
    @ChurchAttendCountND BIT,
    @BirthOrder VARCHAR(10),
    @TobaccoUse VARCHAR(200),
	@MarijuanaUse VARCHAR(200),
	@Vaping VARCHAR(200),
	@RecreationalDrugUse VARCHAR(200),
	@ETOH VARCHAR(200),
	@GravidaPara VARCHAR(200)
AS
BEGIN
	DECLARE @SmokingStatusId BIGINT;
	DECLARE @FinancialResourceStrainId BIGINT;
	DECLARE @EducationStatusId BIGINT;
	DECLARE @StressStatusId BIGINT;
	DECLARE @AlcoholIntervalMonthId BIGINT;
	DECLARE @AlcoholIntervalDayId BIGINT;
	DECLARE @AlcoholIntervalOccasionId BIGINT;
	DECLARE @MaritalStatusId BIGINT;
	DECLARE @ClubOrgMemberStatusId BIGINT;
	DECLARE @EmotionallyAbusedStatusId BIGINT;
	DECLARE @AfraidStatusId BIGINT;
	DECLARE @KHSHurtStatusId BIGINT;
	DECLARE @SexualHarrasmentStatusId BIGINT;
	DECLARE @MultipleBirthIndicatorId BIGINT;
	
	
	SELECT  @SmokingStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @SmokingStatusCode AND AT.Code='SMOKE'
	
	SELECT  @FinancialResourceStrainId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @FinancialResourceStrainCode AND AT.Code='FINRS'
	
	
	SELECT  @EducationStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @EducationStatusCode AND AT.Code='EDCAT'
	
	SELECT  @StressStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @StressStatusCode AND AT.Code='STRES'
	
	SELECT  @AlcoholIntervalMonthId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @AlcoholIntervalMonthCode AND AT.Code='ALINT'
	
	SELECT  @AlcoholIntervalDayId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @AlcoholIntervalDayCode AND AT.Code='ALDAY'
	
	SELECT  @AlcoholIntervalOccasionId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @AlcoholIntervalOccasionCode AND AT.Code='AL6RM'
	
	SELECT  @MaritalStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @MaritalStatusCode AND AT.Code='MARTL'
	
	SELECT  @ClubOrgMemberStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @ClubOrgMemberStatusCode AND AT.Code='CMSTS'
	
	SELECT  @MultipleBirthIndicatorId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @MultipleBirthIndicatorCode AND AT.Code='MULBR'
	
	SELECT  @EmotionallyAbusedStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @EmotionallyAbusedStatusCode AND AT.Code='EMTAB'
	
	SELECT  @AfraidStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @AfraidStatusCode AND AT.Code='AFRPT'
	
	SELECT  @SexualHarrasmentStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @SexualHarrasmentStatusCode AND AT.Code='RAPPT'
	
		
	SELECT  @KHSHurtStatusId = ATS.ApplicationTableConstantId
	FROM ehr.ApplicationTableConstants ATS WITH(NOLOCK)
	INNER JOIN ehr.ApplicationTables AT WITH(NOLOCK) ON AT.ApplicationTableId = ATS.ApplicationTableId AND
	ATS.Code = @KHSHurtStatusCode AND AT.Code='KHSST'
	
	
	IF ISNULL(@SocialHxId, 0) = 0
	BEGIN
		INSERT patient_social_hx 
		(pat_id, emp_info, household_people_no, comments,dr_id, added_by_dr_id, created_on, last_modified_on, last_modified_by, enable
		,SmokingStatusId,FinancialResourceStrainId,EducationStatusId,StressStatusId,StrenousDays,StrenousDaysND
        ,StrenousMinutes,StrenousMinutesND,AlcoholIntervalMonthId,AlcoholIntervalDayId,AlcoholIntervalOccasionId
        ,MaritalStatusId,WeeklyPhoneTalkCount,WeeklyPhoneTalkCountND,FriendFamilyGetTogetherCount
        ,FriendFamilyGetTogetherCountND,ChurchAttendCount,ChurchAttendCountND,ClubOrgMemberStatusId
        ,EmotionallyAbusedStatusId,AfraidStatusId,SexualHarrasmentStatusId,KHSHurtStatusId,MultipleBirthIndicatorId,BirthOrder
        ,TobaccoUse,MarijuanaUse,Vaping,RecreationalDrugUse,ETOH,GravidaPara)
		 VALUES
		(@PatientId, @EmploymentInfo, @NumberOfHouseholdPeople, @Comments,@DocotorId, @AddedByDrID, GETDATE(), GETDATE(), @DocotorId, 1,
		@SmokingStatusId,@FinancialResourceStrainId,@EducationStatusId,@StressStatusId,@StrenousDays,@StrenousDaysND
		,@StrenousMinutes,@StrenousMinutesND,@AlcoholIntervalMonthId,@AlcoholIntervalDayId,@AlcoholIntervalOccasionId,
		@MaritalStatusId,@WeeklyPhoneTalkCount,@WeeklyPhoneTalkCountND,@FriendFamilyGetTogetherCount,@FriendFamilyGetTogetherCountND,
		@ChurchAttendCount,@ChurchAttendCountND,@ClubOrgMemberStatusId,@EmotionallyAbusedStatusId,@AfraidStatusId,@SexualHarrasmentStatusId,@KHSHurtStatusId,@MultipleBirthIndicatorId,@BirthOrder
		,@TobaccoUse,@MarijuanaUse,@Vaping,@RecreationalDrugUse,@ETOH,@GravidaPara)

		SET @SocialHxId = SCOPE_IDENTITY()
	END
	ELSE
	BEGIN
		UPDATE patient_social_hx
		SET
		emp_info = @EmploymentInfo,
		household_people_no = @NumberOfHouseholdPeople,
		comments = @Comments,
		dr_id = @DocotorId,
		last_modified_on = GETDATE(),
		last_modified_by = @AddedByDrID,
		SmokingStatusId=@SmokingStatusId,
		FinancialResourceStrainId=@FinancialResourceStrainId,
		EducationStatusId=@EducationStatusId,
		StressStatusId=@StressStatusId,
		StrenousDays=@StrenousDays,
		StrenousDaysND=@StrenousDaysND,
		StrenousMinutes=@StrenousMinutes,
		StrenousMinutesND=@StrenousMinutesND,
		AlcoholIntervalMonthId=@AlcoholIntervalMonthId,
		AlcoholIntervalDayId=@AlcoholIntervalDayId,
		AlcoholIntervalOccasionId=@AlcoholIntervalOccasionId,
		MaritalStatusId=@MaritalStatusId,
		WeeklyPhoneTalkCount=@WeeklyPhoneTalkCount,
		WeeklyPhoneTalkCountND=@WeeklyPhoneTalkCountND,
		FriendFamilyGetTogetherCount=@FriendFamilyGetTogetherCount,
		FriendFamilyGetTogetherCountND=@FriendFamilyGetTogetherCountND,
		ChurchAttendCount=@ChurchAttendCount,
		ChurchAttendCountND=@ChurchAttendCountND,
		ClubOrgMemberStatusId=@ClubOrgMemberStatusId,
		EmotionallyAbusedStatusId=@EmotionallyAbusedStatusId,
		AfraidStatusId=@AfraidStatusId,
		SexualHarrasmentStatusId=@SexualHarrasmentStatusId,
		KHSHurtStatusId=@KHSHurtStatusId,
		MultipleBirthIndicatorId=@MultipleBirthIndicatorId,
		BirthOrder = @BirthOrder,
		TobaccoUse=@TobaccoUse,
		MarijuanaUse=@MarijuanaUse,
		Vaping=@Vaping,
		RecreationalDrugUse=@RecreationalDrugUse,
		ETOH=@ETOH,
		GravidaPara=@GravidaPara
		
		WHERE sochxid = @SocialHxId
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
