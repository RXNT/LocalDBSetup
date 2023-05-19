SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
  
  
CREATE   PROCEDURE [phr].[usp_GetPatientMedicationCoupon]  
@PatientId BIGINT,  
@CouponId BIGINT,  
@CouponType VARCHAR(50)  
AS  
BEGIN  
 IF @CouponType='PharmacyCoupon'  
 BEGIN  
  SELECT coupon_id CouponId,Med_id DrugId, med_name DrugName,'PharmacyCoupon' CouponType, Title,Disclaimer
  ,rx_bin BINNumber,rx_grp GroupNumber,rx_pcn PCN  
  FROM  [dbo].[rxnt_coupons] WITH(NOLOCK)  
  WHERE coupon_id=@CouponId  
 END  
 IF @CouponType='PatientCoupon'  
 BEGIN  
  SELECT patient_coupon_id CouponId,Med_id DrugId, med_name DrugName, 'PatientCoupon' CouponType, Title,Disclaimer
  ,NULL BINNumber,NULL GroupNumber,NULL PCN  
  FROM [dbo].[rxnt_patient_coupons] WITH(NOLOCK)  
  WHERE  patient_coupon_id=@CouponId  
  ORDER BY DrugId  
 END  
  
END  
  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
