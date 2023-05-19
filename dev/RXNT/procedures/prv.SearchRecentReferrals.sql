SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Balaji
Create date			:	09-SEP-2016
Description			:	This procedure is used to get recent referrals 
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [prv].[SearchRecentReferrals]	
	-- Add the parameters for the stored procedure here
	@DoctorId BIGINT, @PatientFirstName varchar(50)=NULL, @PatientLastName varchar(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	SELECT R.REF_ID,R.REF_START_DATE, T.FIRST_NAME, T.LAST_NAME, T.GROUPNAME, 
	RS.INST_NAME, S.RESPONSE_DATE, S.RESPONSE_TYPE, S.RESPONSE_TEXT, S.DELIVERY_METHOD,
	P.pa_id, P.pa_first, P.pa_middle, P.pa_last, P.pa_dob, P.pa_phone,PE.pa_nick_name,
	(select COUNT (1) FROM dbo.patients WITH (NOLOCK)
						 WHERE pa_id = R.pa_id AND ( 
						 pa_first IS NULL OR pa_first = '' OR
						 pa_last IS NULL OR pa_last = '' OR
						 pa_dob IS NULL OR pa_dob = '' OR
						 pa_sex IS NULL OR pa_sex = '' OR
						 pa_address1 IS NULL OR pa_address1 = '' OR
						 pa_zip IS NULL OR pa_zip = '' OR
						 pa_state IS NULL OR pa_state = '' )
						 ) AS patient_details_missing
	FROM REFERRAL_MAIN R WITH(NOLOCK)
	INNER JOIN patients P WITH(NOLOCK) ON R.pa_id = P.pa_id
	LEFT OUTER JOIN [patient_extended_details] PE WITH(NOLOCK) ON PE.pa_id = P.pa_id 
	LEFT OUTER JOIN REFERRAL_TARGET_DOCS T WITH(NOLOCK) ON R.TARGET_DR_ID = T.TARGET_DR_ID 
	LEFT OUTER JOIN referral_institutions RS WITH(NOLOCK) ON R.INST_ID = RS.INST_ID 
	LEFT OUTER JOIN REFERRAL_STATUS S WITH(NOLOCK) ON R.REF_ID = S.REFERRAL_ID 
	WHERE R.MAIN_DR_ID = @DoctorId AND ref_start_date > getdate() - 30 
	AND (@PatientFirstName IS NULL OR P.pa_first LIKE @PatientFirstName+'%')
	AND (@PatientLastName IS NULL OR P.pa_last LIKE @PatientLastName+'%')
	ORDER BY R.REF_ID DESC

	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
