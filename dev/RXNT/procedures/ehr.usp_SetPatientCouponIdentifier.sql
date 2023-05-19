SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 02-Nov-2016
-- Description:	Set Coupon Identifier for a patient and batch request id
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SetPatientCouponIdentifier]--[ehr].[usp_SetPatientCouponIdentifier] 40905294,1,'9b691f3a-4eb1-451f-861f-7ed106ad32d8'
	@PatientId BIGINT,
	@PatientCouponId BIGINT,
	@BatchId VARCHAR(50)
AS
BEGIN
	BEGIN TRAN T1;  
		DECLARE @coupon_identifier_id AS BIGINT
		DECLARE @client_provided_id AS VARCHAR(50)
		SELECT TOP 1 @coupon_identifier_id = coupon_identifier_id, @client_provided_id = client_provided_id
		FROM rxnt_patient_coupon_identifiers rpci WITH(NOLOCK)
		INNER JOIN rxnt_patient_coupon_batches rpcb WITH(NOLOCK) ON rpci.pa_coupon_batch_id = rpcb.pa_coupon_batch_id
		INNER JOIN rxnt_patient_coupons rpc WITH(NOLOCK) ON rpc.patient_coupon_id = rpcb.patient_coupon_id
		WHERE rpc.patient_coupon_id = @PatientCouponId AND [expiry_date] >GETDATE() AND is_used!=1 
		AND (taken_date IS NULL OR DATEADD(HH,12,taken_date )<GETDATE() )
		 PRINT @coupon_identifier_id
		UPDATE rxnt_patient_coupon_identifiers 
		SET taken_date = GETDATE(),taken_by_pa_id = @PatientId, taken_batch_id = @BatchId 
		WHERE coupon_identifier_id = @coupon_identifier_id
		 
	COMMIT TRAN T1;  

END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
