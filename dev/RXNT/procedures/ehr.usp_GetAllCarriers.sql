SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [ehr].[usp_GetAllCarriers]
AS
BEGIN
	SELECT [carrier_id],[carrier_name],[address1],[city],[state],[zip],[phone] 
	FROM [referral_carrier_details] 
	order by carrier_name
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
