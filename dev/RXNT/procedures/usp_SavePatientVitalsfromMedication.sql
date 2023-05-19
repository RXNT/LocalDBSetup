SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
-- =============================================
-- Author:		JahabarYusuff M
-- Create date: 21-Oct-2019
-- Modified By :  
-- Description:	save/update vitals from Medication(refill/newrx)page
-- =============================================

CREATE PROCEDURE [dbo].[usp_SavePatientVitalsfromMedication]
(
	@PatientVitalsId INT OUTPUT,
	@PatientId INT,
	@Weight FLOAT,
	@Height FLOAT,
	@Pulse FLOAT,
	@BPSystolic FLOAT,
	@BPDiastolic FLOAT,
	@Glucose FLOAT,
	@Respiration FLOAT,
	@Temperature FLOAT,	
	@BMI FLOAT,
	@Age INT,
	@Oxygen FLOAT,
	@HeadCircumference FLOAT,
	
	@AddedByPrescriberId INT,
	
	@Active BIT =1,	
	@GroupId INT,
	@DoctorId INT,
	@WeightEnteredValue FLOAT,
	@HeightEnteredValue FLOAT,
	@WeightEnteredUnit INT,
	@HeightEnteredUnit INT,
	@hc_entered_val FLOAT,
    @hc_entered_unit INT

)
AS
BEGIN
	IF ISNULL(@PatientVitalsId, 0) = 0
	BEGIN
		INSERT INTO [dbo].[patient_vitals] 
		([pa_id],[pa_wt],[pa_ht],[pa_pulse],[pa_bp_sys],[pa_bp_dys],[pa_glucose],[pa_resp_rate],[pa_temp],[pa_bmi],[age]
		,[date_added],[dg_id],[added_by],[added_for],[record_date],[pa_oxm],[pa_hc], [active],
		  wt_entered_val  ,wt_entered_unit ,ht_entered_val ,	ht_entered_unit, [hc_entered_val],[hc_entered_unit])
		VALUES
		(@PatientId,@Weight,@Height,@Pulse,@BPSystolic, @BPDiastolic, @Glucose, @Respiration, @Temperature, @BMI, @Age
		,GETDATE(), @GroupId, @AddedByPrescriberId, @DoctorId, GETDATE(), @Oxygen, @HeadCircumference, @Active,  
		@WeightEnteredValue, @WeightEnteredUnit, @HeightEnteredValue,@HeightEnteredUnit,  @hc_entered_val ,    @hc_entered_unit )
		
		SET @PatientVitalsId = SCOPE_IDENTITY();
	END
	ELSE
	BEGIN
		UPDATE [patient_vitals] 
		SET [pa_wt] = @Weight,[pa_ht] = @Height,  [age] = @Age, [pa_bmi] = @BMI,[added_by] = @AddedByPrescriberId, record_modified_date=getdate(),		 
		 [record_date] = GETDATE(),  
		 [last_modified_date] = GETDATE(), [last_modified_by] = @AddedByPrescriberId
		WHERE pa_id= @PatientId and pa_vt_id =  @PatientVitalsId
	END
	
END
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

GO
