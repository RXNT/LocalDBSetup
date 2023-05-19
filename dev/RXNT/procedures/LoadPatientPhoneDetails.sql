SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 24-AUG-2017
-- Description:	To load Patient Phone details
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [dbo].[LoadPatientPhoneDetails]
	@PatientId BIGINT
AS

BEGIN
	SELECT pat.pa_phone, patext.cell_phone, patext.work_phone, patext.other_phone, patext.pref_phone FROM patients pat WITH(NOLOCK)
	LEFT OUTER JOIN patient_extended_details patext WITH(NOLOCK) ON pat.pa_id=patext.pa_id
	WHERE pat.pa_id=@PatientId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
