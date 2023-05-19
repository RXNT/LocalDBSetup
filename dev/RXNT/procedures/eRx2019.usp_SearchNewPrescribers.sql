SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [eRx2019].[usp_SearchNewPrescribers] 
AS
BEGIN
	DECLARE @PartnerId INT=262144,  
	@version VARCHAR(50)='v6.1'

	UPDATE doctors SET ss_enable=1 
	WHERE dr_id IN (SELECT A.dr_id FROM doctors A WITH(NOLOCK) 
	INNER JOIN doc_admin B WITH(NOLOCK) on A.dr_id=B.dr_id 
	WHERE dr_enabled=1 and ss_enable=0 and not(spi_id is null) and prescribing_authority>=3 
	AND dr_service_level > 0 and dr_partner_participant= @PartnerId AND report_date > GETDATE()-360 AND report_date <= GETDATE()-1)
                                  
	SELECT dr_username Username,A.dr_id Doctorid,dr_first_name DocFirstName,dr_last_name DocLastName,dr_middle_initial DocMiddleName,dr_dea_numb DEA,dr_dea_suffix DEASuffix,
                             NPI,dr_lic_numb LIC,spi_id SPI,dr_address1 Address1,dr_address2 Address2,dr_city City,dr_state State,dr_zip Zip,ss_enable IsSurescriptsEnabled,
                             dr_phone Phone,dr_email Email,dr_fax Fax,dg_name ClinicName,D.dr_service_level ServiceLevel,--,A.beta_tester userlevel,B.beta_tester grouplevel 
							 CASE WHEN EXISTS(SELECT * FROM doc_company_themes ct WITH(NOLOCK) WHERE ct.dc_id=c.dc_id AND ct.theme_id=1) THEN 1 ELSE 0 END AS IsRevoUser
                             FROM doctors A WITH(NOLOCK) 
                             inner join doc_groups B WITH(NOLOCK) on A.dg_id=B.dg_id 
                             inner join doc_admin D WITH(NOLOCK) on A.dr_id=D.dr_id 
                             inner join doc_companies C WITH(NOLOCK) 
                             on B.dc_id=C.dc_id where (spi_id Is Null) And dr_enabled = 1 And ss_enable = 0 And 
                             D.dr_partner_participant = @PartnerId and prescribing_authority>2 and 
                             dr_service_level > 0 and LEN(npi) = 10 
							 AND A.DR_ID=118302--ONLY FOR DEV TESTING THIS SHOULD NOT CHECKIN
                             
                             
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
