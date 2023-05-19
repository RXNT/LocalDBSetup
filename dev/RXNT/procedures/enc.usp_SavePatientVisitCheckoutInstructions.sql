SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 29-Jan-2016
-- Description:	To save the patient visit checkout instruction
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [enc].[usp_SavePatientVisitCheckoutInstructions]
	@PatientId BIGINT,
	@VisitId BIGINT,
	@CheckoutInstructions VARCHAR(MAX)=NULL
AS

BEGIN
	SET NOCOUNT ON;
	UPDATE patient_visit
	SET chkout_notes = ISNULL(@CheckoutInstructions,'')
	WHERE pa_id=@PatientId AND visit_id = @VisitId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
