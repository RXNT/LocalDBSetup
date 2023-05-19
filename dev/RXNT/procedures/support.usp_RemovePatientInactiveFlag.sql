SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- ===============================================================================================  
-- Author  : Jahabar Yusuff  
-- Create date : 05-JAN-2022  
-- Description : Remove Inactive flag from the patient   
-- ===============================================================================================  
CREATE PROCEDURE [support].[usp_RemovePatientInactiveFlag]  
@flagId BIGINT,  
@CompanyId BIGINT  
AS  
  
BEGIN  
   DELETE fd FROM [RxNT].[dbo].[patient_flag_details]  fd WITH(NOLOCK) 
   INNER JOIN [RxNT].[dbo].[patient_flags] flg WITH(NOLOCK)  ON flg.flag_id = fd.flag_id AND flg.is_enabled = 0 AND hide_on_search = 0  
   WHERE flg.dc_id = @CompanyId AND  fd.flag_id=@flagId   
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
