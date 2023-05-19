SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [dbo].[UpdateMessagesInRegistry]
  @drid BIGINT,  
  @patientid BIGINT,
  @vacrecid BIGINT
AS
BEGIN
	IF @patientid=0
	BEGIN
		UPDATE tblVaccinationQueue 
		SET exportedDate=GETDATE()   
		WHERE dr_id=@drid
		AND isIncluded=1 AND exportedDate IS NULL 
		END
	ELSE IF @patientid<>0 and @vacrecid=0
	BEGIN
		UPDATE tblVaccinationQueue 
		SET exportedDate=GETDATE()   
		WHERE dr_id=@drid AND pat_id=@patientid 
		AND isIncluded=1 AND exportedDate IS NULL 
	END
	IF @patientid<>0 and @vacrecid<>0
	BEGIN
	    UPDATE tblVaccinationQueue 
		SET exportedDate=GETDATE()   
		WHERE dr_id=@drid AND pat_id=@patientid and vac_rec_id=@vacrecid
		AND isIncluded=1 AND exportedDate IS NULL 
	END
END
 
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
