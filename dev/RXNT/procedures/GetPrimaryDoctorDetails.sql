SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: VIPUL JAIN
Create date			: 17-MAR-2021
Description			: To Deactivate all users if location is deactivated
Last Modified By	: Nambi
Last Modifed Date	: 20-FEB-2023
Last Modification	: ADV2-2275: update deactivated date for users
======================================================================================= 
*/ 
 CREATE   PROCEDURE [dbo].[GetPrimaryDoctorDetails]
(	
	@dcid	INT,
	@PatientId BIGINT
)
AS
BEGIN
		IF(@dcid>0)
		BEGIN
			SELECT D.DR_FIRST_NAME,
			D.epcs_enabled,
			D.dr_enabled,
			loginlock, 
			D.DR_PREFIX, 
			D.DR_SUFFIX, 
			d.hipaa_agreement_acptd,
			D.dr_agreement_acptd,
			d.dr_def_rxcard_history_back_to,
			d.dr_rxcard_search_consent_type, 
			D.dr_def_pat_history_back_to, 
			D.NPI, 
			D.TIME_DIFFERENCE, 
			D.DR_MIDDLE_INITIAL, 
			D.DR_LAST_NAME, 
			D.DR_DEA_NUMB,
			D.DR_USERNAME,
			D.DR_ID, 
			D.DG_ID, 
			DG.DC_ID, 
			DG.DG_NAME, 
			D.DR_ADDRESS1, 
			D.DR_ADDRESS2, 
			D.DR_CITY, 
			D.DR_STATE, 
			D.DR_ZIP, 
			D.DR_PHONE,
			D.DR_EMAIL, 
			D.RIGHTS, 
			D.DR_FAX, 
			PRESCRIBING_AUTHORITY, 
			ISNULL(PC.isRestricted,0) isRestricted, 
			D.dr_last_name + ' ' + ISNULL(D.dr_middle_initial,'') + ' '  + D.dr_first_name AS DoctorName
			FROM DOCTORS D WITH(NOLOCK)
			INNER JOIN DOC_GROUPS DG WITH(NOLOCK) ON D.DG_ID = DG.DG_ID 
			LEFT OUTER JOIN patient_chart_restricted_users PC WITH(NOLOCK) On D.dr_id = PC.dr_id and PC.pa_id = @PatientId
			WHERE DG.DC_ID = @dcid  AND  D.PRESCRIBING_AUTHORITY IN (0,1,2,3,4) 
			order by D.dr_first_name
		END		
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
