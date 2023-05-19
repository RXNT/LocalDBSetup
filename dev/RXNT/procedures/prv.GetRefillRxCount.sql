SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE   PROCEDURE [prv].[GetRefillRxCount]  
 @UserId int, @DoctorGroupId int, @IsRestrictToPersonalRx bit = 1, @IsAgent bit=0  
AS  
BEGIN  
 SET NOCOUNT ON;  
 DECLARE @PreferredPrescriberId BIGINT = 0;  
   
 SELECT @PreferredPrescriberId=di.staff_preferred_prescriber   
 FROM dbo.doctor_info di WITH(NOLOCK)  
 WHERE di.dr_id=@UserId   
   
 IF(@PreferredPrescriberId>0)  
 BEGIN  
  SET @UserId = @PreferredPrescriberId;  
  SET @IsRestrictToPersonalRx = 1;  
 END  
 Declare @Count as int  
 IF @IsRestrictToPersonalRx = 1   
  BEGIN  
   IF @IsAgent = 1   
    BEGIN  
     SELECT @Count=COUNT(1) FROM vwDrPendingPrescriptionLog A LEFT OUTER JOIN Doctors PRIM_DOCS with(nolock) on A.prim_dr_id = PRIM_DOCS.DR_ID WHERE A.PRIM_DR_ID = @UserId  
AND PRES_PRESCRIPTION_TYPE In( 2)    
    END  
   ELSE  
    BEGIN  
     SELECT @Count=COUNT(1) FROM vwDrPendingPrescriptionLog A LEFT OUTER JOIN Doctors PRIM_DOCS with(nolock) on A.prim_dr_id = PRIM_DOCS.DR_ID WHERE A.DR_ID = @UserId   
AND PRES_PRESCRIPTION_TYPE In( 2)  
    END    
  END  
 ELSE  
  BEGIN  
   SELECT @Count=COUNT(1) FROM vwDrPendingPrescriptionLog A LEFT OUTER JOIN Doctors PRIM_DOCS with(nolock) on A.prim_dr_id = PRIM_DOCS.DR_ID WHERE A.DG_ID = @DoctorGroupId  
AND PRES_PRESCRIPTION_TYPE In( 2)  
  END    
    
   
 Select @Count as RefillRxCount     
 Return   
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
