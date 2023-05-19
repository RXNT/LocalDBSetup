SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Rasheed
-- Create date: 08-MAR-2023
-- Description:	To save the Doctor cqm2023 Request
-- =============================================
CREATE     PROCEDURE [cqm2023].[SaveDoctorCQMRequest]  
	@PrimaryDoctorId BIGINT,
	@MainDoctorId BIGINT,
	@StartDate Datetime,
	@EndDate Datetime
AS
BEGIN
	--UPDATE THE FAILED STATUS
	UPDATE cqm2023.DoctorCQMCalculationRequest 
	SET Active=0
	WHERE Active=1 AND StatusId=3 AND DoctorId=@MainDoctorId
	
	IF NOT EXISTS(
		SELECT *  FROM cqm2023.DoctorCQMCalculationRequest  WITH(NOLOCK)
		WHERE StatusId IN (1,2) 
		AND DoctorId=@MainDoctorId 
		AND Active =1 
		AND (CONVERT(VARCHAR(20),StartDate,101)=CONVERT(VARCHAR(20),@StartDate,101))
		AND (CONVERT(VARCHAR(20),EndDate,101)=CONVERT(VARCHAR(20),@EndDate,101))
	)
	BEGIN
		INSERT INTO cqm2023.DoctorCQMCalculationRequest
		(DoctorId,StartDate,EndDate,StatusId,CreatedOn,CreatedBy,LastModifiedOn,LastModifiedBy,Active,DataImportStatus,RetryCount)
		VALUES
		(@MainDoctorId,@StartDate,@EndDate,1,GETDATE(),@PrimaryDoctorId,NULL,NULL,1,NULL,0)
	END
	
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
