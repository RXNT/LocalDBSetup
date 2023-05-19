SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kalimuthu
-- Create date: 10-Oct-2016
-- Description:	To search the medications
-- Modified By: -
-- Modified Date: -
-- =============================================
CREATE PROCEDURE [dbo].[usp_SearchFDBMedications]-- [dbo].[usp_SearchFDBMedications]'zoloft'
	@Name VARCHAR(50) = NULL,
	@MaxRows INT = 50
AS

BEGIN
	SET @Name = ISNULL(@Name,'')
	SET NOCOUNT ON;
	
		SELECT distinct TOP (@MaxRows) a.medid, a.med_medid_desc , a.MED_STRENGTH_UOM,b.MED_STRENGTH,d.MED_DOSAGE_FORM_ABBR,d.MED_DOSAGE_FORM_DESC,e.dsu_id,f.dsf_id,
		a.MED_REF_DEA_CD,
	PD.duration_amount,PD.duration_unit
	from rnmmidndc a WITH(NOLOCK) 
	INNER JOIN RMIID1 b  WITH(NOLOCK)  ON a.MEDID =b.MEDID
	LEFT OUTER JOIN (SELECT TOP  1 pd.* FROM prescription_details pd WITH(NOLOCK) 
	INNER JOIN prescriptions pres WITH(NOLOCK) ON pd.pres_id=pres.pres_id
	WHERE pres.pres_approved_date IS NOT NULL
	ORDER BY pd.pres_id DESC
	) PD ON PD.ddid=a.MEDID
	LEFT OUTER JOIN RMIDFID1 c  WITH(NOLOCK)  ON a.ROUTED_DOSAGE_FORM_MED_ID=c.ROUTED_DOSAGE_FORM_MED_ID
	LEFT OUTER JOIN RMIDFD1 d  WITH(NOLOCK)  ON c.MED_DOSAGE_FORM_ID=d.MED_DOSAGE_FORM_ID
	LEFT OUTER JOIN drug_strength_units e WITH(NOLOCK) ON a.MED_STRENGTH_UOM=e.dsu_text
	LEFT OUTER JOIN drug_strength_forms f WITH(NOLOCK) ON a.MED_DOSAGE_FORM_DESC=f.dsf_text
	where a.med_medid_desc like '%'+ @Name +'%' AND a.MEDID BETWEEN 0 AND 999999;
	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
