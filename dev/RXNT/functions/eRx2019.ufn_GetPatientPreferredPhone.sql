SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [eRx2019].[ufn_GetPatientPreferredPhone] 
( 
    @PatientId VARCHAR(50)
) 
RETURNS VARCHAR(50)
BEGIN 
	DECLARE @PreferredPhone VARCHAR(100) 
	DECLARE @HomePhone VARCHAR(100) 
	DECLARE @CellPhone VARCHAR(100) 
	DECLARE @WorkPhone VARCHAR(100) 
	DECLARE @OtherPhone VARCHAR(100)
	DECLARE @PhonePreference INT 
	SELECT @HomePhone = pat.pa_phone,@CellPhone = patext.cell_phone,@WorkPhone= patext.work_phone, @OtherPhone = patext.other_phone,@PhonePreference = patext.pref_phone 
	FROM patients pat WITH(NOLOCK)
	LEFT OUTER JOIN patient_extended_details patext WITH(NOLOCK) ON pat.pa_id=patext.pa_id
	WHERE pat.pa_id=@PatientId
	
	 
	  SET @PreferredPhone = @HomePhone
            
    IF @PhonePreference > 0
    BEGIN
        IF @PhonePreference =2 AND LEN(@CellPhone)>0
        BEGIN
            SET @PreferredPhone = @CellPhone;
        END
        ELSE IF @PhonePreference =3 AND LEN(@WorkPhone)>0
        BEGIN
            SET @PreferredPhone = @WorkPhone;
        END
        ELSE IF @PhonePreference =4 AND LEN(@OtherPhone)>0
        BEGIN
            SET @PreferredPhone = @OtherPhone;
        END
    END
    IF LEN(@PreferredPhone)<=0
	BEGIN
        IF LEN(@HomePhone)>0
        BEGIN
            SET @PreferredPhone = @HomePhone
		END
		ELSE IF LEN(@CellPhone)>0
		BEGIN
			SET @PreferredPhone = @CellPhone
		END
		ELSE IF LEN(@WorkPhone)>0
		BEGIN
			SET @PreferredPhone = @WorkPhone
		END
		ELSE IF LEN(@OtherPhone)>0
		BEGIN
			SET @PreferredPhone = @OtherPhone
		END 
	END
            
    RETURN  @PreferredPhone
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
