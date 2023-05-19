SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 12/26/2018
-- Description: Fetch all transmit prescription NewRx
-- Modified By : 
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [dbo].[FetchAllTransmitPrescriptionNewRx]
 @Participant int,  
 @MaxRetryCount INT=0,
 @version VARCHAR(50)
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT DISTINCT TOP 50 pt_id,A.delivery_method,A.pd_id,A.pres_id, 0 transmission_flags,A.prescription_type,B.presc_src,DR_STATE, 
	Case when DR.epcs_enabled is null then 0 else DR.epcs_enabled End epcs 
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
	AND D.version=@version 
	ORDER BY A.pres_id

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
