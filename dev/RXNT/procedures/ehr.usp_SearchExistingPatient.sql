SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	JahabarYusuff M
Create date			:	13-May-2019
Description			:	This procedure is used to gechek the patient availability in the system
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/
CREATE PROCEDURE [ehr].[usp_SearchExistingPatient] 
	@FirstName VARCHAR(900) ,
	@LastName VARCHAR(900) ,
	@DateOfBirth DATETIME,
	@DoctorCopmanyId VARCHAR(50)
AS

BEGIN
    SELECT TOP 1 pat.pa_id AS PatientId FROM  
    dbo.patients pat WITH(NOLOCK)
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id=dg.dg_id
	INNER JOIN doc_companies dc WITH(NOLOCK) ON dc.dc_id=dg.dc_id
	WHERE pat.pa_last = @LastName 
	AND pat.pa_first = @FirstName
	AND convert(date, pat.pa_dob) = convert(date,@DateOfBirth)
	AND  dc.dc_id = @DoctorCopmanyId
	ORDER BY pat.pa_id DESC
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
