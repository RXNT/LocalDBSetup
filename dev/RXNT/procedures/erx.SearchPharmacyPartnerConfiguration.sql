SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	07-AUG-2017
-- Description:		Search Pharmacy Partner configuration
-- =============================================
CREATE PROCEDURE [erx].[SearchPharmacyPartnerConfiguration]
  @DeliveryMethod			BIGINT,
  @Version					VARCHAR(50)
AS
BEGIN
	SELECT [erx_url],[erx_login],[erx_password] FROM pharmacy_partner_config WHERE pharm_participant=@DeliveryMethod AND version=@Version 
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
