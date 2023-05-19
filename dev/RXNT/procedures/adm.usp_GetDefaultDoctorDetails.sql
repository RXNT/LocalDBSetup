SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
======================================================================================= 
Author				: Ramak krishna 
Create date			: 16-Feb-2017
Description			: To get default doctor details
Last Modified By	: 
Last Modifed Date	: 
======================================================================================= 
*/ 
CREATE PROCEDURE [adm].[usp_GetDefaultDoctorDetails] 
	@DoctorCompanyId	INT
	
	
AS 
BEGIN 
	IF(@DoctorCompanyId > 0)
	BEGIN		
		select top 1 d.dr_id, dg.dg_id,d.dr_prefix, d.dr_first_name, d.dr_last_name, 
		d.dr_middle_initial, d.dr_suffix,d.dr_address1, d.dr_address2, d.dr_city, 
		d.dr_state, d.dr_zip, d.dr_phone, d.dr_phone_alt1, d.dr_phone_alt2,
		d.dr_phone_emerg, d.dr_fax,dr_email,d.prescribing_authority,d.dr_lic_state, 
		d.office_contact_email, d.office_contact_name, d.office_contact_phone
		from doctors d
		left outer join doc_groups dg with(nolock) on d.dg_id= dg.dg_id
		WHERE dg.dc_id=@DoctorCompanyId and dr_enabled=1
		order by d.dr_id
	END	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
