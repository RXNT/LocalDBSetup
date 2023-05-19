SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [erxd].[usp_SearchUpdatedProviders] 
	@PartnerId  BIGINT
AS
BEGIN

	SELECT dr_username,A.dr_id,dr_first_name,dr_last_name,dr_middle_initial,dr_dea_numb,dr_dea_suffix,
			 npi,dr_lic_numb,spi_id,dr_address1,dr_address2,dr_city,dr_state,dr_zip,ss_enable,
			 dr_phone,dr_email,dr_fax,dg_name,D.dr_service_level,A.beta_tester userlevel,B.beta_tester grouplevel 
			 FROM doctors A WITH(NOLOCK) inner join doc_groups B WITH(NOLOCK) on A.dg_id=B.dg_id 
			 inner join doc_admin D WITH(NOLOCK) on A.dr_id=D.dr_id inner join doc_companies C WITH(NOLOCK) 
			 on B.dc_id=C.dc_id where NOT(spi_id Is Null) And dr_enabled = 1 And 
			 D.dr_partner_participant =  @PartnerId and prescribing_authority>2 and dr_service_level > 0 and 
			 update_date > getdate()-1 AND report_date < update_date
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
