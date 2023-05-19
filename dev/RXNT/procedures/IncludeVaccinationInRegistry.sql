SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
--sp_helptext IncludeVaccinationInRegistry
  
CREATE PROCEDURE [dbo].[IncludeVaccinationInRegistry]
  @drid BIGINT,  
  @patientid BIGINT,  
  @recid BIGINT,  
  @IsIncluded bit     
    
AS      
BEGIN  
 IF EXISTS(SELECT NULL FROM tblVaccinationQueue WHERE dr_id=@drid AND pat_id=@patientid AND vac_rec_id=@recid)  
 BEGIN  
  IF EXISTS(SELECT NULL FROM tblVaccinationQueue WHERE dr_id=@drid AND pat_id=@patientid AND vac_rec_id=@recid AND exportedDate IS NULL)  
  BEGIN  
   --IF @IsIncluded=1  
   --BEGIN  
    UPDATE tblVaccinationQueue SET isIncluded=@IsIncluded   
    WHERE dr_id=@drid AND pat_id=@patientid AND vac_rec_id=@recid AND exportedDate IS NULL  
   --END  
   --ELSE  
   --BEGIN  
   -- DELETE FROM tblVaccinationQueue  
   -- WHERE dr_id=@drid AND pat_id=@patientid AND vac_rec_id=@recid AND exportedDate IS NULL  
   --END  
  END   
  ELSE  
  BEGIN   
   
   INSERT INTO tblVaccinationQueue (dr_id,pat_id, vac_rec_id,isIncluded,exportedDate) VALUES (@drid,@patientid, @recid,@IsIncluded,NULL)   
  END  
 END  
 ELSE  
 BEGIN   
   
  INSERT INTO tblVaccinationQueue (dr_id,pat_id, vac_rec_id,isIncluded,exportedDate) VALUES (@drid,@patientid, @recid,@IsIncluded,NULL)   
 END  
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
