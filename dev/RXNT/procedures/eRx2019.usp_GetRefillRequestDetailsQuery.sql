SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================  
-- Author:  Rasheed  
-- ALTER  date: 2018/07/22
-- Description: Load the refill request details
-- Modified By :  
-- Modified Date: 
-- Modified Description: 
-- =============================================  
CREATE  PROCEDURE [eRx2019].[usp_GetRefillRequestDetailsQuery]--[eRx2019].[usp_GetRxDetailsQuery]17542,16717
	@RxId BIGINT,
	@RxDetailId BIGINT
AS  

  
BEGIN
	 select ctrl_number MessageId,PatientSeg,PharmSeg,DispDRUSeg,DoctorSeg,SupervisorSeg
	 ,VRD.Code VoidCode,void_comments VoidComments,PrescDRUSeg,fullRequestMessage FullMessage, CASE WHEN RF.VersionType='v6.1' THEN 6 ELSE 5 END Version
	 from prescriptions PRES with(nolock) 
	 INNER JOIN refill_requests RF with(nolock) on PRES.pres_id=RF.pres_id 
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
