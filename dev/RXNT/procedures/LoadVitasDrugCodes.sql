SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Reiah
Create date			:	21-July-2017
Description			:	
Last Modified By	:	
Last Modifed Date	:	
=======================================================================================
*/

CREATE PROCEDURE [dbo].[LoadVitasDrugCodes]
	-- Add the parameters for the stored procedure here
	@pd_id int = 0
AS
BEGIN

	SELECT TOP 1 DR.code DrugRouteCode,DA.code DrugAction_Code,DF.code DrugFormulation_Code,DFR.code DrugFrequency_Code,DI.code DrugIndication_Code
	FROM prescriptions PRES WITH(NOLOCK) 
		INNER JOIN prescription_details PD WITH(NOLOCK) ON pd.pres_id = pres.pres_id
		INNER JOIN prescription_sig_details PSD WITH(NOLOCK) ON  psd.pd_id =  pd.pd_id
		LEFT OUTER JOIN doc_group_drug_route DR  WITH(NOLOCK)   ON pres.dg_id = DR.dg_id AND PSD.sig_route = DR.description
		LEFT OUTER JOIN doc_group_drug_action DA  WITH(NOLOCK) ON pres.dg_id = DA.dg_id  AND PSD.sig_route = DA.description
		LEFT OUTER JOIN doc_group_drug_formulation DF WITH(NOLOCK)  ON pres.dg_id = DF.dg_id AND PSD.sig_route = DF.description
		LEFT OUTER JOIN doc_group_drug_frequency DFR  WITH(NOLOCK) ON pres.dg_id = DFR.dg_id AND PSD.sig_route = DFR.description
		LEFT OUTER JOIN doc_group_drug_indication DI  WITH(NOLOCK)  ON pres.dg_id = DI.dg_id AND PSD.sig_route= DI.description
	WHERE PD.pd_id = @pd_id

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
