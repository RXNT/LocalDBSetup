SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_MatchPatient] 
(  
	@RxNTPatientFirstName VARCHAR(50),
    @PatientFirstName VARCHAR(50),
    @RxNTPatientLastName VARCHAR(50),
    @PatientLastName VARCHAR(50),
    @RxNTPatientDOB DATETIME,
    @PatientDOB DATETIME
) 
	RETURNS BIT
BEGIN 
	DECLARE @IsSame BIT=1
	SET @RxNTPatientFirstName=LOWER(ISNULL(@RxNTPatientFirstName,''))
    SET @PatientFirstName=LOWER(ISNULL(@PatientFirstName,''))
    SET @RxNTPatientLastName = LOWER(ISNULL(@RxNTPatientLastName,''))
    SET @PatientLastName = LOWER(ISNULL(@PatientLastName,''))
	SET @RxNTPatientDOB = ISNULL(@RxNTPatientDOB,GETDATE()+100)
    SET @PatientDOB = ISNULL(@PatientDOB,GETDATE()+100)
	IF (@RxNTPatientFirstName!= @PatientFirstName)
	BEGIN
        SET @IsSame = 0; 
	END

    IF @RxNTPatientLastName != @PatientLastName
    BEGIN
        SET @IsSame = 0; 
	END

    IF CONVERT(VARCHAR(20),@RxNTPatientDOB,101) != CONVERT(VARCHAR(20),@PatientDOB,101) 
    BEGIN
        SET @IsSame = 0; 
	END
    RETURN  @IsSame
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
