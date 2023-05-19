SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
-- =============================================  
-- Author:   Rasheed  
-- Create date:  02-Mar-2020
-- Description:  Search Patient ClaimsHx from past 24 hrs  
-- =============================================  
CREATE PROCEDURE [eRx2019].[usp_GetPatientRxHistory]--[eRx2019].[usp_GetPatientRxHistory] '65639807-92eb5e40-cacb-4fad'
 @RequestId VARCHAR(100)=NULL
AS  
BEGIN  
   
  SELECT Request,StartDate,EndDate,RequestId,ResponseId,PatientId,sms.drid DoctorId,sms.prim_dr_id AgentDoctorId,dg.dc_id DoctorCompanyId,effective_end_date EffectiveEndDate
  FROM surescript_medHx_messages sms WITH(NOLOCK) 
  INNER JOIN patients pa WITH(NOLOCK) ON sms.patientid=pa.pa_id
  INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dg_id=pa.dg_id
  WHERE requestid=@RequestId AND   
  DATEDIFF(HOUR,createddate,GETDATE()) <=24 AND  
  version='v6.1'  
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
