SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan
-- Create date: 2007/05/18
-- Description:	Fetch the patient history based on parameters
-- =============================================
CREATE   PROCEDURE [dbo].[FetchPatientHistory] --49060076,60,'%',0,0
	@pa_id int, @num_months int,  @drugname varchar(255), @bActiveMedFilter bit, @bDischargeFilter bit
AS
BEGIN
	DECLARE @ParmDefinition nvarchar(500);
	DECLARE @SQLQUERY NVARCHAR(MAX)
DECLARE @startdate DATETIME
if(@num_months < 1)
begin
	set @startdate = DATEADD(D, DATEDIFF(D,0,getdate()), 0)
end
else
begin 
	set @startdate = DATEADD(MM, -@num_months,getdate())
end
	SET @SQLQUERY = ' SELECT P.PRES_ID, P.PRES_APPROVED_DATE AS PRES_START_DATE, P.PRES_END_DATE,P.PRIM_DR_ID,PRIM_DOCS.DR_FIRST_NAME PRIM_FIRST_NAME, PRIM_DOCS.DR_LAST_NAME PRIM_LAST_NAME,PD.PD_ID, P.PRES_APPROVED_DATE, P.PRES_PRESCRIPTION_TYPE,  PD.DRUG_NAME, PD.DOSAGE, PD.USE_GENERIC,' +
					' PD.NUMB_REFILLS, PD.DURATION_AMOUNT, PD.DURATION_UNIT, PD.PRN, PD.PRN_DESCRIPTION, PD.ICD9, PD.PAIN, PD.CANCEL_STATUS,PD.CANCEL_STATUS_TEXT,' +
					' PD.DDID, PD.days_supply, PD.COMMENTS, case when AD.IS_ACTIVE IS NULL THEN 1 ELSE AD.IS_ACTIVE END IS_ACTIVE ,PD.discharge_date, PD.discharge_desc, PD.discharge_dr_id, PD.COMPOUND, PD.HISTORY_ENABLED, D.ICD9CM_DESC100 ICD9_DESC,' +
					' DR.DR_ID,DR.DR_FIRST_NAME, DR.DR_LAST_NAME, DR.TIME_DIFFERENCE, PT.PA_FIRST, PT.PA_LAST,'+
					' PH.PHARM_ID, PH.PHARM_COMPANY_NAME, PH.PHARM_ADDRESS1, PH.PHARM_ADDRESS2, PH.PHARM_CITY, ' +
					' PH.PHARM_STATE, PH.PHARM_ZIP, PH.PHARM_PHONE, PH.PHARM_FAX,discharge_desc,discharge_date,discharge_dr_id,' +
					' PTS.RESPONSE_TYPE, PTS.RESPONSE_TEXT, PTS.RESPONSE_DATE, PTS.DELIVERY_METHOD,PTS.cancel_req_response_date,PTS.cancel_req_response_type,PTS.cancel_req_response_text,' +
					' CASE WHEN PAM.DRUG_ID IS NULL THEN 0 ELSE 1 END ACTIVE_MED ' +
					',CASE WHEN P.PRES_ID IS NULL THEN 0 ELSE 1 END  RX_TYPE '+
					',PD.order_reason AS ORDER_REASON, PD.icd9_desc AS ICD9Description, rxfill.FillStatus,rxfill.FillStatusType,rxfill.RequestDate '+
					', PD.hospice_drug_relatedness_id,hdr.Code,hdr.Description, PD.drug_indication, CASE WHEN (PH.service_level & 16 = 16 AND PH.pharm_participant > 2) THEN 1 ELSE 0 END AS IS_PHARMACY_LEVEL_HIGH '+
					', PD.has_rxfillstatus AS HasRxFillStatus, PD.rxfillstatus_filter_settings AS RxFillStatusFilter '+
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
					' WHERE PT.PA_ID = @paid AND P.PRES_VOID = 0 AND P.PRES_APPROVED_DATE IS NOT NULL AND P.PRES_APPROVED_DATE > @start_date  AND ' +
					' PD.DRUG_NAME LIKE @drug_name '
					
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
					' SELECT P.pam_id AS PRES_ID, P.date_start AS PRES_START_DATE, P.date_end AS PRES_END_DATE,P.added_by_dr_id AS PRIM_DR_ID,NULL,NULL,0, P.date_added PRES_APPROVED_DATE,3,   P.DRUG_NAME, P.DOSAGE, CAST(P.USE_GENERIC AS BIT) USE_GENERIC, ' +
					' P.NUMB_REFILLS, P.DURATION_AMOUNT, P.DURATION_UNIT, P.PRN, P.PRN_DESCRIPTION, NULL ICD9, NULL PAIN, NULL CANCEL_STATUS,NULL CANCEL_STATUS_TEXT, ' +
					' P.drug_id, P.days_supply, P.DRUG_COMMENTS, case when AD.IS_ACTIVE IS NULL THEN 1 ELSE AD.IS_ACTIVE END IS_ACTIVE,NULL discharge_date, NULL discharge_desc, NULL discharge_dr_id, CAST(ISNULL(P.COMPOUND,0) AS BIT) COMPOUND, CAST(1 AS BIT) HISTORY_ENABLED, NULL ICD9_DESC, ' +
					' DR.DR_ID,DR.DR_FIRST_NAME, DR.DR_LAST_NAME, DR.TIME_DIFFERENCE, PT.PA_FIRST, PT.PA_LAST, ' +
					' NULL PHARM_ID, NULL PHARM_COMPANY_NAME, NULL PHARM_ADDRESS1, NULL PHARM_ADDRESS2, NULL PHARM_CITY, ' +
					' NULL PHARM_STATE, NULL PHARM_ZIP, NULL PHARM_PHONE, NULL PHARM_FAX,NULL discharge_desc,NULL discharge_date,NULL discharge_dr_id, ' +
					' NULL RESPONSE_TYPE, NULL RESPONSE_TEXT, NULL RESPONSE_DATE, NULL DELIVERY_METHOD,NULL cancel_req_response_date,NULL cancel_req_response_type,NULL cancel_req_response_text, ' +
					' CASE WHEN PAM.DRUG_ID IS NULL THEN 0 ELSE 1 END ACTIVE_MED  ' +
					',CASE WHEN P.pam_id IS NULL THEN 0 ELSE 0 END  RX_TYPE'+
					',P.order_reason AS ORDER_REASON, NULL AS ICD9Description, NULL AS FillStatus,NULL AS FillStatusType,NULL AS RequestDate '+
					', NULL hospice_drug_relatedness_id, NULL Code, NULL Description,NULL drug_indication, 0 AS IS_PHARMACY_LEVEL_HIGH '+		
					', NULL HasRxFillStatus, NULL RxFillStatusFilter '+
					' FROM patient_medications_hx P  WITH(NOLOCK) INNER JOIN PATIENTS PT WITH(NOLOCK)  ON P.PA_ID = PT.PA_ID   ' +
					' INNER JOIN DOCTORS DR  WITH(NOLOCK) ON P.for_dr_id = DR.DR_ID   ' +
					' LEFT OUTER JOIN ACTIVE_DRUGS AD ON P.drug_id = AD.MEDID  ' +
					' LEFT OUTER JOIN PATIENT_ACTIVE_MEDS PAM WITH(NOLOCK)  ON P.DRUG_ID = PAM.DRUG_ID  ' +
					' AND PAM.PA_ID = PT.PA_ID   ' +
					' WHERE PT.PA_ID = @paid AND P.date_start > @start_date  AND  P.DRUG_NAME LIKE @drug_name  ' 
		IF @bActiveMedFilter = 1
		BEGIN
			SET @SQLQUERY = @SQLQUERY  + ' and PAM.DRUG_ID is not null '
		END				
	END
	
	IF (@num_months > 5)
	BEGIN
	SET @SQLQUERY = '( ' + @SQLQUERY  + ' )'
	SET @SQLQUERY = @SQLQUERY + 'UNION(SELECT P.PRES_ID, P.PRES_APPROVED_DATE AS PRES_START_DATE, P.PRES_END_DATE,P.PRIM_DR_ID,NULL,NULL,PD.PD_ID, P.PRES_APPROVED_DATE,P.PRES_PRESCRIPTION_TYPE,   PD.DRUG_NAME, PD.DOSAGE, PD.USE_GENERIC,' +
					' PD.NUMB_REFILLS, PD.DURATION_AMOUNT, PD.DURATION_UNIT, PD.PRN, PD.PRN_DESCRIPTION, PD.ICD9, PD.PAIN, PD.CANCEL_STATUS,PD.CANCEL_STATUS_TEXT,' +
					' PD.DDID, PD.days_supply, PD.COMMENTS, case when AD.IS_ACTIVE IS NULL THEN 1 ELSE AD.IS_ACTIVE END IS_ACTIVE,PD.discharge_date, PD.discharge_desc, PD.discharge_dr_id, PD.COMPOUND, PD.HISTORY_ENABLED, D.ICD9CM_DESC100 ICD9_DESC,' +
					' DR.DR_ID,DR.DR_FIRST_NAME, DR.DR_LAST_NAME, DR.TIME_DIFFERENCE, PT.PA_FIRST, PT.PA_LAST,'+
					' PH.PHARM_ID, PH.PHARM_COMPANY_NAME, PH.PHARM_ADDRESS1, PH.PHARM_ADDRESS2, PH.PHARM_CITY,' +
					' PH.PHARM_STATE, PH.PHARM_ZIP, PH.PHARM_PHONE, PH.PHARM_FAX,discharge_desc,discharge_date,discharge_dr_id,' +
					' PTS.RESPONSE_TYPE, PTS.RESPONSE_TEXT, PTS.RESPONSE_DATE, PTS.DELIVERY_METHOD,PTS.cancel_req_response_date,PTS.cancel_req_response_type,PTS.cancel_req_response_text,' +
					' CASE WHEN PAM.DRUG_ID IS NULL THEN 0 ELSE 1 END ACTIVE_MED ' +
					',CASE WHEN P.PRES_ID IS NULL THEN 0 ELSE 1 END  RX_TYPE '+
					',NULL AS ORDER_REASON, NULL AS ICD9Description, NULL AS FillStatus,NULL AS FillStatusType,NULL AS RequestDate '+
					', PD.hospice_drug_relatedness_id, hdr.Code, hdr.Description, PD.drug_indication, CASE WHEN (PH.service_level & 16 = 16 AND PH.pharm_participant > 2) THEN 1 ELSE 0 END AS IS_PHARMACY_LEVEL_HIGH '+	
					', NULL HasRxFillStatus, NULL RxFillStatusFilter '+
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
					' WHERE PT.PA_ID = @paid AND P.PRES_VOID = 0 AND P.PRES_APPROVED_DATE IS NOT NULL AND P.PRES_APPROVED_DATE > @start_date  AND ' +
					' PD.DRUG_NAME LIKE @drug_name '	
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

	SET @SQLQUERY = @SQLQUERY  + ' ORDER BY P.PRES_ID DESC, PRES_APPROVED_DATE	DESC'
					
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Check if active meds are filtered
	PRINT @SQLQUERY
	--PRINT LEN(@SQLQUERY)
	SET @ParmDefinition = N'@paid int,@drug_name varchar(255),@start_date datetime'
	
	EXECUTE sp_executesql @SQLQUERY, @ParmDefinition,@paid=@pa_id,@drug_name=@drugname,@start_date=@startdate
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
