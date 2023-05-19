SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 02-Nov-2016
-- Description:	Get Patient Coupon Id
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_UpdatePatientCouponIdentifiers]
	@BatchId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	 
	UPDATE rxnt_patient_coupon_identifiers 
	SET used_date = GETDATE(),
	used_by_pa_id = @PatientId
	WHERE taken_batch_id = @BatchId
	 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
