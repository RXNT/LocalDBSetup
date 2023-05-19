SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Thomas K
-- Create date: 8/2/2013
-- Description:	Copy doc_fav_drugs for a specific group
-- =============================================
CREATE PROCEDURE [dbo].[CheckDocFavDrugs] 
	-- Add the parameters for the stored procedure here
	@GROUP_id int, @SOURCE_DR_ID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@dr_id int
    -- Insert statements for procedure here
    DECLARE dr_records CURSOR
	READ_ONLY
		FOR
			SELECT DR_ID FROM doctors WHERE DG_ID = @GROUP_id AND dr_enabled=1 and
			prescribing_authority > 2
	OPEN dr_records
	FETCH NEXT FROM dr_records INTO @dr_id
	WHILE (@@FETCH_STATUS <> -1)
    BEGIN
		if exists(select @dr_id,drug_id from doc_fav_drugs where dr_id=@SOURCE_DR_ID and drug_id not in (select		drug_id from doc_fav_drugs where dr_id=@dr_id))
		begin
			Print 'Missing drug for ' + cast(@dr_id As varchar(10))
		end
		if exists(select @dr_id,A.ddid,A.use_generic,A.dosage,A.numb_refills,A.duration_amount,A.duration_unit,A.comments,A.prn		,A.prn_description,A.days_supply,A.compound from
		(select ddid,use_generic,dosage,numb_refills,duration_amount,duration_unit,comments,prn,			prn_description,days_supply,compound from doc_fav_scripts where dr_id=@SOURCE_DR_ID)A left			outer join 
		(select ddid,use_generic,dosage,numb_refills,duration_amount,duration_unit,comments,prn,prn_description,		days_supply,compound from doc_fav_scripts where dr_id=@dr_id) B on A.ddid=B.ddid and 
		A.dosage=B.dosage and ((A.numb_refills is null AND B.numb_refills is null) or 
		A.numb_refills=B.numb_refills) and ((A.duration_amount is null and 
		B.duration_amount is null) OR A.duration_amount=B.duration_amount) and 
		((A.duration_unit is null and B.duration_unit is null) OR A.duration_unit=B.duration_unit) 
		and A.comments=B.comments and A.prn=B.prn and A.compound=B.compound and 
		A.prn_description=B.prn_description and ((A.days_supply is null AND B.days_supply is null) 
		OR A.days_supply=B.days_supply)  where B.ddid is null)
		begin
			Print 'Missing fav scripts for ' + cast(@dr_id As varchar(10))
		end
		FETCH NEXT FROM dr_records INTO @dr_id
    END
	CLOSE dr_records
	DEALLOCATE dr_records
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
