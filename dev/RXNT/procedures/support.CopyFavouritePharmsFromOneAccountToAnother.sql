SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	05-JUNE-2017
-- Description:		Copy Favourite Pharmacies From one Account to another
-- =============================================
CREATE PROCEDURE [support].[CopyFavouritePharmsFromOneAccountToAnother]  
  @FromDoctorId    BIGINT,  
  @ToDoctorId    BIGINT
AS  
BEGIN  
 DECLARE @CopyRef_Id AS BIGINT  
 DECLARE @new_dg_id AS BIGINT  
 DECLARE @new_dc_id AS BIGINT  
   
 SELECT @new_dg_id = dg_id FROM doctors WHERE dr_id=@ToDoctorId      
 SELECT @new_dc_id = dc_id FROM doc_groups WHERE dg_id=@new_dg_id   
  
 INSERT INTO doc_site_fav_pharms
 (dr_id,pharm_id)
 SELECT @ToDoctorId, P.pharm_id
 FROM pharmacies P WITH(NOLOCK)
 INNER JOIN doc_site_fav_pharms DH ON P.PHARM_ID = DH.PHARM_ID
 LEFT OUTER JOIN doc_site_fav_pharms DH_new ON DH.PHARM_ID = DH_new.PHARM_ID AND  DH_new.DR_ID =@ToDoctorId
 WHERE P.PHARM_ENABLED = 1 AND DH.DR_ID =@FromDoctorId AND DH_new.PHARM_ID IS NULL
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
