SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	12-SEP-2017
-- Description:		Search Change Rx ids for Surescripts Transmission
-- =============================================
CREATE PROCEDURE [erx].[SearchSSChangeRxTransmittals]
  @DeliveryMethod			BIGINT,
  @Version					VARCHAR(50),
  @IsDenied					BIT=0
AS
BEGIN
	IF @IsDenied = 0
	BEGIN
		SELECT DISTINCT TOP 50 pt_id,A.delivery_method,A.pd_id,A.pres_id, 0 transmission_flags,B.presc_src,DR_STATE,  
		CASE WHEN DR.epcs_enabled is null THEN 0 ELSE DR.epcs_enabled END epcs, chg.ResponseType
		FROM prescription_transmittals A WITH (NOLOCK)
		INNER JOIN erx.RxChangeRequests chg WITH(NOLOCK) ON A.pres_id=chg.PresId
		INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
		INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id
		INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id 
		INNER JOIN doc_admin D WITH(NOLOCK) ON DR.dr_id=D.dr_id
		WHERE send_date IS NULL AND response_date IS NULL AND queued_date > getdate()-1
		AND delivery_method= @DeliveryMethod AND D.version= @Version
		AND A.prescription_type=5 AND chg.ResponseType=1 AND chg.IsApproved=1 AND ISNULL(chg.IsVoided,0)=0 ORDER BY A.pres_id
	END
	ELSE
	BEGIN
		SELECT DISTINCT TOP 50 ChgVoidId AS pt_id,A.DeliveryMethod AS delivery_method,A.PdId AS pd_id,A.PresId AS pres_id, 0 transmission_flags,B.presc_src,DR_STATE,  
		CASE WHEN DR.epcs_enabled is null THEN 0 ELSE DR.epcs_enabled END epcs, chg.ResponseType
		FROM erx.RxChangeVoidTransmittals A WITH (NOLOCK)
		INNER JOIN erx.RxChangeRequests chg WITH(NOLOCK) ON A.PresId=chg.PresId
		INNER JOIN prescriptions B WITH (NOLOCK) ON A.PresId = B.pres_id 
		INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id
		INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id 
		INNER JOIN doc_admin D WITH(NOLOCK) ON DR.dr_id=D.dr_id
		WHERE SendDate IS NULL AND ResponseDate IS NULL AND QueuedDate > getdate()-1
		AND A.DeliveryMethod= @DeliveryMethod AND D.version= @Version
		AND A.Type=5 AND chg.ResponseType=0 AND chg.IsVoided=1 AND ISNULL(chg.IsApproved,0)=0 ORDER BY A.PresId
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
