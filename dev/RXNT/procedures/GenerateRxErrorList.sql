SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ganeshan Jayaraman
-- Create date: 2007-12-31
-- Description:	Generates a list of prescriptions that were erroed out
-- =============================================
CREATE PROCEDURE [dbo].[GenerateRxErrorList]	
		@DG_ID int, @delivery_type int, @bUseDeliveryType bit = 1,
		@dtstartdate datetime, @dtenddate datetime
AS
BEGIN	
	SET NOCOUNT ON;
	IF @bUseDeliveryType = 1	
		SELECT PD.PD_ID, P.PRES_ID, PA.PA_FIRST, PA.PA_LAST, PD.DRUG_NAME, P.PRES_APPROVED_DATE,
		PH.PHARM_COMPANY_NAME, PH.PHARM_ADDRESS1, PH.PHARM_CITY, PH.PHARM_STATE,
		PH.PHARM_ZIP, PH.PHARM_PHONE, PH.PHARM_FAX, PD.DOSAGE, PD.DURATION_UNIT,
		PD.DURATION_AMOUNT, PD.NUMB_REFILLS,PD.USE_GENERIC, PD.COMMENTS, PD.COMPOUND,
		DR.DR_FIRST_NAME, DR.DR_LAST_NAME
		FROM PRESCRIPTIONS P INNER JOIN PRESCRIPTION_DETAILS PD ON P.PRES_ID = PD.PRES_ID
		INNER JOIN PHARMACIES PH ON P.PHARM_ID = PH.PHARM_ID INNER JOIN
		PATIENTS PA ON P.PA_ID = PA.PA_ID INNER JOIN DOCTORS DR ON P.DR_ID = DR.DR_ID
		WHERE P.PRES_ID IN (
		select a.pres_id from 
		(select p.pres_id, min(case when pt.response_type is null then -1 else pt.response_type end) response from prescriptions p inner join prescription_details pd on
		p.pres_id = pd.pres_id inner join prescription_transmittals pt
		on pd.pd_id = pt.pd_id where pt.delivery_method = @delivery_type
		and p.pres_void=0 and p.pres_approved_date is not null
		and p.pres_approved_date between @dtstartdate and @dtenddate
		and p.dg_id = @DG_ID
		group by p.pres_id ) a where a.response = 1) order by p.pres_approved_date desc	
	ELSE	
		SELECT PD.PD_ID,P.PRES_ID, PA.PA_FIRST, PA.PA_LAST, PD.DRUG_NAME, P.PRES_APPROVED_DATE,
		PH.PHARM_COMPANY_NAME, PH.PHARM_ADDRESS1, PH.PHARM_CITY, PH.PHARM_STATE,
		PH.PHARM_ZIP, PH.PHARM_PHONE, PH.PHARM_FAX, PD.DOSAGE, PD.DURATION_UNIT,
		PD.DURATION_AMOUNT, PD.NUMB_REFILLS,PD.USE_GENERIC, PD.COMMENTS, PD.COMPOUND,
		DR.DR_FIRST_NAME, DR.DR_LAST_NAME
		FROM PRESCRIPTIONS P INNER JOIN PRESCRIPTION_DETAILS PD ON P.PRES_ID = PD.PRES_ID
		INNER JOIN PHARMACIES PH ON P.PHARM_ID = PH.PHARM_ID INNER JOIN
		PATIENTS PA ON P.PA_ID = PA.PA_ID INNER JOIN DOCTORS DR ON P.DR_ID = DR.DR_ID
		WHERE P.PRES_ID IN (
		select a.pres_id from 
		(select p.pres_id, min(case when pt.response_type is null then -1 else pt.response_type end) response from prescriptions p inner join prescription_details pd on
		p.pres_id = pd.pres_id inner join prescription_transmittals pt
		on pd.pd_id = pt.pd_id where 
		p.pres_void=0 and p.pres_approved_date is not null
		and p.pres_approved_date between @dtstartdate and @dtenddate
		and p.dg_id = @DG_ID
		group by p.pres_id ) a where a.response = 1) order by p.pres_approved_date desc
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
