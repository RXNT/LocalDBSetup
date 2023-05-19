SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
/* 
=======================================================================================
Author				:	Vinod
Create date			:	06-JUNE-2016
Description			:	This procedure is used to Save Next of Kins
Last Modified By	:
Last Modifed Date	:
=======================================================================================
*/

CREATE  PROCEDURE [ehr].[usp_SaveNextOfKins]	
	@pa_id			BIGINT,
	@kin_id			BIGINT,
	@kin_relation_code VARCHAR(10),
	@kin_first		VARCHAR(100),
	@kin_middle		VARCHAR(100),
	@kin_last		VARCHAR(100),
	@kin_address1	VARCHAR(100),
	@kin_city		VARCHAR(100),
	@kin_state		VARCHAR(100),
	@kin_zip		VARCHAR(100),
	@kin_country	VARCHAR(100),
	@kin_phone		VARCHAR(100),
	@kin_pref_phone	VARCHAR(10) = NULL,
	@kin_email		VARCHAR(100),
	@status			VARCHAR(20)
	
AS
BEGIN

IF(@status = 'NEW')
	BEGIN
		INSERT INTO patient_next_of_kin(pa_id, kin_relation_code, kin_first,
		kin_middle, kin_last, kin_address1, kin_city, kin_state, kin_zip, 
		kin_country, kin_phone,kin_pref_phone, kin_email) VALUES 
		(@pa_id, @kin_relation_code, @kin_first, @kin_middle, @kin_last,
		@kin_address1, @kin_city, @kin_state, @kin_zip, @kin_country, @kin_phone, @kin_pref_phone,@kin_email)
	END
ELSE
	BEGIN
		UPDATE patient_next_of_kin SET pa_id=@pa_id, kin_relation_code=@kin_relation_code, kin_first=@kin_first,
		kin_middle=@kin_middle, kin_last=@kin_last, kin_address1=@kin_address1, kin_city=@kin_city,
		kin_state=@kin_state, kin_zip=@kin_zip, 
		kin_country=@kin_country, kin_phone=@kin_phone,kin_pref_phone=@kin_pref_phone, kin_email=@kin_email WHERE kin_id =@kin_id
	END
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
