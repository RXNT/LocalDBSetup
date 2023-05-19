SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	07-AUG-2017
-- Description:		Search Cancel Rx ids for Surescripts Transmission
-- =============================================
CREATE PROCEDURE [erx].[SearchSSCancelRxTransmittals]
  @DeliveryMethod			BIGINT,
  @Version					VARCHAR(50)
AS
BEGIN
	SELECT DISTINCT TOP 50 pct_id,A.delivery_method,A.pd_id,A.pres_id, 0 transmission_flags,B.presc_src,DR_STATE,  
	CASE WHEN DR.epcs_enabled is null THEN 0 ELSE DR.epcs_enabled END epcs 
	FROM prescription_Cancel_transmittals A WITH (NOLOCK)
	INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
	INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id
	INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id 
	INNER JOIN doc_admin D WITH(NOLOCK) ON DR.dr_id=D.dr_id
	WHERE send_date IS NULL AND response_date IS NULL AND queued_date > getdate()-1
	AND delivery_method= @DeliveryMethod AND D.version= @Version ORDER BY A.pres_id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
