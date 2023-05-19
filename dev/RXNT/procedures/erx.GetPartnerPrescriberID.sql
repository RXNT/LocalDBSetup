SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	07-AUG-2017
-- Description:		Get Partner PrescriberID
-- =============================================
CREATE PROCEDURE [erx].[GetPartnerPrescriberID]
  @DoctorId					BIGINT,
  @DeliveryMethod			BIGINT,
  @Version					VARCHAR(50)
AS
BEGIN
	-- SELECT TOP 1 partner_prescriber_id FROM doc_admin WHERE dr_id=@DoctorId AND dr_partner_participant=@DeliveryMethod AND version=@Version
	
	SELECT spi_id AS partner_prescriber_id FROM doctors WHERE dr_id=@DoctorId
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
