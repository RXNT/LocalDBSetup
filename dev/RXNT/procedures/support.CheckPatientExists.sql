SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [support].[CheckPatientExists]
/* 
	EXEC [support].[CheckPatientExists] 
	@DoctorCompany# = <Enter RxNT Doctor Company Id here>,				-- Optional
	@DoctorGroup# = <Enter RxNT Doctor Group Id here>,					-- Optional
	@PatientChart# = '<Enter Patient Chart Number Here>'				-- Optional
	@PatientFirstName = '<Enter Patient First Name Here>'				-- Optional
	@PatientMiddleName = '<Enter Patient Middle Name Here>'				-- Optional
	@PatientLastName = '<Enter Patient Last Name Here>'					-- Optional
	@PatientDOB = '<Enter Patient DOB (MM/dd/yyyy) Here>',				-- Optional
	@PatientPreferredPhone# = '<Enter Patient Preferred Phone Here>'	-- Optional
	GO
*/
@DoctorCompany# INT=NULL, 
@DoctorGroup# INT=NULL,
@PatientChart# VARCHAR(50)=NULL,
@PatientFirstName VARCHAR(50)=NULL,
@PatientMiddleName VARCHAR(50)=NULL,
@PatientLastName VARCHAR(50)=NULL,
@PatientDOB	VARCHAR(50)=NULL,
@PatientPreferredPhone# VARCHAR(20)=NULL
AS
	IF @PatientDOB IS NOT NULL
		SET @PatientDOB = CONVERT(VARCHAR(20),CAST(@PatientDOB AS DATETIME),101)
	SELECT DISTINCT TOP 100 
	dc.dc_id DoctorCompany#,
	dc.dc_name DoctorCompany,
	dg.dg_id DoctorGroup#,
	dg.dg_name DoctorGroup,
	pat.pa_id RxNTPatientId,
	pat.pa_ssn PatientChart#,
	pa_first PatientFirstName,
	pa_middle PatientMiddleName,
	pa_last PatientLastName,
	pa_dob PatientDOB,
	CASE	WHEN pe.pref_phone = 1 THEN pat.pa_phone
			WHEN pe.pref_phone = 2 THEN pe.cell_phone
			WHEN pe.pref_phone = 3 THEN pe.work_phone
			WHEN pe.pref_phone = 4 THEN pe.other_phone END  PatientPreferredPhone
	FROM patients pat WITH(NOLOCK)
	LEFT OUTER JOIN patient_extended_details pe WITH(NOLOCK) ON pat.pa_id = pe.pa_id
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.dg_id = dg.dg_id
	INNER JOIN doc_companies dc WITH(NOLOCK) ON dg.dc_id = dc.dc_id
	WHERE (@DoctorCompany# IS NULL OR dc.dc_id = @DoctorCompany#)
	AND  (@DoctorGroup# IS NULL OR dg.dg_id = @DoctorGroup#)
	AND  (@PatientChart# IS NULL OR pat.pa_ssn LIKE @PatientChart#+'%')
	AND  (@PatientFirstName IS NULL OR pat.pa_first LIKE @PatientFirstName+'%')
	AND  (@PatientMiddleName IS NULL OR pat.pa_middle LIKE @PatientMiddleName+'%')
	AND  (@PatientLastName IS NULL OR pat.pa_last LIKE @PatientLastName+'%')
	AND  (@PatientDOB IS NULL OR  CONVERT(VARCHAR(20),pat.pa_dob,101) = @PatientDOB)
	AND  (@PatientPreferredPhone# IS NULL OR(pe.pref_phone>0 AND ( pe.pref_phone = 1 AND pat.pa_phone LIKE @PatientPreferredPhone# + '%')
                  OR(pe.pref_phone = 2 AND pe.cell_phone LIKE @PatientPreferredPhone# + '%')
                  OR(pe.pref_phone = 3 AND pe.work_phone LIKE @PatientPreferredPhone# + '%')
                  OR(pe.pref_phone = 4 AND pe.other_phone LIKE @PatientPreferredPhone# + '%')))
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
