SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [phr].[usp_UpdatePatientDemographics]
	@PatientId			INT,
	@DoctorCompanyId	INT,
	@Address1 VARCHAR(100),
	@Address2 VARCHAR(100)=NULL,
	@City	  VARCHAR(50),
	@State	  VARCHAR(2),
	@ZipCode  VARCHAR(20),
	@Email  VARCHAR(80)=NULL,
	@HomePhone VARCHAR(20),
	@CellPhone VARCHAR(50) = NULL
AS
BEGIN

	UPDATE pat SET pa_address1 = @Address1,pa_address2 = @Address2, pa_city = @City, pa_state = @State,pa_zip = @ZipCode,pa_email = @Email
	FROM patients pat WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pat.pa_id = dg.dg_id
	WHERE pat.pa_id =  @PatientId AND dg.dg_id = @DoctorCompanyId 

	UPDATE pe SET cell_phone = @CellPhone
	FROM patient_extended_details pe WITH(NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON pe.pa_id = dg.dg_id
	WHERE pe.pa_id =  @PatientId AND dg.dg_id = @DoctorCompanyId 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
