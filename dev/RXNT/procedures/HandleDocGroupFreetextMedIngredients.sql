SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Kalimuthu
-- Create date: 2019/09/25
-- Description:	Create, Read, Update and Delete doctor group free text medication ingredients
-- =============================================
CREATE PROCEDURE [dbo].[HandleDocGroupFreetextMedIngredients]
	@Action VARCHAR(6),
	@CompIngredient VARCHAR(200) = NULL,
	@StrengthValue VARCHAR(10) = NULL,
	@StrengthUnitId INT = NULL,
	@StrengthUnitName VARCHAR(50) = NULL,
	@StrengthFormId INT = NULL,
	@StrengthFormName VARCHAR(50) = NULL,
	@Qty VARCHAR(50) = NULL,
	@QtyUnitId INT = NULL,
	@QtyUnitName VARCHAR(50) = NULL,
	@DGFMId BIGINT = NULL,
	@DrugId INT = NULL,
	@IngredientDrugId INT = NULL,
	@DrugLevel INT = NULL,
	@DGFMIId BIGINT = NULL,
	@DGId BIGINT = NULL

AS
BEGIN
	SET NOCOUNT ON;
	If @Action='Insert'   --used to insert records  
		Begin  
			-- The below condtion added for avoiding duplicate ingredients when we are adding it from PartnerWS API or ENclara API
			IF NOT EXISTS(SELECT * FROM doc_group_freetext_med_ingredients WHERE dgfm_id=@DGFMId AND drug_id=@DrugId AND comp_ingredient=@CompIngredient)
			BEGIN
				--
				IF ISNULL(@QtyUnitId,0)<=0 
				BEGIN
					SELECT TOP 1 @QtyUnitId=dqu_id FROM drug_quantity_units WITH(NOLOCK) WHERE dqu_text=ISNULL(@QtyUnitName,'Unspecified')
					IF ISNULL(@QtyUnitId,0)<=0 
					BEGIN
						SELECT TOP 1 @QtyUnitId=dqu_id FROM drug_quantity_units WITH(NOLOCK) WHERE dqu_text='Unspecified'
					END
				END
				
				IF ISNULL(@StrengthUnitId,0)<=0 
				BEGIN
					SELECT TOP 1 @StrengthUnitId=dsu_id FROM drug_strength_units WITH(NOLOCK) WHERE dsu_text=@StrengthUnitName
				END
				
				IF ISNULL(@StrengthFormId,0)<=0 
				BEGIN
					SELECT TOP 1 @StrengthFormId=dsf_id FROM drug_strength_forms WITH(NOLOCK) WHERE dsf_text=@StrengthFormName
				END

				insert Into doc_group_freetext_med_ingredients (dgfm_id,drug_id,ingredient_drug_id,drug_level,comp_ingredient,strength_value,strength_unit_id,strength_form_id,qty,qty_unit_id,created_date)
				values(@DGFMId,@DrugId,@IngredientDrugId,@DrugLevel,@CompIngredient,@StrengthValue,@StrengthUnitId,@StrengthFormId,@Qty,@QtyUnitId, GETDATE())
			END
		End    
	else if @Action='Select' AND (@DGFMId > 0 OR @DrugId > 0)   --used to Select records  
		Begin  
			select *, b.dsf_id, b.dsf_text, c.dsu_id, c.dsu_id, d.dqu_id, d.dqu_text from 
			doc_group_freetext_med_ingredients a left join drug_strength_forms b on a.strength_form_id = b.dsf_id
			left join drug_strength_units c on a.strength_unit_id = c.dsu_id left join drug_quantity_units d on a.qty_unit_id = d.dqu_id
			where a.is_active=1 and (@DGFMId is NULL or a.dgfm_id=@DGFMId) and (@DrugId is NULL or a.drug_id=@DrugId); 
		End  
	else if @Action='Update'  --used to update records  
		Begin  
		   update doc_group_freetext_med_ingredients set ingredient_drug_id=@IngredientDrugId, drug_level=@DrugLevel, 
		   comp_ingredient=@CompIngredient,strength_value=@StrengthValue,
		   strength_unit_id=@StrengthUnitId,strength_form_id=@StrengthFormId,
		   qty=@Qty,qty_unit_id=@QtyUnitId,last_modified_date=GETDATE() where dgfmi_id=@DGFMIId  
		 End  
	 Else If @Action='Delete'  --used to delete records  
		 Begin  
		  update doc_group_freetext_med_ingredients set is_active=0 where dgfmi_id=@DGFMIId    
		 End
		 

	 if (@Action='Insert' OR @Action='Update' OR @Action='Delete')
		Begin
		Declare @DrugLevelMax Int;
			select @DrugLevelMax=MIN(drug_level) from doc_group_freetext_med_ingredients where drug_id = @DrugId AND drug_level>=2;
			SET @DrugLevelMax=ISNULL(@DrugLevelMax,0)
			update RMIID1 set MED_REF_DEA_CD=@DrugLevelMax where MEDID=@DrugId;
			update RNMMIDNDC set MED_REF_DEA_CD=@DrugLevelMax where MEDID=@DrugId;
		End

	 
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
