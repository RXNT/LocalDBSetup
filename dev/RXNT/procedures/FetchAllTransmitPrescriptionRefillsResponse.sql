SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 12/26/2018
-- Description: Fetch all transmit prescription Refills Response
-- Modified By : 
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [dbo].[FetchAllTransmitPrescriptionRefillsResponse]
 @Participant int,  
 @MaxRetryCount INT=0,
 @version VARCHAR(50)
AS  

  
  BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT DISTINCT TOP 50 pt_id,A.pd_id,A.pres_id,B.pres_prescription_type,B.presc_src,delivery_method, 
	Case when DR.epcs_enabled is null then 0 else DR.epcs_enabled End epcs, CASE WHEN RQ.response_type IS NULL THEN 0 ELSE RQ.response_type END response_type 
	FROM prescription_transmittals A WITH (NOLOCK) 
	INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
	INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id 
	INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id 
	INNER JOIN REFILL_REQUESTS RQ ON A.PRES_ID=RQ.PRES_ID
	INNER JOIN doc_admin DA WITH(NOLOCK) on DR.dr_id=DA.dr_id
	WHERE Not(RQ.PrescDRUSEG is null) 
	AND LEN(RQ.PrescDRUSEG) > 3 
	AND send_date IS NULL 
	AND response_date is null 
	AND A.queued_date > getdate()-4 
	AND ISNULL(A.next_retry_on,GETDATE())<=GETDATE() 
	AND ISNULL(A.retry_count,-1)< @MaxRetryCount
	AND B.pres_prescription_type=2 
	AND delivery_method= @Participant 
	AND RQ.versionType NOT IN ('v6.1')
	ORDER BY A.pres_id

	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
