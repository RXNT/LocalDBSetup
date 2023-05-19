SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Rasheed
Create date			:	07-JULY-2021
Description			:	This procedure is used to get user settings
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE   PROCEDURE [dbo].[usp_GetUserSettings]
	@UserId		BIGINT
AS
BEGIN
	DECLARE @prescribing_authority INT
	DECLARE @last_alias_dr_id BIGINT
	DECLARE @dr_last_auth_dr_id BIGINT
	DECLARE @is_pain_scale_enabled BIT
	SELECT @prescribing_authority=dr.prescribing_authority, @last_alias_dr_id=dr.dr_last_alias_dr_id,@dr_last_auth_dr_id=dr_last_auth_dr_id
	FROM doctors dr WITH(NOLOCK)
	WHERE dr.dr_id = @UserId

	IF @prescribing_authority<4 AND @dr_last_auth_dr_id>0
	BEGIN
		SELECT @is_pain_scale_enabled = df.is_pain_scale_enabled
		FROM doctor_info df WITH(NOLOCK) 
		WHERE df.dr_id = @dr_last_auth_dr_id
	END
	ELSE IF @prescribing_authority<4 AND @last_alias_dr_id>0
	BEGIN
		SELECT @is_pain_scale_enabled = df.is_pain_scale_enabled
		FROM doctor_info df WITH(NOLOCK) 
		WHERE df.dr_id = @last_alias_dr_id
	END
	ELSE
	BEGIN
		SELECT @is_pain_scale_enabled = df.is_pain_scale_enabled
		FROM doctor_info df WITH(NOLOCK) 
		WHERE df.dr_id = @UserId
	END

	SELECT dr_opt_two_printers, dr_severity,printpref,@is_pain_scale_enabled is_pain_scale_enabled, df.is_coupon_enabled,df.is_bannerads_enabled,df.settings, df.is_custom_tester,df.VersionURL,df.encounter_version, df.INLCUDE_ICD_Prescription, df.return_to_prov_dashboard, df.Add_Medications_To_My_Fav_Drugs, df.hide_walkme 
	FROM doctors dr WITH(NOLOCK)
	LEFT OUTER JOIN doctor_info df WITH(NOLOCK) on dr.dr_id = df.dr_id 
	WHERE dr.dr_id = @UserId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
