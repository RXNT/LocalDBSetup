SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Sheikh
-- Create date: 	09-APR-2021
-- Description:		Search Change Rx ids for Surescripts Transmission
-- =============================================
CREATE PROCEDURE [eRx2019].[usp_SearchRxChangeVoidResponseQuery]
AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @Participant INT=262144,  
	@MaxRetryCount INT=3,
	@version VARCHAR(50)='v6.1'
	
	EXECUTE [eRx2019].[PerformBatchRxVoidTransmitals]
	
	 SELECT DISTINCT TOP 50
	 A.pdid RxDetailId,A.presid RxId,A.ChgVoidId RxTransmitalid,CHG.MessageId RelatesToMessageID,CHG.msg_ref_number RxReferenceNumber
	, CASE WHEN CHG.ResponseType IS NULL THEN 0 ELSE CHG.ResponseType END RxChangeResponseType
	,1 SortOrderIndex
    FROM erx.RxChangeVoidTransmittals A WITH (NOLOCK) 
    INNER JOIN prescriptions B WITH (NOLOCK) ON A.presid = B.pres_id 
    INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id 
    INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id 
	INNER JOIN [erx].[RxChangeRequests] CHG WITH(NOLOCK) ON A.PRESID=CHG.PRESID
	WHERE Not(CHG.PrescDrug is null) 
	AND LEN(CHG.PrescDrug) > 3 
	AND A.senddate IS NULL 
	AND A.responsedate is null 
	AND  A.queueddate > getdate()-4
	AND ISNULL(A.next_retry_on,GETDATE())<=GETDATE() 
	AND ISNULL(A.retry_count,-1)< @MaxRetryCount
	AND B.pres_prescription_type=5
	AND A.deliverymethod= @Participant
	AND chg.ResponseType=0 AND chg.IsVoided=1 AND ISNULL(chg.IsApproved,0)=0 


	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
