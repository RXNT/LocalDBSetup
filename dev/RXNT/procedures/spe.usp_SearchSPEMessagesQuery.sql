SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 06/24/2019
-- Description: Fetch all SPOIntitation
-- Modified By : 
-- Modified Date: 
-- Modified Description: 
-- =============================================  
 
CREATE  PROCEDURE [spe].[usp_SearchSPEMessagesQuery]
 
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @MaxRetryCount INT=3

	SELECT DISTINCT TOP 200 A.pd_id RxDetailId,A.pres_id RxId,spo_ir_id SPOInitationId,pt_id RxTransmitalid--,A.delivery_method RxDeliveryMethod, 0 transmission_flags,A.prescription_type RxType,B.presc_src RxSrc,DR_STATE DoctorState, Case when DR.epcs_enabled is null then 0 else DR.epcs_enabled End DoctorEPCS
	FROM [spe].[SPEMessages] A WITH (NOLOCK) 
	INNER JOIN prescription_transmittals PT ON A.pres_id = PT.pres_id
	WHERE A.send_date IS NULL 
	AND A.response_date is null 
	AND A.queued_date > getdate()-1 
	AND A.message_type=2
	AND ISNULL(A.next_retry_on,GETDATE())<=GETDATE() 
	AND ISNULL(A.retry_count,-1)< @MaxRetryCount 
	ORDER BY A.pres_id 
	
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
