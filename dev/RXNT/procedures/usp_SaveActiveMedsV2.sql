SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:  <JahabarYusuff M>    
-- Create date: <06-21-2018>    
-- Description: <Insert/Update patient Active medications  data with drug level SS-2849>    
-- =============================================
CREATE PROCEDURE [dbo].[usp_SaveActiveMedsV2] 
	-- Add the parameters for the stored procedure here
	@FDBMedid varchar(50),
	@Description varchar(150),
	@NDC varchar(50),
	@RxCUI varchar(50),
	@Quantity varchar(50),
	@NCPDPQuantityQualifier varchar(50),
	@UseGeneric varchar(50),
	@Refills varchar(50),
	@Notes varchar(50),
	@Sig varchar(150),
	@patientId bigint,
	@DGId bigint,
	@PRN bit,
	@doctorId bigint,
	@RecordId int OUTPUT,
	@DrugLevel bigint = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @drugId varchar(50)
	DECLARE @PAMID INT
	SET @drugId = 0
	SET @PAMID = 0
	--Declare @doctorId bigint
    -- Insert statements for procedure here
    /*As per Thomas workds on 25-04-2016 dr_id can be passed as param*/
    --select top 1 @doctorId=dr_id  from doctors WITH(NOLOCK) where dg_id=@DGId and dr_enabled=1
    
    if(@FDBMedid !='' And @FDBMedid !='0' AND @FDBMedid IS NOT NULL)
    Begin
		select @drugId=medid from RMIID1 where MEDID =   @FDBMedid 
	End
	
	If @drugId < 1
	Begin
		select @drugId=medid from doc_group_freetext_meds DGF with(nolock) 
			inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
			where DGF.dg_id = @DGId and med_medid_desc like   @Description 
	End
	
	If @drugId < 1
	BEGIN
		EXEC [dbo].[addDocGroupFreeTextMeds] @Description,@DrugLevel,@DGId,@doctorId,1
		select @drugId=medid from doc_group_freetext_meds DGF with(nolock) 
			inner join RMIID1 RM with(nolock) on DGF.drug_id = RM.MEDID
			where DGF.dg_id = @DGId and med_medid_desc like   @Description 
	END
	
	If (@drugId is null) Or @drugId < 1 
	Begin
		SET @RecordId = 0
		return
	End 
	select @PAMID=pam_id from patient_active_meds WITH(NOLOCK) Where pa_id=@patientId and drug_id=@drugId
	If (@PAMID is not null And @PAMID > 0)
	Begin
		Update patient_active_meds Set duration_amount=@Quantity, duration_unit=@NCPDPQuantityQualifier,
		use_generic=@UseGeneric, numb_refills=@Refills, drug_comments=@Notes, 
		dosage=@Sig,prn=@PRN, last_modified_date=GETDATE()
		Where pam_id=@PAMID --pa_id=@patientId and drug_id=@drugId
	ENd
	Else
	Begin
		Insert Into patient_active_meds(pa_id,drug_id,date_added,added_by_dr_id,from_pd_id,compound,duration_amount,duration_unit,use_generic,numb_refills,drug_comments,dosage,prn)
		Values(@patientId,@drugId,GETDATE(),@doctorId,0,0,@Quantity,@NCPDPQuantityQualifier,@UseGeneric,@Refills,@Notes,
		@Sig,@PRN	
		)
		SET @PAMID=SCOPE_IDENTITY()
	END
	
	SET @RecordId = @PAMID
	return
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
