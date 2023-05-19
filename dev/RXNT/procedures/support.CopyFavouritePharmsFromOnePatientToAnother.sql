SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	05-JUNE-2017
-- Description:		Copy Favourite Pharmacies From one Patient to another Patient
-- =============================================
CREATE PROCEDURE [support].[CopyFavouritePharmsFromOnePatientToAnother]  
  @FromPatientId   BIGINT,  
  @ToPatientId    BIGINT,  
  @ToDoctorId    BIGINT  
AS  
BEGIN  
 DECLARE @CopyRef_Id AS BIGINT  
 DECLARE @new_dg_id AS BIGINT  
 DECLARE @new_dc_id AS BIGINT  
   
 SELECT @new_dg_id = dg_id FROM doctors WHERE dr_id=@ToDoctorId      
 SELECT @new_dc_id = dc_id FROM doc_groups WHERE dg_id=@new_dg_id   
  
 SELECT @CopyRef_Id = CopyRef_Id   
 FROM support.Patients_Copy_Ref coa WITH(NOLOCK)   
 WHERE coa.New_DCID = @new_dc_id  AND coa.Old_PatID = @FromPatientId  
 IF NOT EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref_Extended WHERE CopyRef_Id = @CopyRef_Id AND PatientFavouritePharmaciesCopied = 1)  
 BEGIN
		DECLARE @old_pharm_id BIGINT  
		DECLARE @new_pharm_id as BIGINT
		
		INSERT INTO support.Patients_Copy_Data_Ref (CopyRef_Id,Old_DataRef_Id,Type,CreatedOn, Is_Copied)
		SELECT @CopyRef_Id, pfp.pharm_id, 'Favourite_Pharmacies', GETDATE(),0
		FROM PATIENTS_FAV_PHARMS pfp WITH(NOLOCK)
		LEFT OUTER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pcdr.CopyRef_Id = @CopyRef_Id AND pfp.pharm_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Favourite_Pharmacies'
		WHERE pfp.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL AND pcdr.Old_DataRef_Id IS NULL
		
		SELECT TOP 1 @old_pharm_id=pcdr.Old_DataRef_Id
		FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
		INNER JOIN PHARMACIES p WITH(NOLOCK) ON p.pharm_id=pcdr.Old_DataRef_Id
		INNER JOIN pharm_mo_xref X on p.pharm_id = X.pharmacy_id 
		INNER JOIN PATIENTS_FAV_PHARMS PH ON pcdr.Old_DataRef_Id = PH.PHARM_ID
		WHERE pcdr.CopyRef_Id = @CopyRef_Id AND P.PHARM_ID=pcdr.Old_DataRef_Id AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Favourite_Pharmacies'	
	
		WHILE @old_pharm_id>0 
		BEGIN    
			SET @new_pharm_id = 0
			INSERT INTO PATIENTS_FAV_PHARMS   
				  (pa_id,pharm_id,pharm_use_date )
			SELECT TOP 1 @ToPatientId,pharm_id,GETDATE()   
			FROM PATIENTS_FAV_PHARMS pfp
			INNER JOIN support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK) ON pfp.pharm_id=pcdr.Old_DataRef_Id  AND pcdr.Type = 'Favourite_Pharmacies'
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND pfp.pharm_id=@old_pharm_id AND pfp.pa_id=@FromPatientId AND pcdr.New_DataRef_Id IS NULL
			
			SET @new_pharm_id = SCOPE_IDENTITY();  
		    IF @new_pharm_id>0
		    BEGIN
				UPDATE support.Patients_Copy_Data_Ref SET New_DataRef_Id=@new_pharm_id, Is_Copied=1
				WHERE CopyRef_Id = @CopyRef_Id AND Old_DataRef_Id=@old_pharm_id AND Type like 'Favourite_Pharmacies'
			END
			SET @old_pharm_id=0
			SELECT TOP 1 @old_pharm_id=pcdr.Old_DataRef_Id
			FROM support.Patients_Copy_Data_Ref pcdr WITH(NOLOCK)
			INNER JOIN PHARMACIES p WITH(NOLOCK) ON p.pharm_id=pcdr.Old_DataRef_Id
			INNER JOIN pharm_mo_xref X on p.pharm_id = X.pharmacy_id 
			INNER JOIN PATIENTS_FAV_PHARMS PH ON pcdr.Old_DataRef_Id = PH.PHARM_ID
			WHERE pcdr.CopyRef_Id = @CopyRef_Id AND P.PHARM_ID=pcdr.Old_DataRef_Id AND pcdr.New_DataRef_Id IS NULL AND pcdr.Type = 'Favourite_Pharmacies'		
 
		END
    
		UPDATE	support.Patients_Copy_Ref_Extended   
				SET PatientFavouritePharmaciesCopied = 1, LastUpdatedOn = GETDATE()  
				WHERE CopyRef_Id = @CopyRef_Id   
 END  
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
