SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [eRx2019].[PerformBatchRxVoidTransmitals]
 
AS
	DECLARE @Participant INT=262144,  
	@QueuedDate DATETIME = GETDATE(),
	@version VARCHAR(50)='v6.1'
	
	
	SELECT A.pres_id,pres_delivery_method & 0xFFFF0000 DeliveryStatus
	INTO #VoidRxList
	FROM prescriptions A with(nolock) 
	inner join prescription_details B with(nolock) on A.pres_id = B.pres_id 
	inner join refill_requests C with(nolock) on A.pres_id = C.pres_id 
	inner join RMIID1 D with(nolock) on B.ddid = D.MEDID 
	inner join doctors DR with(nolock) on A.dr_id = DR.dr_id 
	inner join pharmacies PH with(nolock) on A.pharm_id = PH.pharm_id 
	left outer join prescription_void_transmittals pvt with(nolock) on A.pres_id = pvt.pres_id 
	where ((Dr.epcs_enabled = 0 or Dr.epcs_enabled is null) OR((PH.service_level & 2048) <> 2048)) 
	AND pres_approved_date > GETDATE() - 2 
	AND pres_void = 0 
	and C.response_type = 0 
	AND Not(C.PrescDRUSEG is null) 
	AND LEN(C.PrescDRUSEG) > 3 
	and D.MED_REF_DEA_CD > 1 
	and pvt.pres_id is null 
	
                                
	UPDATE RQ SET response_type = 10,void_comments='Prescriber or Pharmacy not EPCS enabled, approval via fax or print.' 
	FROM refill_requests RQ WITH(NOLOCK)
	INNER JOIN #VoidRxList VRX ON VRX.pres_id = RQ.pres_id
   
	UPDATE P SET PRES_VOID = PRES_VOID
	FROM prescriptions P WITH(NOLOCK)
	INNER JOIN #VoidRxList VRX  WITH(NOLOCK) ON p.pres_id = VRX.pres_id
	WHERE VRX.DeliveryStatus=0
	
	UPDATE P SET PRES_VOID = PRES_VOID
	FROM prescriptions P WITH(NOLOCK)
	INNER JOIN prescription_void_transmittals pvt WITH(NOLOCK) ON pvt.pres_id=p.pres_id
	INNER JOIN #VoidRxList VRX  WITH(NOLOCK) ON p.pres_id = VRX.pres_id
	  
	INSERT INTO prescription_void_transmittals (refreq_id, pres_id, pd_id, queued_date, delivery_method)
    SELECT B.refreq_id, A.pres_id, C.pd_id, @QueuedDate, pres_delivery_method & 0xFFFF0000 
    FROM prescriptions A WITH(NOLOCK)
    INNER JOIN refill_requests B  WITH(NOLOCK) ON A.pres_id=B.pres_id
    INNER JOIN prescription_details C  WITH(NOLOCK) ON A.pres_id = C.pres_id
    INNER JOIN #VoidRxList VRX  WITH(NOLOCK) ON VRX.pres_id = A.pres_id
    LEFT OUTER JOIN prescription_void_transmittals pvt WITH(NOLOCK) ON VRX.pres_id = pvt.pres_id
    WHERE pvt.pvt_id IS NULL
	  
    DROP TABLE #VoidRxList
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
