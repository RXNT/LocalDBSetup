SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Sheikh
-- Create date: 	09-APR-2021
-- Description:		Search Change Rx ids for Surescripts Transmission
-- =============================================
CREATE PROCEDURE [eRx2019].[usp_SearchRxChangeResponseQuery]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Participant INT=262144,  
	@MaxRetryCount INT=3,
	@version VARCHAR(50)='v6.1'
	
	SELECT DISTINCT TOP 50 
	A.pd_id RxDetailId,A.pres_id RxId,A.pt_id RxTransmitalid,CHG.MessageId RelatesToMessageID,CHG.msg_ref_number RxReferenceNumber
	, CASE WHEN CHG.ResponseType IS NULL THEN 0 ELSE CHG.ResponseType END RxChangeResponseType 
	,2 SortOrderIndex
	FROM prescription_transmittals A WITH (NOLOCK) 
	INNER JOIN prescriptions B WITH (NOLOCK) ON A.pres_id = B.pres_id 
	INNER JOIN pharmacies C WITH(NOLOCK) ON B.pharm_id = C.pharm_id 
	INNER JOIN DOCTORS DR WITH(NOLOCK) ON B.dr_id=DR.dr_id 
	INNER JOIN erx.RxChangeRequests CHG WITH(NOLOCK) ON A.PRES_ID=CHG.PRESID
	WHERE Not(CHG.PrescDrug is null) 
	--AND LEN(RQ.PrescDRUSEG) > 3 //Commented for testing purpose
	
	AND send_date IS NULL 
	AND response_date is null 
	AND A.queued_date > getdate()-4 
	AND ISNULL(A.next_retry_on,GETDATE())<=GETDATE() 
	AND ISNULL(A.retry_count,-1)< @MaxRetryCount
	AND B.pres_prescription_type=5 
	AND delivery_method= @Participant 
	--AND chg.ResponseType=1 AND chg.IsApproved=1
	AND ISNULL(chg.IsVoided,0)=0 
	ORDER BY  A.pres_id
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
