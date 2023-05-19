SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [eRx2019].[usp_SearchDisabledPrescribers] 
AS
BEGIN
	DECLARE @PartnerId INT=262144,  
	@version VARCHAR(50)='v6.1'

	SELECT dr_username Username,A.dr_id Doctorid,dr_first_name DocFirstName,dr_last_name DocLastName,dr_middle_initial DocMiddleName,dr_dea_numb DEA,dr_dea_suffix DEASuffix, 
		NPI,dr_lic_numb LIC,spi_id SPI,dr_address1 Address1,dr_address2 Address2,dr_city City,dr_state State,dr_zip Zip,ss_enable IsSurescriptsEnabled,
		dr_phone Phone,dr_email Email,dr_fax Fax,dg_name ClinicName,D.dr_service_level ServiceLevel--,A.beta_tester userlevel,B.beta_tester grouplevel 
	FROM doctors A WITH(NOLOCK) 
	INNER JOIN doc_groups B WITH(NOLOCK) on A.dg_id=B.dg_id 
	INNER JOIN doc_admin D WITH(NOLOCK) on A.dr_id=D.dr_id 
	INNER JOIN doc_companies C WITH(NOLOCK) on B.dc_id=C.dc_id 
	WHERE NOT(spi_id IS NULL) AND dr_enabled = 0 And ss_enable = 1 AND D.dr_partner_participant = @PartnerId AND prescribing_authority>2 AND update_date > getdate()-1
                             
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
