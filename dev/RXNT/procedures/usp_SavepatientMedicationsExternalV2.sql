SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================    
-- Author:  <JahabarYusuff M>    
-- Create date: <06-21-2018>    
-- Description: <Insert/Update patient medications external data with drug level SS-2849>     
-- =============================================    
CREATE PROCEDURE [dbo].[usp_SavepatientMedicationsExternalV2]     
 -- Add the parameters for the stored procedure here   
 @dr_id				INT,
 @dg_id				INT,
 @dc_id				INT,
 @pa_id				INT,
 @rx_number			VARCHAR(50),
 @ddid				int,
 @drug_name			varchar(150),
 @ndc				varchar(11),
 @dosage				varchar(255),
 @use_generic		bit,
 @numb_refills		int,
 @days_supply		int,
 @duration_amount	varchar(15),
 @duration_unit		varchar(80),
 @comments			varchar(255),
 @prn				bit,
 @history_enabled	bit,
 @RecordId			int OUTPUT,
 @DrugLevel bigint = 0
   
AS    
BEGIN   
 -- SET NOCOUNT ON added to prevent extra result sets from    
 -- interfering with SELECT statements.    
 SET NOCOUNT ON;   
 DECLARE	@SOURCE			varchar(250)

 Declare @drugId varchar(50)
 
 SET	@SOURCE = 'Enclara'
 SET	@drugId = 0
 
	if(@ddid!='' And @ddid IS NOT NULL)
    Begin
		select @drugId=medid from RMIID1 where MEDID =   @ddid 
	End
	
	If @drugId < 1
	Begin
		select @drugId=medid from doc_group_freetext_meds DGF with(nolock) 
			inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
			where DGF.dg_id = @dg_id and med_medid_desc like   @drug_name 
	End
	
	If @drugId < 1
	BEGIN
		EXEC [dbo].[addDocGroupFreeTextMeds] @drug_name,@DrugLevel,@dg_id,@dr_id,1
		select @drugId=medid from doc_group_freetext_meds DGF with(nolock) 
			inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
			where DGF.dg_id = @dg_id and med_medid_desc like   @drug_name 
	END
	
	If (@drugId is null) Or @drugId < 1 
	Begin
		SET @RecordId = 0
		return
	End 

  if(@drugId < 1)
  Begin
	SET @RecordId = 0
	return
  End
  if Exists(select pame_id from patient_active_meds_external with(nolock) where pame_pa_id=@pa_id AND pame_source_name like @SOURCE AND external_id like  @rx_number)
  Begin
	SET @RecordId = 1
		UPDATE				patient_active_meds_external
			SET 
				pame_pa_id					=			@pa_id,
				pame_comments				=			@comments,
				pame_dosage					=			@dosage,
				last_modified_date			=			GETDATE(),
				pame_duration_amount		=			@duration_amount,
				pame_duration_unit			=			@duration_unit,
				pame_numb_refills			=			@numb_refills,
				pame_days_supply			=			@days_supply
		WHERE	pame_pa_id=@pa_id AND pame_source_name like @SOURCE AND external_id like  @rx_number
	return
  End
  
  INSERT INTO patient_active_meds_external 
	(	
			pame_pa_id,				pame_drug_id,			pame_date_added,
			pame_compound,			pame_comments,			pame_status,
			pame_drug_name,			pame_dosage,			pame_duration_amount,
			pame_duration_unit,		pame_drug_comments,		pame_numb_refills,
			pame_use_generic,		pame_days_supply,		pame_prn,
			pame_prn_description,	pame_date_start,		pame_date_end,
			pame_source_name,		active,					last_modified_date,
			last_modified_by,		external_id
	)
	values
	(
			@pa_id,					@drugId,				GETDATE(),
			0,						@comments,				1,
			@drug_name,				@dosage,				@duration_amount,
			@duration_unit,			'',						@numb_refills,
			@use_generic,			@days_supply,			@prn,
			'',						null,					null,
			@SOURCE,				1,						GETDATE(),
			1,						@rx_number
	)
	
	SET @RecordId=SCOPE_IDENTITY()
	return		

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
