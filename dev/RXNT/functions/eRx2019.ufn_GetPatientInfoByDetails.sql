SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [core].[ufn_GetPatientInfoByDetails] 
( 
    @DoctorCompanyId BIGINT,
    @PatientFirstName VARCHAR(50),
    @PatientLastName VARCHAR(50),
    @PatientDOB DATETIME
) 
	RETURNS @Output TABLE(PatientId BIGINT,LastName VARCHAR(50),FirstName VARCHAR(50),MiddleName VARCHAR(50),Gender VARCHAR(1),DOB DATETIME)
BEGIN 
   
    INSERT INTO @Output (PatientId,LastName,FirstName,MiddleName,Gender,DOB)  
	SELECT DISTINCT TOP 2 P.PA_ID, P.PA_LAST, P.PA_FIRST, P.PA_MIDDLE, P.PA_SEX, P.pa_dob 
	FROM patients P WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id=p.dg_id 
	--LEFT OUTER JOIN PATIENT_EXTENDED_DETAILS PE WITH(NOLOCK) ON P.PA_ID = PE.PA_ID 
	--LEFT OUTER JOIN Patient_merge_request_queue PQ WITH(NOLOCK) ON PQ.primary_pa_id=P.pa_id 
    WHERE P.PA_FIRST LIKE @PatientFirstName AND P.PA_LAST LIKE @PatientLastName AND DG.DC_ID=@DoctorCompanyId AND (@PatientDOB IS NULL OR P.PA_DOB = @PatientDOB )
    ORDER BY p.pa_last, p.pa_first
    RETURN 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
