SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Ayja Weems
-- Create date: 15-Feb-2021
-- Description:	Mark intake and consent forms as reviewed by electronic_form_id
-- =============================================
CREATE PROCEDURE [prv].[MarkFormsAsReviewedByPrescriber] 
	@DoctorId BIGINT, 
	@PatientFormIds VARCHAR(MAX)
AS
BEGIN
	UPDATE patient_electronic_forms
	SET is_reviewed_by_prescriber = 1
	WHERE electronic_form_id IN (
		SELECT Item FROM dbo.SplitString(@PatientFormIds, ',')
	)
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
