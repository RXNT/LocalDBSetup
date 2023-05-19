SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/*
=======================================================================================
Author				:	Vinod
Create date			:	25-Sep-2017
Description			:	This procedure is used to save Patient Registration
Last Modified By	:	Ayja Weems
Last Modifed Date	:	Set the accepted_terms_date for a patient's login
=======================================================================================
*/
CREATE PROCEDURE [phr].[usp_SavePatientRegistration]
(
	@PatientId			INT,
	@Source				SMALLINT,
	@PinCode			VARCHAR(20),
	@DoctorId			INT,
	@Token				VARCHAR(30),
	@RegistrationDate	SMALLDATETIME,
	@ExpiryDate			SMALLDATETIME,
	@LastUpdateDate		DATETIME,
	@RegisterName		VARCHAR(50),
	@RepresentativeName VARCHAR(50),
	@RepRelationship	VARCHAR(25),
	@Comments			VARCHAR(100),
	@AcceptedTermsDate	DATETIME
)
AS
BEGIN
    DECLARE @PAREGID int
	
	INSERT INTO [patient_registration] 
	(
		[pa_id],
		[src_id],
		[pincode],
		[dr_id],
		[token],
		[reg_date],
		[exp_date],
		[last_update_date]
	) 
	values (
		@PatientId,
		@Source,
		@PinCode,
		@DoctorId,
		@Token, 
		@RegistrationDate,
		@ExpiryDate,
		@LastUpdateDate
	); 
	 
	-- Mark the terms & conditions as accepted for this user
	UPDATE dbo.patient_login
	SET accepted_terms_date = @AcceptedTermsDate
	WHERE pa_id = @PatientId

	SET @PAREGID = SCOPE_IDENTITY()
	 
	IF @PAREGID > 0 
	 
	BEGIN
	 
	INSERT INTO [patient_registration_details] ([pa_reg_id],[reg_name],[rep_name],[rep_rel],[comments]) 
	VALUES(@PAREGID, @RegisterName, @RepresentativeName, @RepRelationship, @Comments)
	 
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
