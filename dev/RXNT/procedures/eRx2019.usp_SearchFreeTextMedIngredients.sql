SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 2018/07/22
-- Description: To get the freetext med ingredients
-- Modified By :  
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_SearchFreeTextMedIngredients]--[eRx2019].[usp_SearchFreeTextMedIngredients]16074,15254
	@DrugId BIGINT,
	@DoctorCompanyId BIGINT
AS  

  
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT  
		dgfmi.[comp_ingredient] Ingredient
      ,dsf.NCIt_unit_code StrengthFormCode
      ,dgfmi.[strength_value] StrengthValue
      ,dsu.NCIt_unit_code  StrengthUnitCode
      ,dgfmi.[qty] QuantityValue
      ,dqu.NCIt_unit_code QuantityUnitCode
      ,dgfmi.drug_level DrugLevel
	FROM [dbo].[doc_group_freetext_med_ingredients] dgfmi WITH(NOLOCK)
	LEFT OUTER JOIN [dbo].drug_strength_forms dsf WITH(NOLOCK) ON dgfmi.strength_form_id=dsf.dsf_id
	LEFT OUTER JOIN [dbo].drug_strength_units dsu WITH(NOLOCK) ON dgfmi.strength_unit_id=dsu.dsu_id
	LEFT OUTER JOIN [dbo].drug_quantity_units dqu WITH(NOLOCK) ON dgfmi.qty_unit_id=dqu.dqu_id
	INNER JOIN [dbo].[doc_group_freetext_meds] dgfm WITH(NOLOCK) ON dgfmi.drug_id=dgfm.drug_id
	INNER JOIN [dbo].[doc_groups] dg WITH(NOLOCK) ON dg.dg_id=dgfm.dg_id
	WHERE dgfmi.drug_id = @DrugId AND dg.dc_id=@DoctorCompanyId AND dgfmi.[is_active]=1
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
