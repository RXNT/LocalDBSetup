SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:  <JahabarYusuff M>    
-- Create date: <06-21-2018>    
-- Description: <Insert/Update patient Active medications  data with drug level SS-2849>    
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetDrugInfo] 
	-- Add the parameters for the stored procedure here
	@FDBMedid varchar(50),
	@Description varchar(150),
	@DGId bigint,
	@doctorId bigint,
	@drugId BIGINT OUTPUT,
	@IsIngredientsRequired BIT OUTPUT,
	@DrugLevel bigint = 0,
	@DGFMId BIGINT = NULL OUTPUT,
	@IsPreferedNameAvailable  BIT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @PAMID INT
	SET @drugId = 0
	if(@FDBMedid !='' And @FDBMedid !='0' AND @FDBMedid IS NOT NULL)
    Begin
		select @drugId=medid from RMIID1 where MEDID =   @FDBMedid 
	End
	
	If @drugId < 1
	Begin
		SELECT @drugId=medid,@DGFMId=dgfm_id from doc_group_freetext_meds DGF with(nolock) 
			inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
			where DGF.dg_id = @DGId and med_medid_desc like   @Description 
			
		If @drugId > 1
		BEGIN
			IF NOT EXISTS(select * from doc_group_freetext_meds DGF with(nolock) 
			INNER JOIN  doc_group_freetext_med_ingredients DGFI with(nolock) ON DGF.dgfm_id=DGFI.dgfm_id AND DGF.drug_id=DGFI.drug_id
			inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
			where DGF.dg_id = @DGId and DGF.drug_id=@drugId)
			BEGIN
				SET @IsIngredientsRequired=1
			END
		END
		ELSE
		BEGIN
			  
			select TOP 1 @drugId=medid,@DGFMId=dgfm_id from doc_group_freetext_meds DGF with(nolock) 
				inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
				where DGF.dg_id = @DGId and med_medid_desc like   @Description 
			
			If @drugId < 1
			BEGIN
				EXEC [dbo].[addDocGroupFreeTextMeds] @drug_name = @Description,@drug_level = @DrugLevel, @dg_id = @DGId, @added_by_dr_id =@doctorId, @drug_category = 1,@preferred_name= @IsPreferedNameAvailable
				select @drugId=medid,@DGFMId=dgfm_id from doc_group_freetext_meds DGF with(nolock)  
					inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
					where DGF.dg_id = @DGId and med_medid_desc like   @Description 
				SET @IsIngredientsRequired=1
			End
	
		END

		if ISNULL(@IsPreferedNameAvailable,0) = 1
		BEGIN
			SET @IsIngredientsRequired=0;
		END
	END
	
	return @drugId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
