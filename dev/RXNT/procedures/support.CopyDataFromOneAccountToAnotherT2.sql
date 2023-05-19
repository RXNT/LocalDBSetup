SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:			Nambi
-- Create date: 	15-MAR-2017
-- Description:		Copy Active Patients From one Doctor to another Doctor
-- =============================================
CREATE PROCEDURE [support].[CopyDataFromOneAccountToAnotherT2]  
  @FromDoctorId    BIGINT,  
  @ToDoctorId    BIGINT  
AS  
BEGIN  
   
 DECLARE @CopyRef_Id AS BIGINT  
 DECLARE @new_dg_id AS BIGINT  
 DECLARE @new_dc_id AS BIGINT  
 DECLARE @old_dg_id AS BIGINT  
 DECLARE @old_dc_id AS BIGINT  
  
 SELECT @new_dg_id = dg_id FROM doctors WHERE dr_id=@ToDoctorId      
 SELECT @new_dc_id = dc_id FROM doc_groups WHERE dg_id=@new_dg_id   
  
 SELECT @old_dg_id = dg_id FROM doctors WHERE dr_id=@FromDoctorId      
 SELECT @old_dc_id = dc_id FROM doc_groups WHERE dg_id=@old_dg_id   
 --Loop Through Every Patients And Export them to ToDoctorId  
   
 DECLARE @old_pa_id BIGINT  
 DECLARE @new_pa_id as BIGINT

 --EXEC [support].[CopyFavouritePharmsFromOneAccountToAnother] @FromDoctorId = @FromDoctorId, @ToDoctorId = @ToDoctorId
 /* ------------- User Local Veriables ------------- */   
   
 DECLARE @PatientExportCursor CURSOR  
  
 SET @PatientExportCursor = CURSOR FAST_FORWARD  
 FOR SELECT pat.pa_id  
 FROM patients pat WITH(NOLOCK)
 INNER JOIN doc_groups dg_pat WITH(NOLOCK) ON pat.dg_id=dg_pat.dg_id 
 LEFT OUTER JOIN prescriptions pres WITH(NOLOCK) ON pat.pa_id=pres.pa_id AND pres.dr_id=@FromDoctorId  
 LEFT OUTER JOIN enchanced_encounter enc WITH(NOLOCK) ON pat.pa_id=enc.patient_id AND enc.dr_id=@FromDoctorId  
 INNER JOIN doctors doc WITH(NOLOCK) ON doc.dr_id=@FromDoctorId
 INNER JOIN doc_groups dg WITH(NOLOCK) ON doc.dg_id=dg.dg_id
 WHERE (pres.pres_id IS NOT NULL OR enc.enc_id IS NOT NULL)  AND dg.dc_id=@old_dc_id AND dg_pat.dc_id=@old_dc_id
 GROUP BY pat.pa_id  
         
 OPEN @PatientExportCursor  
 FETCH NEXT FROM @PatientExportCursor  
 INTO  @old_pa_id  
  
 WHILE @@FETCH_STATUS = 0  
 BEGIN    
  IF EXISTS(SELECT TOP 1 1 FROM support.Patients_Copy_Ref coa WITH(NOLOCK)   
  WHERE coa.New_DCID = @new_dc_id  AND coa.Old_PatID = @old_pa_id)  
  BEGIN
	SELECT @new_pa_id = New_PatID 
	FROM [support].[Patients_Copy_Ref] p_ref WITH(NOLOCK)
	WHERE  Old_DGID = @old_dg_id AND New_DGID = @new_dg_id AND Old_PatID = @old_pa_id 
  END
       
  --EXEC [support].[CopyActiveMedsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  --EXEC [support].[CopyActiveDiagnosisFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  --EXEC [support].[CopyAllergiesFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  --EXEC [support].[CopyHistoryFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  --EXEC [support].[CopyImmunizationsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  --EXEC [support].[CopyProceduresFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  --EXEC [support].[CopyReferralsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @FromDoctorId= @FromDoctorId, @ToDoctorId= @ToDoctorId  
  --EXEC [support].[CopyVitalsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id,@ToDoctorId= @ToDoctorId 
  --EXEC [support].[CopyFavouritePharmsFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
  EXEC [support].[CopyPatientNotesFromOnePatientToAnother] @FromPatientId=@old_pa_id, @ToPatientId= @new_pa_id, @ToDoctorId= @ToDoctorId  
         
 FETCH NEXT FROM @PatientExportCursor INTO  @old_pa_id  
 END  
 CLOSE @PatientExportCursor  
 DEALLOCATE @PatientExportCursor  
END  
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
