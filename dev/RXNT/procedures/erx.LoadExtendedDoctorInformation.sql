SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 10-AUG-2017
-- Description:	To get the doctor extended information
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [erx].[LoadExtendedDoctorInformation]
	@DoctorId BIGINT
AS

BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 dr_lic_numb, D.lab_enabled, D.dr_speciality_code, dc.emr_modules,dc.show_email, dc.dc_settings, dg.emr_modules dg_modules,
	D.hipaa_agreement_acptd, D.dr_agreement_acptd, dr_dea_hidden, dc_name, dg_name, dr_lic_state, dr_sig_file,
	spi_id, ss_enable, billing_enabled, dr_dea_suffix, X.speciality_id 
	FROM doctors D WITH(NOLOCK) 
	INNER JOIN doc_groups DG WITH(NOLOCK) ON D.dg_id = DG.dg_id 
	INNER JOIN doc_companies dc ON dg.dc_id = dc.dc_id 
	LEFT OUTER JOIN doctor_specialities_xref x  WITH(NOLOCK)  ON d.dr_id = X.dr_id  WHERE D.dr_id = @DoctorId
    
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
