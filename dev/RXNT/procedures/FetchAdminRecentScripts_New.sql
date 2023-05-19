SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Thomas K
-- Create date: 2008/1/15
-- Description:	Fetch Admin Recent scripts
-- =============================================
CREATE PROCEDURE [dbo].[FetchAdminRecentScripts_New]
	@daysBack int,@iadminCompanyId int = 0,@sDrFirstName varchar(50)='',@sDrLastName varchar(50) ='',@iPharmid int =0
AS
BEGIN	
	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 2000;
	DECLARE @WHERECLAUSE VARCHAR(1500)
	DECLARE @SELECTTOP VARCHAR(1500)
	SET @WHERECLAUSE = ''
	SET @SELECTTOP = 'SELECT TOP 50'
	SET @WHERECLAUSE = ' WHERE prescriptions.pres_entry_date > GETDATE()- ' + convert(varchar(20),@daysBack) + ' AND queued_date > GETDATE()- ' + convert(varchar(20),@daysBack) + '
		   AND pres_approved_date IS NOT NULL AND pres_void = 0
			 AND dbo.prescriptions.sfi_is_sfi = 0 '
	IF @iadminCompanyId > 1
	BEGIN
		SET @WHERECLAUSE =  @WHERECLAUSE + ' AND ADMIN_COMPANY_ID=' + convert(varchar(20),@iadminCompanyId)
	END
	
	IF @sDrFirstName <> '' 
	BEGIN
		SET @WHERECLAUSE = @WHERECLAUSE + ' AND DR_FIRST_NAME LIKE ''' + @sDrFirstName +'%'''
	END
	IF @sDrLastName <> '' 
	BEGIN
		SET @WHERECLAUSE = @WHERECLAUSE + ' AND DR_LAST_NAME LIKE ''' + @sDrLastName +'%'''
	END
	IF @sDrLastName <> '' And @sDrFirstName <> '' 
	BEGIN
		SET @SELECTTOP = 'SELECT '
	END
		EXEC (@SELECTTOP + ' dbo.doctors.dr_last_name, dbo.doctors.dr_first_name, dbo.patients.pa_id, dbo.patients.pa_first, dbo.patients.pa_middle, dbo.patients.pa_last, 
		  prescriptions.pres_id, prescriptions.pres_entry_date, response_type, response_date, prescriptions.dr_id, 
		  prescriptions.pharm_id, delivery_method, prescriptions.pres_approved_date, prescriptions.pres_void, 
		  pharmacies.pharm_company_name, pharmacies.pharm_phone, prescription_status.queued_date,
		  CASE WHEN pharmacies.pharm_id IS NULL THEN ''Print-Only'' ELSE pharm_fax END pharm_fax, 
		  response_text, admin_notes, prescriptions.pres_delivery_method, prescription_details.pd_id, drug_name, dosage,
		  duration_amount, duration_unit, numb_refills, dbo.prescription_details.comments, use_generic,admin_company_id
		FROM dbo.prescriptions WITH(NOLOCK)INNER JOIN dbo.prescription_details WITH(NOLOCK) ON dbo.prescriptions.pres_id = dbo.prescription_details.pres_id
		  INNER JOIN prescription_status WITH(NOLOCK) ON prescription_details.pd_id = prescription_status.pd_id INNER JOIN
		  dbo.patients WITH(NOLOCK) ON prescriptions.pa_id = dbo.patients.pa_id INNER JOIN
		  dbo.doctors WITH(NOLOCK) ON prescriptions.dr_id = dbo.doctors.dr_id INNER JOIN DOC_GROUPS dg WITH(NOLOCK) ON dbo.doctors.dg_id=dg.dg_id
		 inner join doc_companies dc WITH(NOLOCK) on dg.dc_id=dc.dc_id LEFT OUTER JOIN
		  pharmacies ON pharmacies.pharm_id = prescriptions.pharm_id' +  @WHERECLAUSE  +
		' order by queued_date desc	')	

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
