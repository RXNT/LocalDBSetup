SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 02-Nov-2016
-- Description:	Search Patient Coupon Identifiers for a batch
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchBatchPatientCouponIdentifiers]
	@PatientId	BIGINT,
	@BatchId	VARCHAR(50)
AS
BEGIN
	
	SELECT rpc.patient_coupon_id,rpc.[filename],rpci.client_provided_id, rpc.coupon_id_coords
	FROM rxnt_patient_coupons rpc WITH(NOLOCK)
	INNER JOIN rxnt_patient_coupon_batches rpcb WITH(NOLOCK) ON rpc.patient_coupon_id = rpcb.patient_coupon_id
	INNER JOIN rxnt_patient_coupon_identifiers rpci WITH(NOLOCK) ON rpcb.pa_coupon_batch_id = rpci.pa_coupon_batch_id
	WHERE taken_by_pa_id = @PatientId AND rpci.taken_batch_id = @BatchId  
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
