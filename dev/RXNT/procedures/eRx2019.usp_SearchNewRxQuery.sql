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
CREATE  PROCEDURE [eRx2019].[usp_SearchNewRxQuery]
 
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Participant INT=262144,  
	@MaxRetryCount INT=3,
	@version VARCHAR(50)='v6.1'

	SELECT DISTINCT TOP 200 A.pd_id RxDetailId,A.pres_id RxId,pt_id RxTransmitalid--,pt_id RxTransmitalid,A.delivery_method RxDeliveryMethod, 0 transmission_flags,A.prescription_type RxType,B.presc_src RxSrc,DR_STATE DoctorState, Case when DR.epcs_enabled is null then 0 else DR.epcs_enabled End DoctorEPCS
	FROM prescription_transmittals A WITH (NOLOCK) 
	INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
	INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id 
	INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id
	inner join doc_admin D WITH(NOLOCK) on DR.dr_id=D.dr_id
	WHERE send_date IS NULL 
	AND response_date is null 
	AND A.queued_date > getdate()-1 
	AND ISNULL(A.next_retry_on,GETDATE())<=GETDATE() 
	AND ISNULL(A.retry_count,-1)< @MaxRetryCount 
	AND prescription_type=1 
	AND delivery_method=@Participant 
	ORDER BY A.pres_id 

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
