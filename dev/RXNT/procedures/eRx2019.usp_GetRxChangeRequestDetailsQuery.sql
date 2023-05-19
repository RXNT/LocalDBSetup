SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Sheikh  
-- ALTER  date: 2021/04/14
-- Description: Load the Rxchange request details
-- Modified By :  
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_GetRxChangeRequestDetailsQuery]--[eRx2019].[usp_GetRxChangeRequestDetailsQuery]17542,16717
	@RxId BIGINT,
	@RxDetailId BIGINT
AS  

  
BEGIN
	 select Rc.MessageId,Rc.PatientSeg,Rc.PharmSeg,RcI.RequestSeg,Rc.DoctorSeg,Rc.SupervisorSeg,RC.ChgType,RC.PriorAuthNum,
	 VRD.Code VoidCode, PRES.pres_void_comments AS VoidComments,PrescDrug,FullReqMessage FullMessage, CASE WHEN Rc.VersionType='v6.1' THEN 6 ELSE 5 END Version
	 from prescriptions PRES with(nolock) 
	 INNER JOIN [erx].[RxChangeRequests] Rc with(nolock) on PRES.pres_id=Rc.PresId 
	 LEFT OUTER JOIN [erx].[RxChangeRequestsInfo] RcI with(nolock) on RcI.ChgReqId=RC.ChgReqId AND RcI.ChgReqInfoId=Rc.ApprovedChgReqInfoId 
	 LEFT OUTER JOIN void_reason_codes VRD WITH(NOLOCK) ON PRES.pres_void_code=VRD.Id
	 WHERE PRES.pres_id=@RxId
            
	RETURN
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
