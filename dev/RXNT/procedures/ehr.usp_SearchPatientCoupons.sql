SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 02-Nov-2016
-- Description:	Search Patient Coupons
-- Modified By: 
-- Modified Date: 
-- =============================================
CREATE PROCEDURE [ehr].[usp_SearchPatientCoupons]
	@DrugId BIGINT
AS
BEGIN
	
	SELECT rpc.patient_coupon_id,rpc.[filename],rpc.brochure_url,med_name
	FROM rxnt_patient_coupons rpc WITH(NOLOCK)
	WHERE med_id = @DrugId  
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
