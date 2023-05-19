SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji	>
-- Create date: <03-02-2016>
-- Description:	<Insert/Update active med data>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ClearActiveMeds] 
	-- Add the parameters for the stored procedure here
	@PAID	int,
	@IDS	varchar(1000),
	@RecordId int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	If(LEN(@IDS) > 0)
	BEGIN
		delete PAM from patient_active_meds PAM WITH(NOLOCK)
		inner join patient_active_meds_external PAE WITH(NOLOCK) 
			on PAM.pa_id = PAE.pame_pa_id and PAM.drug_id = PAE.pame_drug_id
        where PAM.pa_id=@PAID 
			AND external_id is not null
			AND PAE.pame_source_name like 'Enclara' 
			AND LEN(external_id) > 0
			AND PAE.external_id not in 
        (
			SELECT CAST(Item AS INTEGER)
            FROM dbo.SplitString(@IDS, ',')
        )
        
		delete from patient_active_meds_external 
		where pame_pa_id =@PAID 
		AND external_id is not null
		AND LEN(external_id) > 0 
		AND pame_source_name like 'Enclara'
		AND external_id not in 
        (
			SELECT CAST(Item AS INTEGER)
            FROM dbo.SplitString(@IDS, ',')
        )
	END
	ELSE
	BEGIN
		delete PAM from patient_active_meds PAM WITH(NOLOCK)
		inner join patient_active_meds_external PAE WITH(NOLOCK) 
			on PAM.pa_id = PAE.pame_pa_id and PAM.drug_id = PAE.pame_drug_id
        where PAM.pa_id=@PAID 
			AND external_id is not null
			AND PAE.pame_source_name like 'Enclara' 
			AND LEN(external_id) > 0
			
		delete from patient_active_meds_external 
		where pame_pa_id =@PAID 
		AND external_id is not null
		AND LEN(external_id) > 0 
		AND pame_source_name like 'Enclara'
	END
	--delete from patient_active_meds where pa_id =@PAID
	--and pam_id not in(
	--select PM.pam_id from patient_active_meds PM with(nolock)
	--	inner join prescriptions P with(nolock) on PM.pa_id = P.pa_id
	--	inner join prescription_details PD with(nolock) on P.pres_id = PD.pres_id and PD.ddid = PM.drug_id
	--	where PM.pa_id=@PAID
	--)
	
	--delete from patient_active_meds_external where pame_pa_id =@PAID and external_id is not null and
	--LEN(external_id) > 0 and pame_source_name like 'Enclara'
	
	SET @RecordId = 1
	return
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
