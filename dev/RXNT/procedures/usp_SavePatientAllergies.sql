SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		<Balaji>
-- Create date: <03-01-2016>
-- Description:	<Save patient allergies>
-- =============================================
CREATE PROCEDURE usp_SavePatientAllergies
	-- Add the parameters for the stored procedure here
	@AlrCode varchar(50),
	@AlrDesc varchar(50),
	@AlrType varchar(50),
	@patientId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	If  NOT Exists(Select * from patient_new_allergies where pa_id=@patientId And allergy_id=@AlrCode And allergy_type=@AlrType)	
	Begin
		Insert into patient_new_allergies(pa_id,allergy_id,allergy_type,add_date,status)
		Values(@patientId,@AlrCode,@AlrType,GETDATE(),1)
	End
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
