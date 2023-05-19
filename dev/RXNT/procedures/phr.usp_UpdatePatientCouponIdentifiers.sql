SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 19-Sep-2021
-- Description:	Update Patient Id for Coupon
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [phr].[usp_UpdatePatientCouponIdentifiers]
	@CouponCodeId BIGINT,
	@PatientId BIGINT
AS
BEGIN
	 
	UPDATE rxnt_patient_coupon_identifiers 
	SET used_date = GETDATE(),
	used_by_pa_id = @PatientId
	WHERE coupon_identifier_id = @CouponCodeId
	 

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
