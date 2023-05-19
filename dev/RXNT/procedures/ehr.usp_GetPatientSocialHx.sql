SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Singaravelan
-- Create date: 22-Jul-2016
-- Description:	To get the patient Social Hx
-- Modified By: Niyaz
-- Modified Date: 3rd OCT 2017
-- =============================================
CREATE PROCEDURE [ehr].[usp_GetPatientSocialHx]
	@PatientId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT 
	sochx.sochxid, 
	sochx.pat_id,
	sochx.emp_info,
	sochx.household_people_no,
	sochx.comments,
	sochx.dr_id,
	sochx.added_by_dr_id,
	sochx.created_on,
	sochx.last_modified_on,
	sochx.last_modified_by,
	sochx.enable,
	sochx.StrenousDays,
    sochx.StrenousDaysND,
	sochx.StrenousMinutes,
    sochx.StrenousMinutesND,
    sochx.WeeklyPhoneTalkCount,
    sochx.WeeklyPhoneTalkCountND,
	sochx.FriendFamilyGetTogetherCount,
	sochx.FriendFamilyGetTogetherCountND,
	sochx.ChurchAttendCount,
	sochx.ChurchAttendCountND,
	sochx.BirthOrder,
	sochx.TobaccoUse,
	sochx.MarijuanaUse,
	sochx.Vaping,
	sochx.RecreationalDrugUse,
	sochx.ETOH,
	sochx.GravidaPara,
	ATS1.Code as SmokingStatusCode,
	ATS2.Code as FinancialResourceStrainCode,
	ATS3.Code as EducationStatusCode,
	ATS4.Code as StressStatusCode,
	ATS5.Code as AlcoholIntervalMonthCode,
	ATS6.Code as AlcoholIntervalDayCode,
	ATS7.Code as AlcoholIntervalOccasionCode,
	ATS8.Code as MaritalStatusCode,
	ATS9.Code as ClubOrgMemberStatusCode,
	ATS10.Code as EmotionallyAbusedStatusCode,
	ATS11.Code as AfraidStatusCode,
	ATS12.Code as SexualHarrasmentStatusCode,
	ATS13.Code as KHSHurtStatusCode,
	ATS14.Code as MultipleBirthIndicatorCode
	FROM patient_social_hx sochx WITH(NOLOCK)
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS1 ON sochx.SmokingStatusId = ATS1.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS2 ON sochx.FinancialResourceStrainId = ATS2.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS3 ON sochx.EducationStatusId = ATS3.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS4 ON sochx.StressStatusId = ATS4.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS5 ON sochx.AlcoholIntervalMonthId = ATS5.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS6 ON sochx.AlcoholIntervalDayId = ATS6.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS7 ON sochx.AlcoholIntervalOccasionId = ATS7.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS8 ON sochx.MaritalStatusId = ATS8.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS9 ON sochx.ClubOrgMemberStatusId = ATS9.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS10 ON sochx.EmotionallyAbusedStatusId = ATS10.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS11 ON sochx.AfraidStatusId = ATS11.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS12 ON sochx.SexualHarrasmentStatusId = ATS12.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS13 ON sochx.KHSHurtStatusId = ATS13.ApplicationTableConstantId
	LEFT OUTER JOIN ehr.ApplicationTableConstants ATS14 ON sochx.MultipleBirthIndicatorId = ATS14.ApplicationTableConstantId
	
	WHERE sochx.pat_id = @PatientId AND sochx.enable=1 
	ORDER BY sochx.created_on DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
