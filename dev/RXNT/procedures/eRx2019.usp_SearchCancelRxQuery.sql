SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 06/24/2019
-- Description: Fetch all transmit prescription NewRx
-- Modified By : 
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_SearchCancelRxQuery]
 
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Participant INT=262144,  
	@MaxRetryCount INT=3,
	@version VARCHAR(50)='v6.1'
  

	SELECT DISTINCT TOP 50 A.pd_id RxDetailId,A.pres_id RxId,pct_id RxTransmitalid--, 0 transmission_flags,B.presc_src,DR_STATE,  	CASE WHEN DR.epcs_enabled is null THEN 0 ELSE DR.epcs_enabled END epcs 
	FROM prescription_Cancel_transmittals A WITH (NOLOCK)
	INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
	INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id
	INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id 
	INNER JOIN doc_admin D WITH(NOLOCK) ON DR.dr_id=D.dr_id
	WHERE send_date IS NULL AND response_date IS NULL AND queued_date > getdate()-1
	AND delivery_method= @Participant
	ORDER BY A.pres_id
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
