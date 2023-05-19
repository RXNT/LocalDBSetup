SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		Sheik
-- Create date: 29-June-2020
-- Description:	Save Patient Vitals External API
-- =============================================

CREATE PROCEDURE [dbo].[usp_SavePatientExternalVitals]
(
	@PatientId INT,
	@Weight FLOAT,
	@Height FLOAT,
	@RecordDate DATETIME,
	@DoctorCompanyId INT,
	@GroupId INT,
	@DoctorId INT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM doc_companies dc WITH (NOLOCK) 
	INNER JOIN doc_groups dg WITH(NOLOCK) ON dg.dc_id = dc.dc_id 
	INNER JOIN patients pat WITH(NOLOCK) ON dg.dg_id = pat.dg_id 
	WHERE dc.dc_id = @DoctorCompanyId AND dc.EnableExternalVitals = 1 AND pat.pa_id=@PatientId) 
	BEGIN

		Declare @Age Int;
		SELECT @Age = DATEDIFF(yy, pa_dob, @RecordDate) FROM  patients WITH (NOLOCK) WHERE pa_id=@PatientId

		INSERT INTO [dbo].[patient_vitals] 
		([pa_id],[pa_wt],[pa_ht],[pa_pulse],[pa_bp_sys],[pa_bp_dys],[pa_glucose],[pa_resp_rate],[pa_temp],[pa_bmi],[age]
		,[date_added],[dg_id],[added_by],[added_for],[record_date],[active],[wt_entered_val],[wt_entered_unit],[ht_entered_val],[ht_entered_unit])
		VALUES
		(@PatientId,@Weight,@Height,0,0, 0, 0, 0, 0, 0, @Age, GETDATE(), @GroupId, @DoctorId, @DoctorId, @RecordDate, 1, @Weight, 2, @Height, 2)
	END	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
