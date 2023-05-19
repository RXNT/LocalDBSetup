SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE PROCEDURE [prv].[SetPrescribingDoctor]
	 @UserId INT,
	 @DoctorId INT,
	 @AuthorizedDoctorId INT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE DOCTORS 
	SET dr_last_alias_dr_id=@DoctorId, dr_last_auth_dr_id =@AuthorizedDoctorId
	WHERE dr_id = @UserId;
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
