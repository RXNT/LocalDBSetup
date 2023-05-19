SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff
-- Create date: 23-Aug-2019
-- Description:	Fetch the patient history Count based on parameters
-- =============================================
 CREATE   PROCEDURE [dbo].[GetPatientAllMedicationHistory] --49060076,60,'%',0,0
	@pa_id int, @num_months int,   @bActiveMedFilter bit, @bDischargeFilter bit
AS
BEGIN
	DECLARE @ParmDefinition nvarchar(500);
	DECLARE @SQLQUERY NVARCHAR(MAX)
DECLARE @startdate DATETIME

if(@num_months < 1)
begin
	set @startdate = DATEADD(MM, -24,getdate())
end
else
begin 
	set @startdate = DATEADD(MM, -@num_months,getdate())
end

	SET @SQLQUERY = ' SELECT P.PRES_ID'+
					' FROM PRESCRIPTIONS P  WITH(NOLOCK) INNER JOIN PATIENTS PT WITH(NOLOCK)  ON P.PA_ID = PT.PA_ID' +  
					' INNER JOIN PRESCRIPTION_DETAILS PD WITH(NOLOCK)  ON P.PRES_ID = PD.PRES_ID' +
					' LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON PD.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id '+ 
					' INNER JOIN DOCTORS DR  WITH(NOLOCK) ON P.DR_ID = DR.DR_ID ' + 
					' LEFT OUTER JOIN ACTIVE_DRUGS AD ON PD.DDID = AD.MEDID ' +
					' LEFT OUTER JOIN DOCTORS PRIM_DOCS ON PRIM_DOCS.dr_id = P.prim_dr_id ' +
					' LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK)  ON P.PHARM_ID = PH.PHARM_ID ' +
					' LEFT OUTER JOIN RFMLINM0 D ON PD.ICD9 = D.ICD9CM ' +
					' LEFT OUTER JOIN prescription_status PTS WITH(NOLOCK)  ON PD.PD_ID = PTS.PD_ID' + 
					' LEFT OUTER JOIN erx.RxFillRequests rxfill WITH(NOLOCK) ON P.pres_id=rxfill.PresID AND PD.FillReqId=rxfill.FillReqId' +
					' LEFT OUTER JOIN PATIENT_ACTIVE_MEDS PAM WITH(NOLOCK)  ON PD.DDID = PAM.DRUG_ID' + 
					' AND PAM.PA_ID = PT.PA_ID ' + 
					' WHERE PT.PA_ID = @paid AND P.PRES_VOID = 0 AND P.PRES_APPROVED_DATE IS NOT NULL AND P.PRES_APPROVED_DATE < @start_date ' +
					' '
					
	IF @bActiveMedFilter = 1
	BEGIN
		SET @SQLQUERY = @SQLQUERY  + ' and PAM.DRUG_ID is not null '
	END				
	IF @bDischargeFilter = 1
	BEGIN
		SET @SQLQUERY = @SQLQUERY  + ' and HISTORY_ENABLED = 1'
	END
	IF @bDischargeFilter != 1
	BEGIN				
		SET @SQLQUERY = @SQLQUERY  + ' UNION ALL ' +
					' SELECT P.pam_id AS PRES_ID '+					
					' FROM patient_medications_hx P  WITH(NOLOCK) INNER JOIN PATIENTS PT WITH(NOLOCK)  ON P.PA_ID = PT.PA_ID   ' +
					' INNER JOIN DOCTORS DR  WITH(NOLOCK) ON P.for_dr_id = DR.DR_ID   ' +
					' LEFT OUTER JOIN ACTIVE_DRUGS AD ON P.drug_id = AD.MEDID  ' +
					' LEFT OUTER JOIN PATIENT_ACTIVE_MEDS PAM WITH(NOLOCK)  ON P.DRUG_ID = PAM.DRUG_ID  ' +
					' AND PAM.PA_ID = PT.PA_ID   ' +
					' WHERE PT.PA_ID = @paid AND P.date_start < @start_date   ' 
		IF @bActiveMedFilter = 1
		BEGIN
			SET @SQLQUERY = @SQLQUERY  + ' and PAM.DRUG_ID is not null '
		END				
	END
	
	IF (@num_months > 5)
	BEGIN
	SET @SQLQUERY = '( ' + @SQLQUERY  + ' )'
	SET @SQLQUERY = @SQLQUERY + 'UNION(SELECT P.PRES_ID '+	
					' FROM PRESCRIPTIONS_ARCHIVE P  WITH(NOLOCK) INNER JOIN PATIENTS PT WITH(NOLOCK)  ON P.PA_ID = PT.PA_ID' +  
					' INNER JOIN PRESCRIPTION_DETAILS_ARCHIVE PD WITH(NOLOCK)  ON P.PRES_ID = PD.PRES_ID' + 
					' LEFT OUTER JOIN hospice_drug_relatedness hdr WITH(NOLOCK) ON PD.hospice_drug_relatedness_id = hdr.hospice_drug_relatedness_id '+ 
					' INNER JOIN DOCTORS DR  WITH(NOLOCK) ON P.DR_ID = DR.DR_ID ' + 
					' LEFT OUTER JOIN ACTIVE_DRUGS AD ON PD.DDID = AD.MEDID ' +
					' LEFT OUTER JOIN PHARMACIES PH WITH(NOLOCK)  ON P.PHARM_ID = PH.PHARM_ID ' +
					' LEFT OUTER JOIN RFMLINM0 D ON PD.ICD9 = D.ICD9CM ' +
					' LEFT OUTER JOIN prescription_status_ARCHIVE PTS WITH(NOLOCK)  ON PD.PD_ID = PTS.PD_ID' + 
					' LEFT OUTER JOIN PATIENT_ACTIVE_MEDS PAM WITH(NOLOCK)  ON PD.DDID = PAM.DRUG_ID' + 
					' AND PAM.PA_ID = PT.PA_ID ' + 
					' WHERE PT.PA_ID = @paid AND P.PRES_VOID = 0 AND P.PRES_APPROVED_DATE IS NOT NULL AND P.PRES_APPROVED_DATE < @start_date   ' 
						
	IF @bActiveMedFilter = 1
	BEGIN
		SET @SQLQUERY = @SQLQUERY  + ' and PAM.DRUG_ID is not null '
	END					
	IF @bDischargeFilter = 1
	BEGIN
		SET @SQLQUERY = @SQLQUERY  + ' and HISTORY_ENABLED = 1'
	END
	SET @SQLQUERY = @SQLQUERY  + ')'
	END

	SET @SQLQUERY = @SQLQUERY  + ' ORDER BY P.PRES_ID DESC'
					
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Check if active meds are filtered
	PRINT @SQLQUERY
	--PRINT LEN(@SQLQUERY)
	SET @ParmDefinition = N'@paid int,@start_date datetime'
	
	EXECUTE sp_executesql @SQLQUERY, @ParmDefinition,@paid=@pa_id,@start_date=@startdate
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
