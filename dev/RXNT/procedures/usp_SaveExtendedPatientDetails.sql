SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Nambi
-- Create date: 16-JAN-2017
-- Description:	Save Extended Patient Details
-- =============================================

CREATE PROCEDURE [dbo].[usp_SaveExtendedPatientDetails]
	@PatientId BIGINT,
	@pa_death_date DATETIME,
	@PAEXT BIT,
	@PAREF VARCHAR(255),
	@REFDATE DATETIME,
	@PRIMDRID BIGINT,
	@DRID BIGINT,
	@cphone VARCHAR(50),
	@wphone VARCHAR(50),
	@ophone VARCHAR(50),
	@mstat TINYINT,
	@estat TINYINT,
	@commpref TINYINT,
	@prefphone TINYINT,
	@timezone VARCHAR(6),
	@prefstarttime TIME(7),
	@prefendtime TIME(7), 
	@mother_first VARCHAR(35),
	@mother_middle VARCHAR(35),
	@mother_last VARCHAR(35),
	@emergency_contact_first VARCHAR(35),
	@emergency_contact_last VARCHAR(35),
	@emergency_contact_address1 VARCHAR(100),
	@emergency_contact_address2 VARCHAR(100),
	@emergency_contact_city VARCHAR(50),
	@emergency_contact_state VARCHAR(2),
	@emergency_contact_zip VARCHAR(20),
	@emergency_contact_phone VARCHAR(20),
	@emergency_contact_relationship VARCHAR(3),
	@emergency_contact_release_documents BIT,
	@pa_phone_ctry_code VARCHAR(5),
	@cell_phone_ctry_code VARCHAR(5),
	@work_phone_ctry_code VARCHAR(5),
	@other_phone_ctry_code VARCHAR(5),
	@pa_phone_dial_code VARCHAR(5),
	@cell_phone_dial_code VARCHAR(5),
	@work_phone_dial_code VARCHAR(5),
	@other_phone_dial_code VARCHAR(5),
	@pa_phone_full VARCHAR(30),
	@cell_phone_full VARCHAR(30),
	@work_phone_full VARCHAR(30),
	@other_phone_full VARCHAR(30)
AS
BEGIN
	DELETE FROM patient_extended_details WHERE pa_id=@PatientId
	
	INSERT INTO patient_extended_details(pa_id, pa_death_date,pa_ext_ref, pa_ref_name_details,pa_ref_date, prim_dr_id, dr_id,cell_phone, work_phone, other_phone, marital_status, empl_status,comm_pref, pref_phone, time_zone, pref_start_time, pref_end_time,mother_first,mother_middle,mother_last, emergency_contact_first, emergency_contact_last, emergency_contact_address1, emergency_contact_address2, emergency_contact_city, emergency_contact_state, emergency_contact_zip, emergency_contact_phone, emergency_contact_relationship, emergency_contact_release_documents, pa_phone_ctry_code, cell_phone_ctry_code, work_phone_ctry_code, other_phone_ctry_code, pa_phone_dial_code, cell_phone_dial_code, work_phone_dial_code, other_phone_dial_code, pa_phone_full, cell_phone_full, work_phone_full, other_phone_full) VALUES (@PatientId, @pa_death_date, @PAEXT, @PAREF, @REFDATE, @PRIMDRID, @DRID, @cphone, @wphone, @ophone, @mstat, @estat,@commpref, @prefphone, @timezone, @prefstarttime, @prefendtime, @mother_first,@mother_middle,@mother_last, @emergency_contact_first, @emergency_contact_last, @emergency_contact_address1, @emergency_contact_address2, @emergency_contact_city, @emergency_contact_state, @emergency_contact_zip, @emergency_contact_phone, @emergency_contact_relationship, @emergency_contact_release_documents, @pa_phone_ctry_code, @cell_phone_ctry_code, @work_phone_ctry_code, @other_phone_ctry_code, @pa_phone_dial_code, @cell_phone_dial_code, @work_phone_dial_code, @other_phone_dial_code, @pa_phone_full, @cell_phone_full, @work_phone_full, @other_phone_full)
END
RETURN 0
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
