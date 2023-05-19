SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vinod
Create date			:	25-Sep-2017
Description			:	This procedure is used to Get Basic Registration Info For PinCode
Last Modified By	:	Nambi
Last Modifed Date	:	25-SEP-2018
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_GetPatientRegistrationInfoByPincode]
(
	@Pincode			VARCHAR(20)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT a.dr_id, a.pa_id, a.pincode, a.date_created, a.src_type, pa.pa_first, pa.pa_last, pa.pa_middle, 
	CONVERT(DATE, pa.pa_dob) AS pa_dob,DG.dc_id, DC.dc_name,
	dr.dr_first_name, dr.dr_last_name, dr.dr_state, c.pa_id accnt_id, b.pa_id reg_test_id,
	b.exp_date expdate
	FROM patient_reg_db a WITH(NOLOCK) 
	INNER JOIN patients pa WITH(NOLOCK) ON a.pa_id = pa.pa_id 
	LEFT OUTER JOIN doctors dr WITH(NOLOCK) ON a.dr_id = dr.dr_id 
	LEFT OUTER JOIN doc_groups DG WITH(NOLOCK) ON DG.dg_id = dr.dg_id
	LEFT OUTER JOIN doc_companies DC WITH(NOLOCK) ON DG.dc_id=DC.dc_id
	LEFT OUTER JOIN patient_login c WITH(NOLOCK) ON a.pa_id = c.pa_id 
	LEFT OUTER JOIN patient_registration b WITH(NOLOCK) ON a.pincode=b.pincode
	WHERE a.pincode = @Pincode AND
	ISNULL(a.active,0)=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
