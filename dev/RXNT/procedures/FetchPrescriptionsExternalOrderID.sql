SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FetchPrescriptionsExternalOrderID]
	(@externalOrderId AS VARCHAR(200),
	@DoctorCompanyId BIGINT = NULL)
AS
BEGIN
	SELECT P.PRES_ID, P.PRES_ENTRY_DATE, P.PRES_APPROVED_DATE, P.PRES_VOID,P.ELIGIBILITY_CHECKED, P.ELIGIBILITY_TRANS_ID, P.PRINT_OPTIONS, 
	P.PRES_VOID_CODE, P.IS_SIGNED,P.PRES_PRESCRIPTION_TYPE, P.PRES_DELIVERY_METHOD, P.PRES_VOID_COMMENTS, P.ADMIN_NOTES,P.PHARM_ID, P.PA_ID, 
	P.DR_ID, P.PRIM_DR_ID, P.AUTHORIZING_DR_ID, P.PRES_START_DATE, P.PRES_END_DATE,PD.PD_ID, PD.DDID, PD.DRUG_NAME, PD.DOSAGE, PD.USE_GENERIC, PD.NUMB_REFILLS, 
	CASE WHEN PD.REFILLS_PRN IS NULL THEN 0 ELSE PD.REFILLS_PRN END REFILLS_PRN,PD.DURATION_AMOUNT, PD.DURATION_UNIT, PD.COMMENTS, PD.PRN,
	PD.INCLUDE_IN_PRINT, PD.DAYS_SUPPLY, PD.INCLUDE_IN_PHARM_DELIVER, PD.SCRIPT_GUIDE_STATUS, PD.SCRIPT_GUIDE_ID, PD.AS_DIRECTED, PD.ICD9,  PD.PRN_DESCRIPTION, 
	PD.COMPOUND, PD.SCRIPT_GUIDE_STATUS, PD.SCRIPT_GUIDE_ID, PD.INCLUDE_IN_PRINT, PD.INCLUDE_IN_PHARM_DELIVER,
	case when med_strength is null then '' else med_strength end [DrugStrength],
	case when med_strength_uom is null then '' else med_strength_uom end DrugUnit,
	case when drugType = '1' or drugType = '4' Then 'Generic' 
		when drugType = '2' or drugType = '3' then 'Brand' 
		else 'other' 
	end [DrugType],
	case when rxType = '1' Then 'Rx' 
		when rxType = '2' Then 'OTC' 
		else 'Other' 
	end [RxType],
	RxNormId
	FROM PRESCRIPTIONS P  WITH(NOLOCK) 
	INNER JOIN PATIENTS PT WITH(NOLOCK)  ON P.PA_ID = PT.PA_ID
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = PT.dg_id
	INNER JOIN PRESCRIPTION_DETAILS PD WITH(NOLOCK)  ON P.PRES_ID = PD.PRES_ID
	INNER JOIN PRESCRIPTION_EXTERNAL_INFO PEI WITH(NOLOCK) ON PD.PRES_ID=PEI.PRES_ID
		LEFT OUTER JOIN
	(
		SELECT cast(RM1.MEDID As varchar(20)) MEDID, 
		min(case when RM1.med_strength is null then '' ELSE RM1.med_strength end) med_strength,
		min(case when RM1.med_strength_uom is null then '' ELSE RM1.med_strength_uom end) med_strength_uom,
		MIN(cast((case when RM.NDC is null then '' else RM.NDC END) As varchar(20))) NDC,
		min(cast(med_ref_gen_drug_name_cd As varchar(10))) drugType,
		MIN(cast(MED_REF_FED_LEGEND_IND As varchar(10))) rxtype,
		min(cast(EVD_EXT_VOCAB_ID As Varchar(20))) RxNormId
			FROM RMIID1 RM1 with(nolock)
			inner join REVDEL0 R1 WITH(NOLOCK) 
			on cast(R1.EVD_FDB_VOCAB_ID As varchar(20)) = cast(RM1.MEDID AS Varchar(20))
			inner join REVDVT0 R2 WITH(NOLOCK) on R1.EVD_EXT_VOCAB_TYPE_ID=R2.EVD_VOCAB_TYPE_ID 
			left outer join RMINDC1 RM WITH(NOLOCK) on RM1.medid = RM.medid
			INNER JOIN RNDC14 RN WITH(NOLOCK) ON RM.NDC = RN.NDC
			GROUP BY cast(RM1.MEDID As varchar(20))
	)ND ON PD.DDID = ND.MEDID
	WHERE dg.dc_id=@DoctorCompanyId AND  PEI.external_order_id=@externalOrderId  AND P.PRES_VOID = 0 AND P.PRES_APPROVED_DATE IS NOT NULL
	--AND PEI.external_source_syncdate IS NULL
	
	UPDATE PEI SET external_source_syncdate=GETDATE() 
	FROM PRESCRIPTION_EXTERNAL_INFO PEI WITH(NOLOCK) 
	INNER JOIN PRESCRIPTIONS P  WITH(NOLOCK) ON PEI.pres_id = P.pres_id 
	INNER JOIN PATIENTS PT WITH(NOLOCK)  ON P.PA_ID = PT.PA_ID
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id = PT.dg_id
	WHERE dg.dc_id=@DoctorCompanyId AND external_order_id=@externalOrderId AND external_source_syncdate IS NULL
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
