SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 10/9/2007
-- Description:	Runs the report with the given parameters
-- =============================================
CREATE PROCEDURE [dbo].[GenerateReport]	
	@DGID INT, @MAINDRID INT, @PRIMDRID INT, @bUsePrimDocFilter BIT, @dtStartDate DateTime, @dtEndDate DateTime,
    @bComplianceReport BIT, @sPatFirstName varchar(50), @sPatLastName varchar(50), @sDrugName varchar(80), 
	@pdidColl varchar(100), @nPharmacyId INT, @bDebug bit = 0
AS
BEGIN
	DECLARE @tSQL nvarchar(4000);
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/* Decide if its a compliance report */
	IF (@bComplianceReport = 1)
		BEGIN
			select @tsql = ' SELECT prescriptions.dr_id, prescriptions.pres_void, B.dr_last_name, B.dr_first_name, pa_last, pa_first, pa_dob, pres_approved_date, pharm_company_name, pharm_address1, pharm_city, pharm_state, pharm_zip, pharm_phone, pd_id,drug_name, dosage, comments, duration_amount, duration_unit, numb_refills, use_generic, ' +
                           ' prescriptions.pres_read_date, prescriptions.pres_id, prescriptions.prim_dr_id, Z.dr_last_name prim_dr_last_name, Z.dr_first_name prim_dr_first_name, pres_delivery_method  FROM  dbo.prescriptions INNER JOIN dbo.doctors B ON dbo.prescriptions.dr_id = B.dr_id inner join dbo.prescription_details on dbo.prescriptions.pres_id = dbo.prescription_details.pres_id LEFT OUTER JOIN dbo.doctors Z ON dbo.prescriptions.prim_dr_id = Z.dr_id INNER JOIN dbo.patients C ON dbo.prescriptions.pa_id = C.pa_id LEFT OUTER JOIN dbo.pharmacies D ON dbo.prescriptions.pharm_id = D.pharm_id WHERE dbo.prescriptions.pres_approved_date > (SELECT report_print_date FROM dbo.doctors WHERE dr_id = @drid) AND pres_approved_date IS NOT NULL AND prescriptions.dr_id = @drid ORDER BY pres_approved_date DESC, pa_last, pa_first'
		END
	ELSE
		BEGIN
			select @tsql = ' SELECT prescriptions.dr_id, prescriptions.pres_void, B.dr_last_name, B.dr_first_name, pa_last, pa_first, pa_dob, pres_approved_date, pharm_company_name, pharm_address1, pharm_city, pharm_state, pharm_zip, pharm_phone, pd_id,drug_name, dosage, comments, duration_amount, duration_unit, numb_refills, use_generic, ' +
                           ' prescriptions.pres_read_date, prescriptions.pres_id, prescriptions.prim_dr_id, Z.dr_last_name prim_dr_last_name, Z.dr_first_name prim_dr_first_name, pres_delivery_method  FROM   dbo.prescriptions INNER JOIN dbo.doctors B ON dbo.prescriptions.dr_id = B.dr_id inner join dbo.prescription_details on dbo.prescriptions.pres_id = dbo.prescription_details.pres_id LEFT OUTER JOIN dbo.doctors Z ON dbo.prescriptions.prim_dr_id = Z.dr_id INNER JOIN dbo.patients C ON dbo.prescriptions.pa_id = C.pa_id LEFT OUTER JOIN dbo.pharmacies D ON dbo.prescriptions.pharm_id = D.pharm_id WHERE ' +
						   ' PRESCRIPTIONS.PRES_APPROVED_DATE BETWEEN @dtstart AND @dtend AND PRESCRIPTIONS.PRES_APPROVED_DATE IS NOT NULL '
			/* Report at group or doctor level */
			IF @MAINDRID = -1
				BEGIN
					SELECT @tsql = @tsql + ' AND  dbo.prescriptions.dg_id = @dgid'
				END
			ELSE
				BEGIN
					SELECT @tsql = @tsql + ' AND  dbo.prescriptions.dr_id = @drid'
				END
			/* Apply Primary Doctor Filter */
			IF (@bUsePrimDocFilter = 1)	
				BEGIN
					IF @PRIMDRID <= 0	
						BEGIN	
							SELECT @tsql = @tsql + ' and dbo.prescriptions.prim_dr_id <> 0 '
						END
					ELSE
						BEGIN
							SELECT @tsql = @tsql + ' and dbo.prescriptions.prim_dr_id = @primdrid '
						END
				END		
			IF len(@sPatFirstName) > 0
				BEGIN
					SELECT @tsql = @tsql + ' and C.pa_first like @pafirst'
				END
			IF len(@sPatLastName) > 0
				BEGIN
					SELECT @tsql = @tsql + ' and C.pa_last like @palast'
				END
			IF len(@sDrugName) > 0
				BEGIN
					SELECT @tsql = @tsql + ' and drug_name like @drugname'
				END
			IF len(@pdidColl) > 0
				BEGIN
					SELECT @tsql = @tsql + ' and dbo.prescription_details.pd_id in (' + @pdidcoll + ')'
				END
			IF @nPharmacyId > 0
				BEGIN
					SELECT @tsql = @tsql + ' and dbo.prescriptions.pharm_id = @pharmid'
				END
				
		END    
	/* If debug is on, print a message por-favor */
	IF (@bDebug = 1)	
		BEGIN
			Print @tsql		
		END
	Exec sp_executesql @tsql , N'@drid int, @dtstart datetime, @dtend datetime, @dgid int, @primdrid int, @pafirst varchar(50), @palast varchar(50), @drugname varchar(80), @pharmid int', @MAINDRID, @dtStartDate, @dtEndDate, @DGID, @PRIMDRID, @sPatFirstName, @sPatLastName, @sDrugName, @nPharmacyId
    RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
